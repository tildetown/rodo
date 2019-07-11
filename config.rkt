#lang racket/base
(provide (all-defined-out))

(define program-name "rodo")
(define program-directory (path->string (expand-user-path "~/.rodo/")))
(define program-file "to-do.txt")
(define remove-command "rm")
(define add-command "add")
(define list-command "ls")
(define initialize-command "init")
(define help-command '("-h" "--help"))
(define path-to-file (string-append program-directory program-file))
