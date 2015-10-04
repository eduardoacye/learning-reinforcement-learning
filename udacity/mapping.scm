;; ;; Mappings

;; ;; Los mappings son una mezcla entre listas de asociación y funciones.

;; ;; La idea es poder tener las abstracciones usuales sobre listas, como map, fold, for-each, etc. aplicadas a funciones discretas.

;; ;; Un mapping pudiera visualizarse como una lista de asociación, por ejemplo:

;; ;; ((0 . 0)
;; ;;  (1 . 1)
;; ;;  (2 . 4)
;; ;;  (3 . 9)
;; ;;  . . .)

;; ;; Teniendo este mapping m, podemos obtener su dominio explícito (similar a las llaves de la lista de asociación) y su codominio explícito (similar a los valores de la lista de asociación), también podemos obtener el valor del mapping en un elemento del dominio dado, por ejemplo (m 3) => 9. Los mappings son funciones totales, es decir, para cualquier valor en el dominio, va a existir un valor en el codominio, sin embargo, podemos definir un mapping expresando no solo elementos del dominio y elementos del codominio, si no tambiéne expresando predicados que al ser cumplidos por algún valor, se asocien a un resultado. También se pueden usar valores por defecto, de tal manera que podemos expresar un valor asociado a todos los elementos que no estén  explicitamente definidos en el mappings y que no cumplan tampoco con los predicados establecidos.

;; ;; (mapping <pattern>)

;; ;; <pattern> puede ser

;; ;; (<left> . <right>)

;; (M '(1 . 2) 'up '(1 . 3)) = .5
;; (M '(1 . 2) 'left '(0 . 2)) = .25
;; (M '(1 . 2) 'right '(2 . 2)) = .25
;; (M '(1 . 2) ')

;; (M '(1 . 2) <x> (go-to '(1 . 2) <x>)) = 0.5
;; (M '(1 . 2) <x> (go-to '(1 . 2) (rotate-left <x>))) = 0.25
;; (M '(1 . 2) <x> (go-to '(1 . 2) (rotate-right <x>))) = 0.25
;; (M '(1 . 2) <x> <y>) = 0.0

;; ;;; From state s, taking action a, into state s*, calculate probability
;; (M (x y) z )

(import (scheme base)
	(scheme load))

(load "utils.scm")

(define-syntax mapping-aux
  (syntax-rules (else)
    ((mapping-aux (x ...) (else result))
     result)
    ((mapping-aux (x ...) ((y ...) result) clause1 clause2 ...)
     (if (equal? (list x ...) (list y ...))
	 result
	 (mapping-aux (x ...) clause1 clause2 ...)))))

(define-syntax-rule (mapping (x ...) clause1 clause2 ...)
  (lambda (x ...) (mapping-aux (x ...) clause1 clause2 ...)))
