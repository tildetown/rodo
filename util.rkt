#lang racket/base

(require (prefix-in list: racket/list)
         (prefix-in file: racket/file)
         (prefix-in string: racket/string)
         (prefix-in system: racket/system)
         (prefix-in config: "config.rkt")
         (prefix-in messages: "messages.rkt"))

(provide (all-defined-out))

(define (set-permissions permissions file-or-directory)
  (let* ([converted-permissions (number->string permissions)]
         [converted-file-or-directory
           (cond [(path? file-or-directory) (path->string file-or-directory)]
                 [else file-or-directory])])
    (system:system
      (string-append "chmod" " " converted-permissions " " converted-file-or-directory))))

(define (check-for-file)
  (file-exists? config:path))

(define (create-file)
  (let ([opened-file
          (open-output-file config:path
                            #:mode 'text
                            #:exists 'can-update)])
    (close-output-port opened-file))
  (set-permissions 600 config:path))

(define (check-for-directory)
  (directory-exists? (expand-user-path
                       (string-append
                         config:program-directory))))

(define (create-directory)
  (make-directory (expand-user-path
                    (string-append
                      config:program-directory)))
  (set-permissions 700 config:program-directory))

(define (display-hash-ref hash-list key)
  (display (hash-ref hash-list key)))

;; Just so I don't have to keep typing "#:mode...#:line-mode..." every time
(define (file->string-list config:path-to-file)
  (let ([todo-list (file:file->lines config:path-to-file
                                     #:mode 'text
                                     #:line-mode 'any)])
    todo-list))

(define (list-empty? lst)
  (list:empty? (file->string-list lst)))

;; Find out which item is being removed by scooping up
;; the number the user entered in the command line
;; argument
(define (get-removed-item lst args)
  ;; Subtract one from what the user chose, because they are
  ;; are actually viewing the list numbers as human numbers
  ;; so (actual-number +1)
  (list-ref (file->string-list lst) (sub1 (string->number args))))

(define (surround-in-quotes args)
  (display (string-append "\"" args "\"")))

(define (prefix-with-period lst)
  (string-append lst ". "))

(define (prefix-with-number lst)
  (map string-append
       ;; Note: compose starts from the last element in it's
       ;; list, as if it were nested, so that would be add1 here
       (map (compose prefix-with-period number->string add1)
            (list:range (length lst)))
       lst))

(define (display-prettified-list)
  (display
    (string:string-join
      (prefix-with-number (file->string-list config:path))
      "\n"
      #:after-last "\n")))

;; This is a bit of ugly scheme sorcery
(define (append-to-end args lst)
  (reverse (cons args (reverse (file->string-list lst)))))

(define (display-item-added args)
  (display-hash-ref messages:messages 'item-added-prefix)
  (surround-in-quotes args)
  (display-hash-ref messages:messages 'item-added-suffix))

(define (display-item-removed args)
  (display-hash-ref messages:messages 'item-removed-prefix)
  (surround-in-quotes args)
  (display-hash-ref messages:messages 'item-removed-suffix))

(define (show-list)
  (cond [(and
           (check-for-directory)
           (check-for-file))
         (if
           ;; If file exists, see if it's empty, if so
           ;; tell the user
           (list-empty? config:path)
           (display-hash-ref messages:messages 'empty-todo-list)
           ;; If file isn't empty, display a pretty list
           (display-prettified-list))]
        ;; If file doesn't exist, tell the user
        [else
          (display-hash-ref messages:messages 'file-not-found)
          (display-hash-ref messages:messages 'try-init)]))

(define (add-item-to-file args)
  ;; Add item to end of list and write to file
  (let ([new-list (append-to-end args config:path)])
    (file:display-to-file
      (string:string-join new-list "\n")
      config:path
      #:mode 'text
      #:exists 'replace)
    (display-item-added args)))

(define (add-item args)
  (if (and
        (check-for-directory)
        (check-for-file))
    (add-item-to-file (vector-ref args 1))
    (begin
      (display-hash-ref messages:messages 'file-not-found)
      (display-hash-ref messages:messages 'try-init))))

(define (remove-item-from-file args)
  (let* ([removed-item (get-removed-item config:path args)]
         [new-list (remove removed-item (file->string-list config:path))])

    (file:display-to-file
      (string:string-join new-list "\n")
      config:path
      #:mode 'text
      #:exists 'replace)
    (display-item-removed removed-item)))

(define (remove-item args)
  (cond [(list-empty? config:path)
         (display-hash-ref messages:messages 'empty-todo-list)]
        [(and
           (check-for-directory)
           (check-for-file))
         (remove-item-from-file (vector-ref args 1))]
        [(and (not (check-for-directory)) (not (check-for-file)))
         (begin
           (display-hash-ref messages:messages 'file-not-found)
           (display-hash-ref messages:messages 'try-init))]))
