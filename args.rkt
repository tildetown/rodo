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
    (cond [(equal? args-length 0)
           (util:display-hash-ref messages:messages 'show-usage)]

          ;; ls
          [(and (equal? args-length 1)
                (equal? (vector:vector-member config:list-command args) 0))
           (util:show-list-from-file config:path-to-list-file)]

          ;; add
          [(and (or (equal? args-length 2) (>= args-length 2))
                (equal? (vector-ref args 0) config:add-command))
           (util:add-item-to-list config:path-to-list-file args)]

          ;; rm
          [(and (equal? args-length 2)
                (equal? (vector-ref args 0) config:remove-command)
                (real? (string->number (vector-ref args 1)))
                (or (positive? (string->number (vector-ref args 1)))
                    (zero? (string->number (vector-ref args 1))))
                ;; Length subtract one because the numbering starts at zero
                (not (> (string->number (vector-ref args 1)) (sub1 (length (util:file->string-list config:path-to-list-file))))))
           (util:remove-item-from-list config:path-to-list-file args)]

          ;; init
          [(and (equal? args-length 1)
                (equal? (vector:vector-member config:initialize-command args) 0))
           (init:initialize)]

          ;; help
          [(and (equal? args-length 1)
                (member (vector-ref args 0) config:help-command))
           (util:display-hash-ref messages:messages 'show-help)]

          [else
           (util:display-hash-ref messages:messages 'show-usage)])))
