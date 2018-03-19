#! /usr/bin/env racket
#lang racket/base

(define (displayln-hash-ref hash-list key)
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
    (let ([opened-file (open-output-file path
                      #:mode 'text
                      #:exists 'can-update)])
      (close-output-port opened-file))))

(define (prompt-user prompt-message)
  (displayln-hash-ref messages prompt-message)
  (let ([user-input (read-line)])
    (cond
      [(member user-input (hash-ref y/n 'yes))  
       (displayln-hash-ref messages 'creating-file)
       (open/create-file "~/.rodo")]
      [(member user-input (hash-ref y/n 'no))  
       (displayln-hash-ref messages 'terminating)]
      [else 
        (displayln-hash-ref messages 'choose-y/n)
        (prompt-user 'file-not-found)])))

(define (todo-list-exist?)
  (if (file-exists? (expand-user-path "~/.rodo"))
    (displayln-hash-ref messages 'file-exists)
    (prompt-user 'file-not-found)))

(todo-list-exist?)
