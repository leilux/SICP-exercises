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
; 2.27
(define x (list (list 1 2) (list 3 4)))

(define (deep-reverse L)
  (define (iter lst-i lst-o)
	(cond ((null? lst-i) lst-o)
		  ((not (pair? (car lst-i)))
		   (iter (cdr lst-i)
				 (cons (car lst-i) lst-o)))
		  (else 
			(iter (cdr lst-i)
				  (cons (deep-reverse (car lst-i))
						lst-o)))))
  (iter L ()))
; test
(deep-reverse x)

