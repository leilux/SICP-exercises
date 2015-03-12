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
; 1.45
; fixed-point
(define tolerance 0.001)
(define (fixed-point f fist-guess)
  (define (closs-enough? v1 v2)
	(< (abs (- v1 v2)) tolerance))
  (define (try guess count)
	(let ((next (f guess)))
	  (if (closs-enough? guess next)
		next
		(begin
		  (display "\nguess ")(display count)(display " : ")
		  (display guess)
		  (try next (+ 1 count))))))
  (try fist-guess 0))
; average
(define (average x y) (/ (+ x y) 2))
(define (average-damp f)
  (lambda (x) (average x (f x))))
; repeated
(define (compose f g)
  (lambda (x) (f (g x))))
(define (repeated f n)
  (if (= n 0)
	(lambda (x) (f x))
	(compose f (repeated f (- n 1)))))
; pow
(define (f-expt-i b n )
  (define (expt-iter b n a)	
	(cond ((= n 0) a)
		  ((= (remainder n 2) 0) (expt-iter (* b b) (/ n 2) a))
		  (else (expt-iter b (- n 1) (* a b)))))
  (expt-iter b n 1))
; the-n 
; 2,3 ; 4,5,6,7 ; 8,9,10,11,12,13,14,15 ; 16,17...
(define (the-n x)
  (define (iter x n)
	(if (< x (f-expt-i 2 n))
	  (- n 2)
	  (iter x (+ n 1))))
  (iter x 0))
; n-th-root
(define (n-th-root x n)
  (define i (the-n n))
  (define f (lambda (y) (/ x (f-expt-i y (- n 1)))))
  (fixed-point ((repeated average-damp i) f) 
			   1.0))
;; test
(test (lambda (x) (n-th-root 27 x)) 7 100)
(n-th-root 27 33)

;(define (t x n)
;  (define f (lambda (y) (/ x (f-expt-i y (- n 1)))))
;  (fixed-point ((repeated average-damp (the-n x)) f) 
;			   1.0))
