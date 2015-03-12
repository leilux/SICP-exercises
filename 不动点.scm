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
; fixed-point
(define tolerance 0.00001)
(define (fixed-point f fist-guess)
  (define (closs-enough? v1 v2)
	(< (abs (- v1 v2)) tolerance))
  (define (try guess)
	(let ((next (f guess)))
	  (if (closs-enough? guess next)
		next
		(try guess))))
  (try first-guess))
; sqrt - 不收敛 y = x/y
(define (sqrt-m x)
  (fixed-point (lambda (y) (/ x y)) 1.0))
; sqrt - 收敛  y = (1/2)(y + x/y)
(define (sqrt-m-r x)
  (fixed-point (lambda (y) (average y (/ x y)))
			   1.0))

