;; 1.17
(define (double x) (+ x x))
(define (halve x) (if (= (remainder x 2) 0) (/ x 2) x))

;; iterator
(define (mul-i a n)
  (define (iter a n t)
	(cond ((= n 0) t)
		  ((= (remainder n 2) 0) (iter (double a) (halve n) t))
		  (else (iter a (- n 1) (+ t a)))))
  (iter a n 0))

;; recursion
(define (mul-r a n)
  (cond ((= n 0) 0)
		((= n 1) a)
		((= (remainder n 2) 0) (mul-r (double a) (halve n)))
		(else (+ a (mul-r a (- n 1))))))

;; test
(begin
  (display "\n")
  (display '(mul-r 3 0)) (display (mul-r 3 0)) (display "\n")
  (display '(mul-r 3 1)) (display (mul-r 3 1)) (display "\n") 
  (display '(mul-r 3 2)) (display (mul-r 3 2)) (display "\n")
  (display '(mul-r 3 3)) (display (mul-r 3 3)) (display "\n")
  (display '(mul-r 3 4)) (display (mul-r 3 4)) (display "\n")
  (display '(mul-r 3 5)) (display (mul-r 3 5)) (display "\n")
)
