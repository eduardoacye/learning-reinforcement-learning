(define-syntax define-syntax-rule
  (syntax-rules ()
    ((define-syntax-rule (name . pattern) template)
     (define-syntax name
       (syntax-rules ()
	 ((name . pattern) template))))))

(define-syntax val-max
  (syntax-rules (for in)
    ((val-max code for var in lst)
     (apply max (map (lambda (var) code) lst)))))

(define (arg-max-aux args vals best-arg best-val)
  (cond ((null? args) best-arg)
	((> (car vals) best-val) (arg-max-aux (cdr args) (cdr vals) (car args) (car vals)))
	(else (arg-max-aux (cdr args) (cdr vals) best-arg best-val))))

(define-syntax arg-max
  (syntax-rules (for in)
    ((arg-max code for var in lst)
     (let ((args lst)
	   (vals (map (lambda (var) code) lst)))
       (arg-max-aux (cdr args) (cdr vals) (car args) (car vals))))))

(define-syntax dict
  (syntax-rules (=> for in)
    ((dict code-key => code-val for var in lst)
     (map (lambda (var) (cons code-key code-val)) lst))))

(define-syntax-rule (make-utility x ...)
  (mdp:utility (dict x ...)))

(define-syntax-rule (make-policy x ...)
  (mdp:policy (dict x ...)))

(define (difference x y)
  (abs (- x y)))

(define (approximate good-enough? improve initial-guess)
  (define (next-step current-guess)
    (let ((next-guess (improve current-guess)))
      (if (good-enough? next-guess current-guess)
	  current-guess
	  (next-step next-guess))))
  (next-step (initial-guess)))
