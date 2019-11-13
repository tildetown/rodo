#lang racket/base
(provide (all-defined-out))

(define list-file "todo.txt")
(define program-name "rodo")

(define program-directory
  (path->string
    (expand-user-path
      (string-append "~/." program-name "/"))))

(define path-to-list-file
  (string-append program-directory list-file))

(define help-command '("-h"
                       "--help"
                       "h"
                       "help"))

(define initialize-command '("init"
                             "create"
                             "start"
                             "begin"))

(define add-command '("add"
                      "a"))

(define list-command '("ls"
                       "list"))

(define remove-command '("rm"
                         "remove"
                         "del"
                         "delete"))
