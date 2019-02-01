#lang racket/base

(require (prefix-in list: racket/list)
         (prefix-in file: racket/file)
         (prefix-in string: racket/string)
         (prefix-in config: "config.rkt")
         (prefix-in messages: "messages.rkt"))

(provide (all-defined-out))

(define (check-for-file)
  (file-exists? config:path))

(define (create-file)
  (let ([opened-file
         (open-output-file config:path
                           #:mode 'text
                           #:exists 'can-update)])
    (close-output-port opened-file)))

(define (check-for-folder)
  (directory-exists? (expand-user-path
                      (string-append
                       config:program-path
                       config:program-directory))))

(define (create-folder)
  (make-directory (expand-user-path
                   (string-append
                    config:program-path
                    config:program-directory))))

(define (display-hash-ref hash-list key)
  (display (hash-ref hash-list key)))

(define (file->string-list config:path-to-file)
  (let ([todo-list (file:file->lines config:path-to-file
                           #:mode 'text
                           #:line-mode 'any)])
    todo-list))

(define (list-empty? lst)
  (list:empty? (list:rest (file->string-list lst))))

(define (get-removed-item lst args)
  (list-ref lst (string->number args)))

(define (quote-item args)
  (display
   (string-append "\"" args "\"")))

(define (prefix-with-number lst)
  (map string-append
       (map number->string
            (list:rest
             (list:range (length lst))))
       (list:rest lst)))

(define (prefix-with-period lst)
  (string-append ". " lst))

(define (prettify-list)
  (display
   (string:string-join (prefix-with-number (map prefix-with-period (file->string-list config:path)))
    "\n"
    #:after-last "\n")))

(define (append-to-end args lst)
  (reverse (cons args (reverse (file->string-list lst)))))

(define (display-item-added args)
  (display-hash-ref messages:messages 'item-added-prefix)
  (quote-item args)
  (display-hash-ref messages:messages 'item-added-suffix))

(define (display-item-removed args)
  (display-hash-ref messages:messages 'item-removed-prefix)
  (quote-item args)
  (display-hash-ref messages:messages 'item-removed-suffix))

(define (show-list)
  (cond [(and
          (check-for-folder)
          (check-for-file))
         (if
          (list-empty? config:path)
          (display-hash-ref messages:messages 'empty-todo-list)
          (prettify-list))]
        [else
         (display-hash-ref messages:messages 'file-not-found)
         (display-hash-ref messages:messages 'try-init)]))

(define (add-item-to-file args)
  (let ([new-list (append-to-end args config:path)])
    (file:display-to-file
     (string:string-join new-list "\n" #:after-last "\n")
     config:path
     #:mode 'text
     #:exists 'replace)
    (display-item-added args)))

(define (add-item args)
  (if (and
       (check-for-folder)
       (check-for-file))
      (add-item-to-file (vector-ref args 1))
      (begin
        (display-hash-ref messages:messages 'file-not-found)
        (display-hash-ref messages:messages 'try-init))))

(define (remove-item-from-file args)
  (let ([removed-item (get-removed-item (file->string-list config:path) args)]
        [new-list (remove
                   (list-ref (file->string-list config:path) (string->number args))
                   (file->string-list config:path))])
    (file:display-to-file
     (string:string-join new-list "\n" #:after-last "\n")
     config:path
     #:mode 'text
     #:exists 'replace)
    (display-item-removed removed-item)))

(define (remove-item args)
  (cond [(list-empty? config:path)
         (display-hash-ref messages:messages 'empty-todo-list)]
        [(and
          (check-for-folder)
          (check-for-file))
         (remove-item-from-file (vector-ref args 1))]
        [(and (not (check-for-folder)) (not (check-for-file)))
         (begin
           (display-hash-ref messages:messages 'file-not-found)
           (display-hash-ref messages:messages 'try-init))]))
