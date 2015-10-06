(import (scheme base)
	(scheme load))

(load "utils.scm")
(load "mdp.scm")

(define (eval-policy mdp discount policy)
  (define states (mdp:S mdp))
  (let iter ((utility (make-utility s => 0.0 for s in states))
	     (k (length (mdp:S mdp))))
    (if (zero? k)
	utility
	(iter (make-utility s => (mdp:bellman-policy mdp discount utility s policy) for s in states)
	      (- k 1)))))

(define (policy-iteration mdp tolerance discount)
  (define states (mdp:S mdp))
  (define actions (mdp:A mdp))
  (approximate (lambda (P1:U1 P2:U2)               ;good-enough?
		 ;(define-values (P1 U1 P2 U2) (values (car P1:U1) (cdr P1:U1) (car P2:U2) (cdr P2:U2)))
		 (define U1 (cdr P1:U1))
		 (define U2 (cdr P2:U2))
		 (< (val-max (difference (U1 s) (U2 s)) for s in states) (/ tolerance (length states))))
	       (lambda (P:U)                       ;improve
		 (define-values (P U) (values (car P:U) (cdr P:U)))
		 (define policy
		   (make-policy s => (if (> (val-max (expected-utility mdp U s a)
						    for a in (actions s))
					   (expected-utility mdp U s (P s)))
					(arg-max (expected-utility mdp U s a)
						 for a in (actions s))
					(P s))
				for s in states))
		 (cons policy (eval-policy mdp discount policy)))
	       (lambda ()                          ;initial-guess
		 (define policy (make-policy s => (choose (actions s)) for s in states))
		 (cons policy (eval-policy mdp discount policy)))))

(define (pi:best-policy mdp tolerance discount)
  (define p:u (policy-iteration mdp tolerance discount))
  (car p:u))
