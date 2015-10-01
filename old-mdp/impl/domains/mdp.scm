;;; -*- coding: utf-8; mode: scheme-mode -*-
;;; 2015 - Eduardo Acuña Yeomans
;;;
;;; MDP
;;;

(import (scheme base)
	(scheme load))

(load "../utils/mappings.scm")

(define (mdp S T A R)
  (list S T A R))

(define (S mdp)
  (list-ref mdp 0))

(define (T mdp)
  (list-ref mdp 1))

(define (A mdp)
  (list-ref mdp 2))

(define (R mdp)
  (list-ref mdp 3))


;; ┏━━━━━┳━━━━━┳━━━━━┳━━━━━┓
;; ┃-.04 ┃-.04 ┃-.04 ┃+1.0 ┃
;; ┣━━━━━╋━━━━━╋━━━━━╋━━━━━┫
;; ┃-.04 ┃█████┃-.04 ┃-1.0 ┃
;; ┣━━━━━╋━━━━━╋━━━━━╋━━━━━┫
;; ┃-.04 ┃-.04 ┃-.04 ┃-.04 ┃
;; ┗━━━━━┻━━━━━┻━━━━━┻━━━━━┛
;;
;; STATES <-- { (1 1),(1,2),(1,3),
;;              (2 1),      (2 3),
;;              (3 1),(3 2),(3 3),
;;              (4 1),(4 2),(4 3) }
;;
;; TRANSITIONS <-- 



;; (1) -- (2)
;;  |  ___/
;;  | /
;; (3) 

(define test (mdp (list 1 2 3)
		  (mapping '(((1 1 goto2) . .4)
			     ((1 1 goto3) . .6)
			     ((1 2 goto1) . .4)
			     ((1 2 goto3) . .6)
			     ((1 3 goto1) . .4)
			     ((1 3 goto2) . .6)
			     
			     ((2 1 goto2) . .4)
			     ((2 1 goto3) . .6)
			     ((2 2 goto1) . .4)
			     ((2 2 goto3) . .6)
			     ((2 3 goto1) . .4)
			     ((2 3 goto2) . .6)
			     
			     ((3 1 goto2) . .4)
			     ((3 1 goto3) . .6)
			     ((3 2 goto1) . .4)
			     ((3 2 goto3) . .6)
			     ((3 3 goto1) . .4)
			     ((3 3 goto2) . .6)))
		  (mapping '((1 . (goto2 goto3))
			     (2 . (goto1 goto3))
			     (3 . (goto1 goto2))))
		  (mapping '((1 . -.04)
			     (2 . -.01)
			     (3 . +.05)))))


#;
(define grid4x3
  (mdp
   ;; States				;
   (list '(1 3) '(2 3) '(3 3) '(4 3)
	 '(1 2)        '(3 2) '(4 2)
	 '(1 1) '(1 2) '(1 3) '(1 4)))
  ;; Transitions			;
  (mapping '(())))
