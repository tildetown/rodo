#lang racket/base

(require (prefix-in args: "args.rkt"))

(define (main args)
  (args:check-args args))

(main (vector->list (current-command-line-arguments)))
