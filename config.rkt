#lang racket/base
(provide (all-defined-out))

(define program-name "rodo")
(define program-directory
  (path->string
   (expand-user-path
    (string-append "~/." program-name "/"))))
(define list-file "todo.txt")
(define remove-command "rm")
(define add-command "add")
(define list-command "ls")
(define initialize-command "init")
(define help-command '("-h" "--help"))
(define path-to-list-file
  (string-append program-directory list-file))
