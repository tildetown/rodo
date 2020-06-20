#lang racket/base

(require racket/file
         racket/list
         racket/match
         racket/string)

;; ------------------------------------------------
;; values
;; ------------------------------------------------
(define help-command        "help")
(define ls-command          "ls")
(define rm-command          "rm")
(define add-command         "add")
(define program-name        "rodo")
(define program-name-dotted (string-append "." program-name))
(define home-directory-path (find-system-path 'home-dir))
(define program-path        (build-path home-directory-path program-name-dotted))
(define correct-permissions 384) ;; -rw------- permissions
(define message-prefix      "> ")

;; ------------------------------------------------
;; messages
;; ------------------------------------------------
(define messages
  (hash
   'error-add                (list (format "Error: No arguments were found after the '~a' command." add-command)
                                   (format "Suggestion: Try using a quoted argument after the '~a' command." ls-command)
                                   (format "Example: ~a add \"Go for a walk\"" program-name))

   'item-not-found           (list         "Error: Item not found."
                                   (format "Suggestion: Try using the '~a' command to see which number " ls-command)
                                           "            correlates to which message in your list."
                                   (format "Example: ~a ~a" program-name ls-command))

   'error-rm                 (list (format "Error: No arguments were found after the '~a' command." rm-command)
                                   (format "Suggestion: Try using a number after the '~a' command." rm-command)
                                   (format "Example: ~a ~a 2" program-name rm-command)
                                   ""
                                   (format "Note: You may need to run the '~a' command to see which " ls-command)
                                           "      number correlates to which item in your list."
                                   (format "Example: ~a ~a" program-name ls-command))

   'error-usage              (list         "Error: Incorrect usage."
                                   (format "Suggestions: Try running the '~a' command." help-command)
                                   (format "Example: ~a ~a" program-name help-command))

   'error-ls                 (list (format "Error: Found arguments after the '~a' command." ls-command)
                                   (format "Suggestions: Try using '~a' without any arguments." ls-command)
                                   (format "Example: ~a ~a" program-name ls-command))

   'error-fake-file          (list (format "Error: A '~a' directory was found in your home directory." program-name-dotted)
                                   (format "Suggestion 1: Move the '~a' directory out of your " program-name-dotted)
                                   (format "              home directory before using ~a." program-name)
                                   (format "Suggestion 2: Rename the '~a' directory before using ~a." program-name-dotted program-name))

   'error-permissions-prompt (list (format "Error: '~a''s permissions are incorrect." program-path)
                                           "Would you like to fix them? [y/n]")

   'cancel-creation          (list (format "Cancelled the creation of ~a." program-path))

   'permissions-fixed        (list (format "'~a''s permissions were successfully fixed." program-path))

   'file-created             (list (format "'~a' was successfully created." program-path))

   'not-found-prompt         (list (format "'~a' wasn't found." program-path)
                                           "Would you like to create it? [y/n]")

   'error-option             (list "Error: '~a' is not an option.")

   'empty-list               (list "There is nothing in your list.")

   'added                    (list "'~a' was added to your list.")

   'removed                  (list "'~a' was removed from your list.")))

;; ------------------------------------------------
;; helpers
;; ------------------------------------------------
(define (messages-ref key)
  (map (lambda (element) (string-append message-prefix element))
       (hash-ref messages key)))

(define-syntax-rule (displayln-message-format key string ...)
  (let ([string-to-format (string-join (messages-ref key) "\n")])
    (displayln (format string-to-format string ...))))

(define (displayln-message-list key)
  (let ([listof-strings (messages-ref key)])
    (for ([string listof-strings])
      (displayln string))))

(define (displayln-for . strings)
  (for ([string strings])
    (displayln string)))

