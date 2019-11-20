#lang racket/base

(require (prefix-in config: "config.rkt")
         (prefix-in messages: "messages.rkt")
         (prefix-in utils: "utils.rkt"))

(provide (all-defined-out))

(define (init-prompt hash-list key)
  (utils:display-hash-ref hash-list key)
  (display "> ")
  (let ([user-input (read-line)])
    (cond [(member user-input (hash-ref messages:y/n 'yes))
           (begin
             (utils:display-hash-ref messages:messages 'creating)
             (utils:create-directory-700 config:program-directory)
             (utils:create-file-600 config:list-file)
             (if (and (directory-exists? config:program-directory)
                      (file-exists? config:list-file))
                 (utils:display-hash-ref messages:messages 'successfully-created)
                 (utils:display-hash-ref messages:messages 'creation-error)))]
          [(member user-input (hash-ref messages:y/n 'no))
           (utils:display-hash-ref messages:messages 'terminating)]
          [else
           (init-prompt messages:messages 'choose-y/n)])))

(define (initialize)
  (if (file-exists? config:list-file)
      (utils:display-hash-ref messages:messages 'file-already-exists)
      (begin
        (init-prompt messages:messages 'init-y/n))))
