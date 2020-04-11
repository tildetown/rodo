#lang racket/base

(require (prefix-in config: "config.rkt"))

(provide (all-defined-out))

(define (indent string)
  (string-append "\t" string))

(define newline "\n")
(define newline-double "\n\n")

(define messages
  (hash 'show-help (string-append
                     "NAME" newline
                     "====" newline
                     "rodo" newline-double

                     "DESCRIPTION" newline
                     "===========" newline
                     "rodo is a minimalistic list-management tool. It does not use any data formats, and cannot remove multiple items at once." newline-double

                     "USAGE SYNTAX" newline
                     "============" newline
                     "rodo [command] <args>" newline-double

                     "COMMANDS AVAILABLE" newline
                     "==================" newline
                     (car config:initialize-commands) " - " (format "Creates a list file located at ~a" config:list-file) newline-double

                     (car config:list-commands) " - " "Displays items from your list" newline-double

                     (car config:add-commands) " <args> - Adds an item to your list" newline-double

                     (car config:remove-commands) " <args> - Removes an item from your list" newline-double

                     "USAGE EXAMPLES" newline
                     "==============" newline
                     (car config:initialize-commands) " usage:" newline
                     (format "~a ~a" config:program-name (car config:initialize-commands)) newline-double

                     (car config:list-commands) " usage:" newline
                     (format "~a ~a" config:program-name (car config:list-commands)) newline-double

                     (car config:add-commands) " usage:" newline
                     (format "~a ~a this is an item without double quotation marks" config:program-name (car config:add-commands)) newline
                     (format "~a ~a \"this is an item surrounded by double quotation marks\"" config:program-name (car config:add-commands)) newline-double

                     (car config:remove-commands) " usage:" newline
                     (format "~a ~a 2" config:program-name (car config:remove-commands)) newline-double

                     "Can't see the whole help message?" newline
                     "=================================" newline
                     "Try running the command below:" newline
                     (format "~a ~a | less" config:program-name (car config:help-commands)) newline)

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
