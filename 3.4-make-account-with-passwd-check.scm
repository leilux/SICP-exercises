; 3.4
(define (make-account balance passwd)
  ; withdraw
  (define (withdraw amount)
	(if (>= balance amount)
	  (begin (set! balance (- balance amount))
			 balance)
	  "Insufficient funds"))
  ; deposit
  (define (deposit amount)
	(set! balance (+ balance amount))
	balance)
  ; call-the-cops
  (define call-the-cops "You have error 7 times in a row.")
  ; error-time
  (define error-time 0)
  ; passwd-error
  (define (passwd-error amount) 
	(if (>= error-time 6)
	  call-the-cops
	  (begin 
		(set! error-time (+ error-time 1))
		error-time)))
  ; dispatch
  (define (dispatch pass m)
	(if (eq? pass passwd)
	  (begin 
		(set! error-time 0)
		(cond ((eq? m 'withdraw) withdraw)
			  ((eq? m 'deposit)  deposit)
			  (else (error "Unknomw request -- MAKE-ACCOUNT" m))))
	  passwd-error))
  dispatch)
;; test 
(define acc (make-account 100 '12))
(display "n")
(newline) (display ((acc '12  'withdraw) 40))
(newline) (display ((acc '12  'withdraw) 40))
(newline) (display ((acc '1	  'deposit) 5))
(newline) (display ((acc '1	  'deposit) 5))
(newline) (display ((acc '1	  'deposit) 5))
(newline) (display ((acc '1	  'deposit) 5))
(newline) (display ((acc '1	  'deposit) 5))
(newline) (display ((acc '12  'deposit) 40))
(newline) (display ((acc '1	  'deposit) 5))
(newline) (display ((acc '1	  'deposit) 5))
(newline) (display ((acc '1	  'deposit) 5))
(newline) (display ((acc '1	  'deposit) 5))
(newline) (display ((acc '1	  'deposit) 5))
(newline) (display ((acc '1	  'deposit) 5))
(newline) (display ((acc '1	  'deposit) 5))


