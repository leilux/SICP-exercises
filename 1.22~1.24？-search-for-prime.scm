;; prime? find-divisor O(n^-1)
(define (square x) (* x x))
;;;;;;;;;;;;;;;;;;;;;;;;;;;prime use divisor;;;;;;;;;;;;;;;;;;;;
(define (divides? a b)
  (= (remainder b a) 0))

(define (next n) (if (= n 2) 3 (+ n 2)))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
		((divides? test-divisor n) test-divisor)
		;; 
		(else (find-divisor n (next test-divisor)))))

(define (smallest-divisor n)
  (find-divisor n 2))

(define (prime? n)
  (= n (smallest-divisor n)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time))

(define (start-prime-test n start-time)
  (if (prime? n)
	(report-prime (- (runtime) start-time))))

(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (runtime)))

(define (search-for-prime a b n)
  (cond ((= n 7) (display n))
		((prime? a)
		 (begin
		   (timed-prime-test a)
		   (search-for-prime (+ a 1) b (+ n 1))))
		(else (search-for-prime (+ a 1) b n))))

;; test
(search-for-prime 1000		10000	0)
(newline)
(search-for-prime 10000		100000	0)
(newline)
(search-for-prime 100000	1000000 0)
(newline)
(search-for-prime 1000000	10000000 0)

