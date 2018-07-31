#lang racket/base

(require "config.rkt")

(provide (all-defined-out))

(define messages
  (hash
    'show-help
    (string-append
      "* " initialize-command ": "
      "initialize a file in "
      program-path
      program-directory
      program-file
      "\n"
      "\x09Example: "
      "rodo init\n\n"

      "* " list-command ": "
      "lists items on the list"
      "\n"
      "\x09Example: "
      "rodo ls\n\n"

      "* " add-command ": "
      "adds an item to the list"
      "\n"
      "\x09Example: "
      "rodo add bread\n\n"
      "\x09Note: For multi-word items you will need to\n"
      "\x09surround your item in double quotes as so:\n"
      "\x09rodo add \"go to the bank\"\n"

      "* " remove-command ": "
      "removes an item from the list\n"
      "\x09Example: "
      "rodo rm 1\n"
      "\x09Note: You may have to run `rodo ls` to see which\n"
      "\x09number corresponds to which item to remove it.\n")

    'empty-todo-list
    "> There is nothing in your list \n"

    'show-usage
    (string-append
      "> For usage type "
      "`" program-name " -h`"
      " or "
      "`" program-name " --help`\n")

    'creating-folder
    (string-append
      "> creating a "
      program-directory
      " folder in "
      program-path " ...\n")

    'creating-file
    (string-append
      "> creating a "
      program-file
      " file in "
      program-path
      program-directory " ...\n")

    'creation-error
    (string-append 
      "> Error: Could not create "
      program-file
      " in "
      program-directory
      program-path ".\n"
      "> This may be due to directory permissions\n")

    'file-already-exists
    (string-append
      "> Error: "
      program-name
      " already exists in "
      program-path
      program-directory
      program-file "\n")

    'successfully-created
    (string-append
      "> "
      program-path
      program-directory
      program-file
      " has been successfully created\n")

    'file-not-found
    (string-append
      "> Error: Could not find "
      program-path
      program-directory
      program-file "\n")

    'init-y/n
    (string-append
      "> A "
      program-file
      " file will be created in "
      program-path
      program-directory "\n"
      "> Are you sure you want to continue? [y/n]\n")

    'try-init
    (string-append
      "> Try typing "
      "`" program-name " init` "
      "to set it up\n")

    'terminating
    (string-append
      "> Exiting "
      program-name
      " ...\n")

    'choose-y/n
    "> Error: Please choose y or n\n"

    'not-in-list
    "> Error: Item does not exist\n"

    'item-added-prefix
    "> Added "

    'item-added-suffix
    " to list\n"

    'item-removed-prefix
    "> Removed "

    'item-removed-suffix
    " from list\n"))

(define y/n
  (hash
    'yes
    '("yes" "Yes" "y" "Y")

    'no
    '("no" "No" "n" "N")))
