;;-------------------------------- T E S T ---------------------;+
(define (title n)												;|
  (begin                                                        ;|
	(display "\n - - - - ")	(display n) (display " - - - -\n")));|
(define (test f a b)                                            ;|
  (newline)                                                     ;|
  (if (> a b)                                                   ;|
	(display "test over !\n")                                   ;|
	(begin                                                      ;|
	  (display a) (display " : ") (display (f a))               ;|
	  (test f (+ a 1) b))))                                     ;|
; --------------------------------------------------------------;+
; 2.34
(define (accumulate op init sequence)
  (if (null? sequence)
	init
	(op (car sequence)
		(accumulate op init (cdr sequence)))))

(define (horner-eval x corfficient-sequence)
  (accumulate (lambda (this-coeff higher-terms)
				(+ this-coeff (* x higher-terms)))
			  0
			  corfficient-sequence))
; test
(horner-eval 2 (list 1 3 0 5 0 1))

