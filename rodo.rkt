#lang racket/base

(require (prefix-in args: "args.rkt"))

(define (main args)
  (let ([args-converted (vector->list args)])
    (args:check-args args-converted)))

(main (current-command-line-arguments))
