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
; 2.1
(define (numer x) (car x))
(define (denom x) (cdr x))

(define (make-rat n d)
  (define (m-r n d)
	(let ((g (gcd n d)))
	  (cons (/ n g) (/ d g))))
  (cond ((> d 0) (m-r n d))
		((< d 0) (m-r (* -1 n) (* -1 d)))
		(else (display "d can't be 0 !"))))

(define (print-rat x)
  (newline)
  (display (numer x))
  (display "/")
  (display (denom x)))

; test
(print-rat (make-rat 1 2))
(print-rat (make-rat 1 -2))
(print-rat (make-rat -1 2))
(print-rat (make-rat -1 -2))
