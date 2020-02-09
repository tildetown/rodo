#lang racket/base

(require (prefix-in config: "config.rkt")
         (prefix-in init: "init.rkt")
         (prefix-in file: racket/file)
         (prefix-in messages: "messages.rkt")
         (prefix-in utils: "utils.rkt"))

(provide (all-defined-out))

(define (check-args args)
  (let ([args-length (length args)]
        [is-member?  (lambda (command) (member (list-ref args 0) command))]
        [args-second (string->number (list-ref args 1))])
    (cond
      [(equal? args-length 0)
       (utils:display-messages '(show-usage))]

      ;; help-command
      [(and (equal? args-length 1)
            (is-member? config:help-commands))
       (utils:display-messages '(show-help))]

      ;; initialize-command
      [(and (equal? args-length 1)
            (is-member? config:initialize-commands))
       (init:check-initialize-conditions)]

      ;; add-command
      [(and (>= args-length 2)
            (is-member? config:add-commands))
       (utils:check-add-conditions args)]

      ;; list-command
      [(and (equal? args-length 1)
            (is-member? config:list-commands))
       (utils:check-list-conditions)]

      ;; remove-command
      [(and (equal? args-length 2)
            (is-member? config:remove-commands)
            (real? args-second)
            (or (positive? args-second)
                (zero? args-second)))
       (utils:check-remove-conditions args)]

      [else (utils:display-messages '(show-usage))])))
