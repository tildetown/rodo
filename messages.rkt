#lang racket/base

(require (prefix-in config: "config.rkt"))

(provide (all-defined-out))

(define messages
  (hash
   'show-help (string-append
               "Usage:"
               "\n"
               "rodo <command> [optional argument]\n"
               "\n"

               config:initialize-command ":\n"
               "Initialize a file in "
               config:program-directory
               config:program-file "\n"

               "Example: "
               "rodo init\n"
               "\n"

               config:list-command ":\n"
               "Lists items on the list"
               "\n"
               "Example: "
               "rodo ls\n"
               "\n"

               config:add-command ":\n"
               "Adds an item to the list"
               "\n"
               "Example: "
               "rodo add bread\n"
               "\n"

               "Note: For multi-word items you will need to\n"
               "surround your item in double quotes as so:\n"
               "rodo add \"go to the bank\"\n"
               "\n"

               config:remove-command ":\n"
               "Removes an item from the list\n"
               "Example: "
               "rodo rm 1\n"
               "\n"

               "Note: You may have to use the ls command to see\n"
               "which number corresponds to which item\n")

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
