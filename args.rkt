#lang racket/base

(require racket/vector
         racket/list
         "config.rkt"
         "init.rkt"
         "util.rkt"
         "messages.rkt")

(provide (all-defined-out))

(define (check-args args)
  (let
    ([args-length (vector-length args)])
    (cond
      [(equal? args-length 0)
       (d-hash-ref messages 'show-usage)]

      [(and
         (equal? args-length 1)
         (equal? (vector-member list-command args) 0))
       (show-list)]

      [(and
         (equal? args-length 2)
         (equal? (vector-ref args 0) add-command))
       (add-item args)]

      [(and
         (equal? args-length 2)
         (equal? (vector-member remove-command args) 0)
         (not (equal? (vector-member "0" args) 1))
         (vector-member (vector-ref args 1) (list->vector (map number->string (range (length (file->string-list path)))))))
       (remove-item args)]

      [(and
         (equal? args-length 1)
         (equal? (vector-member initialize-command args) 0))
       (initialize)]

      [(and
         (equal? args-length 1)
         (member (vector-ref args 0) help-command))
       (d-hash-ref messages 'show-help)]

      [else
        (d-hash-ref messages 'show-usage)])))
