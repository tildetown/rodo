#! /usr/bin/env racket
#lang racket/base

(define message (hash 
                  'help-message "For usage type `rodo -h` or `rodo --help`"
                  'file-not-found ".rodo file was not found in your home directory. Would you like to create it?"
                  'file-exists ".rodo file exists"
                  'item-added "Item added"
                  'item-removed "item removed"
                  'initializing "Initializing rodo in your home directory"))

(define (todo-list-exist?)
  (if (file-exists? (expand-user-path "~/.rodo"))
    ; the displayln here removes the quotes from appearing
    ; in the stdout. from ".rodo file exists" -> .rodo file exists
    ; not sure if this is the cleanest way to do so
    (displayln (hash-ref message 'file-exists))
    (displayln (hash-ref message 'file-not-found))))

(todo-list-exist?)
