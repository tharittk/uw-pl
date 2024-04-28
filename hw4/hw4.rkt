
#lang racket

(provide (all-defined-out)) ;; so we can put tests in a second file

;; put your code below

; Q.1
(define (sequence low high stride)
  (if (> low high)
      null
      (cons low (sequence (+ low stride) high stride))))

; Q.2
(define (string-append-map xs suffix)
  (map (lambda (str) (string-append str suffix)) xs))

; Q.3
(define (list-nth-mod xs n)
  (cond [(< n 0) (error "list-nth-mod: negative number")]
        [(null? xs) (error "list-nth-mod: empty list")]
        [#t (car (list-tail xs (remainder n (length xs))))]))