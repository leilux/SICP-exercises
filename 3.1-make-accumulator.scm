;; 1
(define new-withdraw
  (let ((balance 100))
	(lambda (amount)
	  (if (>= balance amount)
		(begin (set! balance (- balance amount))
			   balance)
		"Insufficient funds"))))
;; 2
(define (make-withdraw balance)
  (lambda (amount)
	(if (>= balance amount)
	  (begin (set! balance (- balance amount))
			 balance)
	  "Insufficient funds")))
;; test
(define w1 (make-withdraw 100))
(w1 50)
;; 3
(define (make-account balance)
  (define (withdraw amount)
	(if (>= balance amount)
	  (begin (set! balance (- balance amount))
			 balance)
	  "Insufficient funds"))
  (define (deposit amount)
	(set! balance (+ balance amount))
	balance)
  (define (dispatch m)
	(cond ((eq? m 'withdraw) withdraw)
		  ((eq? m 'deposit)  deposit)
		  (else (error "Unknomw request -- MAKE-ACCOUNT" m))))
  dispatch)
;; test
(define acc (make-account 100))
((acc 'withdraw) 50)
((acc 'deposit) 40)
; 3.1
(define (make-accumulator start)
  (lambda (add)
	(begin 
	  (set! start (+ add start))
	  start)))
;; test
(define a (make-accumulator 5))
(newline) (display (a 10))
(newline) (display (a 10))
(newline) (display (a 10))
(newline) (display (a 10))
