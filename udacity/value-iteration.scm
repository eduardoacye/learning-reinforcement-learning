(import (scheme base)
	(scheme load))

(load "utils.scm")
(load "mdp.scm")

(define (value-iteration m tolerance discount)
  (approximate (lambda (U1 U2)		;good-enough?
		 (< (val-max (difference (U1 s) (U2 s)) for s in (mdp:S m)) tolerance))
	       (lambda (U)			;improve
		 (make-utility s => (mdp:bellman m discount U s) for s in (mdp:S m)))
	       (lambda ()			;initial-guess
		 (make-utility s => 0.0 for s in (mdp:S m)))))
