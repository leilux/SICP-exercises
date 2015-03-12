;; prime? find-divisor O(n^-1)
(define (square x) (* x x))

(define (divides? a b)
  (= (remainder b a) 0))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
		((divides? test-divisor n) test-divisor)
		(else (find-divisor n (+ test-divisor 1)))))

(define (smallest-divisor n)
  (find-divisor n 2))

(define (prime? n)
  (= n (smallest-divisor n)))
;; 1.21
;; 199 -> 199, 1999 -> 1999, 19999 -> 7

;; prime? feima O(logn)
(define (expmod base exps m)
  (cond ((= exps 0) 1)
		((even? exps)
		 (remainder (square (expmod base (/ exps 2) m))
					m))
		(else 
		  (remainder (* base (expmod base (- exps 1) m))
					 m))))

(define (fermat-test n)
  (define (try-it a)
	(= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))

(define (fast-prime? n times)
  (cond ((= times 0) #t)
		((fermat-test n) (fast-prime? n (- times 1)))
		(else #f)))


