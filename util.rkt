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
  ;; Subtract one from what the user chose, because they are
  ;; are actually viewing the list numbers as human numbers,
  ;; so what they see is actual-number +1
  (list-ref (file->string-list lst) (sub1 (string->number args))))

(define (surround-item-in-quotation-marks args)
  (display (string-append "\"" args "\"")))

(define (prefix-item-with-period lst)
  (string-append lst ". "))

(define (prefix-item-with-number lst)
  (map string-append
       ;; Note: compose starts from the last element in it's
       ;; list, so that would be add1 here
       (map (compose prefix-item-with-period number->string add1)
            (list:range (length lst)))
       lst))

(define (display-prettified-program-file)
  (display
   (string:string-join
    (prefix-item-with-number (file->string-list config:path-to-file))
    "\n"
    #:after-last "\n")))

;; This one is pretty wild
(define (append-item-to-end args lst)
  (reverse (cons args (reverse (file->string-list lst)))))

(define (display-item-added args)
  (display-hash-ref messages:messages 'item-added-prefix)
  (surround-item-in-quotation-marks args)
  (display-hash-ref messages:messages 'item-added-suffix))

(define (display-item-removed args)
  (display-hash-ref messages:messages 'item-removed-prefix)
  (surround-item-in-quotation-marks args)
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
      ;; The cdr here prevents the first command line argument ("add")
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
