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
             (utils:create-program-directory-700 config:program-directory)
             (utils:create-list-file-600 config:path-to-list-file)
             (if (and (utils:program-directory-exists?)
                      (utils:list-file-exists?))
                 (utils:display-hash-ref messages:messages 'successfully-created)
                 (utils:display-hash-ref messages:messages 'creation-error)))]
          [(member user-input (hash-ref messages:y/n 'no))
           (utils:display-hash-ref messages:messages 'terminating)]
          [else
           (init-prompt messages:messages 'choose-y/n)])))

(define (initialize)
  (if (utils:list-file-exists?)
      (utils:display-hash-ref messages:messages 'file-already-exists)
      (begin
        (init-prompt messages:messages 'init-y/n))))
