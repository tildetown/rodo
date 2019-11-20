#lang racket/base

(require (prefix-in config: "config.rkt")
         (prefix-in init: "init.rkt")
         (prefix-in file: racket/file)
         (prefix-in messages: "messages.rkt")
         (prefix-in utils: "utils.rkt"))

(provide (all-defined-out))

(define (check-args args)
  (let ([args-length (length args)])
    (cond
      [(equal? args-length 0)
       (utils:display-hash-ref messages:messages 'show-usage)]

      ;; help-command
      [(and (equal? args-length 1)
            (member (list-ref args 0) config:help-command))
       (utils:display-hash-ref messages:messages 'show-help)]

      ;; initialize-command
      [(and (equal? args-length 1)
            (member (list-ref args 0) config:initialize-command))
       (init:initialize)]

      ;; add-command
      [(and (or (equal? args-length 2) (>= args-length 2))
            (member (list-ref args 0) config:add-command))
       (utils:add-item-to-list config:list-file args)]

      ;; list-command
      [(and (equal? args-length 1)
            (member (list-ref args 0) config:list-command))
       (utils:show-list-from-file config:list-file)]

      ;; remove-command
      [(and (equal? args-length 2)
            (member (list-ref args 0) config:remove-command)
            (real?         (string->number (list-ref args 1)))
            (or (positive? (string->number (list-ref args 1)))
                (zero?     (string->number (list-ref args 1)))))
       (utils:remove-item-from-list args)]

      [else (utils:display-hash-ref messages:messages 'show-usage)])))
