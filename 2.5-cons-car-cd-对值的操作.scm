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
; 2.5
(define (f-expt-i b n )
  (define (expt-iter b n a)	
	(cond ((= n 0) a)
		  ((= (remainder n 2) 0) (expt-iter (* b b) (/ n 2) a))
		  (else (expt-iter b (- n 1) (* a b)))))
  (expt-iter b n 1))

(define (cons-m a b)
  (* (f-expt-i 2 a)
	 (f-expt-i 3 b)))

(define (count z factor)
  (define (count-i z factor n)
	(if (= (remainder z factor) 0)
	  (count-i (/ z factor) factor (+ n 1))
	  n))
  (count-i z factor 0))

(define (car-m z) (count z 2))
(define (cdr-m z) (count z 3))
;; test
(newline) (display (car-m (cons-m 2   3)))
(newline) (display (car-m (cons-m 4   5)))
(newline) (display (car-m (cons-m 21 32)))
(newline) (display (cdr-m (cons-m 32 43)))
(newline) (display (cdr-m (cons-m 35 44)))
(newline) (display (cdr-m (cons-m 32  4)))
