#lang racket/base

(require "config.rkt")

(provide (all-defined-out))

(define (d-hash-ref hash-list key)
  (display (hash-ref hash-list key)))

(define (d-vector-ref args key)
  (display (vector-ref args key)))
