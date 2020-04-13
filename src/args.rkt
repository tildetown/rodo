#lang racket/base

(require (prefix-in config: "config.rkt")
         (prefix-in init: "init.rkt")
         (prefix-in file: racket/file)
         (prefix-in messages: "messages.rkt")
         (prefix-in utils: "utils.rkt"))

(provide (all-defined-out))

(define (check-args args)
  (let ([args-length (length args)]
        [is-member?  (lambda (command) (member (list-ref args 0) command))])
    (cond
      ;; if no args
      [(equal? args-length 0)
       (utils:display-messages '(show-usage))]

      ;; if one arg, and arg is the help command
      [(and (equal? args-length 1)
            (is-member? config:help-commands))
       (utils:display-messages '(show-help))]

      ;; if one arg, and arg is the initialize command
      [(and (equal? args-length 1)
            (is-member? config:initialize-commands))
       (init:check-initialize-conditions)]

      ;; if two args, and the add command exists in one of those args
      [(and (>= args-length 2)
            (is-member? config:add-commands))
       (utils:check-add-conditions args)]

      ;; if one arg, and arg is the list command
      [(and (equal? args-length 1)
            (is-member? config:list-commands))
       (utils:check-list-conditions)]

      ;; if two args, and the remove command exists in one of those args
      [(and (>= args-length 2)
      [(and (equal? args-length 2)
            (is-member? config:remove-commands)
            (real? (string->number (list-ref args 1)))
            (or (positive? (string->number (list-ref args 1)))
                (zero? (string->number (list-ref args 1)))))
       (utils:check-remove-conditions args)]

      [else (utils:display-messages '(show-usage))])))
