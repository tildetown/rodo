#! /usr/bin/env racket
#lang racket/base
(require json racket/vector)

;; set the name of the program here
(define program-name "rodo")

;; set which path the program will live in
(define program-path "~/.")

;; because I don't want to type `(display (hash-ref...` over and over again
(define (displayln-hash-ref hash-list key)
  (displayln (hash-ref hash-list key)))

;; (define (add-to-list)
;;  (let ([args (vector-ref (current-command-line-arguments) 1)])
;;    (string-append "> Added " args " to list")))

;;(define (remove-from-list)
;;  (let ([args (vector-ref (current-command-line-arguments) 1)])
;;    (string-append "> Removed " args " from list")))

;; define all messages for quick access
(define messages 
  (hash 
    'incorrect-usage (string-append "> For usage type `" program-name " -h` or `" program-name " --help`")
    'file-not-found (string-append "> " program-name " has not been setup in your home directory\n> Would you like to set it up now? [y/n]")
    'file-exists (string-append "> ." program-name " file exists")
    'creating-file (string-append "> Creating ." program-name " file in your home directory...")

    'item-added "> Added item to list" 
    'item-removed "> Added item to list"

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
(define (prompt-initialize prompt-message)
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
        (prompt-initialize 'file-not-found)])))

(define (check-args args)
  (let ([args-length (vector-length args)])
    (cond
      [(or (equal? args-length 0) (> args-length 2))
       (displayln-hash-ref messages 'incorrect-usage)]
      [(and (equal? args-length 2) (equal? (vector-member "add" args) 0))
       (displayln-hash-ref messages 'item-added)]
      [(and (equal? args-length 1) (equal? (vector-member "init" args) 0))
       (todo-list-exist?)])))

(define (todo-list-exist?)
  (if (file-exists? (expand-user-path (string-append program-path program-name)))
    (displayln-hash-ref messages 'file-exists)
    (prompt-initialize 'file-not-found)))

(define (main)
(check-args (current-command-line-arguments)))

(main)
