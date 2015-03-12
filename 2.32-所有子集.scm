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
; 2.32
(define (subsets s)
  (if (null? s)
	(list ())
	(let ((rest (subsets (cdr s))))
	  (append rest 
			  (map (lambda (sub) (cons (car s) sub))
				   rest)))))

;; test
(subsets (list 1 2))
