#lang racket/base

(require (prefix-in config: "config.rkt"))

(provide (all-defined-out))

(define messages
  (hash
   'show-help (string-append
               "Usage\n"
               "======\n"
               "If using the "
               "<" config:initialize-command ">" " or "
               "<" config:list-command ">" " commands, follow the structure below:\n"
               config:program-name " <command>\n"
               "\n"

               "If using the "
               "<" config:add-command ">" " or "
               "<" config:remove-command ">" " commands, follow the structure below:\n"
               config:program-name " <command> [argument]\n"
               "\n"

               "Commands\n"
               "======\n"

               "<" config:initialize-command ">" ":\n"
               "Create a file in "
               config:program-directory
               config:program-file
               " where your todo list will be stored\n"
               "Example:\n"
               config:program-name " "
               config:initialize-command "\n"
               "\n"

               "<" config:list-command ">" ":\n"
               "Displays items in the list\n"
               "Example:\n"
               config:program-name " "
               config:list-command "\n"
               "\n"

               "<" config:add-command ">" " "
               "[argument]:\n"
               "Adds an item to the list\n"
               "Example:\n"
               config:program-name " "
               config:add-command " "
               "bread\n"
               config:program-name " "
               config:add-command " "
               "this is an unquoted task\n"
               config:program-name " "
               config:add-command " "
               "\"this is a quoted task which isn't any different from an unquoted task\"\n"
               "\n"

               "<" config:remove-command ">" " "
               "[argument]:\n"
               "Removes an item from the list\n"
               "Example:\n"
               config:program-name " " config:remove-command " " "1\n"
               "\n"

               "Note: You may have to run "
               "`" config:program-name " " config:list-command "`" " "
               "see which number corresponds to which item in the list."
               " In the example above, the first item was removed from the list\n"
               "\n"

               "Can't see this whole help message?\n"
               "======\n"
               "Try running "
               "`" config:program-name " -h | less` to use the arrow keys "
               "to scroll up and down through the help message\n")

   'empty-todo-list "> There is nothing in your list \n"

   'show-usage (string-append
                "> For usage type "
                "`" config:program-name " -h`"
                " or "
                "`" config:program-name " --help`\n")

   'creating (string-append
              "> Creating "
              config:program-file
              " file in "
              config:program-directory "\n")

   'creation-error (string-append
                    "> Error: Could not create "
                    config:program-file
                    " in "
                    config:program-directory
                    ".\n"
                    "> This may be due to directory permissions\n")

   'file-already-exists (string-append
                         "> Error: "
                         config:program-name
                         " already exists in "
                         config:program-directory
                         config:program-file "\n")

   'successfully-created (string-append
                          "> "
                          config:program-directory
                          config:program-file
                          " has been successfully created\n")

   'file-not-found (string-append
                    "> Error: Could not find "
                    config:program-directory
                    config:program-file "\n")

   'init-y/n (string-append
              "> A "
              config:program-file
              " file will be created in the directory "
              config:program-directory "\n"
              "> Are you sure you want to continue? [y/n]\n")

   'try-init (string-append
              "> Try typing "
              "`" config:program-name " init` "
              "to set it up\n")

   'terminating (string-append
                 "> Exiting "
                 config:program-name
                 "\n")

   'choose-y/n "> Error: Please choose y or n\n"

   'not-in-list "> Error: Item does not exist\n"

   'item-added-prefix "> Added "

   'item-added-suffix " to list\n"

   'item-removed-prefix "> Removed "

   'item-removed-suffix " from list\n"))

(define y/n
  (hash
   'yes '("yes" "Yes" "y" "Y")

   'no '("no" "No" "n" "N")))
