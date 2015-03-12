;;-------------------------------- T E S T ---------------------------------;+
(define (title n)                                                           ;|
  (begin                                                                    ;|
	(display "\n - - - - ")	(display n) (display " - - - -\n")))            ;|
(define (test f a b)                                                        ;|
  (newline)                                                                 ;|
  (if (> a b)                                                               ;|
	(display "test over !\n")                                               ;|
	(begin                                                                  ;|
	  (display a) (display " : ") (display (f a))                           ;|
	  (test f (+ a 1) b))))                                                 ;|
; --------------------------------------------------------------------------;+
;; 1.33 filtered-accumulate
;; (accumulate combiner null-value term a next b) - 1.32
;;
(define (accumulate combiner null-value term a next b filters)
  (cond ((> a b) null-value)
		((filters a) (combiner 
					   (term a)
					   (accumulate combiner null-value term (next a) next b filters)))
		(else (accumulate combiner null-value term (next a) next b filters))))
;; use accumulate define sum
(define (sum-even term a next b)
  (accumulate + 0 term a next b even?))

;; test 
;; cube sum
(define (cube x) (* x x x))
(define (inc n) (+ n 1))
(define (sum-cube b)
  (sum-even cube 0 inc b))
(title "sum-cube")
(test sum-cube 1 4)

;; a) prime?
;; b) GCD?
