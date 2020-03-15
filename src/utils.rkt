#lang racket/base

(require (prefix-in     file: racket/file)
         (prefix-in     list: racket/list)
         (prefix-in   string: racket/string)
         (prefix-in   config: "config.rkt")
         (prefix-in messages: "messages.rkt"))

(provide (all-defined-out))

(define (create-file-600 a-file)
  (let ([opened-file (open-output-file a-file #:mode 'text #:exists 'truncate)])
    (close-output-port opened-file))
  (file-or-directory-permissions a-file #o600))

(define (create-directory-700 a-directory)
  (make-directory a-directory)
  (file-or-directory-permissions a-directory #o700))

(define (display-messages key-list)
  (for ([key key-list])
       (display (hash-ref messages:messages key))))

(define (list->ascending-numbers-list lst)
  (list:range (length lst)))

(define (list->dotted-ascending-numbers-list lst)
  (map (lambda (x) (string-append x ". "))
       (map number->string (list->ascending-numbers-list lst))))

(define (list->numbered-list lst)
  (map (lambda (x y) (string-append x y))
       (list->dotted-ascending-numbers-list lst)
       lst))

(define (file->vertically-numbered-list a-file)
  (string:string-join (list->numbered-list (file:file->lines a-file))
                      "\n"
                      #:after-last "\n"))

(define (surround-with-quotation-marks item)
  (string-append "\"" item "\""))

(define (display-item-added item-to-add)
  (display (format (hash-ref messages:messages 'item-added) item-to-add)))

(define (display-item-removed item-to-remove)
  (display (format (hash-ref messages:messages 'item-removed) item-to-remove)))

(define (check-list-conditions)
  (let ([file-exists?   (lambda () (file-exists? config:list-file))]
        [file-null?     (lambda () (null? (file:file->lines config:list-file)))])
    (cond
      [(and (file-exists?)
            (file-null?))
       (display-messages '(empty-list))]

      [(and (file-exists?)
            (not (file-null?)))
       (display (file->vertically-numbered-list config:list-file))]

      [(not (file-exists?))
       (display-messages '(file-not-found try-init))]

      [else (display-messages '(show-usage))])))

(define (append-element-to-end-of-list lst item-to-add)
  (reverse (cons item-to-add (reverse (file:file->lines lst)))))

(define (add-item-to-list args)
  (let* ([item-to-add (string:string-join (cdr args) " ")]
         [new-list (append-element-to-end-of-list config:list-file item-to-add)])
    (file:display-lines-to-file new-list
                                config:list-file
                                #:mode 'text
                                #:exists 'truncate)
    (display-item-added item-to-add)))

(define (check-add-conditions args)
  (if (and (file-exists? config:list-file))
    (add-item-to-list args)
    ;; Otherwise
    (display-messages '(file-not-found
                         try-init))))

(define (remove-item-from-list args)
  (let* ([item-to-remove (list-ref (file:file->lines config:list-file) args)]
         [new-list (remove item-to-remove (file:file->lines config:list-file))])
    (file:display-lines-to-file new-list config:list-file #:mode 'text #:exists 'truncate)
    (display-item-removed item-to-remove)))

(define (check-remove-conditions args)
  (cond
    ;; If directory and file exist, but file is empty
    [(and (directory-exists? config:program-directory)
          (file-exists?      config:list-file)
          (null?             config:list-file))
     (display-messages '(empty-list))]

    ;; If directory and file exist, and file is not empty
    [(and (directory-exists? config:program-directory)
          (file-exists?      config:list-file)
          (not (null?        config:list-file)))
     (let ([args   (string->number (list-ref args 1))]
           ;; Length subtract one because the numbering starts at zero
           [list-length (sub1 (length (file:file->lines config:list-file)))])
       (if (not (> args list-length))
         (remove-item-from-list args)
         ;; Otherwise
         (display-messages '(item-not-found))))]

    ;; If directory and file don't exist
    [(and (not (directory-exists? config:program-directory))
          (not (file-exists? config:list-file)))
     (display-messages '(file-not-found
                          try-init))]))
