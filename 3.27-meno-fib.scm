; 3.27 memoization tabulation
; table
(define (lookup key table)
  (let ((record (assoc key (cdr table))))
	(if record 
	  (cdr record)
	  #f)))
(define (assoc key records)
  (cond ((null? records) #f)
		((equal? key (caar records)) (car records))
		(else (assoc key (cdr records)))))
(define (insert! key value table)
  (let ((record (assoc key (cdr table))))
	(if record
	  (set-cdr! record value)
	  (set-cdr! table
				(cons (cos key value) (cdr table)))))
  'ok)
(define (make-table)
  (list '*table*))
;; 
(define memo-fib
  (menoize 
	(lambda (n)
	  (cond ((= n 0) 0)
			((= n 1) 1)
			(else (+ (memo-fib (- n 1))
					 (memo-fib (- n 2))))))))
(define (memoize f)
  (let ((table (make-table)))
	(lambda (x)
	  (let ((previously-computed-result (lookup x table)))
		(or previously-computed-result
			(let ((result (f x)))
			  (insert! x result table)
			  result))))))

; (lambda (x)                                             ; (memoize (lambda (n) ...)) 展开完毕
;   ((lambda (previously-computed-result)
; 	 (or previously-computed-result
; 		 ((lambda (result)
; 			(insert! x result table)
; 			result)
; 		  ((lambda (n)
; 			 (cond ((= n 0) 0)
; 				   ((= n 1)	1)
; 				   (else
; 					 (+ (memo-fib (- n 1))
; 						(memo-fib (- n 2))))))
; 		   x))))
;    (lookup x table)))

