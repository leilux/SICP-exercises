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
; 区间折半寻找方程的根
(define (close-enough? x y)
  (< (abs (- x y)) 0.001))
(define (search f neg-point pos-point)
  (let ((midpoint (averge neg-point pos-point)))
	(if (close-enough? neg-point pos-point)
	  midpoint
	  (let ((test-value (f midpoint)))
		(cond ((positive? test-value)
			   (search f neg-point midpoint))
			  ((negative? test-value)
			   (search f midpoint pos-point))
			  (else midpoint))))))
; 优化
(define (half-interval-method f a b)
  (let ((a-value (f a))
		(b-value (f b)))
	(cond ((and (negative? a-value) (positive? b-value))
		   (search f a b))
		  ((and (negative? b-value) (positive? a-value))
		   (search f b a))
		  (else
			(error "Value are not opposite sign" a b)))))

