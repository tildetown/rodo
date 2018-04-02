#! /usr/bin/env racket
#lang racket/base
(require json)

;; set the name of the program here
(define program-name "rodo")

;; set which path the program will live in
(define program-path "~/.")

;; because I don't want to type `(display (hash-ref...` over and over again
(define (displayln-hash-ref hash-list key)
  (displayln (hash-ref hash-list key)))

;; define all messages for quick access
(define messages 
  (hash 
    'incorrect-usage (string-append "> For usage type `" program-name " -h` or `" program-name " --help`")
    'file-not-found (string-append "> " program-name " has not been setup in your home directory\n> Would you like to set it up now? [y/n]")
    'file-exists (string-append "> ." program-name " file exists")
    'creating-file (string-append "> Creating ." program-name " file in your home directory...")
    
    ;; temporary thing
    'item-added (string-append "> Added ") 

    ;; todo change `item` to command-line argument for add and remove
    ;; 'item-added (string-append "> Added " (vector-ref (current-command-line-arguments) 1)) 
    ;; 'item-removed "> Item removed" ;; todo change `item` to command-line argument
    'initializing (string-append "> Initializing " program-name " in your home directory")
    'terminating (string-append "> Exiting " program-name "...")
    'choose-y/n "> Error: Please choose y or n"))

;; some possible user-input related "mistakes" that will be accepted for input
(define y/n 
  (hash
    'yes '("yes" "Yes" "y" "Y")
    'no '("no" "No" "n" "N")))

;; yet again, less typing for opening a file
(define (open/create-file path)
  (let ([path (expand-user-path path)])
    (let ([opened-file (open-output-file path
                                         #:mode 'text
                                         #:exists 'can-update)])
      (close-output-port opened-file))))

;; talk with user if something goes wrong/right 
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

(define (add-to-list args)
  ;; (let ([item (vector-ref args 1)])
  (displayln-hash-ref messages 'item-added))

(define (check-args args)
  (vector-length (args)))

(define (todo-list-exist?)
  (if (file-exists? (expand-user-path (string-append program-path program-name)))
    (displayln-hash-ref messages 'file-exists)
    (prompt-user 'file-not-found)))

;; todo get command-line args
#|(define (todo-list-exist?)
    (if (file-exists? (expand-user-path (string-append program-path program-name)))
      (begin
        (displayln-hash-ref messages 'file-exists)
        (add-to-list (current-command-line-arguments)))
      (prompt-user 'file-not-found)))
|#

(todo-list-exist?)
