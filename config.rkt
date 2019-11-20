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

;; TODO: pluralize this value's name
(define help-command '("-h"
                       "--help"
                       "h"
                       "help"))

;; TODO: pluralize this value's name
(define initialize-command '("init"
                             "create"
                             "start"
                             "begin"))

;; TODO: pluralize this value's name
(define add-command '("add"
                      "a"))

;; TODO: pluralize this value's name
(define list-command '("ls"
                       "list"))

;; TODO: pluralize this value's name
(define remove-command '("rm"
                         "remove"
                         "del"
                         "delete"))
