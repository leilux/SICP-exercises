;;-------------------------------- T E S T ---------------------;+
(define (title n)												;|
  (begin                                                        ;|
	(display "\n - - - - ")	(display n) (display " - - - -\n")));|
(define (test f a b)                                            ;|
  (newline)                                                     ;|
  (if (> a b)                                                   ;|
	(display "test over !\n")                                   ;|
	(begin                                                      ;|
	  (display a) (display " : ") (display (f a))               ;|
	  (test f (+ a 1) b))))                                     ;|
; --------------------------------------------------------------;+
; 2.17 list not nil
(define (last-pair list1)
  (if (and (null? (cdr list1))
		   (not (null? (car list1))))
	(car list1)
	(last-pair (cdr list1))))

(define x1 (list 1 2 3 4 2 1))
(define x2 (list 1 2 3 4 2 2))
(define x3 (list 1 2 3 4 2 3))
(define x4 (list 1 2 3 4 2 4))

(newline)(display (last-pair x1))
(newline)(display (last-pair x2))
(newline)(display (last-pair x3))
(newline)(display (last-pair x4))
