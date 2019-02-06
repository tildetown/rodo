#lang racket/base

(require (prefix-in vector: racket/vector)
         (prefix-in list: racket/list)
         (prefix-in config: "config.rkt")
         (prefix-in init: "init.rkt")
         (prefix-in util: "util.rkt")
         (prefix-in messages: "messages.rkt"))

(provide (all-defined-out))

(define (check-args args)
  (let([args-length (vector-length args)])
    (cond
      [(equal? args-length 0)
       (util:display-hash-ref messages:messages 'show-usage)]

      [(and
        (equal? args-length 1)
        (equal? (vector:vector-member config:list-command args) 0))
       (util:show-list)]

      [(and
        (equal? args-length 2)
        (equal? (vector-ref args 0) config:add-command))
       (util:add-item args)]

      [(and
        (equal? args-length 2)
        (equal? (vector:vector-member config:remove-command args) 0)
        ;; Don't allow user to remove zeroth item
        (not (equal? (vector:vector-member "0" args) 1))
        ;; Don't allow removal of items beyond last item
        (not (> (string->number (vector-ref args 1)) (length (util:file->string-list config:path)))))
       (util:remove-item args)]

      [(and
        (equal? args-length 1)
        (equal? (vector:vector-member config:initialize-command args) 0))
       (init:initialize)]

      [(and
        (equal? args-length 1)
        (member (vector-ref args 0) config:help-command))
       (util:display-hash-ref messages:messages 'show-help)]

      [else
       (util:display-hash-ref messages:messages 'show-usage)])))
