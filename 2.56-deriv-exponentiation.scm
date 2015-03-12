; 2.56
(define (make-exponentiation base exponent) (list '** base exponent))
(define (exponentiation? e) (and (pair? e) (eq? (car e) '**)))
(define (base e) (cadr e))
(define (exponent e) (caddr e))
(define (deriv exps var)
  (cond ((number? exps) 0)
		((variable? exps)
		 (if (same-varibale? exps var) 1 0))
		((sum? exps)						; +
		 (make-sum (deriv (addend exps) var)
				   (deriv (augend exps) var)))
		((product? exps)
		 (make-sum							; *
		   (make-product (multiplier exps)
						 (deriv (multiplicand exps) var))
		   (make-product (deriv (multiplier exps) var)
						 (multiplicand exps))))
		((exponentiation? exps)				; exp
		 (make-product (exponent exps)
					   (make-exponentiation (base exps)
											(- (exponent exps) 1))))
		(else
		  (error "unkonwn expression type -- DERIV" exps))))

