#lang racket/base

(require (prefix-in config: "config.rkt"))

(provide (all-defined-out))

(define messages
  (hash
   'show-help (string-append
               "Usage\n"
               "=====\n"
               (format "If you want to use the ~a or ~a commands, follow the structure below:\n"
                       config:initialize-command
                       config:list-command)
               (format "~a <command>\n\n"
                       config:program-name)

               (format "If you want to use the ~a or ~a commands, follow the structure below:\n"
                       config:add-command
                       config:remove-command)
               (format "~a <command> [argument]\n\n" config:program-name)

               "Note: Replace <command> with one of the Commands below without the surrounding \"<\" and \">\".\n\n"

               "Commands\n"
               "========\n"
               (format "This section describes the commands available for ~a.\n\n" config:program-name)
               (format "Note: The commands mentioned in this section should replace the \"<command>\" filler text found in the Usage section above.\n\n")

               ;; init
               (format "~a\n" config:initialize-command)
               "====\n"
               (format "Creates ~a in ~a. This is where your todo list will be stored.\n\n"
                       config:list-file
                       config:program-directory)

               "Example:\n"
               (format "~a ~a\n\n" config:program-name config:initialize-command)

               ;; ls
               (format "~a\n" config:list-command)
               "====\n"
               "Displays items in your todo list.\n\n"

               "Example:\n"
               (format "~a ~a\n\n" config:program-name config:list-command)

               (format "~a [argument(s)]\n" config:add-command)
               "=================\n"
               "Adds an item to the list.\n\n"

               "Examples:\n"
               (format "~a ~a this is an unquoted item\n" config:program-name config:add-command)
               (format "~a ~a \"this is a quoted item\"\n\n" config:program-name config:add-command)

               (format "~a [argument]\n" config:remove-command)
               "=============\n"
               "Removes an item from the list.\n\n"

               "Example:\n"
               (format "~a ~a 1\n\n" config:program-name config:remove-command)

               (format "Note: You may have to run `~a ~a` to see which number corresponds to which item in your todo list."
                       config:program-name
                       config:list-command)
               " "
               "In the example above, the first item was removed from the todo list.\n\n"

               "Can't see the whole help message?\n"
               "=================================\n"
               (format "Try running `~a -h | less` so you can use the arrow keys to scroll up and down."
                       config:program-name)
               " "
               "When you want to quit, type `q` (without the grave accents).\n")

   'empty-todo-list "> There is nothing in your list.\n"

   'show-usage (format "> For usage type `~a -h` or `~a --help`.\n"
                       config:program-name
                       config:program-name)

   'creating (format "> Creating ~a in ~a.\n"
                     config:list-file
                     config:program-directory)

   'creation-error (string-append
                    (format "> Error: Could not create a(n) ~a in ~a.\n"
                            config:list-file
                            config:program-directory)
                    "> This might be due to directory permissions.\n")

   'file-already-exists (format "> Error: ~a already exists in ~a~a.\n"
                                config:program-name
                                config:program-directory
                                config:list-file)

   'successfully-created (format "> ~a has been successfully created in ~a.\n"
                                 config:program-directory
                                 config:list-file)

   'file-not-found (format "> Error: Could not find ~a~a\n"
                           config:program-directory
                           config:list-file)

   'item-not-found "> Error: Could not find that item\n"

   'init-y/n (string-append
              (format "> ~a will be created in ~a.\n"
                      config:list-file
                      config:program-directory)
              "> Are you sure you want to continue? [y/n]\n")

   'try-init (format "> Try typing `~a ~a` to set it up (without the grave accents).\n"
                     config:program-name
                     (car config:initialize-command))

   'terminating (format "> Exiting ~a\n" config:program-name)

   'choose-y/n "> Error: Please choose y or n\n"

   'not-in-list "> Error: Item does not exist\n"

   'item-added-prefix "> Added "

   'item-added-suffix " to list\n"

   'item-removed-prefix "> Removed "

   'item-removed-suffix " from list\n"))

(define y/n (hash 'yes '("yes" "Yes" "y" "Y")
                  'no '("no" "No" "n" "N")))
