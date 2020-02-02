#lang racket/base

(require (prefix-in config: "config.rkt")
         (prefix-in init: "init.rkt")
         (prefix-in file: racket/file)
         (prefix-in messages: "messages.rkt")
         (prefix-in utils: "utils.rkt"))

(provide (all-defined-out))

(define (check-args args)
  (let ([args-length (length args)]
        [is-member?  (lambda (command)
                       (member (list-ref args 0) command))])
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
            ;; possibly replace this with something that checks
            ;; the length, the creates a range with that, starting
            ;; from zero, and checks to see if the user input
            ;; is a member of that list
            (real?         (string->number (list-ref args 1)))
            (or (positive? (string->number (list-ref args 1)))
                (zero?     (string->number (list-ref args 1)))))
       (utils:check-remove-conditions args)]

      [else (utils:display-messages '(show-usage))])))
