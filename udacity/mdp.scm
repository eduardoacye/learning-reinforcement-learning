(import (scheme base)
	(scheme load))

(load "utils.scm")

(define-record-type <mdp>
  (make-mdp states transitions actions rewards)
  mdp?
  (states mdp:S)
  (transitions mdp:T)
  (actions mdp:A)
  (rewards mdp:R))

(define (mdp:bellman mdp discount utility state)
  (define reward (mdp:R mdp))
  (define probability (mdp:T mdp))
  (define actions (mdp:A mdp))
  (+ (reward state)
     (* discount
	(val-max (sum (* (probability state action next)
			 (utility next))
		      for next in (mdp:S mdp))
		 for action in (actions state)))))

(define (mdp:utility alist) (alist-lambda alist))

(define (mdp:policy alist) (alist-lambda alist))

(define-syntax-rule (make-utility x ...)
  (mdp:utility (dict x ...)))

(define-syntax-rule (make-policy x ...)
  (mdp:policy (dict x ...)))
