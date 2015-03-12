; 3.14
(define (mystery x)
  (define (loop x y)
	(if (null? x)
	  y
	  (let ((temp (cdr x)))
		(set-cdr! x y)
		(loop temp x))))
  (loop x '()))
(define v (list 'a 'b 'c 'd))
(define w (mystery v))
(newline) (display v) ; a
(newline) (display w) ; d c b a
