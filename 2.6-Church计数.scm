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
; 2.6 
 (define zero (lambda (f) (lambda (x) x)))
 (define one (lambda (f) (lambda (x) (f x))))
 (define two (lambda (f) (lambda (x) (f (f x)))))

 (define (add a b) (lambda (f) (lambda (x) ((a f) ((b f) x)))))
 (define (add-1 n) (lambda (f) (lambda (x) (f ((n f) x)))))

 (define (multi a b)
   (lambda (f)
     (lambda (x)
       ((a (b f) ) x))))
 
 (define (expon a b)
   (lambda (f)
     (lambda (x)
       (((a b) f)  x))))

 (define (show-num n) 
   (newline)
   (display ((n (lambda (x) (+ 1 x))) 0)))
 
 (show-num zero)
 (show-num one)
 (show-num two)
 (newline)
 (show-num (add-1 zero))
 (show-num (add-1 (add-1 zero)))
 (show-num (add-1 (add-1 (add-1 zero))))
 (show-num (add-1 (add-1 (add-1 (add-1 zero)))))
 
 (newline)
 (display "my add\n")
 (show-num (add zero zero))
 (show-num (add (add-1 zero) (add-1 zero)))
 (show-num (add (add-1 zero) (add-1 (add-1 zero))))
 
 (show-num (multi two two))
 (show-num (multi (add one two) two))
 
 (show-num (expon two two))
 (show-num (expon (expon two two) two))



