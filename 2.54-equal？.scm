; 2.54
(define (equal-?-m x y)
  (cond ((and (pair? x) (pair? y)) (if (equal-?-m (car x) (car y)) 
									 (equal-?-m (cdr x) (cdr y))
									 #f))
		((and (not (pair? x)) (not (pair? y))) (if (eq? x y) #t #f))
		(else #f)))
; test 
(newline) (display (equal-?-m '(a b c d) '(a b c d)))
(newline) (display (equal-?-m '(a b c d) '(a (b c) d)))
(newline) (display (equal-?-m '(a (b c) d) '(a b c d)))
(newline) (display (equal-?-m '(a (b c) d) '(a (b c) d)))
