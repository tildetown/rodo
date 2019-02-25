#lang racket/base

(require (prefix-in file: racket/file)
         (prefix-in config: "config.rkt")
         (prefix-in util: "util.rkt")
         (prefix-in messages: "messages.rkt"))

(provide (all-defined-out))

(define (init-prompt hash-list key)
  (util:display-hash-ref hash-list key)
  (display "> ")
  (let
      ([user-input (read-line)])
    (cond
      [(member user-input (hash-ref messages:y/n 'yes))
       (util:display-hash-ref messages:messages 'creating)
       (util:create-directory)
       (util:create-file)
       (if (and
            (util:check-for-directory)
            (util:check-for-file))
           (util:display-hash-ref messages:messages 'successfully-created)
           (util:display-hash-ref messages:messages 'creation-error))]

      [(member user-input (hash-ref messages:y/n 'no))
       (util:display-hash-ref messages:messages 'terminating)]

      [else
       (init-prompt messages:messages 'choose-y/n)])))

(define (initialize)
  (if (util:check-for-file)
      (util:display-hash-ref messages:messages 'file-already-exists)
      (begin
        (init-prompt messages:messages 'init-y/n))))
