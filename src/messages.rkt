#lang racket/base

(require "config.rkt")

(provide (all-defined-out))

(define tab-full       "\t")
(define tab-half       "    ")
(define newline        "\n")
(define newline-double "\n\n")

(define messages
  (hash
   'show-help
   (string-append
    "NAME" newline
    tab-half (format "~a" program-name) newline-double

    "DESCRIPTION" newline
    tab-half (format (string-append "~a is a todo-list program for the command line. "
                                    "~a does not use any data formats, and cannot "
                                    "remove multiple items at once.") program-name program-name)
    newline-double

    "USAGE SYNTAX" newline
    tab-half (format "~a [command] <args>" program-name)
    newline-double

    "COMMANDS AVAILABLE" newline
    tab-half initialize-command newline
    tab-full (format "Creates a list file located at ~a" program-file)
    newline-double

    tab-half list-command newline
    tab-full "Displays items from your todo list"
    newline-double

    tab-half add-command " <\"A quoted string\">" newline
    tab-full "Adds an item to your todo list"
    newline-double

    tab-half remove-command " <number>" newline
    tab-full "Removes an item from your todo list"
    newline-double

    "USAGE EXAMPLES" newline
    tab-half initialize-command newline
    tab-full (format "~a ~a" program-name initialize-command)
    newline-double

    tab-half list-command newline
    tab-full (format "~a ~a" program-name list-command)
    newline-double

    tab-half add-command newline
    tab-full (format "~a ~a \"Go for a walk\"" program-name add-command)
    newline-double

    tab-half remove-command newline
    tab-full (format "~a ~a 2" program-name remove-command)
    newline-double

    "If you can't see the whole help message, then try running the following command: " newline
    (format "~a ~a | less" program-name help-command) newline)

   'empty-list                   "> There is nothing in your todo list"
   'show-usage           (format "> For usage type the following command:\n~a ~a" program-name help-command)
   'initialize-prompt    (format "> A todo list file will be created at ~a\n> Are you sure you want to continue? [y/n]" program-file)
   'cancel               (format "> Cancelled initialization of ~a" program-name)
   'creating             (format "> Creating ~a ..." program-file)
   'successfully-created (format "> Your todo list file was successfully created at ~a" program-file)
   'try-init             (format "> Try typing the following command to initialize ~a:\n~a ~a" program-name program-name initialize-command)
   'try-ls               (format "> Try typing the following command to see which item corresponds to which number in your list:\n~a ~a" program-name list-command)
   'item-added                   "> Added \"~a\" to your todo list"
   'item-removed                 "> Removed \"~a\" from your todo list"

   'too-many-args                "> Error: Too many arguments"
   'creation-error       (format "> Error: Could not create ~a" program-file)
   'file-already-exists  (format "> Error: A todo list file already exists at ~a" program-file)
   'file-not-found       (format "> Error: Could not find ~a" program-file)
   'item-not-found               "> Error: Could not find that item"
   'choose-y/n                   "> Error: Please choose y or n"
   'not-in-list                  "> Error: Item does not exist"))
