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
; 2.31
(define (square x) (* x x))
; 1
(define (tree-map-lambda proc tree)
  (map (lambda (sub-t)
		 (if (pair? sub-t)
		   (tree-map-lambda proc sub-t)
		   (proc sub-t)))
	   tree))
; 2
(define (tree-map proc tree)
  (cond ((null? tree) tree)
		((not (pair? tree)) (proc tree))
		(else (cons (tree-map proc (car tree))
					(tree-map proc (cdr tree))))))

(define (square-tree tree) (tree-map square tree))
;; test
(define x (list 1 (list 2 (list 3 4) 5) (list 6 7)))

(newline) (display (square-tree x))
(newline) (display (square-tree ()))
;(newline) (display (square-tree-map x))
