#lang racket/base

(require "config.rkt")

(provide (all-defined-out))

(define hyphen         " - ")
(define indent         "  ")
(define newline        "\n")
(define newline-double "\n\n")

(define messages
  (hash
   'show-help
   (string-append
    "NAME" newline
    indent (format "~a" program-name)
    newline-double

    "DESCRIPTION" newline
    indent (format (string-append "~a is a todo-list program for the command line. "
                                    "~a does not use any data formats, and cannot "
                                    "remove multiple items at once.")
                   program-name program-name)
    newline-double

    "USAGE" newline
    indent (format "~a [command] [<args>]" program-name)
    newline-double

    "COMMANDS" newline
    indent initialize-command hyphen (format "Creates a list file located at ~a" program-file)
    newline-double

    indent list-command hyphen "Displays items from your todo list"
    newline-double

    indent add-command " \"A quoted string\"" hyphen "Adds an item to your todo list"
    newline-double

    indent remove-command " <number>" hyphen "Removes an item from your todo list"
    newline-double

    "USAGE EXAMPLES" newline
    indent (format "~a ~a" program-name initialize-command)
    newline

    indent (format "~a ~a" program-name list-command)
    newline

    indent (format "~a ~a \"Go for a walk\"" program-name add-command)
    newline

    indent (format "~a ~a 2" program-name remove-command)
    newline-double

    "If you can't see the whole help message, then try running the following command: " newline
    (format "~a ~a | less" program-name help-command))

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
