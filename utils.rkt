#lang racket/base

(require (prefix-in     file: racket/file)
         (prefix-in     list: racket/list)
         (prefix-in   string: racket/string)
         (prefix-in   config: "config.rkt")
         (prefix-in messages: "messages.rkt"))

(provide (all-defined-out))

(define (create-file-600 a-file)
  (let ([opened-file (open-output-file a-file #:mode 'text #:exists 'truncate)])
    (close-output-port opened-file))
  (file-or-directory-permissions a-file #o600))

(define (create-directory-700 a-directory)
  (make-directory a-directory)
  (file-or-directory-permissions a-directory #o700))

(define (display-hash-ref hash-list key)
  (display (hash-ref hash-list key)))

(define (list->ascending-numbers lst)
  (list:range (length lst)))

(define (list->dotted-ascending-numbers lst)
  (map (lambda (x) (string-append x ". "))
       (map number->string (list->ascending-numbers lst))))

(define (list->numbered-list lst)
  (map (lambda (x y) (string-append x y))
       (list->dotted-ascending-numbers lst)
       lst))

(define (file->vertically-numbered-list a-file)
  (string:string-join
   (list->numbered-list (file:file->lines a-file))
   "\n"
   #:after-last "\n"))

(define (surround-with-quotation-marks item)
  (string-append "\"" item "\""))

(define (display-item-added item)
  (display-hash-ref messages:messages 'item-added-prefix)
  (display (surround-with-quotation-marks item))
  (display-hash-ref messages:messages 'item-added-suffix))

(define (display-item-removed args)
  (display-hash-ref messages:messages 'item-removed-prefix)
  (display (surround-with-quotation-marks args))
  (display-hash-ref messages:messages 'item-removed-suffix))

;; TODO: Turn into a check-show-list-conditions and then break
;;       the rest down into separate functions
(define (show-list-from-file a-file)
  (cond
    ;; If exists and not empty
    [(and (file-exists? config:list-file)
          (not (null? (file:file->lines a-file))))
     (display (file->vertically-numbered-list a-file))]

    ;; If exists and empty
    [(and (file-exists? config:list-file)
          (null? (file:file->lines a-file)))
     (display-hash-ref messages:messages 'empty-todo-list)]

    ;; If not exist
    [(and (not (file-exists? config:list-file)))
     (begin
       (display-hash-ref messages:messages 'file-not-found)
       (display-hash-ref messages:messages 'try-init))]

    ;; Otherwise
    [else (display-hash-ref messages:messages 'show-usage)]))

;; TODO: Change this to just use append with lst and (list args)
(define (append-item-to-list args lst)
  (reverse (cons args (reverse (file:file->lines lst)))))

;; TODO: Turn into a check-add-conditions and then break
;;       the rest down into separate functions
(define (add-item-to-list a-file args)
  (if (and (file-exists? config:list-file))
      (let* ([item (string:string-join (cdr args) " ")]
             [new-list (append-item-to-list item config:list-file)])
        (file:display-to-file (string:string-join new-list "\n")
                              config:list-file
                              #:mode 'text
                              #:exists 'truncate)
        (display-item-added item))
      (begin
        (display-hash-ref messages:messages 'file-not-found)
        (display-hash-ref messages:messages 'try-init))))

;; TODO: Turn into a check-remove-conditions and then break
;;       the rest down into separate functions
(define (remove-item-from-list args)
  (cond
    ;; If directory and file exist, but file is empty
    [(and (directory-exists? config:program-directory)
          (file-exists?      config:list-file)
          (null?             config:list-file))
     (display-hash-ref messages:messages 'empty-todo-list)]

    ;; If directory and file exist, and file is not empty
    [(and (directory-exists? config:program-directory)
          (file-exists?      config:list-file)
          (not (null?        config:list-file)))
     (let ([user-args   (string->number (list-ref args 1))]
           ;; Length subtract one because the numbering starts at zero
           [list-length (sub1 (length (file:file->lines config:list-file)))])
       (if (not (> user-args list-length))
           (let* ([item-to-remove (list-ref (file:file->lines config:list-file) user-args)]
                  [new-list (remove item-to-remove (file:file->lines config:list-file))])
             (file:display-to-file (string:string-join new-list "\n")
                                   config:list-file
                                   #:mode 'text
                                   #:exists 'truncate)
             (display-item-removed item-to-remove))
           ;; Else
           (display-hash-ref messages:messages 'item-not-found)))]

    ;; If directory and file don't exist
    [(and (not (directory-exists? config:program-directory))
          (not (file-exists? config:list-file)))
     (begin
       (display-hash-ref messages:messages 'file-not-found)
       (display-hash-ref messages:messages 'try-init))]))
