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
       (utils:display-messages '(show-usage))]

      ;; help-command
      [(and (equal? args-length 1)
            (member (list-ref args 0) config:help-commands))
       (utils:display-messages '(show-help))]

      ;; initialize-command
      [(and (equal? args-length 1)
            (member (list-ref args 0) config:initialize-commands))
       (init:check-initialize-conditions)]

      ;; add-command
      [(and (or (equal? args-length 2) (>= args-length 2))
            (member (list-ref args 0) config:add-commands))
       (utils:check-add-conditions args)]

      ;; list-command
      [(and (equal? args-length 1)
            (member (list-ref args 0) config:list-commands))
       (utils:check-list-conditions)]

      ;; remove-command
      [(and (equal? args-length 2)
            (member (list-ref args 0) config:remove-commands)
            (real?         (string->number (list-ref args 1)))
            (or (positive? (string->number (list-ref args 1)))
                (zero?     (string->number (list-ref args 1)))))
       (utils:check-remove-conditions args)]

      [else (utils:display-messages '(show-usage))])))
