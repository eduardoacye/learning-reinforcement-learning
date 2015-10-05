(import (scheme base)
	(scheme load))

(load "utils.scm")
(load "mdp.scm")

(define (policy-iteration mdp)
  (approximate (lambda (P1 P2)		;good-enough?
		 ())
	       (lambda (P)			;improve
		 (make-policy s => ()))
	       (lambda ()			;initial-guess
		 (make-policy s => 'up for s in (mdp:states mdp)))))
