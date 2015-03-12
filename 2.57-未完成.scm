; 2.57
(define (variable? x) (symbol? x))
(define (same-variable? v1 v2) (and (variable? v1) (variable? v2) (eq? v1 v2)))
; make
(define (make-sum  . a2) (append (list '+) a2))
(define (addend s) (cadr s))
(define (augend s) (make-sum (caddr s)))
(define (sum? x) (and (pair? x) (> (length x) 2) (eq? (car x) '+)))

(define (make-product  . m2) (append (list '*) m2))
(define (multiplier p) (cadr p))
(define (multiplicand p) (make-product (caddr p)))
(define (product? x) (and (pair? x) (> (length x) 2) (eq? (car x) '*)))

(define (deriv exps var)
  (cond ((number? exps) 0)
		((variable? exps)
		 (if (same-variable? exps var) 1 0))
		((sum? exps)
		 (make-sum (deriv (addend exps) var)
				   (deriv (augend exps) var)))
		((product? exps)
		 (make-sum
		   (make-product (multiplier exps)
						 (deriv (multiplicand exps) var))
		   (make-product (deriv (multiplier exps) var)
						 (multiplicand exps))))
		(else
		  (error "unkonwn expression type -- DERIV" exps))))
;; test
(newline) (display (deriv '(* x y (+ x 3)) 'x))
