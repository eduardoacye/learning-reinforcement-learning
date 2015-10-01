;;; -*- coding: utf-8; mode: scheme-mode -*-
;;; 2015 - Eduardo Acuña Yeomans
;;;
;;; Policy iteration implementation for aproximating the utility function
;;;

(define (policy-iteration mdp discount)
  (define (good-enough? next guess) 'to-do)
  (define (improve guess) 'to-do)
  (define (initial-guess) 'to-do)
  (define (try guess)
    (let ((next (improve guess)))
      (if (good-enough? next guess)
	  guess
	  (try next))))
  (try (initial-guess)))
