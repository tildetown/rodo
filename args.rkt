#lang racket/base

(require racket/vector
         "config.rkt"
         "init.rkt"
         "util.rkt"
         "messages.rkt")

(provide (all-defined-out))

(define (check-args args)
  (let
    ([args-length (vector-length args)])
    (cond
      [(and
         (equal? args-length 1)
         (equal? (vector-member list-command args) 0))
       (show-list)]

      [(and
         (equal? args-length 2)
         (equal? (vector-member add-command args) 0))
       (add-item args)]

      [(and
         (equal? args-length 2)
         (equal? (vector-member remove-command args) 0))
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