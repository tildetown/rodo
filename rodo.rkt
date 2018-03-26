#! /usr/bin/env racket
#lang racket/base

(define program-name "rodo")

(define program-path "~/.")

(define (displayln-hash-ref hash-list key)
  (displayln (hash-ref hash-list key)))

(define messages 
  (hash 
    'incorrect-usage (string-append "> For usage type `" program-name " -h` or `" program-name " --help`")
    'file-not-found (string-append "> " program-name " has not been setup in your home directory\n> Would you like to set it up now? [y/n]")
    'file-exists (string-append "> ." program-name " file exists")
    'creating-file (string-append "> Creating ." program-name " file in your home directory...")
    'item-added "> Item added"
    'item-removed "> Item removed"
    'initializing (string-append "> Initializing " program-name " in your home directory")
    'terminating (string-append "> Terminating " program-name "...")
    'choose-y/n "> Error: Please choose y or n"))

(define y/n 
  (hash
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
  (display "> ")
  (let ([user-input (read-line)])
    (cond
      [(member user-input (hash-ref y/n 'yes))  
       (displayln-hash-ref messages 'creating-file)
       (open/create-file (string-append program-path program-name))]
      [(member user-input (hash-ref y/n 'no))  
       (displayln-hash-ref messages 'terminating)]
      [else 
        (displayln-hash-ref messages 'choose-y/n)
        (prompt-user 'file-not-found)])))

(define (todo-list-exist?)
  (if (file-exists? (expand-user-path (string-append program-path program-name)))
    (displayln-hash-ref messages 'file-exists)
    (prompt-user 'file-not-found)))

(todo-list-exist?)
