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
; 1.46
(define (iterative-improve good-enough? improve)
  (lambda (x) 
	(if (good-enough? x (improve x))
	  x
	  ((iterative-improve good-enough? improve) (improve x)))))
(define tolerance 0.001)
(define (good-enough? v1 v2) (< (abs (- v1 v2)) tolerance))
(define (improve guess) (/ (+ (/ 2 guess) guess) 2))
; test
((iterative-improve good-enough? improve) 1.0)
