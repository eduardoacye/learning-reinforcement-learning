;;; -*- coding: utf-8; mode: scheme-mode -*-
;;; 2015 - Eduardo Acuña Yeomans
;;;
;;; Value iteration implementation for aproximating the utility function
;;;

(import (scheme base)
	(scheme load))

(load "../domains/mdp.scm")
(load "../utils/mappings.scm")
(load "../utils/procs.scm")

(define (value-iteration mdp epsilon discount)
  (define (good-enough? next guess)
    (< (apply max (map (lambda (x y) (abs (- x y)))
		       (mapping-outputs next)
		       (mapping-outputs guess)))
       epsilon))
  (define (improve guess)
    (mapping (map (lambda (p) (cons (car p)
			       (bellman-update mdp discount guess (car p))))
		  (guess))))
  (define (initial-guess)
    (mapping (map (lambda (s) (cons s 0.0)) (S mdp))))
  (define (try guess)
    (let ((next (improve guess)))
      (if (good-enough? next guess)
          guess
          (try next))))
  (try (initial-guess)))
