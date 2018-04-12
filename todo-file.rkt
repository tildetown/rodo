#lang racket/base

(require racket/list
         racket/file
         racket/string
         "config.rkt"
         "io.rkt"
         "list-hash.rkt"
         "messages.rkt")

(provide (all-defined-out))

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
    ([path
       (expand-user-path
         (string-append
           program-path
           program-directory
           program-file))])
    (let
      ([todo-list
         (file->lines path
                      #:mode 'text
                      #:line-mode 'linefeed)])
      (display
        (string-join
          (make-numbered (map (add-spaces) todo-list))
          "\n"
          #:after-last "\n")))))

(define (show-list)
  (if
    (and
      (check-for-folder)
      (check-for-file))
    (show-list-from-file)
    (begin
      (d-hash-ref messages 'file-not-found)
      (d-hash-ref messages 'try-init))))

(define (add-item-to-file item)
  (let ([item (string-append item "\n")])
    (let
      ([path
         (expand-user-path
           (string-append
             program-path
             program-directory
             program-file))])
      (display-to-file item
                       path
                       #:mode 'text
                       #:exists 'append))))

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

(define (remove-item args)
  (if
    (and
      (check-for-folder)
      (check-for-file))
    (begin
      ;; TODO (remove-item-from-file (vector-ref args 1))
      (d-hash-ref messages 'item-removed-prefix)
      (d-vector-ref args 1)
      (d-hash-ref messages 'item-removed-suffix))
    (begin
      (d-hash-ref messages 'file-not-found)
      (d-hash-ref messages 'try-init))))
