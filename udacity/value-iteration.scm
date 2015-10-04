(import (scheme base)
	(scheme load))

(load "utils.scm")
(load "mdp.scm")

(define (value-iteration mdp epsilon discount)
  (approximate (lambda (U1 U2)		;good-enough?
		 (< (val-max (difference (U1 s) (U2 s)) for s in (mdp:states mdp)) epsilon))
	       (lambda (U)			;improve
		 (make-utility s => (mdp:bellman-update mdp discount U s) for s in (mdp:states mdp)))
	       (lambda ()			;initial-guess
		 (make-utility s => 0.0 for s in (mdp:states mdp)))))

#;
(define (value-iteration mdp epsilon discount)
  (approximate (lambda (next-guess current-guess) ; good-enough? ;
		 (< (apply max (map (lambda (s) (difference (next-guess s) (current-guess s))) (mdp:states mdp)))
		    epsilon))
	       (lambda (current-guess)	; improve
		 (mdp:utility (map (lambda (s) (cons s (mdp:bellman-update mdp discount current-guess s)))
				   (mdp:states mdp))))
	       (lambda ()			; initial-guess
		 (mdp:utility (map (lambda (s) (cons s 0.0)) (mdp:states mdp))))))

#;
(define (value-iteration mdp epsilon discount)
  (define (good-enough? next guess)
    (< (apply max (map (lambda (s) (difference (next s) (guess s))) (mdp:states mdp)))
       epsilon))
  (define (improve guess)
    (mdp:utility (map (lambda (s) (cons s (mdp:bellman-update mdp discount guess s))) (mdp:states mdp))))
  (define (try guess)
    (let ((next (improve guess)))
      (if (good-enough? next guess)
	  guess
	  (try next))))
  (try (mdp:utility (map (lambda (s) (cons s 0.0)) (mdp:states mdp)))))
