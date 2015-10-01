;; -*- coding: utf-8; mode: scheme -*-
;; 2015 Eduardo Acuña Yeomans
;;
;; Code tested on:
;; * chibi-scheme
;; * larceny

(import (scheme base)
        (scheme write))

(define-record-type <mdp>
  (make-mdp S: T: A: R:)
  mdp?
  (S: S) ; List of states, elements must be the same if they are <equal?>
  (T: T) ; Procedure of three arguments ((T mdp) s a s') ]=> [0,1] where s in S, a in A(s) and s' in S
  (A: A) ; Procedure of one argument ((A mdp) s) ]=> (s' ...) where s in S
  (R: R) ; Procedure of three arguments ((R mdp) s a s') ]=> x where s, s' in S, a in A(s) and x in R
  )

(define gridworld
  (make-mdp (list '(1 . 3) '(2 . 3) '(3 . 3) '(4 . 3)
                  '(1 . 2)          '(3 . 2) '(4 . 2)
                  '(1 . 1) '(2 . 1) '(3 . 1) '(4 . 1))
            (lambda (s a s*)
              (let* ((x (car s))
                     (y (cdr s))
                     (plist (cond ((eq? a 'arriba)
                                   (list (cons (cons x (if (or (= y 3) (equal? s '(2 . 1))) y (+ y 1))) .8)
                                         (cons (cons (if (or (= x 1) (equal? s '(3 . 2))) x (- x 1)) y) .1)
                                         (cons (cons (if (or (= x 4) (equal? s '(1 . 2))) x (+ x 1)) y) .1)))
                                  ((eq? a 'abajo)
                                   (list (cons (cons x (if (or (= y 1) (equal? s '(2 . 3))) y (- y 1))) .8)
                                         (cons (cons (if (or (= x 4) (equal? s '(1 . 2))) x (+ x 1)) y) .1)
                                         (cons (cons (if (or (= x 1) (equal? s '(3 . 2))) x (- x 1)) y) .1)))
                                  ((eq? a 'derecha)
                                   (list (cons (cons (if (or (= x 4) (equal? s '(1 . 2))) x (+ x 1)) y) .8)
                                         (cons (cons x (if (or (= y 3) (equal? s '(2 . 1))) y (+ y 1))) .1)
                                         (cons (cons x (if (or (= y 1) (equal? s '(2 . 3))) y (- y 1))) .1)))
                                  ((eq? a 'izquierda)
                                   (list (cons (cons (if (or (= x 1) (equal? s '(3 . 2))) x (- x 1)) y) .8)
                                         (cons (cons x (if (or (= y 1) (equal? s '(2 . 3))) y (- y 1))) .1)
                                         (cons (cons x (if (or (= y 3) (equal? s '(2 . 1))) y (+ y 1))) .1)))
                                  (else (error "la acción no es válida" a)))))
                (cond ((assoc s* plist) => (lambda (pair) (cdr pair)))
                      (else 0))))
            (lambda (s)
              (list '(1 . 3) '(2 . 3) '(3 . 3) '(4 . 3)
                    '(1 . 2)          '(3 . 2) '(4 . 2)
                    '(1 . 1) '(2 . 1) '(3 . 1) '(4 . 1)))
            (lambda (s a s*)
              (cond ((equal? s* '(4 . 3)) +1.0)
                    ((equal? s* '(4 . 2)) -1.0)
                    (else -0.04)))))


(define (grid-ref grid x y)
  (vector-ref (vector-ref grid x) y))

(define (grid-set! grid x y val)
  (vector-set! (vector-ref grid x) y val))

(define (make-grid mdp)
  (define width (apply max (map car (S mdp))))
  (define height (apply max (map cdr (S mdp))))
  (define grid
    (do ((vec (make-vector width))
         (i 0 (+ i 1)))
        ((= i width) vec)
      (vector-set! vec i (make-vector height 'wall))))
  (for-each (lambda (s)
              (grid-set! grid (- (car s) 1) (- (cdr s) 1) s))
            (S mdp))
  grid)


;; (define (make-grid width height)
;;   (do ((vec (make-vector width))
;;        (i 1 (+ i 1)))
;;       ((> i width) vec)
;;     (vector-set! vec (- i 1)
;;                  (do ((col (make-vector height))
;;                       (j 1 (+ j 1)))
;;                      ((> j height) col)
;;                    (vector-set! col (- j 1) (cons i j))))))

(define-syntax repeat
  (syntax-rules ()
    ((repeat exp n)
     (do ((i n (- i 1)))
         ((= i 0) (display ""))
       exp))))

(define (draw-grid g)
  ;; ┏━━━━━━━┳━━━━━━━┳━━━━━━━┳━━━━━━━┓
  ;; ┃(x . y)┃       ┃       ┃       ┃
  ;; ┣━━━━━━━╋━━━━━━━╋━━━━━━━╋━━━━━━━┫
  ;; ┃       ┃███████┃       ┃       ┃
  ;; ┣━━━━━━━╋━━━━━━━╋━━━━━━━╋━━━━━━━┫
  ;; ┃       ┃       ┃       ┃       ┃
  ;; ┗━━━━━━━┻━━━━━━━┻━━━━━━━┻━━━━━━━┛
  (define width (vector-length g))
  (define height (vector-length (vector-ref g 0)))
  (display "┏")
  (repeat (begin (display "━━━━━━━")
                 (display "┳")) width)
  (display "\b┓")
  (do ((i 0 (+ i 1)))
      ((= i width))
    (do ((j (- height 1) (- j 1)))
        ((< j 0))
      (display "━━━━━━━"))))
