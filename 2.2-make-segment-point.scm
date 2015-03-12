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
; 2.2
; point
(define (make-point x y) (cons x y))
(define (x-point p) (car p))
(define (y-point p) (cdr p))
; segment
(define (make-segment p1 p2) (cons p1 p2))
(define (str-segemnt L) (car L))
(define (end-segemnt L) (cdr L))

(define (midpoint-segment L)
  (make-point (/ (+ (x-point (str-segemnt L)) 
					(x-point (end-segemnt L)))
				 2)
			  (/ (+ (y-point (str-segemnt L))
					(y-point (end-segemnt L)))
				 2)))

(define (print-point p)
  (newline)
  (display "(")
  (display (x-point p))
  (display ", ")
  (display (y-point p))
  (display ")"))
;; test
(print-point (make-point 1 2))
(print-point (midpoint-segment (make-segment (make-point 0 0) (make-point 2 2))))
