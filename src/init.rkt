#lang racket/base

(require (prefix-in config: "config.rkt")
         (prefix-in messages: "messages.rkt")
         (prefix-in utils: "utils.rkt"))

(provide (all-defined-out))

(define (create-initialization-contents)
  (utils:display-messages '(creating))
  (utils:directory-create-700 config:program-directory)
  (utils:file-create-600      config:list-file)
  (if (and (directory-exists? config:program-directory)
           (file-exists?      config:list-file))
      (utils:display-messages '(successfully-created))
      ;; Otherwise
      (utils:display-messages '(creation-error))))

(define (initialize)
  (utils:display-messages '(init-y/n))
  (display "> ")
  (let ([user-input (read-line)])
    (cond [(member user-input (hash-ref messages:y/n 'yes))
           (create-initialization-contents)]
          [(member user-input (hash-ref messages:y/n 'no))
           (utils:display-messages '(terminating))]
          [else (utils:display-messages '(choose-y/n))])))

(define (check-initialize-conditions)
  (if (file-exists? config:list-file)
      (utils:display-messages '(file-already-exists))
      (initialize)))
