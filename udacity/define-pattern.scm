;;; Variable bindings from list pattern
;;;
;;; > (define lst '(1 2 (3)))
;;; > (define x (car lst))
;;; > (define y (cadr lst))
;;; > (define z (caaddr lst))
;;; > x
;;; ]=> 1
;;; > y
;;; ]=> 2
;;; > z
;;; ]=> 3
;;;
;;; If we know the structure of lst we can make the definitions of x, y and z a lot easier
;;;
;;; > (define lst '(1 2 (3)))
;;; > (define-pattern (x y (z)) lst)
;;; > x
;;; ]=> 1
;;; > y
;;; ]=> 2
;;; > z
;;; ]=> 3

(import (scheme base)
	(scheme eval)
	(scheme repl))

#;
(define-syntax dp
  (syntax-rules ()
    ((dp (x . xs) (y . ys)) (begin (dp x y) (dp xs ys)))
    ((dp () x)              (begin))
    ((dp x y)               (define x (quote y)))))

(define (alist-match pattern data)
  (cond ((symbol? pattern) (list (cons pattern data)))
	((null? pattern) '())
	(else (append (alist-match (car pattern) (car data))
		      (alist-match (cdr pattern) (cdr data))))))
  
(define-syntax define-pattern-aux
  (syntax-rules ()
    ((define-pattern-aux ((x . y))) (define x (quote y)))
    ((define-pattern-aux ((x . y) (w . z) ...)) (begin (define x (quote y)) (define-pattern-aux ((w . z) ...))))))

(define-syntax define-pattern
  (syntax-rules ()
    ((define-pattern pattern data)
     (eval `(define-pattern-aux ,(alist-match (quote pattern) data)) (interaction-environment)))))
