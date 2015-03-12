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
; 2.30
(define (square x) (* x x))

(define (square-tree t)
  (cond ((null? t) ())
		((not (pair? t)) (square t))
		(else 
		  (cons (square-tree (car t))
				(square-tree (cdr t))))))
; using map
(define (square-tree-map t)
  (map (lambda (sub-t)
		 (if (pair? sub-t)
		   (square-tree-map sub-t)
		   (square sub-t)))
	   t))


;; test
(define x (list 1 (list 2 (list 3 4) 5) (list 6 7)))

(newline) (display (square-tree x))
(newline) (display (square-tree-map x))
