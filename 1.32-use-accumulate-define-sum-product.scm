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

;; 1.32
;; a) 递归
(define (accumulate-r combiner null-value term a next b)
  (if (> a b)
	null-value
	(combiner (term a)
			  (accumulate-r combiner null-value term (next a) next b))))
;; b) 迭代
(define (accumulate-i combiner null-value term a next b)
  (define (iter a result)
	(if (> a b)
	  result
	  (iter (next a) (combiner result
							   (term a)))))
  (iter a null-value))

;; define sum & product
(define (sum term a next b)
  (accumulate-i + 0 term a next b))
(define (product term a next b)
  (accumulate-i * 1 term a next b))

;; test sum & product --------------------------------
;; factorial 
(define (factorial b)
  (define (identity x) x)
  (define (next x) (+ x 1))
  (product identity 1 next b)) ; here to change MODE!
;; test
(title "factorial(n)")
(test factorial 1 4)
; ----------------------------------------------------
;; cube sum
(define (cube x) (* x x x))
(define (inc n) (+ n 1))
(define (sum-cube b)
  (sum cube 0 inc b))
(title "sum-cube")
(test sum-cube 1 3)
