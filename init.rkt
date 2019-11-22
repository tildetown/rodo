#lang racket/base

(require (prefix-in config: "config.rkt")
         (prefix-in messages: "messages.rkt")
         (prefix-in utils: "utils.rkt"))

(provide (all-defined-out))

(define (create-initialization-contents)
  (utils:display-hash-ref     messages:messages 'creating)
  (utils:create-directory-700 config:program-directory)
  (utils:create-file-600      config:list-file)
  (if (and (directory-exists? config:program-directory)
           (file-exists?      config:list-file))
      (utils:display-hash-ref messages:messages 'successfully-created)
      ;; Otherwise
      (utils:display-hash-ref messages:messages 'creation-error)))

(define (initialize)
  (utils:display-hash-ref messages:messages 'init-y/n)
  (display "> ")
  (let ([user-input (read-line)])
    (cond [(member user-input (hash-ref messages:y/n 'yes))
           (create-initialization-contents)]
          [(member user-input (hash-ref messages:y/n 'no))
           (utils:display-hash-ref messages:messages 'terminating)]
          [else (utils:display-hash-ref messages:messages 'choose-y/n)])))

(define (check-initialize-conditions)
  (if (file-exists? config:list-file)
      (utils:display-hash-ref messages:messages 'file-already-exists)
      (initialize)))
