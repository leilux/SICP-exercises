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
; 2.39
(define (reverse-r sequence)
  (fold-right (lambda (x y)
				(append (reverse-r y) (list x)))
			  ()
			  sequence))
(define (reverse-l seq)
  (fold-left (lambda (result rest) (cons rest result))
			 ()
			 seq))
; test
(newline) (display (reverse-r (list 1 2 3 4)))
(newline) (display (reverse-l (list 1 2 3 4)))
