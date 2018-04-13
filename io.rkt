#lang racket/base

(require racket/file
         "config.rkt")

(provide (all-defined-out))

(define (check-for-file)
  (file-exists?
    (expand-user-path
      (string-append
        program-path
        program-directory
        program-file))))

(define (create-file)
  (let
    ([path
       (expand-user-path
         (string-append
           program-path
           program-directory
           program-file))])
    (let
      ([opened-file
         (open-output-file
           path
           #:mode 'text
           #:exists 'can-update)])
      (close-output-port opened-file))))

(define (check-for-folder)
  (directory-exists?
    (expand-user-path
      (string-append
        program-path
        program-directory))))

(define (create-folder)
  (make-directory
    (expand-user-path
      (string-append
        program-path
        program-directory))))
