; (define (make-from-real-imag x y)
;   (define (dispatch op)
; 	(cond ((eq? op 'real-part) x)
; 		  ((eq? op 'imag-part) y)
; 		  ((eq? op 'magnitude)
; 		   (sqrt (+ (square x) (square y))))
; 		  ((eq? op 'angle) (atan y x))
; 		  (else (error "unknown op -- MAKE-FROM-REAL-IMAG" op))))
;   dispatch)
; (define (apply-generic op arg) (arg op))

; 2.75
(define (square x) (* x x))
(define (make-from-mag-ang r a)
  (define (dispatch op)
	(cond ((eq? op 'real-part) (* r (cos a)))
		  ((eq? op 'imag-part) (* r (sin a)))
		  ((eq? op 'magnitude) r)
		  ((eq? op 'angle ) a)
		  (else (error "unknown op -- MAKE-FROM-MAG-ANG", op))))
  dispatch)
; 2.76
; 显示分派 ：都不合适
; 数据导向 ：使用包机制增加新类型和新的通用操作，都合适
; 消息传递 ：将数据对象和数据对象的操作整合在一起，因此适合新类型，不适合新操作
; 





