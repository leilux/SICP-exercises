(define (average x y) (/ (+ x y) 2))
;; 1.8
(define (square x) (* x x))

(define (improve guess x) (average guess (/ x guess)))
(define (improvecuberoot guess x) 
  (/ (+ (/ x (square y)) (* 2 y)) 3))

;; for x < 1
(define error 0.001)
(define (good-enough1? guess x) 
  (< (abs (- (square guess) x)) error))
;; 1.7  smaller than error will be wrong 
;;		for the big number the error is no mean
;; for x > 1
(define (pre-guess guess x) (/ (* 2 guess x) (+ 1 x)))
;; | (nex_guess - pre_guess) / (guess - pre_guess) | > 0.5
;; |delta2 -delta 1| / delta1 < 0.01
(define (delta x y) (abs (- x y)))
(define (good-enough2? guess x) 
  (< (/ (abs (- (delta (pre-guess guess x) guess)
				(delta (pre-guess guess x) (improve guess x))))
		(delta (pre-guess guess x) guess)
		)
	 0.001))

;;1.6 -> Aborting!: maximum recursion depth exceeded
(define (new-if predicate then-clause else-clause)
  (cond (predicate then-clause)
		(else else-clause)))
;; recursion
(define (sqrt-iter guess x)
  (if (good-enough? guess x)
	(improve guess x)
	(sqrt-iter (improve guess x)
			   x)))

(define guess 1.0)
(define (my-sqrt x) 
  (if (> x 1)
	(set! good-enough? good-enough2?)
	(set! good-enough? good-enough2?))
  (sqrt-iter (/ x 2.0)  x))


(define (T-my-sqrt x) (- (square (my-sqrt x)) x))
(my-sqrt 0.0001)


