;; 1.15
(define (cube x) (* x x x))
(define (p x) (- (* 3 x) (* 4 (cube x))))
(define (sine angles)
  (if (not (> (abs angles) 0.1))
	angles
	(p (sine (/ angles 3.0)))))
;; a) (sine 12.15) p use n (3^n > 121.5)
;; b) (sine a ) space log3(10*a) time (a^3)*(log3(10*a))
