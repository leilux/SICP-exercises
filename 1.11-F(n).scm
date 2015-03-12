;; 1.11
;; recursion
(define (fun-r n)
  (if (< n 3)
	n
	(+ (fun-r (- n 1))
	   (* 2
		  (fun-r (- n 2)))
	   (* 3
		  (fun-r (- n 3))))))
;; iterator
(define (fun-i n)
  (define (fun-iter a b c n)
	(cond ((< n 3) n)
		  ((= n 3) c)
		  (else (fun-iter b c (+ (* 3 a) (* 2 b) c) (- n 1)))))
  (fun-iter 1 2 4 n))

