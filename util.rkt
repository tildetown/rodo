#lang racket/base

(require racket/list
         racket/file
         racket/string
         "config.rkt"
         "io.rkt"
         "messages.rkt")

(provide (all-defined-out))

(define (d-hash-ref hash-list key)
  (display (hash-ref hash-list key)))

(define (d-vector-ref args key)
  (display (vector-ref args key)))

(define (file->string-list path-to-file)
  (let
    ([todo-list
       (file->lines 
         path-to-file 
         #:mode 'text
         #:line-mode 'any)])
    todo-list))

(define (list-empty? lst)
  (empty? (rest (file->string-list lst))))

(define (get-removed-item lst args)
     (list-ref lst (string->number args)))

(define (quote-item args)
  (display
  (string-append "\"" args "\"")))

(define (number-list lst)
  (map string-append
       (map number->string
            (rest (range (length lst)))) 
       (rest lst)))                 

(define (indent-list)
  (lambda (lst)
    (string-append ". " lst)))

(define (prettify-list)
  (display
    (string-join
      (number-list (map (indent-list) (file->string-list path)))
      "\n"
      #:after-last "\n")))

(define (show-list)
  (cond
    [(and
       (check-for-folder)
       (check-for-file))
     (if
       (list-empty? path)
       (d-hash-ref messages 'empty-todo-list)
       (prettify-list))]
    [else
      (d-hash-ref messages 'file-not-found)
      (d-hash-ref messages 'try-init)]))

(define (add-item-to-file args)
  (let ([new-list
          (reverse
            (append (list args)
                    (reverse (file->string-list path))))])
    (display-to-file 
      (string-join new-list "\n" #:after-last "\n")
      path
      #:mode 'text
      #:exists 'replace)
      (d-hash-ref messages 'item-added-prefix)
      (quote-item args)
      (d-hash-ref messages 'item-added-suffix)))

(define (add-item args)
  (if
    (and
      (check-for-folder)
      (check-for-file))
    (add-item-to-file (vector-ref args 1))
    (begin
      (d-hash-ref messages 'file-not-found)
      (d-hash-ref messages 'try-init))))

(define (remove-item-from-file args)
  (let ([removed-item
          (get-removed-item (file->string-list path) args)])
    (let ([new-list
            (remove 
              (list-ref (file->string-list path) (string->number args)) 
              (file->string-list path))])
      (display-to-file 
        (string-join new-list "\n" #:after-last "\n")
        path
        #:mode 'text
        #:exists 'replace))
    (d-hash-ref messages 'item-removed-prefix)
    (quote-item removed-item)
    (d-hash-ref messages 'item-removed-suffix)))

(define (remove-item args)
  (cond
    [(list-empty? path)
     (d-hash-ref messages 'empty-todo-list)]
    [(and
       (check-for-folder)
       (check-for-file))
     (remove-item-from-file (vector-ref args 1))]
    [(and (not (check-for-folder)) (not (check-for-file)))
     (begin
       (d-hash-ref messages 'file-not-found)
       (d-hash-ref messages 'try-init))]))
