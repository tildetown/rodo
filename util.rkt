#lang racket/base

(require (prefix-in list: racket/list)
         (prefix-in file: racket/file)
         (prefix-in string: racket/string)
         (prefix-in config: "config.rkt")
         (prefix-in messages: "messages.rkt"))

(provide (all-defined-out))

(define (check-for-file)
  (file-exists? config:path))

(define (create-file)
  (let ([opened-file
         (open-output-file config:path
                           #:mode 'text
                           #:exists 'can-update)])
    (close-output-port opened-file)))

(define (check-for-folder)
  (directory-exists? (expand-user-path
                      (string-append
                       config:program-path
                       config:program-directory))))

(define (create-folder)
  (make-directory (expand-user-path
                   (string-append
                    config:program-path
                    config:program-directory))))

(define (display-hash-ref hash-list key)
  (display (hash-ref hash-list key)))

;; Just so I don't have to keep typing
;; "#:mode...#:line-mode..." every time
(define (file->string-list config:path-to-file)
  (let ([todo-list (file:file->lines config:path-to-file
                                     #:mode 'text
                                     #:line-mode 'any)])
    todo-list))

(define (list-empty? lst)
  (list:empty? (file->string-list lst)))

;; Find out which item is being removed by scooping up
;; the number the user entered in the command line
;; argument
(define (get-removed-item lst args)
  ;; Subtract one from what the user chose, because they are
  ;; are actually viewing the list numbers as human numbers
  ;; so (actual-number +1)
  (list-ref (file->string-list lst) (sub1 (string->number args))))

(define (surround-in-quotes args)
  (display (string-append "\"" args "\"")))

(define (prefix-with-period lst)
  (string-append lst ". "))

(define (prefix-with-number lst)
  ;; Connect the list of numbers to the list of items
  (map string-append
       (map prefix-with-period
            ;; 3. Convert the numbers made below into strings
            ;; so we can append them to other strings
            (map number->string
                 ;; 2. The add1 here makes the numbers more human by
                 ;; starting at 1 instead of 0
                 (map add1
                      ;; 1. Create a list of numbers from the total
                      ;; number of items in a list
                      (list:range (length lst)))))
       ;; This is just the original list that everything will
       ;; be appended to
       lst))

(define (display-prettified-list)
  (display
   (string:string-join
    (prefix-with-number (file->string-list config:path))
    "\n"
    #:after-last "\n")))

;; This is a bit of ugly scheme sorcery
(define (append-to-end args lst)
  (reverse (cons args (reverse (file->string-list lst)))))

(define (display-item-added args)
  (display-hash-ref messages:messages 'item-added-prefix)
  (surround-in-quotes args)
  (display-hash-ref messages:messages 'item-added-suffix))

(define (display-item-removed args)
  (display-hash-ref messages:messages 'item-removed-prefix)
  (surround-in-quotes args)
  (display-hash-ref messages:messages 'item-removed-suffix))

(define (show-list)
  (cond [(and
          (check-for-folder)
          (check-for-file))
         (if
          ;; If file exists, see if it's empty, if so
          ;; tell the user
          (list-empty? config:path)
          (display-hash-ref messages:messages 'empty-todo-list)
          ;; If file isn't empty, display a pretty list
          (display-prettified-list))]

        ;; If file doesn't exist, tell the user
        [else
         (display-hash-ref messages:messages 'file-not-found)
         (display-hash-ref messages:messages 'try-init)]))

(define (add-item-to-file args)
  ;; Add item to end of list and write to file
  (let ([new-list (append-to-end args config:path)])
    (file:display-to-file
     (string:string-join new-list "\n")
     config:path
     #:mode 'text
     #:exists 'replace)
    (display-item-added args)))

(define (add-item args)
  (if (and
       (check-for-folder)
       (check-for-file))
      (add-item-to-file (vector-ref args 1))
      (begin
        (display-hash-ref messages:messages 'file-not-found)
        (display-hash-ref messages:messages 'try-init))))

(define (remove-item-from-file args)
  (let ([removed-item (get-removed-item config:path args)]
        ;; Todo:
        ;; Some how add removed-item here, instead of
        ;; repeating (get-removed-item config:path args).
        ;; This is still a mystery to me
        [new-list (remove
                   (get-removed-item config:path args)
                   (file->string-list config:path))])
    (file:display-to-file
     (string:string-join new-list "\n")
     config:path
     #:mode 'text
     #:exists 'replace)
    (display-item-removed removed-item)))

(define (remove-item args)
  (cond [(list-empty? config:path)
         (display-hash-ref messages:messages 'empty-todo-list)]

        [(and
          (check-for-folder)
          (check-for-file))
         (remove-item-from-file (vector-ref args 1))]

        [(and (not (check-for-folder)) (not (check-for-file)))
         (begin
           (display-hash-ref messages:messages 'file-not-found)
           (display-hash-ref messages:messages 'try-init))]))
