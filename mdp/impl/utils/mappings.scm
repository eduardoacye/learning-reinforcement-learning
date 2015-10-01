;;; -*- coding: utf-8; mode: scheme-mode -*-
;;; 2015 - Eduardo Acuña Yeomans
;;;
;;; Mapping as a discrete function
;;;
;;; (define-mapping f association)
;;; (f) ; shows the mapping
;;; (f x) ; gets the value of x in the mapping
;;; (f x y) ; sets the value of x in the mapping

(import (scheme base)
	(scheme case-lambda))

(define-syntax mapping
  (syntax-rules ()
    ((mapping alist)
     (let ((alist* (list alist)))
       (case-lambda
         (() (car alist*))
         ((key) (cond ((assoc key (car alist*)) => cdr)
                      (else (error "mapping not defined for domain value" key))))
         ((key val) (cond ((assoc key (car alist*)) => (lambda (p) (set-cdr! p val)))
                          (else (set-car! alist* (cons (cons key val) (car alist*)))))))))))

(define-syntax define-mapping
  (syntax-rules ()
    ((define-mapping name)
     (define name (mapping '())))
    ((define-mapping name alist)
     (define name (mapping alist)))))

(define (mapping-inputs m)
  (map car (m)))

(define (mapping-outputs m)
  (map cdr (m)))
