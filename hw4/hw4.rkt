
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
  (cond [(negative? n) (error "list-nth-mod: negative number")]
        [(empty? xs) (error "list-nth-mod: empty list")]
        [#t (car (list-tail xs (remainder n (length xs))))]))

; Q.4
(define (stream-for-n-steps s n)
  (letrec ([f (lambda (stream ans)
              (let ([pr (stream)])
                (if (> ans n)
                    null
                    (cons (car pr) (f (cdr pr) (+ ans 1))))))])
   (f s 1)))

; Q.5
(define funny-number-stream
  (letrec ([f (lambda (x)
                ( if (= (remainder x 5) 0)
                     (cons (* -1 x) (lambda () (f (+ x 1))))
                     (cons x (lambda () (f (+ x 1))))))])
    (lambda () (f 1))))

; Q.6
(define dan-then-dog
  (letrec ([f (lambda (isDanTurn)
                (if isDanTurn
                (cons "dan.jpg" (lambda () (f #f)))
                (cons "dog.jpg" (lambda () (f #t)))))])
    (lambda () (f #t))))

; Q.7
(define (stream-add-zero s)
  (letrec ([pr (s)]
        [v (car pr)])
    (lambda () (cons (cons 0 v) (stream-add-zero (cdr pr))))))

; Q.8
(define (cycle-lists xs ys)
  (letrec ([f (lambda (n)
                (cons (cons (list-nth-mod xs n) (list-nth-mod ys n)) (lambda() (f (+ n 1)))))])
    (lambda () (f 0))))

; Q.9
(define (vector-assoc v vec)
  (letrec ([len (vector-length vec)]
           [f (lambda (i)
               (if (= i len)
                   #f
                   (let ([e (vector-ref vec i)])
                   (if (pair? e)
                       (if (equal? (car e) v)
                           e
                           (f (+ i 1)))
                       (f (+ i 1))))))])
    (f 0)))

; Q.10
(define (cached-assoc xs n)
  (let ([cache (make-vector n #f)]
        [pos 0])
      (lambda (v)
        (let ([foundInCache (vector-assoc v cache)])
        (if foundInCache
            foundInCache
            (let ([foundInAssoc (assoc v xs)])
              (if foundInAssoc
                  (begin
                    (vector-set! cache pos foundInAssoc)
                    (if (= pos (- n 1))
                        (set! pos 0)
                        (set! pos (+ pos 1)))
                    foundInAssoc)
                  #f)))))))