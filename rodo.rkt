#! /usr/bin/env racket
#lang racket/base

(require (prefix-in args: "args.rkt"))

(define (main)
  (args:check-args (current-command-line-arguments)))

(main)
