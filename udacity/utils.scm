(import (scheme base)
	(scheme time))

(define-syntax define-syntax-rule
  (syntax-rules ()
    ((define-syntax-rule (name . pattern) template)
     (define-syntax name
       (syntax-rules ()
	 ((name . pattern) template))))))

(define-syntax sum
  (syntax-rules (for in)
    ((sum code for var in lst)
     (apply + (map (lambda (var) code) lst)))))

(define-syntax val-max
  (syntax-rules (for in)
    ((val-max code for var in lst)
     (apply max (map (lambda (var) code) lst)))))

(define (arg-max-aux args vals best-arg best-val)
  (cond ((null? args) best-arg)
	((> (car vals) best-val) (arg-max-aux (cdr args) (cdr vals) (car args) (car vals)))
	(else (arg-max-aux (cdr args) (cdr vals) best-arg best-val))))

(define-syntax arg-max
  (syntax-rules (for in)
    ((arg-max code for var in lst)
     (let ((args lst)
	   (vals (map (lambda (var) code) lst)))
       (arg-max-aux (cdr args) (cdr vals) (car args) (car vals))))))

(define-syntax dict
  (syntax-rules (=> for in)
    ((dict code-key => code-val for var in lst)
     (map (lambda (var) (cons code-key code-val)) lst))))

(define (difference x y)
  (abs (- x y)))

(define (alist-lambda alist)
  (lambda (x)
    (cond ((assoc x alist) => cdr)
	  (else (error "value not in the domain of the function" x)))))

(define (approximate good-enough? improve initial-guess)
  (define (next-step current-guess)
    (let ((next-guess (improve current-guess)))
      (if (good-enough? current-guess next-guess)
	  current-guess
	  (next-step next-guess))))
  (next-step (initial-guess)))

;;; 
;;; ========================
;;; RANDOM NUMBER GENERATOR
;;; ========================
;;;
;;; BEGIN IGNORANCE
;;;
;;; STRANGE ARCANE NUMERICAL SHIT IS ABOUT TO BE WRITTEN
;;; I DO NOT FULLY UNDERSTAND THIS CODE

(define (make-linear-congruential-generator m a c)
  (let ((prev (current-jiffy)))
    (lambda ()
      (define next (remainder (+ (* a prev) c) m))
      (set! prev next)
      next)))

(define the-knuth (make-linear-congruential-generator 18446744073709551616 ;MAGIC NUMBER 1
						      6364136223846793005  ;MAGIC NUMBER 2
						      1442695040888963407  ;MAGIC NUMBER 3
						      ))

(define (random-integer n)
  (remainder (the-knuth) n))

(define (test-randomness n times)
  (let ((lst (make-list n 0)))
    (let iter ((t times))
      (cond ((zero? t) lst)
	    ((random-integer n) =>
	     (lambda (i)
	       (list-set! lst i (+ 1 (list-ref lst i)))
	       (iter (- t 1))))))))

(define (random-real)
  (/ (the-knuth) 18446744073709551616.0))

;;;
;;; END IGNORANCE
;;; 

(define (choose lst)
  (let ((n (length lst)))
    (list-ref lst (random-integer n))))
