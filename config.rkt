#lang racket/base
(provide (all-defined-out))

(define program-name "rodo")
(define program-directory ".rodo/")
(define program-path "~/")
(define program-file "todo-list")
(define remove-command "rm")
(define add-command "add")
(define list-command "ls")
(define initialize-command "init")
(define help-command '("-h" "--help"))
(define path 
  (expand-user-path
    (string-append
      program-path
      program-directory
      program-file)))
