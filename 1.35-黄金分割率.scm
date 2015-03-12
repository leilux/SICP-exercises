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
; 1.35
; fixed-point
(define tolerance 0.001)
(define (fixed-point f first-guess)
  (define (closs-enough? v1 v2)
	(< (abs (- v1 v2)) tolerance))
  (define (try guess)
	(let ((next (f guess)))
	  (if (closs-enough? guess next)
		next
		(begin (display guess)
		(try next)))))
  (try first-guess))
; 求黄金分割率
(define (square x) (* x x))
;(define lu
 ; (fixed-point (lambda (x) (+ 1 (/ 1 x))) 1.018))
(define (f x)
  (+ 1 (/ 1 x)))
(fixed-point f 0.1)


