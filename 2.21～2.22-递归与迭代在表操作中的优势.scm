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
; 2.21, 2.22
(define (square x) (* x x))
; 递归
(define (square-list-r L)
  (if (null? L)
	()
	(cons (square (car L)) (square-list-1 (cdr L)))))
; 迭代
(define (square-list-i L)
  (define (iter things answer)
	(if (null? things)
	  answer
	  (iter (cdr things)
			(cons (square (car things))
				  answer)))))


(define (square-list-2 L)
  (map square L))

;; test 
(define l1 (list 1 2 3 4))
(newline) (display (square-list-r l1))
(newline) (display (square-list-2 l1))
