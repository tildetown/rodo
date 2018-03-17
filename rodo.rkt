#! /usr/bin/env racket
#lang racket/base

(define (display-hash hash-list key)
  (displayln (hash-ref hash-list key)))

(define messages (hash 
                  'incorrect-usage "> For usage type `rodo -h` or `rodo --help`"
                  'file-not-found "> rodo has not been setup in your home directory\nWould you like to set it up now? [y/n]"
                  'file-exists "> .rodo file exists"
                  'creating-file "> Creating .rodo file in your home directory..."
                  'item-added "> Item added"
                  'item-removed "> Item removed"
                  'initializing "> Initializing rodo in your home directory"
                  'terminating "> Terminating rodo..."
                  'choose-y/n "> Error: Please choose y or n"))

(define y/n (hash
              'yes '("yes" "Yes" "y" "Y")
              'no '("no" "No" "n" "N")))

(define (open/create-file path)
  (let ([path (expand-user-path path)])
    (open-output-file path
                      #:mode 'text
                      #:exists 'can-update)))

; just figuring out stuff here
(define (prompt-user prompt-message)
  (display-hash messages prompt-message)
  (let ([user-input (read-line)])
    (cond
      [(member user-input (hash-ref y/n 'yes))  
       (display-hash messages 'creating-file)
       (open/create-file "~/.rodo")]
      [(member user-input (hash-ref y/n 'no))  
       (display-hash messages 'terminating)]
      [else 
        (display-hash messages 'choose-y/n)
        (prompt-user 'file-not-found)])))

(define (todo-list-exist?)
  (if (file-exists? (expand-user-path "~/.rodo"))
    (display-hash messages 'file-exists)
    (prompt-user 'file-not-found)))

(todo-list-exist?)