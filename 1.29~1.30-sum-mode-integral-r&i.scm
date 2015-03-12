;; 递归
;; ===================================
(define (sum-r term a next b)
  (if (> a b)
	0
	(+ (term a)
	   (sum-r term (next a) next b))))
;; ===================================

;; 立方和
(define (cube x) (* x x x))
(define (inc n) (+ n 1))
(define (sum-cubes a b)
  (sum cube a inc b))
;; 求定积分
(define (integral f a b dx)
  (define (add-dx x) (+ x dx))
  (* (sum-r f (+ a (/ dx 2.0)) add-dx b)
	 dx))

;; 1.29 递归
;; 辛普森规则 [y0 + 4y1 + 2y2 + 4y3 + 2y4 + ... 2yn-2 + 4yn-1 + yn] * h / 3
;; h = (b - a) / n 
;; yk = f(a + h*k)
(define (intergal-r f a b n)
  (define b-a (- b a))
  (define h (/ b-a n))
  (define (next a) (+ a h))
  (define (n-k x) (/ (* n (- b x)) b-a))
  (define (term a) 
	(* (f a) 
	   (cond ((or (= (n-k a) 0) (= (n-k a) n)) 1.0)
			 ((even? (n-k a)) 2.0)
			 (else 4.0))))
  (* (sum-r term a next b) (/ h 3)))

;; 迭代
; ===================================
(define (sum-i term a next b)
  (define (iter a result)
	(if (> a b)
	  result
	  (iter (next a)
			(+ result 
			   (term a)))))
  (iter a 0))
; ===================================
;; 1.30 迭代
(define (intergal-i f a b n)
  (define b-a (- b a))
  (define h (/ b-a n))
  (define (next a) (+ a h))
  (define (n-k x) (/ (* n (- b x)) b-a))
  (define (term a) 
	(* (f a) 
	   (/ h 3)
	   (cond ((or (= (n-k a) 0) (= (n-k a) n)) 1.0)
			 ((even? (n-k a)) 2.0)
			 (else 4.0))))
  (sum-i term a next b))

;; test 
(newline)
(display (intergal-i cube 0 1 100))
(newline)
(display (intergal-i cube 0 1 1000))
