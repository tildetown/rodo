#! /usr/bin/env racket
#lang racket/base

(require (prefix-in args: "args.rkt"))

(define (main args)
  (args:check-args args))

(main (current-command-line-arguments))
