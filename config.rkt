#lang racket/base
(provide (all-defined-out))

(define file-name "todo.txt")
(define program-name "rodo")

(define program-directory
  (path->string
    (expand-user-path
      (string-append "~/." program-name "/"))))

(define list-file
  (string-append program-directory file-name))

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
