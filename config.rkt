#lang racket/base
(provide (all-defined-out))

(define file-name "list.txt")
(define program-name "rodo")

(define program-directory
  (path->string
   (expand-user-path
    (string-append "~/." program-name "/"))))

(define list-file
  (string-append program-directory file-name))

(define help-commands '("-h"
                        "--help"
                        "h"
                        "help"))

(define initialize-commands '("init"
                              "create"
                              "start"
                              "begin"))

(define add-commands '("add"
                       "a"))

(define list-commands '("ls"
                        "list"))

(define remove-commands '("rm"
                          "remove"
                          "del"
                          "delete"))
