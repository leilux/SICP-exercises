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
; 2.35
(define (accumulate op init sequence)
  (if (null? sequence)
	init
	(op (car sequence)
		(accumulate op init (cdr sequence)))))

(define (count-leaves t)
  (accumulate + 0 (map (lambda (x)
						 (if (pair? x) (count-leaves x) 1))
				   t)))
(count-leaves (list 1 (list 2 3) 4))
