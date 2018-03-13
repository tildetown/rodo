#! /usr/bin/env racket
#lang racket/base

(define (display-hash hash-list key)
  (displayln (hash-ref hash-list key)))

(define message (hash 
                  'incorrect-usage-msg "For usage type `rodo -h` or `rodo --help`"
                  'file-not-found "rodo has not been setup in your home directory\nWould you like to set it up now? [y/n]"
                  'file-exists ".rodo file exists"
                  'item-added "Item added"
                  'item-removed "Item removed"
                  'initializing "Initializing rodo in your home directory"))

(define y-n (hash
              'yes '("yes" "Yes" "y" "Y")
              'no '("no" "No" "n" "N")))

; just figuring out stuff here
(define (prompt-user prompt-message)
  (display-hash message prompt-message)
  (let ([user-input (read-line)])
    (cond
      [(member user-input (hash-ref y-n 'yes))  
       (displayln "You chose yes")]
      [else 
        (displayln "you chose something else")])))

(define (todo-list-exist?)
  (if (file-exists? (expand-user-path "~/.rodo"))
    (display-hash message 'file-exists)
    (prompt-user 'file-not-found)))

(todo-list-exist?)
