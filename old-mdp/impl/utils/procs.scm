;;; -*- coding: utf-8; mode: scheme-mode -*-
;;; 2015 - Eduardo Acuña Yeomans
;;;
;;; Utility procedures
;;;

(import (scheme base)
	(scheme load)
	(scheme case-lambda))

(load "../domains/mdp.scm")

(define (range start end step)
  (if (>= start end)
      '()
      (cons start (range (+ start step) end step))))

(define (bellman-update mdp discount U s)
  (+ ((R mdp) s)
     (* discount
	(apply max (map (lambda (a) (apply + (map (lambda (s*) (* ((T mdp) (list s* s a)) (U s*)))
					     (S mdp))))
			((A mdp) s))))))

(define (additive-rewards mdp states)
  (apply + (map (R mdp) states)))

(define (discounted-rewards mdp discount states)
  (apply + (map (lambda (s i) (* ((R mdp) s) (expt discount i)))
		states
		(range 0 (length states) 1))))
