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

(define (quote-item-in-list lst args)
  (display
    (string-append 
      "\"" 
      (list-ref lst
                (string->number args)) 
      "\"")))

(define (make-numbered lst)
  (map
    string-append
    (map
      number->string
      (range (length lst)))
    lst))

(define (add-spaces)
  (lambda (lst)
    (string-append ". " lst)))

(define (show-list-from-file)
  (let
    ([todo-list
       (file->lines path
                    #:mode 'text
                    #:line-mode 'linefeed)])
    (display
      (string-join
        (make-numbered (map (add-spaces) todo-list))
        "\n"
        #:after-last "\n"))))

(define (show-list)
  (if
    (and
      (check-for-folder)
      (check-for-file))
    (show-list-from-file)
    (begin
      (d-hash-ref messages 'file-not-found)
      (d-hash-ref messages 'try-init))))

(define (add-item-to-file args)
  (let ([args (string-append args "\n")])
    (display-to-file args 
                     path
                     #:mode 'text
                     #:exists 'append)))

(define (add-item args)
  (if
    (and
      (check-for-folder)
      (check-for-file))
    (begin
      (add-item-to-file (vector-ref args 1))
      (d-hash-ref messages 'item-added-prefix)
      (d-vector-ref args 1)
      (d-hash-ref messages 'item-added-suffix))
    (begin
      (d-hash-ref messages 'file-not-found)
      (d-hash-ref messages 'try-init))))

(define (remove-item-from-file args)
  (let ([todo-list
          (file->lines path
                       #:mode 'text
                       #:line-mode 'linefeed)])
    (d-hash-ref messages 'item-removed-prefix)
    (quote-item-in-list todo-list args)
    (d-hash-ref messages 'item-removed-suffix)
    (let ([new-list
            (remove 
              (list-ref 
                todo-list 
                (string->number 
                  args)) 
              todo-list)])
      (display-to-file 
        (string-join new-list "\n")
        path
        #:mode 'text
        #:exists 'replace))))

(define (remove-item args)
  (let ([todo-list
          (file->lines
            path
            #:mode 'text
            #:line-mode 'linefeed)])
    (cond
      [(< (length todo-list) 1)
       (d-hash-ref messages 'empty-todo-list)]
      [(and
         (number? (string->number (vector-ref args 1)))
         (< (string->number (vector-ref args 1)) (vector-length args))
         (check-for-folder)
         (check-for-file))
       (remove-item-from-file (vector-ref args 1))]
      [(and (not (check-for-folder)) (not (check-for-file)))
       (begin
         (d-hash-ref messages 'file-not-found)
         (d-hash-ref messages 'try-init))]
      [(>= (string->number (vector-ref args 1)) (vector-length args))
       (d-hash-ref messages 'not-in-list)])))
