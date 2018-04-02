#! /usr/bin/env racket
#lang racket/base

(require json racket/vector)

(define program-name "rodo")
(define program-file ".rodo")
(define program-path "~/")

(define (d-hash-ref hash-list key)
  (displayln (hash-ref hash-list key)))

;;(define (add-to-list)
;;  (let ([args (vector-ref (current-command-line-arguments) 1)])
;;    (string-append "> Added " args " to list")))

;;(define (remove-from-list)
;;  (let ([args (vector-ref (current-command-line-arguments) 1)])
;;    (string-append "> Removed " args " from list")))

;; define all messages for quick access

(define messages 
  (hash 
    'incorrect-usage (string-append "> For usage type `" program-name " -h` or `" program-name " --help`")

    'file-not-found (string-append "> " program-file " has not been setup in your " program-path " directory\n> Would you like to set it up now? [y/n]")
    'file-exists-already (string-append "> " program-file " file already exists in " program-path)

    'creating-file (string-append "> Creating a " program-file " file in your " program-path " directory...")
    'file-exists-now (string-append "> " program-path program-file " have been successfully created") 
    'error-creating-file (string-append "> Error: Could not create " program-file " in your " program-path " directory.\n> This may be due to directory permissions")

    'item-added "> Added item to list" 
    'item-removed "> Added item to list"

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
  (d-hash-ref messages prompt-message)
  (display "> ")
  (let ([user-input (read-line)])
    (cond
      [(member user-input (hash-ref y/n 'yes))  
       (d-hash-ref messages 'creating-file)
       (open/create-file (string-append program-path program-file))
       (if (file-exists? (expand-user-path (string-append program-path program-file)))
         (d-hash-ref messages 'file-exists-now)
         (d-hash-ref messages 'error-creating-file))]
      [(member user-input (hash-ref y/n 'no))  
       (d-hash-ref messages 'terminating)]
      [else 
        (prompt-initialize 'choose-y/n)])))

(define (check-args args)
  (let ([args-length (vector-length args)])
    (cond
      [(or (equal? args-length 0) (> args-length 2))
       (d-hash-ref messages 'incorrect-usage)]

      [(and (equal? args-length 2) (equal? (vector-member "add" args) 0))
       (d-hash-ref messages 'item-added)]

      [(and (equal? args-length 2) (equal? (vector-member "remove" args) 0))
       (d-hash-ref messages 'item-removed)]

      [(and (equal? args-length 1) (equal? (vector-member "init" args) 0))
       (todo-list-exist?)])))

(define (todo-list-exist?)
  (if (file-exists? (expand-user-path (string-append program-path program-file)))
    (d-hash-ref messages 'file-exists-already)
    (prompt-initialize 'file-not-found)))

(define (main)
  (check-args (current-command-line-arguments)))

(main)
