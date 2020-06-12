#lang racket/base

(provide (all-defined-out))

(define program-name "rodo")

(define program-directory (build-path (find-system-path 'home-dir) ".config" "rodo"))
(define program-file      (build-path program-directory "list.txt"))

(define help-command "help")

(define initialize-command "initialize")

(define add-command "add")

(define list-command "ls")

(define remove-command "rm")
