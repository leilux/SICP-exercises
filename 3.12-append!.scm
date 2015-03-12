; 3.12
(define (append x y)
  (if (null? x)
	y
	(cons (car x) (append (cdr x) y))))
(define (append! x y)
  (set-cdr! (last-pair x) y)
  x)
(define (last-pair x)
  (if (null? (cdr x))
	x
	(last-pair (cdr x))))
;; test
(define x (list 'a 'b))
(define y (list 'c 'd))
(define z (append x y))
(newline) (display z)
(newline) (display (cdr x)) ; b
(define w (append! x y))
(newline) (display w)
(newline) (display (cdr x)) ; b c d

