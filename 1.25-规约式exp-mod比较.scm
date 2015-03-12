;; 1.25
(define (expmod-f base exps m)
  (cond ((= exps 0) 1)
		((even? exps)
		 (remainder (square (expmod-f base (/ exps 2) m))
					m))
		(else 
		  (remainder (* base (expmod-f base (- exps 1) m))
					 m))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define (f-expt-i b n )
  (define (expt-iter b n a)	
	(cond ((= n 0) a)
		  ((= (remainder n 2) 0) (expt-iter (* b b) (/ n 2) a))
		  (else (expt-iter b (- n 1) (* a b)))))
  (expt-iter b n 1))

(define (expmod base exps m)
  (remainder (f-expt-i base exps) m))
;; base 太大不行
