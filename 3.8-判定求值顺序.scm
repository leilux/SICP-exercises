; 3.8
(define (ff)
  (define a 1)
  (lambda (x)
	(begin (set! a (* a x)) (* a 1))))

(define f (ff))
(newline) (display (+ (f 0) (f 1))) ; 1 : L <- R

(define g (ff))
(newline) (display (+ (g 1) (g 0))) ; 0


