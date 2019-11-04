#lang racket/base

(require (prefix-in list: racket/list)
         (prefix-in file: racket/file)
         (prefix-in string: racket/string)
         (prefix-in config: "config.rkt")
         (prefix-in messages: "messages.rkt"))

(provide (all-defined-out))

(define (list-file-exists?)
  (file-exists? config:path-to-list-file))

(define (program-directory-exists?)
  (directory-exists? config:program-directory))

(define (create-list-file-600 a-file)
  (let ([opened-file (open-output-file a-file
                                       #:mode 'text
                                       #:exists 'truncate)])
    (close-output-port opened-file))
  (file-or-directory-permissions a-file #o600))

(define (create-program-directory-700 a-directory)
  (make-directory a-directory)
  (file-or-directory-permissions a-directory #o700))

(define (display-hash-ref hash-list key)
  (display (hash-ref hash-list key)))

(define (file->string-list a-file)
  (let ([todo-list (file:file->lines a-file
                                     #:mode 'text
                                     #:line-mode 'any)])
    todo-list))

(define (list-file-empty? lst)
  (list:empty? (file->string-list lst)))

(define (get-removed-item lst args)
  (list-ref (file->string-list lst) (string->number args)))

(define (surround-with-quotation-marks args)
  (display (string-append "\"" args "\"")))

(define (list->list-of-dotted-numbers lst)
  (map (lambda (x) (string-append x ". "))
       (map number->string (list:range (length lst)))))

(define (list->numbered-list lst)
  (map (lambda (x y) (string-append x y))
       (list->list-of-dotted-numbers lst)
       lst))

(define (file->numbered-list-as-lines a-file)
  (string:string-join (list->numbered-list (file->string-list a-file))
                      "\n"
                      #:after-last "\n"))

(define (append-item-to-list args lst)
  (reverse (cons args (reverse (file->string-list lst)))))

(define (display-item-added args)
  (display-hash-ref messages:messages 'item-added-prefix)
  (surround-with-quotation-marks args)
  (display-hash-ref messages:messages 'item-added-suffix))

(define (display-item-removed args)
  (display-hash-ref messages:messages 'item-removed-prefix)
  (surround-with-quotation-marks args)
  (display-hash-ref messages:messages 'item-removed-suffix))

(define (show-list-from-file a-file)
  (cond [(and (program-directory-exists?)
              (list-file-exists?))
         (if (list-file-empty? a-file)
             (display-hash-ref messages:messages 'empty-todo-list)
             (display (file->numbered-list-as-lines a-file)))]
        [else
         (display-hash-ref messages:messages 'file-not-found)
         (display-hash-ref messages:messages 'try-init)]))

(define (write-item-to-file a-file args)
  (let ([new-list (append-item-to-list args a-file)])
    (file:display-to-file (string:string-join new-list "\n")
                          a-file
                          #:mode 'text
                          #:exists 'truncate))
  (display-item-added args))

;; The cdr here prevents user commands, such as "add" from being added to the file
(define (add-item-to-list a-file args)
  (if (and (program-directory-exists?)
           (list-file-exists?))
      (write-item-to-file a-file (string:string-join (cdr (vector->list args))))
      ;; Else
      (begin
        (display-hash-ref messages:messages 'file-not-found)
        (display-hash-ref messages:messages 'try-init))))

(define (remove-item-from-list-file a-file args)
  (let* ([removed-item (get-removed-item a-file args)]
         [new-list (remove removed-item (file->string-list a-file))])
    (file:display-to-file (string:string-join new-list "\n")
                          a-file
                          #:mode 'text
                          #:exists 'truncate)
    (display-item-removed removed-item)))

(define (remove-item-from-list a-file args)
  (cond [(list-file-empty? a-file)
         (display-hash-ref messages:messages 'empty-todo-list)]
        [(and (program-directory-exists?)
              (list-file-exists?))
         (remove-item-from-list-file a-file (vector-ref args 1))]
        [(and (not (program-directory-exists?))
              (not (list-file-exists?)))
         (begin
           (display-hash-ref messages:messages 'file-not-found)
           (display-hash-ref messages:messages 'try-init))]))
