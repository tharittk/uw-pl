;; Programming Languages, Homework 5

#lang racket
(provide (all-defined-out)) ;; so we can put tests in a second file

;; definition of structures for MUPL programs - Do NOT change
(struct var  (string) #:transparent)  ;; a variable, e.g., (var "foo")
(struct int  (num)    #:transparent)  ;; a constant number, e.g., (int 17)
(struct add  (e1 e2)  #:transparent)  ;; add two expressions
(struct ifgreater (e1 e2 e3 e4)    #:transparent) ;; if e1 > e2 then e3 else e4
(struct fun  (nameopt formal body) #:transparent) ;; a recursive(?) 1-argument function
(struct call (funexp actual)       #:transparent) ;; function call
(struct mlet (var e body) #:transparent) ;; a local binding (let var = e in body) 
(struct apair (e1 e2)     #:transparent) ;; make a new pair
(struct fst  (e)    #:transparent) ;; get first part of a pair
(struct snd  (e)    #:transparent) ;; get second part of a pair
(struct aunit ()    #:transparent) ;; unit value -- good for ending a list
(struct isaunit (e) #:transparent) ;; evaluate to 1 if e is unit else 0

;; a closure is not in "source" programs but /is/ a MUPL value; it is what functions evaluate to
(struct closure (env fun) #:transparent) 

;; Problem 1

;1.a
(define (racketlist->mupllist rl)
  (cond [(null? rl) (aunit)]
        [#t (apair (car rl) (racketlist->mupllist (cdr rl)))]))
;1.b
(define (mupllist->racketlist ml)
  (cond [(aunit? ml) null]
        [#t (cons (apair-e1 ml) (mupllist->racketlist (apair-e2 ml)))])) 

;; Problem 2
;; lookup a variable in an environment
;; Do NOT change this function
(define (envlookup env str)
  (cond [(null? env) (error "unbound variable during evaluation" str)]
        [(equal? (car (car env)) str) (cdr (car env))]
        [#t (envlookup (cdr env) str)]))

;; Do NOT change the two cases given to you.  
;; DO add more cases for other kinds of MUPL expressions.
;; We will test eval-under-env by calling it directly even though
;; "in real life" it would be a helper function of eval-exp.
(define (eval-under-env e env)
  (cond [(var? e) 
         (envlookup env (var-string e))]
        ; addition
        [(add? e) 
         (let ([v1 (eval-under-env (add-e1 e) env)]
               [v2 (eval-under-env (add-e2 e) env)])
           (if (and (int? v1)
                    (int? v2))
               (int (+ (int-num v1) 
                       (int-num v2)))
               (error "MUPL addition applied to non-number")))]
        ;; CHANGE add more cases here
        ;all values evaluate to themselves
        [(int? e) e]
        [(closure? e) e]
        [(aunit? e) e]
        ;function
        [(fun? e)
         (let ([s1 (fun-nameopt e)]
               [s2 (fun-formal e)])
           (if (and (or (string? s1) (not s1)) (string? s2))
               (closure env e)
               (error "function name and/or arguement is not string or #f")))]
        ;ifgreater
        [(ifgreater? e)
         (let ([v1 (eval-under-env (ifgreater-e1 e) env)]
               [v2 (eval-under-env (ifgreater-e2 e) env)])
           (if (and (int? v1)
                    (int? v2))
               (if (> (int-num v1) (int-num v2))
                   (eval-under-env (ifgreater-e3 e) env)
                   (eval-under-env (ifgreater-e4 e) env))
               (error "MUPL ifgreater compare non-number")))]
        ;mlet
        [(mlet? e)
         (let ([v (eval-under-env (mlet-e e) env)])
           (if (string? (mlet-var e))
               (eval-under-env (mlet-body e) (cons (cons (mlet-var e) v) env))
               (error "MUPL var in mlet argumnet is not string")))]
        ;call
        [(call? e)
         (let ([cl (eval-under-env(call-funexp e) env)]
               [arg (eval-under-env(call-actual e) env)])
           (if (closure? cl)
               (let* ( [f (closure-fun cl)]
                       [new-env  (cons (cons (fun-formal f) arg) (closure-env cl))])
               (if (fun-nameopt f) ; fn #f
                   (eval-under-env (fun-body f) (cons (cons (fun-nameopt f) cl) new-env))
                   (eval-under-env (fun-body f) new-env)))
               (error "call first expression not evaluated to closure")))]

        ;apair
        [(apair? e) (apair (eval-under-env (apair-e1 e) env) (eval-under-env (apair-e2 e) env))]
        ;fst
        [(fst? e)
         (let ([pr (eval-under-env (fst-e e) env)])
           (if (apair? pr)
               (apair-e1 pr)
               (error "fst expression not evaluated to apair type")))]
        ;snd
        [(snd? e)
         (let ([pr (eval-under-env (snd-e e) env)])
           (if (apair? pr)
               (apair-e2 pr)
               (error "snd expression not evaluated to apair type")))]
        ;isaunit
        [(isaunit? e)
         (let ([unit (eval-under-env (isaunit-e e) env)])
           (if (aunit? unit)
               (int 1)
               (int 0)))]
        
        [#t (error (format "bad MUPL expression: ~v" e))]))

;; Do NOT change
(define (eval-exp e)
  (eval-under-env e null))
        
;; Problem 3

(define (ifaunit e1 e2 e3) (ifgreater (isaunit e1) (int 0) e2 e3))

(define (mlet* lstlst e2)
  (if (null? lstlst)
      e2
      (mlet (car (car lstlst)) (cdr (car lstlst)) (mlet* (cdr lstlst) e2))))
                      

(define (ifeq e1 e2 e3 e4) (mlet "_x" e1
                                 (mlet "_y" e2
                                       (if (equal? (var "_x") (var "_y"))
                                           e3
                                           e4))))
                                        
;; Problem 4

(define mupl-map
  (fun #f "fn"
       (fun "map" "mlist"
            (ifaunit (var "mlist")
                     (var "mlist")
                     (apair (call (var "fn") (fst (var "mlist"))) (call (var "map") (snd (var "mlist"))))))))


(define mupl-mapAddN 
  (mlet "map" mupl-map
        "CHANGE (notice map is now in MUPL scope)"))

;; Challenge Problem

(struct fun-challenge (nameopt formal body freevars) #:transparent) ;; a recursive(?) 1-argument function

;; We will test this function directly, so it must do
;; as described in the assignment
(define (compute-free-vars e) "CHANGE")

;; Do NOT share code with eval-under-env because that will make
;; auto-grading and peer assessment more difficult, so
;; copy most of your interpreter here and make minor changes
(define (eval-under-env-c e env) "CHANGE")

;; Do NOT change this
(define (eval-exp-c e)
  (eval-under-env-c (compute-free-vars e) null))
