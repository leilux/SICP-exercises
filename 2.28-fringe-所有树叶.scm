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
; 2.28
(define x (list (list 1 2) (list 3 4)))
(define y (list (list 1 2 3) 4 5 6))

(define (fringe tree)
	(cond ((null? tree) ())
		  ((not (pair? tree)) (list tree))
		  (else (append
				  (fringe (car tree))
				  (fringe (cdr tree))))))
;; test
(newline) (display (fringe x))
(newline) (display (fringe y))
