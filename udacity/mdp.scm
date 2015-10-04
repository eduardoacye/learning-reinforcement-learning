(import (scheme base))

#;
(define-syntax transition-aux
  (syntax-rules (otherwise)
    ((transition-aux (x y z) (otherwise result))
     result)
    ((transition-aux (x y z) ((x* y* z*) result) clause1 clause2 ...)
     (if (equal? (list x y z) (list x* y* z*))
	 result
	 (transition-aux (x y z) clause1 clause2 ...)))))

#;
  (define-syntax transition
    (syntax-rules ()
      ((transition (x y z) clause1 clause2 ...)
       (lambda (x y z)
	 (transition-aux (x y z) clause1 clause2 ...)))))
