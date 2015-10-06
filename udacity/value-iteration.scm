(import (scheme base)
	(scheme load))

(load "utils.scm")
(load "mdp.scm")

(define (value-iteration mdp tolerance discount)
  (define states (mdp:S mdp))
  (approximate (lambda (U1 U2)               ;good-enough?
		 (< (val-max (difference (U1 s) (U2 s)) for s in states) tolerance))
	       (lambda (U)                   ;improve
		 (make-utility s => (mdp:bellman mdp discount U s) for s in states))
	       (lambda ()                    ;initial-guess
		 (make-utility s => 0.0 for s in states))))

(define (vi:best-policy mdp tolerance discount)
  (define utility (value-iteration mdp tolerance discount))
  (define actions (mdp:A mdp))
  (define states (mdp:S mdp))
  (make-policy s => (arg-max (expected-utility mdp utility s a) for a in (actions s))
	       for s in states))
