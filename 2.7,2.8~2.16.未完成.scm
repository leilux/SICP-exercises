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
; 2.7
; make
(define (make-interval a b) (cons a b))
; opt
(define (lower-bound x) (car x))
(define (upper-bound x) (cdr x))
; +
(define (add-interval x y)
  (make-interval (+ (lower-bound x) (lower-bound y))
				 (+ (upper-bound x) (upper-bound y))))
; *
(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
		(p2 (* (lower-bound x) (upper-bound y)))
		(p3 (* (upper-bound x) (lower-bound y)))
		(p4 (* (upper-bound x) (upper-bound y))))
	(make-interval (min p1 p2 p3 p4)
				   (max p1 p2 p3 p3))))
; /
(define (div-interval x y)
  (mul-interval x
				(make-interval (/ 1.0 (upper-bound y))
							   (/ 1.0 (lower-bound y)))))
; 2.8
; -
(define (sub-interval x y)
  (make-interval (- (lower-bound x) (upper-bound y))
				 (- (upper-bound x) (lower-bound y))))


