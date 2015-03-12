; 3.7
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
		(display "error times : ")
		error-time)))
  ; ch-passwd
  (define (ch-passwd new-passwd)
	(set! passwd new-passwd))
  ; dispatch
  (define (dispatch pass m)
	(if (eq? pass passwd)
	  (begin 
		(set! error-time 0)
		(cond ((eq? m 'withdraw) withdraw)
			  ((eq? m 'deposit)  deposit)
			  ((eq? m 'join) ch-passwd)
			  (else (error "Unknomw request -- MAKE-ACCOUNT" m))))
	  passwd-error))
  dispatch)
; joint 
(define (make-joint account old-passwd new-passwd)
  (begin
	((account old-passwd 'join) new-passwd)
	account))

;; test 
(define acc (make-account 100 '12))
(define acc-1 (make-joint acc '12 1))

(newline) (display ((acc '12  'withdraw) 40))
(newline) (display ((acc '12  'withdraw) 40))
(newline) (display ((acc '1	  'deposit) 5))
(newline) (display ((acc '1	  'deposit) 5))
(newline) (display ((acc '12  'deposit) 40))
(newline) (display ((acc '1	  'deposit) 5))
(newline) (display ((acc-1 '1 'deposit) 5))
