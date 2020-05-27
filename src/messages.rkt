#lang racket/base

(require (prefix-in config: "config.rkt"))

(provide (all-defined-out))

(define (indent string)
  (string-append "\t" string))

(define tab-full       "\t")
(define tab-half       "    ")
(define newline        "\n")
(define newline-double "\n\n")

(define messages
  (hash
    'show-help
    (string-append
      "NAME" newline
      tab-half (format "~a" config:program-name) newline-double

      "DESCRIPTION" newline
      tab-half (format "~a is a todo-list program for the command line. ~a does not use any data formats, and cannot remove multiple items at once." config:program-name config:program-name) newline-double

      "USAGE SYNTAX" newline
      tab-half (format "~a [command] <args>" config:program-name) newline-double

      "COMMANDS AVAILABLE" newline
      tab-half (car config:initialize-commands) newline
      tab-full (format "Creates a list file located at ~a" config:list-file) newline-double

      tab-half (car config:list-commands) newline
      tab-full "Displays items from your list" newline-double

      tab-half (car config:add-commands) " <args>" newline
      tab-full "Adds an item to your list" newline-double

      tab-half (car config:remove-commands) " <args>" newline
      tab-full "Removes an item from your list" newline-double

      "USAGE EXAMPLES" newline
      tab-half (car config:initialize-commands) newline
      tab-full (format "~a ~a" config:program-name (car config:initialize-commands)) newline-double

      tab-half (car config:list-commands) newline
      tab-full (format "~a ~a" config:program-name (car config:list-commands)) newline-double

      tab-half (car config:add-commands) newline
      tab-full (format "~a ~a this is an item without double quotation marks" config:program-name (car config:add-commands)) newline
      tab-full (format "~a ~a \"this is an item surrounded by double quotation marks\"" config:program-name (car config:add-commands)) newline-double

      tab-half (car config:remove-commands) newline
      tab-full (format "~a ~a 2" config:program-name (car config:remove-commands)) newline-double

      "If you can't see the whole help message, then try running the following command: " newline
      tab-half (format "~a ~a | less" config:program-name (car config:help-commands)) newline)

    'empty-list "> There is nothing in your list\n"

    'show-usage (format "> For usage type ~a -h\n" config:program-name)

    'creating (format "> Creating a list at ~a...\n" config:list-file)

    'creation-error (format "> Error: Could not create a list file at ~a\n" config:list-file)

    'file-already-exists (format "> Error: A list file already exists at ~a\n" config:list-file)

    'successfully-created (format "> Your list file was successfully created at ~a\n" config:list-file)

    'file-not-found (format "> Error: Could not find ~a\n" config:list-file)

    'item-not-found "> Error: Could not find that item\n"

    'init-y/n (format "> A list file will be created at ~a\n> Are you sure you want to continue? [y/n]\n" config:list-file)

    'try-init (format "> Try typing the following to setup ~a:\n~a ~a\n" config:program-name config:program-name (car config:initialize-commands))

    'terminating (format "> Exited ~a\n" config:program-name)

    'choose-y/n "> Error: Please choose y or n\n"

    'not-in-list "> Error: Item does not exist\n"

    'item-added "> Added \"~a\" to your list\n"

    'item-removed "> Removed \"~a\" from your list\n"))


(define y/n (hash 'yes '("yes" "Yes" "y" "Y")
                  'no  '("no" "No" "n" "N")))
