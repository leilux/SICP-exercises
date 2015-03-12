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
; 1.44
(define (compose f g)
  (lambda (x) (f (g x))))
(define (repeated f n)
  (if (= n 1)
	(lambda (x) (f x))
	(compose f (repeated f (- n 1)))))
; smooth
(define dx 0.00001)
(define (smooth f)
  (lambda (x) (/ (+ (f (- x dx))
					(f x)
					(f (+ x dx)))
				 3.0)))
; repeated-smooth
; smooth(smooth(...(smooth(f))))
(define (repeated-smooth f n)
  ((repeated smooth n) f))
;; test
(define (inc x) (+ x 1))
;(test (smooth inc) 1 9)
(test (repeated-smooth inc 4) 1 9)
