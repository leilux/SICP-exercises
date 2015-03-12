; 3.3
(define (make-account balance passwd)
  (define (withdraw amount)
	(if (>= balance amount)
	  (begin (set! balance (- balance amount))
			 balance)
	  "Insufficient funds"))
  (define (deposit amount)
	(set! balance (+ balance amount))
	balance)
  (define (dispatch pass m)
	(if (eq? pass passwd)
	  (cond ((eq? m 'withdraw) withdraw)
			((eq? m 'deposit)  deposit)
			(else (error "Unknomw request -- MAKE-ACCOUNT" m)))
	  (lambda (amount) "error passwd")))
  dispatch)
;; test 
(define acc (make-account 100 '12))
(newline) (display ((acc '12  'withdraw) 40))
(newline) (display ((acc '12  'withdraw) 40))
(newline) (display ((acc '12  'deposit) 40))
(newline) (display ((acc '1	  'deposit) 5))

