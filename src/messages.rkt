#lang racket/base

(require (prefix-in config: "config.rkt"))

(provide (all-defined-out))

(define (indent string)
  (string-append "\t" string))

(define line-gap-single "\n")
(define line-gap-double "\n\n")
(define space " ")
(define tab "\t")
(define tab-double "\t\t")

(define messages
  (hash
    'show-help
    (string-append "rodo"
                   line-gap-double

                   "NAME"
                   line-gap-single
                   tab "rodo - A list-management tool"
                   line-gap-double

                   "SYNOPSIS"
                   line-gap-single
                   tab "rodo [command] <args>"
                   line-gap-double

                   "DESCRIPTION"
                   line-gap-single
                   tab "rodo is a minimalistic list-management tool. It does not use any data formats, and cannot remove multiple items at once."
                   line-gap-double
                   tab (format "I made this tool to separate my hobby todos and my important todos. I do this by only using ~a to organize my hobby todos on the command line, and my important todos on a synced calendar elsewhere." config:program-name)
                   line-gap-double

                   "COMMANDS"
                   line-gap-single
                   ;; initialize-command
                   tab (car config:initialize-commands)
                   line-gap-single
                   tab-double (format "Creates a list file located at ~a" config:list-file)
                   line-gap-double

                   ;; list-command
                   tab (car config:list-commands)
                   line-gap-single
                   tab-double "Displays items from your list"
                   line-gap-double

                   ;; add-command
                   tab (car config:add-commands) space "<args>"
                   line-gap-single
                   tab-double "Adds an item to your list"
                   line-gap-double

                   ;; remove-command
                   tab (car config:remove-commands) space "<args>"
                   line-gap-single
                   tab-double"Removes an item from your list"
                   line-gap-double

                   "USAGE EXAMPLES"
                   line-gap-single
                   ;; initialize-command
                   tab (car config:initialize-commands)
                   line-gap-single
                   tab-double (format "~a ~a" config:program-name (car config:initialize-commands))
                   line-gap-double

                   ;; list-command
                   tab (car config:list-commands)
                   line-gap-single
                   tab-double (format "~a ~a" config:program-name (car config:list-commands))
                   line-gap-double

                   ;; add-command
                   tab (car config:add-commands)
                   line-gap-single
                   tab-double (format "~a ~a this is an item without double quotation marks" config:program-name (car config:add-commands))
                   line-gap-single
                   tab-double (format "~a ~a \"this is an item surrounded by double quotation marks\"" config:program-name (car config:add-commands))
                   line-gap-double

                   ;; remove-command
                   tab (car config:remove-commands)
                   line-gap-single
                   tab-double (format "~a ~a 2" config:program-name (car config:remove-commands))
                   line-gap-double

                   "Can't see the whole help message? Try running:"
                   line-gap-single
                   (format "~a ~a | less" config:program-name (car config:help-commands))
                   line-gap-single)

    'empty-list "> There is nothing in your list\n"

    'show-usage (format "> For usage type ~a -h\n" config:program-name)

    'creating (format "> Creating a list in ~a...\n" config:list-file)

    'creation-error (format "> Error: Could not create a list file in ~a\n" config:list-file)

    'file-already-exists (format "> Error: A list file already exists in ~a\n" config:list-file)

    'successfully-created (format "> Your list file was successfully created in ~a\n" config:list-file)

    'file-not-found (format "> Error: Could not find ~a\n" config:list-file)

    'item-not-found "> Error: Could not find that item\n"

    'init-y/n (format "> A list file will be created in ~a\n> Are you sure you want to continue? [y/n]\n" config:list-file)

    'try-init (format "> Try typing ~a ~a to set it up\n" config:program-name (car config:initialize-commands))

    'terminating (format "> Exited ~a\n" config:program-name)

    'choose-y/n "> Error: Please choose y or n\n"

    'not-in-list "> Error: Item does not exist\n"

    'item-added "> Added \"~a\" to your list\n"

    'item-removed "> Removed \"~a\" from your list\n"))


(define y/n (hash 'yes '("yes" "Yes" "y" "Y")
                  'no  '("no" "No" "n" "N")))
