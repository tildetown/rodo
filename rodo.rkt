#! /usr/bin/env racket
#lang racket/base

(require "args.rkt")

(define (main)
  (check-args (current-command-line-arguments)))

(main)
