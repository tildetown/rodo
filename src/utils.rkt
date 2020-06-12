#lang racket/base

(require racket/file
         racket/list
         racket/string
         "config.rkt"
         "messages.rkt")

(provide (all-defined-out))

(define (append-period string)
  (string-append string ". "))

(define (combine-lists lst1 lst2)
  (map (lambda (lst1 lst2) (string-append lst1 lst2))
       lst1
       lst2))

(define (messages-ref key)
  (hash-ref messages key))

(define (displayln-messages key-list)
  (for ([key key-list])
    (displayln (messages-ref key))))

(define (displayln-format-message key item)
  (displayln (format (messages-ref key) item)))

(define (check-paths-exist)
  (when (not (or (directory-exists? program-directory)
                 (file-exists?      program-file)))
    (displayln-messages '(file-not-found try-init))
    (exit)))

(define (check-file-empty)
  (when (null? (file->lines program-file))
    (displayln-messages '(empty-list))
    (exit)))

;; This may be affected by the user's umask
(define (file-create-600 a-file)
  (close-output-port
   (open-output-file a-file
                     #:mode 'text
                     #:exists 'truncate))
  (file-or-directory-permissions a-file #o600))

;; This may be affected by the user's umask
(define (directory-create-700 a-directory)
  (make-directory a-directory)
  (file-or-directory-permissions a-directory #o700))

;; --------------------------------------------------------
;; ls
;; --------------------------------------------------------
;; The (map add1 ...) here starts the numbering at 1 instead of 0
(define (ls)
  (check-paths-exist)
  (check-file-empty)
  (let* ([listof-file-lines            (file->lines program-file)]
         [listof-numbers               (map add1 (range (length listof-file-lines)))]
         [listof-number-strings        (map number->string listof-numbers)]
         [listof-dotted-number-strings (map append-period listof-number-strings)]
         [combined-lists               (combine-lists listof-dotted-number-strings listof-file-lines)]
         [numbered-list                (string-join combined-lists "\n" #:after-last "\n")])
    (display numbered-list)))

;; --------------------------------------------------------
;; add
;; --------------------------------------------------------
(define (add/append-item-to-list lst subcommand)
  (let* ([listof-lines                    (file->lines lst)]
         [listof-lines-reversed           (reverse listof-lines)]
         [listof-lines-reversed-with-item (cons subcommand listof-lines-reversed)])
    (reverse listof-lines-reversed-with-item)))

(define (add subcommand)
  (check-paths-exist)
  (let ([list-with-item (add/append-item-to-list program-file subcommand)])
    (display-lines-to-file list-with-item
                           program-file
                           #:mode 'text
                           #:exists 'truncate)
    (displayln-format-message 'item-added subcommand)))

;; --------------------------------------------------------
;; rm
;; --------------------------------------------------------
;; The (sub1 subcommand-number) is because list-ref starts
;; its index at 0, so we want to lower the user input by 1
(define (rm subcommand-number)
  (check-paths-exist)
  (check-file-empty)
  (if (<= subcommand-number (length (file->lines program-file)))
      (let* ([item-number       (sub1 subcommand-number)]
             [listof-lines      (file->lines program-file)]
             [item-to-remove    (list-ref listof-lines item-number)]
             [list-without-item (remove item-to-remove listof-lines)])
        (display-lines-to-file list-without-item
                               program-file
                               #:mode 'text
                               #:exists 'truncate)
        (displayln-format-message 'item-removed item-to-remove))
      (displayln-messages '(item-not-found try-ls))))

;; --------------------------------------------------------
;; Initialize
;; --------------------------------------------------------
(define (initialize/cancel)
  (displayln-messages '(cancel))
  (exit))

(define (initialize/start)
  (displayln-messages '(creating))
  (directory-create-700 program-directory)
  (file-create-600      program-file)
  (if (and (directory-exists? program-directory)
           (file-exists?      program-file))
      (displayln-messages '(successfully-created))
      (displayln-messages '(creation-error))))

(define (initialize/prompt)
  (displayln-messages '(initialize-prompt))
  (display "> ")
  (let ([user-input (read-line)])
    (case (string->symbol user-input)
      ['y   (initialize/start)]
      ['n   (initialize/cancel)]
      [else (displayln-messages '(choose-y/n))])))

(define (initialize)
  (if (file-exists? program-file)
      (displayln-messages '(file-already-exists))
      (initialize/prompt)))