(define (file-has-correct-permissions? file)
  (equal? correct-permissions (file-or-directory-permissions file 'bits)))

;; ------------------------------------------------
;; repair
;; ------------------------------------------------
(define (repair/not-an-option user-input)
  (displayln-message-format 'error-option user-input)
  (exit))

(define (repair/cancel)
  (displayln-message-list 'cancel-creation)
  (exit))

(define (repair/fake-file)
  (displayln-message-list 'error-fake-file)
  (exit))

(define (repair/create-exit-mode key)
  (match key
    [(or 'ls 'rm) (exit)]
    ['add         'do-nothing]))

(define (repair/fix-permissions key)
  (file-or-directory-permissions program-path correct-permissions)
  (displayln-message-list 'permissions-fixed)
  (repair/create-exit-mode key))

(define (repair/wrong-permissions key)
  (displayln-message-list 'error-permissions-prompt)
  (display message-prefix)
  (let ([user-input (read-line)])
    (case (string->symbol user-input)
      ['y   (repair/fix-permissions key)]
      ['n   (repair/cancel)]
      [else (repair/not-an-option user-input)])))

(define (repair/create-file key)
  (close-output-port (open-output-file program-path))
  (file-or-directory-permissions program-path correct-permissions)
  (displayln-message-list 'file-created)
  (repair/create-exit-mode key))

(define (repair/not-found key)
  (displayln-message-list 'not-found-prompt)
  (display message-prefix)
  (let ([user-input (read-line)])
    (case (string->symbol user-input)
      ['y   (repair/create-file key)]
      ['n   (repair/cancel)]
      [else (repair/not-an-option user-input)])))

(define (repair key)
  (cond
    [(directory-exists? program-path)
     (repair/fake-file)]

    [(not (file-exists? program-path))
     (repair/not-found key)]

    [(not (file-has-correct-permissions? program-path))
     (repair/wrong-permissions key)]

    [else 'do-nothing]))

;; ------------------------------------------------
;; ls
;; ------------------------------------------------
(define (ls/display-list listof-items)
  ;; add1 starts the listof-numbers at 1 instead of 0
  (let* ([listof-numbers        (map add1 (range (length listof-items)))]
         [listof-number-strings (map number->string listof-numbers)]
         [combine-lists         (lambda (a b) (string-append a ". " b))]
         [listof-numbered-items (map combine-lists
                                     listof-number-strings
                                     listof-items)])
    (for ([item listof-numbered-items])
      (displayln item))))

(define (ls)
  (repair 'ls)
  (let ([listof-items (file->lines program-path)])
    (if (null? listof-items)
        (displayln-message-list 'empty-list)
        (ls/display-list listof-items))))

;; ------------------------------------------------
;; rm
;; ------------------------------------------------
(define (rm/remove-item listof-items item-number)
  (let* ([item-to-remove    (list-ref listof-items item-number)]
         [list-without-item (remove item-to-remove listof-items)])
    (display-lines-to-file list-without-item
                           program-path
                           #:exists 'truncate)
    (displayln-message-format 'removed item-to-remove)))

(define (rm string)
  (repair 'rm)
  (let* ([listof-items (file->lines program-path)]
         ;; subtract 1 because the index starts at
         ;; 0 under the hood, but the numbers presented from 'ls'
         ;; start at 1.
         [item-number       (string->number string)]
         [item-number-sub1  (sub1 item-number)]
         [list-length       (length listof-items)])
    (if (and (not (null? listof-items))
             (number? item-number)
             (positive? item-number)
             ;; 1 less than length, because we want to
             ;; remove the index number, which is one less
             ;; than the item the user chose
             ;; Example:
             ;; We have a list length of 3:
             ;; '(1 2 3)
             ;; `list-ref` in rm/remove-item above
             ;; uses an index that starts at 0, so
             ;; the index of the numbers above are:
             ;; '(0 1 2)
             ;; The 2 is the last index number in a
             ;; list of length 3, which is what we
             ;; want, because if you try to remove
             ;; an index larger than 2, such as the
             ;; list length 3, then that would be
             ;; an error
             (< item-number-sub1 list-length))
        (rm/remove-item listof-items item-number-sub1)
        (displayln-message-list 'item-not-found))))

;; ------------------------------------------------
;; add
;; ------------------------------------------------
;; The string-cleaned and -remade is incase there
;; are multiple newline characters. This ensures
;; there is only one newline character.
(define (add string)
  (repair 'add)
  (let* ([string-no-newline (string-replace string "\n" "")]
         [string-newline    (string-append string-no-newline "\n")])
    (display-to-file string-newline
                     program-path
                     #:exists 'append)
    (displayln-message-format 'added string-no-newline)))

;; ------------------------------------------------
;; help
;; ------------------------------------------------
(define (help)
  (displayln-for
   "Usage:"
   (format "  ~a [<command>] [<args>]" program-name)
   ""
   "Commands:"
   (format "  ~a - Adds an item to your list." add-command)
   (format "  ~a - Prints a numbered list of your items." ls-command)
   (format "  ~a - Removes an item from your list." rm-command)
   ""
   "Examples:"
   (format "  ~a ~a \"Go for a walk\"" program-name add-command)
   (format "  ~a ~a" program-name ls-command)
   (format "  ~a ~a 2" program-name rm-command)))

(define (process-args vectorof-args)
  (define (args-ref number)
    (vector-ref vectorof-args number))
  (match vectorof-args
    ;; Proper usage
    [(or '#("-h")
         '#("--help")
         '#(help-command))  (help)]
    [(vector add-command _) (add (args-ref 1))]
    [(vector rm-command _)  (rm  (args-ref 1))]
    [(vector ls-command)    (ls)]
    ;; Improper usage
    ;; This is checked so we can give the user hints on how to
    ;; use the software if they have part of the command
    ;; correct
    [(vector ls-command _) (displayln-message-list 'error-ls)]
    [(vector add-command)  (displayln-message-list 'error-add)]
    [(vector rm-command)   (displayln-message-list 'error-rm)]
    [(or (vector)
         (vector _ ...))   (displayln-message-list 'error-usage)]))

(define (main vectorof-args)
  (process-args vectorof-args))

(main (current-command-line-arguments))
