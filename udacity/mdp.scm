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

(define (expected-utility mdp utility state action)
  (define probability (mdp:T mdp))
  (define states (mdp:S mdp))
  (sum (* (probability state action next)
	  (utility next))
       for next in states))

(define (mdp:bellman mdp discount utility state)
  (define reward (mdp:R mdp))
  (define actions (mdp:A mdp))
  (+ (reward state)
     (* discount
	(val-max (expected-utility mdp utility state action)
		 for action in (actions state)))))

(define (mdp:bellman-policy mdp discount utility state policy)
  (define reward (mdp:R mdp))
  (define action (policy state))
  (+ (reward state)
     (* discount
	(expected-utility mdp utility state action))))

(define (mdp:utility alist) (alist-lambda alist))

(define (mdp:policy alist) (alist-lambda alist))

(define-syntax-rule (make-utility x ...)
  (mdp:utility (dict x ...)))

(define-syntax-rule (make-policy x ...)
  (mdp:policy (dict x ...)))

#;
(define (list-policy mdp policy)
  (define states (mdp:S mdp))
  (map (lambda (s) (list s (policy s))) states))
