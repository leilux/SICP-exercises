; 3.16
(define (count-pairs x)
  (if (not (pair? x))
	0
	(+ (count-pairs (car x))
	   (count-pairs (cdr x))
	   1)))

(define x (cons (cons 
				  (cons 1 '()) 
				  '()) 
				(cons 2 '())))
(define two (list 1 2))
(define four (cons two (cdr two)))
(define five (cons two two))
(define seven (cons five (cddr five)))
;; test 
(newline) (display (count-pairs two))
(newline) (display (count-pairs four))
(newline) (display (count-pairs seven))
(newline) (display (count-pairs x))
; 3.17
(define (count-pairs x)
  (length (inner x '())))
(define (inner x meno-list)
  (if (and (pair? x) (not (memq x meno-list)))
	(inner (car x) (inner (cdr x) (cons x meno-list)))
	meno-list))
; test
(newline)
(newline) (display (count-pairs two))
(newline) (display (count-pairs four))
(newline) (display (count-pairs seven))
(newline) (display (count-pairs x))
