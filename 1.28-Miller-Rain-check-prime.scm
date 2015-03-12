;; 1.27
;; Carmichael number : 561 1105 1729 2465 2821 6601  in 100,000,000
;; prime? feima O(logn)
(define (square x) (* x x))
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
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define (carmi-t a n)
  (cond ((= a n) (display #t))
		((= a (expmod a n n)) (if (and (< a (- n 1)) (= (remainder (* a a) n) 1))
								(display #f)
								(carmi-t (+ a 1) n)))
		(else (display #f))))

;; test
(newline)
(carmi-t 2 561)
(newline)
(carmi-t 2 1105)
(newline)
(carmi-t 2 1729)
(newline)
(carmi-t 2 2465)
(newline)
(carmi-t 2 3)
(newline)
(carmi-t 2 5)
(newline)
(carmi-t 2 1999)

