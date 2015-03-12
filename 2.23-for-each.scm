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
; 2.23
(define (for-each-m pros L)
  (if (null? L)
	#f
	(begin
	  (pros (car L))
	  (for-each-m pros (cdr L)))))

(newline) (display (for-each-m (lambda (x) (newline) (display x))
							   (list 57 321 88)))
