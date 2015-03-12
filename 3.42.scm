; 3.42
(define (make-account balance)
  (define (withdraw amount)
	(if (>= balance amount)
	  (begin (set! balance (- balance amount))
			 balance)
	  "insufficient funds"))
  (define (deposit amount)
	(set! balance (+ balance amount))
	balance)
  (let ((protected (make-serializer)))
	(let ((protected-withdraw (protected withdraw))
		  (protected-deposit (protected deposit)))
		(define (dispatch m)
		  (cond ((eq? m 'withdraw) protected-withdraw)
				((eq? m 'deposit) protected-deposit)
				((eq? m 'balance)
				 ((protected (lambda () balance)))) ; serialized
				(else (error "unknown request -- MAKE-ACCOUNT" m))))
		dispatch)))
;; (parallel-execute
;; ((protected withdraw) 10)
;; ((protected withdraw) 20)
;; ((protected withdraw) 30))
;; 串行化执行
;; (parallel-execute
;; (protected-withdraw 10)
;; (protected-withdraw 20)
;; (protected-withdraw 30)
;; 只串行化 10 其他的失败
;; (let ((protected-withdraw (protected withdraw))
;; protected-withdraw 为不变的对象是(protected withdraw)执行过后的对象。
