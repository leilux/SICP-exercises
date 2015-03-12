; 2.46
; make
(define (make-vect x y) (cons x y))
; x
(define (xcor-vect v) (car v))
; y
(define (ycor-vect v) (cdr v))
; op
(define (s-or-a-vect  op v1 v2) (cons (op (xcor-vect v1)
										 (xcor-vect v2))
									  (op (ycor-vect v1)
										 (ycor-vect v2))))
; +
(define (add-vect v1 v2) (s-or-a-vect + v1 v2))
; -
(define (sub-vect v1 v2) (s-or-a-vect - v1 v2))
; scale
(define (scale-vect s v) (cons (* s (xcor-vect v)) (* s (ycor-vect v))))

