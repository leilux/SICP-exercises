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
; 2.37
(define (accumulate op init sequence)
  (if (null? sequence)
	init
	(op (car sequence)
		(accumulate op init (cdr sequence)))))
(define (accumulate-n op init seqs)
  (if (null? (car seqs))
	()
	(cons (accumulate op init (map car seqs))
		  (accumulate-n op init (map cdr seqs)))))

(define (dot-product v w)
  (accumulate + 0 (map * v w)))

(define (matrix-*-vector m v)
  (map (lambda (mj) (dot-product v mj)) m))

(define (transpose mat)
  (accumulate-n cons
				()
				mat))
; test transpose
(newline) (display (transpose (list (list 1 2 3 4)
									(list 4 5 6 7)
									(list 6 7 8 9))))
(define (matrix-*-matrix m n)
  (let ((cols (transpose n)))
	(map (lambda (x) (matrix-*-vector cols x)) m)))
