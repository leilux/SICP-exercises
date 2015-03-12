(define (square x) (* x x))
(define (expt-r b n)
  (if (= n 0)
	1
	(* b (expt-r b (- n 1)))))

(define (expt-i b n)
  (define (expt-iter b counter product)
	(if (= counter 0)
	  product
	  (expt-iter b 
				 (- counter 1)
				 (* b product))))
  (expt-iter b n 1))

(define (f-expt-r b n)
  (cond ((= n 0) 1)
		((= (remainder n 2) 0) (square (f-expt-r b (/ n 2))))
		(else (* b (f-expt-r b (- n 1))))))
;; 1.16
;; not good
;;(define (f-expt-i b n)
;;  (define (e-iter b n a)
;;	(cond ((= n 0) 1)
;;		  ((= n 1) a)
;;		  ((= (remainder n 2) 0) (e-iter (* b b) (/ n 2) (* b b)))
;;		  (else (* b (e-iter b a (- n 1))))))
;;  (e-iter b n a))

(define (f-expt-i b n )
  (define (expt-iter b n a)	
	(cond ((= n 0) a)
		  ((= (remainder n 2) 0) (expt-iter (* b b) (/ n 2) a))
		  (else (expt-iter b (- n 1) (* a b)))))
  (expt-iter b n 1))

;; test
(begin
  (display "\n")
  (display '(f-expt-i 3 0)) (display (f-expt-i 3 0)) (display "\n")
  (display '(f-expt-i 3 1)) (display (f-expt-i 3 1)) (display "\n") 
  (display '(f-expt-i 3 2)) (display (f-expt-i 3 2)) (display "\n")
  (display '(f-expt-i 3 3)) (display (f-expt-i 3 3)) (display "\n")
  (display '(f-expt-i 3 4)) (display (f-expt-i 3 4)) (display "\n")
  (display '(f-expt-i 3 5)) (display (f-expt-i 3 5)) (display "\n")
  (display '(f-expt-i 3 10)) (display (f-expt-i 3 10)) (display "\n")
  (display '(f-expt-i 2 16)) (display (f-expt-i 2 16)) (display "\n")
  )
