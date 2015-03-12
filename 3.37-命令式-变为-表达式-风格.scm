; 3.37
(load "book/p216-constraint-propagate.scm")

; 将命令式风格的约束语言，变换为表达式风格的语言
(define (c+ x y) (let ((z (make-connector))) (adder		 x y z) z))
(define (c* x y) (let ((z (make-connector))) (multiplier x y z) z))
(define (c/ x y) (let ((z (make-connector))) (adder		 y z x) z))
(define (cv x)	 (let ((z (make-connector))) (constant	 x z)   z))

;; test
(define (celsius-fahrenheit-converter x)
  (c+ (c* (c/ (cv 9) (cv 5))
		  x)
	  (cv 32)))
(define C (make-connector))
(define F (celsius-fahrenheit-converter C))
(probe "C " C)
(probe "F " F)
(set-value! C 25 'user)
;(set-value! F 212 'user)
(forget-value! C 'user)
(set-value! F 212 'user)
