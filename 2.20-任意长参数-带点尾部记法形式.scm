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
; 2.20
; (define (f x y . z) <body>)
; (define (g . w) <body>)
; (define f (lambda (x y . z) <body>))
; (define g (lambda w <body>))
 
(define (same-parity x . y)
  (define a (remainder x 2))
  (define (y-iter y z)
	(if (null? y)
	  z
	  (y-iter (cdr y) 
			  (if (= a (remainder (car y) 2))
				(append z (list (car y))) ;(cons (car y) z)
				z))))
  (y-iter y (list x)))
;; test
(newline) (display (same-parity 2 3 4 5 6 7))
(newline) (display (same-parity 1 2 3 4 5 6 7))


