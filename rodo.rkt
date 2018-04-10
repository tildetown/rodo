#! /usr/bin/env racket 
#lang racket/base

(require racket/vector 
         racket/file
         racket/string
         racket/list)

(define program-name "rodo")
(define program-directory ".rodo/")
(define program-path "~/")
(define program-file "todo-list")
(define remove-command "rm")
(define add-command "add")
(define list-command "ls")
(define initialize-command "init")

(define (d-hash-ref hash-list key)
  (display (hash-ref hash-list key)))

(define (d-vector-ref args key)
  (display (vector-ref args key)))

(define messages 
  (hash 
    'show-usage 
    (string-append 
      "> For usage type " 
      "`" program-name " -h`" 
      " or " 
      "`" program-name " --help`\n")

    'creating-folder 
    (string-append 
      "> creating a " 
      program-directory 
      " folder in " 
      program-path " ...\n")

    'creating-file 
    (string-append 
      "> creating a " 
      program-file 
      " file in "
      program-path
      program-directory " ...\n")

    'creation-error 
    (string-append 
      "> Error: Could not create " 
      program-file
      " in "
      program-directory 
      program-path ".\n" 
      "> This may be due to directory permissions\n")

    'file-already-exists 
    (string-append 
      "> Error: " 
      program-name 
      " already exists in " 
      program-path 
      program-directory 
      program-file "\n")

    'successfully-created 
    (string-append 
      "> " 
      program-path 
      program-directory 
      program-file
      " has been successfully created\n") 

    'file-not-found 
    (string-append 
      "> Error: Could not find " 
      program-path 
      program-directory 
      program-file "\n")

    'init-y/n 
    (string-append
      "> A "
      program-file 
      " file will be created in "
      program-path
      program-directory "\n"
      "> Are you sure you want to continue? [y/n]\n")

    'try-init 
    (string-append
      "> Try typing "
      "`" program-name " init` "
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

(define (check-for-file)
  (file-exists?
    (expand-user-path
      (string-append
        program-path
        program-directory
        program-file))))

(define (create-file)
  (let 
    ([path 
       (expand-user-path 
         (string-append 
           program-path 
           program-directory
           program-file))])
    (let 
      ([opened-file 
         (open-output-file 
           path
           #:mode 'text
           #:exists 'can-update)])
      (close-output-port opened-file))))

(define (check-for-folder)
  (directory-exists? 
    (expand-user-path 
      (string-append 
        program-path 
        program-directory))))

(define (create-folder)
  (make-directory 
    (expand-user-path 
      (string-append 
        program-path 
        program-directory))))

(define (make-numbered lst)
  (map
   string-append
   (map
    number->string
        (range (length lst)))
   lst))

(define (add-spaces)
  (lambda (lst)
    (string-append ". " lst)))

(define (show-list-from-file)
  (let 
    ([path
       (expand-user-path
         (string-append
           program-path
           program-directory
           program-file))])
    (let 
      ([todo-list 
         (file->lines path
                      #:mode 'text
                      #:line-mode 'linefeed)])
      (display
        (string-join
          (make-numbered (map (add-spaces) todo-list)) 
          "\n"
          #:after-last "\n")))))

(define (show-list)
  (if 
    (and
      (check-for-folder)
      (check-for-file))
    (show-list-from-file)
    (begin
      (d-hash-ref messages 'file-not-found)
      (d-hash-ref messages 'try-init))))

(define (add-item-to-file item)
  (let ([item (string-append item "\n")])
    (let
      ([path
         (expand-user-path
           (string-append
             program-path
             program-directory
             program-file))])
      (display-to-file item 
                       path
                       #:mode 'text
                       #:exists 'append))))

(define (add-item args)
  (if 
    (and
      (check-for-folder)
      (check-for-file))
    (begin
      (add-item-to-file (vector-ref args 1))
      (d-hash-ref messages 'item-added-prefix) 
      (d-vector-ref args 1) 
      (d-hash-ref messages 'item-added-suffix))
    (begin
      (d-hash-ref messages 'file-not-found)
      (d-hash-ref messages 'try-init))))

(define (remove-item args)
  (if 
    (and
      (check-for-folder)
      (check-for-file))
    (begin
      ;; TODO (remove-item-from-file (vector-ref args 1))
      (d-hash-ref messages 'item-removed-prefix) 
      (d-vector-ref args 1) 
      (d-hash-ref messages 'item-removed-suffix))
    (begin
      (d-hash-ref messages 'file-not-found)
      (d-hash-ref messages 'try-init))))

(define (check-args args)
  (let 
    ([args-length (vector-length args)])
    (cond
      [(and 
         (equal? args-length 1) 
         (equal? (vector-member list-command args) 0))
       (show-list)]

      [(and 
         (equal? args-length 2) 
         (equal? (vector-member add-command args) 0))
       (add-item args)]

      [(and 
         (equal? args-length 2) 
         (equal? (vector-member remove-command args) 0))
       (remove-item args)]

      [(and 
         (equal? args-length 1) 
         (equal? (vector-member initialize-command args) 0))
       (initialize)]

      [else 
        (d-hash-ref messages 'show-usage)])))

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

(define (main)
  (check-args (current-command-line-arguments)))

(main)
