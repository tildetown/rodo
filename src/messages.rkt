#lang racket/base

(require (prefix-in config: "config.rkt"))

(provide (all-defined-out))

(define tab-full       "\t")
(define tab-half       "    ")
(define newline        "\n")
(define newline-double "\n\n")

(define program-name       config:program-name)
(define list-file          config:list-file)
(define help-command       (car config:help-commands))
(define initialize-command (car config:initialize-commands))
(define list-command       (car config:list-commands))
(define add-command        (car config:add-commands))
(define remove-command     (car config:remove-commands))

(define messages
  (hash
   'show-help
   (string-append
    "NAME" newline
    tab-half (format "~a" program-name) newline-double

    "DESCRIPTION" newline
    tab-half (format "~a is a todo-list program for the command line. ~a does not use any data formats, and cannot remove multiple items at once." program-name program-name) newline-double

    "USAGE SYNTAX" newline
    tab-half (format "~a [command] <args>" program-name) newline-double

    "COMMANDS AVAILABLE" newline
    tab-half initialize-command newline
    tab-full (format "Creates a list file located at ~a" list-file) newline-double

    tab-half list-command newline
    tab-full "Displays items from your list" newline-double

    tab-half add-command " <args>" newline
    tab-full "Adds an item to your list" newline-double

    tab-half remove-command " <args>" newline
    tab-full "Removes an item from your list" newline-double

    "USAGE EXAMPLES" newline
    tab-half initialize-command newline
    tab-full (format "~a ~a" program-name initialize-command) newline-double

    tab-half list-command newline
    tab-full (format "~a ~a" program-name list-command) newline-double

    tab-half add-command newline
    tab-full (format "~a ~a this is an item without double quotation marks" program-name add-command) newline
    tab-full (format "~a ~a \"this is an item surrounded by double quotation marks\"" program-name add-command) newline-double

    tab-half remove-command newline
    tab-full (format "~a ~a 2" program-name remove-commands) newline-double

    "If you can't see the whole help message, then try running the following command: " newline
    tab-half (format "~a ~a | less" program-name help-command) newline)

   'empty-list "> There is nothing in your list\n"

   'show-usage (format "> For usage type ~a -h\n" program-name)

   'creating (format "> Creating a list at ~a...\n" list-file)

   'creation-error (format "> Error: Could not create a list file at ~a\n" list-file)

   'file-already-exists (format "> Error: A list file already exists at ~a\n" list-file)

   'successfully-created (format "> Your list file was successfully created at ~a\n" list-file)

   'file-not-found (format "> Error: Could not find ~a\n" list-file)

   'item-not-found "> Error: Could not find that item\n"

   'init-y/n (format "> A list file will be created at ~a\n> Are you sure you want to continue? [y/n]\n" list-file)

   'try-init (format "> Try typing the following to setup ~a:\n~a ~a\n" program-name program-name initialize-command)

   'terminating (format "> Exited ~a\n" program-name)

   'choose-y/n "> Error: Please choose y or n\n"

   'not-in-list "> Error: Item does not exist\n"

   'item-added "> Added \"~a\" to your list\n"

   'item-removed "> Removed \"~a\" from your list\n"))


(define y/n
  (hash 'yes '("yes" "Yes" "y" "Y")
        'no  '("no" "No" "n" "N")))
