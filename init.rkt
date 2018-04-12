#lang racket/base

(require "config.rkt"
         "list-hash.rkt"
         "messages.rkt"
         "io.rkt")

(provide (all-defined-out))

(define (init-prompt hash-list key)
  (d-hash-ref hash-list key)
  (display "> ")
  (let
    ([user-input (read-line)])
    (cond
      [(member user-input (hash-ref y/n 'yes))
       (d-hash-ref messages 'creating-folder)
       (d-hash-ref messages 'creating-file)
       (create-folder)
       (create-file)
       (if
         (and
           (check-for-folder)
           (check-for-file))
         (d-hash-ref messages 'successfully-created)
         (d-hash-ref messages 'creation-error))]

      [(member user-input (hash-ref y/n 'no))
       (d-hash-ref messages 'terminating)]

      [else
        (init-prompt messages 'choose-y/n)])))

(define (initialize)
  (if (check-for-file)
    (d-hash-ref messages 'file-already-exists)
    (begin
      (init-prompt messages 'init-y/n))))
