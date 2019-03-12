#lang racket/base

(require (prefix-in vector: racket/vector)
         (prefix-in list: racket/list)
         (prefix-in config: "config.rkt")
         (prefix-in init: "init.rkt")
         (prefix-in util: "util.rkt")
         (prefix-in messages: "messages.rkt"))

(provide (all-defined-out))

(define (check-args args)
  (let ([args-length (vector-length args)])
    (cond
      [(equal? args-length 0)
       (util:display-hash-ref messages:messages 'show-usage)]

      ;; ls
      [(and
        (equal? args-length 1)
        (equal? (vector:vector-member config:list-command args) 0))
       (util:show-list)]

      ;; add
      [(and
        (or (equal? args-length 2) (>= args-length 2))
        (equal? (vector-ref args 0) config:add-command))
       (util:add-item args)]

      ;; rm
      [(and
        (equal? args-length 2)
        (equal? (vector:vector-member config:remove-command args) 0)
        (real? (string->number (vector-ref args 1)))
        (positive? (string->number (vector-ref args 1)))
        (not (> (string->number (vector-ref args 1)) (length (util:file->string-list config:path))))
        (not (< (string->number (vector-ref args 1)) (car (list:range (length (util:file->string-list config:path)))))))
       (util:remove-item args)]

      ;; init
      [(and
        (equal? args-length 1)
        (equal? (vector:vector-member config:initialize-command args) 0))
       (init:initialize)]

      ;; help
      [(and
        (equal? args-length 1)
        (member (vector-ref args 0) config:help-command))
       (util:display-hash-ref messages:messages 'show-help)]

      [else
       (util:display-hash-ref messages:messages 'show-usage)])))
