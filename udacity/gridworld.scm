;;; Como me gustaría poder plantear el problema del gridworld como proceso de desición markoviano
;;;

(import (scheme base)
	(scheme load))

(load "mdp.scm")
(load "mapping.scm")

(define (rotate-left a)
  (case a ((up) 'left) ((down) 'right) ((left) 'down) ((right) 'up)))

(define (rotate-right a)
  (case a ((up) 'right) ((down) 'left) ((left) 'up) ((right) 'down)))

(define (opposite a)
  (case a ((up) 'down) ((down) 'up) ((left) 'right) ((right) 'left)))

(define states
  '((0 2) (1 2) (2 2) (3 2)
    (0 1)       (2 1) (3 1)
    (0 0) (1 0) (2 0) (3 0)))

(define walls
  '((1 1)))

(define (go state action)
  (define x (car state))
  (define y (cadr state))
  (let ((next (case action
		((up)    (list x (+ y 1))) ((down)  (list x (- y 1)))
		((left)  (list (- x 1) y)) ((right) (list (+ x 1) y)))))
    (define x* (car next))
    (define y* (cadr next))
    (if (or (member next walls)
	   (< x* 0) (> x* 3) (< y* 0) (> y* 2))
	state
	next)))

(define transitions
  (mapping (s a s*)
   ((s a (go s a))                0.8)
   ((s a (go s (rotate-left a)))  0.1)
   ((s a (go s (rotate-right a))) 0.1)
   (else 0.0)))

(define (actions state)
  (if (member state states) '(up down left right) '()))

(define rewards
  (mapping (s a s*)
   ((s a '(3 1)) -1.0)
   ((s a '(3 2)) +1.0)
   (else         -0.04)))


#;
(define gridworld
  (make-mdp states
	    transitions
	    actions
	    rewards))
