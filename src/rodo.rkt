#lang racket/base
(require (prefix-in args: "args.rkt"))

(define (main args)
  (args:check-args (vector->list args)))

(main (current-command-line-arguments))
