#lang racket/base

(require (prefix-in config: "config.rkt"))

(provide (all-defined-out))

(define (indent string)
  (string-append "\t" string))

(define messages
  (hash
   'show-help
     (string-append "\n"
                    "Conventions used in this help message\n"
                    "====================================="
                    "\n\n"
                    "[command]  - [command]s should be replaced by a command from the Command section below without the surrounding \"[\" and \"]\"s."
                    "\n\n"
                    "<argument> - <argument>s should be replaced by user input without the surrounding \"<\" and \">\"s."
                    "\n\n"
                    "Command descriptions\n"
                    "===================="
                    "\n\n"

                    ;; initialize-command
            (format "~a" (car config:initialize-commands))
                    "\n\n"
    (indent (format "Creates a list in ~a." config:list-file))
                    "\n\n"

                    ;; list-command
            (format "~a" (car config:list-commands))
                    "\n\n"
            (indent "Displays items in your list.")
                    "\n\n"

                    ;; add-command
            (format "~a" (car config:add-commands))
                    "\n\n"
            (indent "Adds an item to your list.")
                    "\n\n"

                    ;; remove-command
            (format "~a" (car config:remove-commands))
                    "\n\n"
            (indent "Removes an item from your list.")
                    "\n\n"

                    "Usage examples\n"
                    "=============="
                    "\n\n"

                    ;; initialize-command
            (format "~a" (car config:initialize-commands))
                    "\n\n"
    (indent (format "~a ~a" config:program-name (car config:initialize-commands)))
                    "\n\n"

                    ;; list-command
            (format "~a" (car config:list-commands))
                    "\n\n"
    (indent (format "~a ~a" config:program-name (car config:list-commands)))
                    "\n\n"

                    ;; add-command
            (format "~a" (car config:add-commands))
                    "\n\n"
    (indent (format "~a ~a this is an item without double quotation marks" config:program-name (car config:add-commands)))
                    "\n\n"
    (indent (format "~a ~a \"this is an item surrounded by double quotation marks\"" config:program-name (car config:add-commands)))
                    "\n\n"
            (indent "Note: Grave accents (`) and single quotation marks (\') cannot be used with this command.")
                    "\n\n"

                    ;; remove-command
            (format "~a" (car config:remove-commands))
                    "\n\n"
    (indent (format "~a ~a 2" config:program-name (car config:remove-commands)))
                    "\n\n"
            (indent "Note: The example above will remove the third item from your list, because the list starts at zero.")
                    "\n\n"

                    "Can't see the whole help message?\n"
                    "================================="
                    "\n\n"
            (format "Try running \"~a -h | less\" (without the double quotation marks), so you can use the arrow keys to scroll up and down." config:program-name)
                    "\n\n"
                    "When you want to quit, type \"q\" (without the double quotation marks)."
                    "\n\n")

        'empty-list "> There is nothing in your list.\n"

        'show-usage (format "> For usage type \"~a -h\" (without the double quotation marks).\n" config:program-name)

        'creating (format "> Creating a list in ~a...\n" config:list-file)

        'creation-error (format "> Error: Could not create a list file in ~a.\n" config:list-file)

        'file-already-exists (format "> Error: A list file already exists in ~a.\n" config:list-file)

        'successfully-created (format "> Your list file was successfully created in ~a.\n" config:list-file)

        'file-not-found (format "> Error: Could not find ~a.\n" config:list-file)

        'item-not-found "> Error: Could not find that item.\n"

        'init-y/n (format (string-append "> A list file will be created in ~a.\n"
                                         "> Are you sure you want to continue? [y/n].\n")
                          config:list-file)

        'try-init (format "> Try typing \"~a ~a\" to set it up (without the double quotation marks).\n"
                          config:program-name (car config:initialize-commands))

        'terminating (format "> Exited ~a.\n" config:program-name)

        'choose-y/n "> Error: Please choose y or n\n"

        'not-in-list "> Error: Item does not exist\n"

        'item-added "> Added \"~a\" to your list\n"

        'item-removed "> Removed \"~a\" from your list\n"))


(define y/n (hash 'yes '("yes" "Yes" "y" "Y")
                  'no  '("no" "No" "n" "N")))
