; 3.45
(define (make-account-and-serizlizer balance)
  (define (withdraw amount)
	(if (>= balance amount)
	  (begin (set! balance (- balance amount))
			 balance)
	  "insufficient funds"))
  (define (deposit amount)
	(set! balance (+ balance amount))
	balance)
  (let ((balance-serializer (make-serializer)))
	(define (dispatch m)
	  (cond ((eq? m 'withdraw) (balance-serializer withdraw))
			((eq? m 'deposit) (balance-serializer deposit))
			((eq? m 'balance) balance)
			((eq? m 'serializer) balance-serializer)
			(else (error "unknown request -- MAKE_ACCOUNT" m))))
	dispatch))

(define (deposit account amount)
  ((account 'deposit) amount))
;; 在调用serialized-exchange时
;; 1. 将exchange加入serilized1和serilized2的串行化组
;; 2. 执行exchange时，返回了加入serilized1串行化组的withdraw。
;; 这样导致exchange和withdraw同时在一个串行化组，要执行withdraw就要先
;; 执行完exchange，导致阻塞发生。
