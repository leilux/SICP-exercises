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

(define (transpose mat)
(accumulate-n cons
			  ()
			  mat))
; test transpose
(newline) (display (transpose (list (list 1 2 3 4)
									(list 4 5 6 7)
									(list 6 7 8 9))))
; 2.49
(define get-vertex
  (lambda (op)
	(op 1 2 3 4)))
(define (a-pointer x)
  (define (op a b c d) (display (- a b)))
  (get-vertex op))
;; test
(a-pointer 1)
