#lang racket/base

(require "config.rkt")

(provide (all-defined-out))

(define messages
  (hash
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
