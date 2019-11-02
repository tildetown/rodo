#lang racket/base

(require (prefix-in list: racket/list)
         (prefix-in file: racket/file)
         (prefix-in string: racket/string)
         (prefix-in config: "config.rkt")
         (prefix-in messages: "messages.rkt"))

(provide (all-defined-out))

(define (check-for-program-file)
  (file-exists? config:path-to-file))

(define (create-program-file)
  (let ([opened-file (open-output-file config:path-to-file
                                       #:mode 'text
                                       #:exists 'truncate)])
    (close-output-port opened-file))
  (file-or-directory-permissions config:path-to-file #o600))

(define (check-for-program-directory)
  (directory-exists? config:program-directory))

(define (create-program-directory)
  (make-directory config:program-directory)
  (file-or-directory-permissions config:program-directory #o700))

(define (display-hash-ref hash-list key)
  (display (hash-ref hash-list key)))

(define (file->string-list config:path-to-file-to-file)
  (let ([todo-list (file:file->lines config:path-to-file-to-file
                                      #:mode 'text
                                      #:line-mode 'any)])
    todo-list))

(define (list-empty? lst)
  (list:empty? (file->string-list lst)))

(define (get-removed-item lst args)
  (list-ref (file->string-list lst) (string->number args)))

(define (surround-with-quotation-marks args)
  (display (string-append "\"" args "\"")))

(define (list->dotted-list lst)
  (string-append lst "." " "))

(define (list->numbered-list lst)
  ;; Take the list made in the first (map), which is
  ;; '(0 1 2 ...), and append that to each item in a list
  (map string-append
       ;; Note: compose starts from the last element in it's
       ;; list. In this case, it starts at (number->string).
       (map (compose1 list->dotted-list number->string)
            (list:range (length lst)))
       lst))

(define (display-prettified-program-file)
  (display (string:string-join
            (list->numbered-list (file->string-list config:path-to-file))
            "\n"
            #:after-last "\n")))

(define (append-item-to-end args lst)
  (reverse (cons args (reverse (file->string-list lst)))))

(define (display-item-added args)
  (display-hash-ref messages:messages 'item-added-prefix)
  (surround-with-quotation-marks args)
  (display-hash-ref messages:messages 'item-added-suffix))

(define (display-item-removed args)
  (display-hash-ref messages:messages 'item-removed-prefix)
  (surround-with-quotation-marks args)
  (display-hash-ref messages:messages 'item-removed-suffix))

(define (show-list-from-program-file)
  (cond [(and
          (check-for-program-directory)
          (check-for-program-file))
         (if
          (list-empty? config:path-to-file)
          (display-hash-ref messages:messages 'empty-todo-list)
          (display-prettified-program-file))]
        [else
         (display-hash-ref messages:messages 'file-not-found)
         (display-hash-ref messages:messages 'try-init)]))

(define (write-item-to-program-file args)
  ;; Add an item to the end of a list and write to a file
  (let ([new-list (append-item-to-end args config:path-to-file)])
    (file:display-to-file
     (string:string-join new-list "\n") config:path-to-file
     #:mode 'text
     #:exists 'truncate)
    ;; After writing to the file, tell the user what was written
    (display-item-added args)))

(define (add-item-to-list args)
  (if (and (check-for-program-directory)
           (check-for-program-file))
      ;; The cdr here prevents user commands, such as "add"
      ;; from being added to the file
      (write-item-to-program-file (string:string-join (cdr (vector->list args))))
      ;; Else
      (begin
        (display-hash-ref messages:messages 'file-not-found)
        (display-hash-ref messages:messages 'try-init))))

(define (remove-item-from-program-file args)
  (let* ([removed-item (get-removed-item config:path-to-file args)]
         [new-list (remove removed-item (file->string-list config:path-to-file))])
    (file:display-to-file
     (string:string-join new-list "\n")
     config:path-to-file
     #:mode 'text
     #:exists 'truncate)
    (display-item-removed removed-item)))

(define (remove-item-from-list args)
  (cond [(list-empty? config:path-to-file)
         (display-hash-ref messages:messages 'empty-todo-list)]
        [(and (check-for-program-directory)
              (check-for-program-file))
         (remove-item-from-program-file (vector-ref args 1))]
        [(and (not (check-for-program-directory))
              (not (check-for-program-file)))
         (begin
           (display-hash-ref messages:messages 'file-not-found)
           (display-hash-ref messages:messages 'try-init))]))
