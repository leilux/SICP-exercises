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
; 2.25
(define x (cons (list 1 2) (list 3 4)))

(newline) (display (car   x))(display(pair? (car   x)))
(newline) (display (cdr   x))(display(pair? (cdr   x)))
(newline) (display (caar  x))(display(pair? (caar  x)))
(newline) (display (cadr  x))(display(pair? (cadr  x)))
(newline) (display (cdar  x))(display(pair? (cdar  x)))
(newline) (display (cadar x))(display(pair? (cadar x)))
(newline) (display (cddr  x))(display(pair? (cddr  x)))
(newline) (display (caddr x))(display(pair? (caddr x)))
(newline) (display (cdddr x))(display(pair? (cdddr x)))
(define (count-leaves x)
  (cond ((null? x) 0)
		((not (pair? x)) 1)
		(else (+ (count-leaves (car x))
				 (count-leaves (cdr x))))))
; 1
(define x1 (list 1 3 (list 5 7) 9))
(cadr (list-ref x1 2))
; 2
(caar (list (list 7)))
; 3
(define x (list 1 (list 2 (list 3 (list 4 (list 5 (list 6 7)))))))
(cadadr (cadadr (cadadr x)))
