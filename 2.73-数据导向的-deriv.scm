(define (attach-tag type-tag x y) (list type-tag x y))
(define (type-tag datum) (car datum))
(define (contents datum) (cdr datum))

;; 基与被求导表达式类型的分派工作
(define (deriv exps var)
  (cond ((number? exps) 0)
		((variable? exps) (if (same-variable? exps var) 1 0))
		((sum? exps)
		 (make-sum (deriv (addend exps) var)
				   (deriv (augend exps) var)))
		((product? exps)
		 (make-sum
		   (make-product (multiplier exps)
						 (deriv (multiplicand exps) var))
		   (make-product (deriv (multiplier exps) var)
						 (multiplicand exps))))
		(else (error "unknow expression type -- DERIV" exps))))
;; 数据导向
(define (deriv exps var)
  (cond ((number? exps) 0)
		((variable? exps) (if (same-variable? exps var) 1 0))
		(else ((get 'deriv (operator exps)) 
			   (operands exps) var))))
(define (operator exps) (car exps))
(define (operands exps) (cdr exps))
; 2.73
; b)
(define (install-sum-package)
  ;;
  (define (addend s) (car s))
  (define (augend s) (cadr s))
  (define (make-sum x y) 
	(cond ((= x 0) y)
		  ((= y 0) x)
		  ((and (number? x) (number? y)) (+ x y))
		  (else (attach-tag '+ x y))))
  ;; 
  (put 'addend   '+ addend)
  (put 'augend   '+ augend)
  (put 'make-sum '+ make-sum)
  (put 'deriv '+
	   (lambda (exps var)
		 (make-sum (deriv (addend exps) var)
				   (deriv (augend exps) var))))
  'done)
(define (make-sum x y) ((get 'make-sum '+) x y))
(define (addend sum) ((get 'addend '+) (contents sum)))
(define (augend sum) ((get 'augend '+) (contents sum)))
;; 
(define (install-product-package)
  ;; internal procedures
  (define (multiplier p) (car p))
  (define (multiplicand p) (cadr p))
  (define (make-product x y)
	(cond ((or (= x 0) (= y 0)) 0)
		  ((= x 1) y)
		  ((= y 1) x)
		  ((and (number? x) (number? y))
		   (* x y))
		  (else (attach-tag '* x y))))
  ;; interface to the rest of the system
  (put 'multipiler   '* multiplier)
  (put 'multiplicand '* multiplicand)
  (put 'make-product '* make-product)
  (put 'deriv '*
	   (lambda (exps var)
		 (make-sum
		   (make-product (multiplier exps)
						 (deriv (multiplicand exps) var))
		   (make-product (deriv (multiplier exps) var)
						 (multiplicand exps)))))
  'done)
(define (make-product x y) ((get 'multiplicand '*) x y))
(define (multiplier product) ((get 'multipiler '*) (contents product)))
(define (multiplicand product) ((get 'multiplicand '*) (contents product)))

;; c)
(define (install-exponentiation-package)

    ;;; internal procedures
    (define (base exp)
        (car exp))

    (define (exponent exp)
        (cadr exp))

    (define (make-exponentiation base n)
        (cond ((= n 0)
                0)
              ((= n 1)
                base)
              (else
                (attach-tag '** base n))))

    ;;; interface to the rest of the system
    (put 'base '** base)
    (put 'exponent '** exponent)
    (put 'make-exponentiation '** make-exponentiation)

    (put 'deriv '**
         (lambda (exp var)
            (let ((n (exponent exp))
                  (u (base exp)))
                (make-product
                    n
                    (make-product
                        (make-exponentiation
                            u
                            (- n 1))
                        (deriv u var))))))

'done)

(define (make-exponentiation base n)
    ((get 'make-exponentiation '**) base n))

(define (base exp)
    ((get 'base '**) (contents exp)))

(define (exponent exp)
    ((get 'exponent '**) (contents exp)))
; d)
; (put 'addend '+ addend) => (put '+ 'addend addend)
