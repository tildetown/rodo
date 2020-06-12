#lang racket/base

(require racket/file
         "config.rkt"
         "utils.rkt")

(provide (all-defined-out))

(define (process-args vectorof-args)
  (let ([lengthof-vector   (vector-length vectorof-args)])
    (cond
      ;; if no args
      [(= lengthof-vector 0)
       (displayln-messages '(show-usage))]

      ;; if more than 2 args
      ;; Note: The add command requires items to be surrounded
      ;;       in double quotes, so single quotation marks can
      ;;       be used by the user in their add command text.
      [(> lengthof-vector 2)
       (displayln-messages '(too-many-args show-usage))]

      ;; if help command
      [(and (= lengthof-vector 1)
            (equal? (vector-ref vectorof-args 0) help-command))
       (displayln-messages '(show-help))]

      ;; if initialize command
      [(and (= lengthof-vector 1)
            (equal? (vector-ref vectorof-args 0) initialize-command))
       (initialize)]

      ;; if list command
      [(and (= lengthof-vector 1)
            (equal? (vector-ref vectorof-args 0) list-command))
       (ls)]

      ;; if add command
      [(and (= lengthof-vector 2)
            (equal? (vector-ref vectorof-args 0) add-command))
       (add (vector-ref vectorof-args 1))]

      ;; if remove command
      [(and (= lengthof-vector 2)
            (equal?    (vector-ref vectorof-args 0) remove-command)
            (real?     (string->number (vector-ref vectorof-args 1)))
            (positive? (string->number (vector-ref vectorof-args 1))))
       (rm (string->number (vector-ref vectorof-args 1)))]

      [else (displayln-messages '(show-usage))])))
