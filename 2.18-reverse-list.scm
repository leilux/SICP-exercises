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
; 2.18
; 递归
(define (reverse-m-r L)
	(if (null? L)
	  ()
	  (append (reverse-m-r (cdr L)) (cons (car L) ()))))

; 迭代
(define (reverse-m-i L)
  (define (reverse-iter L temp)
	(if (and (null? (cdr L))
			 (not (null? (car L))))
	  (cons (car L) temp)
	  (reverse-iter (cdr L) (cons (car L) temp))))
  (if (null? L) 
	L
	(reverse-iter L ())))
;; test 
(define l1 (list 1 2 3 4 5 6))
(define l2 (list 1 3 5 7 2 4 6 8))
(newline) (display (reverse-m-r l1))
(newline) (display (reverse-m-r l2))

