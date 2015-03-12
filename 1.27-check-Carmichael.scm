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
  (cond ((= a n) (display "\na is n now"))
		((= a (expmod a n n)) (carmi-t (+ a 1) n))
		(else (display "\nwrong != discove"))))

;; test
(carmi-t 2 561)
(carmi-t 2 1105)
(carmi-t 2 1729)
(carmi-t 2 2465)
(carmi-t 2 2821)
(carmi-t 2 6601)
(carmi-t 2 2456) ; it's not 
