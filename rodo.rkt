#! /usr/bin/env racket 
#lang racket/base

(require racket/vector)

(define program-name "rodo")
(define program-directory ".rodo/")
(define program-path "~/")

(define (d-hash-ref hash-list key)
  (display (hash-ref hash-list key)))

(define (d-vector-ref args key)
  (display (vector-ref args key)))

(define messages 
  (hash 
    'incorrect-usage 
    (string-append 
      "> For usage type " 
      "`" program-name " -h`" 
      " or " 
      "`" program-name " --help`\n")

    'creating 
    (string-append 
      "> Creating a " 
      program-directory 
      " folder in " 
      program-path " ...\n")

    'creation-error 
    (string-append 
      "> Error: Could not create " 
      program-directory 
      " in " 
      program-path ".\n" 
      "> This may be due to directory permissions\n")

    'already-exists 
    (string-append 
      "> " 
      program-directory 
      " folder already exists in " 
      program-path "\n")

    'successfully-created 
    (string-append 
      "> " 
      program-path program-directory 
      " has been successfully created\n") 

    'not-found 
    (string-append 
      "> " 
      program-directory 
      " has not been setup in " 
      program-path "\n")

    'setup-y/n 
    (string-append
      "> Would you like to set it up now? [y/n]\n")

    'try-initializing 
    (string-append
      "> Try typing "
      "`" program-name
      " init` "
      "to set it up\n")

    'terminating 
    (string-append 
      "> Exiting " 
      program-name 
      " ...\n")

    'choose-y/n
    "> Error: Please choose y or n\n"

    'item-added-prefix 
    "> Added " 

    'item-added-suffix 
    " to list\n" 

    'item-removed-prefix 
    "> Removed "

    'item-removed-suffix 
    " from list\n"))

(define y/n 
  (hash
    'yes 
    '("yes" "Yes" "y" "Y")

    'no 
    '("no" "No" "n" "N")))

(define (open/create-file)
  (let 
    ([path 
       (expand-user-path 
         (string-append 
           program-path 
           program-directory))])
    (let 
      ([opened-file 
         (open-output-file path
                           #:mode 'text
                           #:exists 'can-update)])
      (close-output-port opened-file))))

(define (create-folder)
  (make-directory 
    (expand-user-path 
      (string-append 
        program-path 
        program-directory))))

(define (check-for-folder)
  (directory-exists? 
    (expand-user-path 
      (string-append 
        program-path 
        program-directory))))

(define (prompt-user chosen-message)
  (d-hash-ref messages chosen-message)
  (display "> ")
  (let 
    ([user-input (read-line)])
    (cond
      [(member user-input (hash-ref y/n 'yes))  
       (d-hash-ref messages 'creating)
       (create-folder)
       (if (check-for-folder)
         (d-hash-ref messages 'successfully-created)
         (d-hash-ref messages 'creation-error))]

      [(member user-input (hash-ref y/n 'no))  
       (d-hash-ref messages 'terminating)]

      [else 
        (prompt-user 'choose-y/n)])))

(define (add-item args)
  (if (check-for-folder)
    (begin
      (d-hash-ref messages 'item-added-prefix) 
      (d-vector-ref args 1) 
      (d-hash-ref messages 'item-added-suffix))
    (begin
      (d-hash-ref messages 'not-found)
      (d-hash-ref messages 'try-initializing))))

(define (remove-item args)
  (if (check-for-folder)
    (begin
      (d-hash-ref messages 'item-removed-prefix) 
      (d-vector-ref args 1) 
      (d-hash-ref messages 'item-removed-suffix))
    (begin
      (d-hash-ref messages 'not-found)
      (d-hash-ref messages 'try-initializing))))

(define (check-args args)
  (let 
    ([args-length (vector-length args)])
    (cond
      [(and 
         (equal? args-length 2) 
         (equal? (vector-member "add" args) 0))
       (add-item args)]

      [(and 
         (equal? args-length 2) 
         (equal? (vector-member "remove" args) 0))
       (remove-item args)]

      [(and 
         (equal? args-length 1) 
         (equal? (vector-member "init" args) 0))
       (todo-folder-exist?)]

      [else 
        (d-hash-ref messages 'incorrect-usage)])))

(define (todo-folder-exist?)
  (if (check-for-folder)
    (d-hash-ref messages 'already-exists)
    (begin
      (d-hash-ref messages 'not-found)
      (prompt-user 'setup-y/n))))

(define (main)
  (check-args (current-command-line-arguments)))

(main)
