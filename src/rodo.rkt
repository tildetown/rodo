#lang racket/base

(require "args.rkt")

(define (main vectorof-args)
  (process-args vectorof-args))

(main (current-command-line-arguments))
