; 2.61
(define (element-of-set? x set) ; O(n)
  (cond ((null? set) #f)
		((= x (car set)) #t)
		((< x (car set)) #f)
		(else (element-of-set? x (cdr set)))))

(define (intersection-set set1 set2) ; O(n)
  (if (or (null? set1) (null? set2))
	'()
	(let ((x1 (car set1)) (x2 (car set2)))
	  (cond ((= x1 x2)
			 (cons x1
				   (intersection-set (cdr set1)
									 (cdr set2))))
			((< x1 x2)
			 (intersection-set (cdr set1) set2))
			((> x1 x2)
			 (intersection-set set1 (cdr set2)))))))

(define (adjoin-set x set) ; O(n)
  (cond ((or (null? set) 
			 (<= x (car set)))
		 (cons x set))
		(else (cons (car set) (adjoin-set x (cdr set))))))
;; test 
(newline) (display "adjoin-set test ...")
(newline) (display (adjoin-set 0 (list 1 2 3 4 5 6 )))
(newline) (display (adjoin-set 1 (list 1 2 3 4 5 6 )))
(newline) (display (adjoin-set 2 (list 1 2 3 4 5 6 )))
(newline) (display (adjoin-set 3 (list 1 2 3 4 5 6 )))
(newline) (display (adjoin-set 4 (list 1 2 3 4 5 6 )))
(newline) (display (adjoin-set 5 (list 1 2 3 4 5 6 )))
(newline) (display (adjoin-set 6 (list 1 2 3 4 5 6 )))
(newline) (display (adjoin-set 7 (list 1 2 3 4 5 6 )))

; 2.62
(define (union-set set1 set2) ; O(n)
  (cond ((null? set1) set2)
		((null? set2) set1)
		(else 
		  (let ((x1 (car set1)) (x2 (car set2)))
			(cond ((= x1 x2) (cons x1 (union-set (cdr set1) (cdr set2))))
				  ((< x1 x2) (cons x1 (union-set (cdr set1) set2)))
				  ((> x1 x2) (cons x2 (union-set set1 (cdr set2)))))))))
;; test
(newline) (display "union-set testing ...")
(newline) (display (union-set (list 1 2 3 4) (list 2 3 4 5)))
(newline) (display (union-set (list 2 3 4 6) (list 1 3 4 5)))
(newline) (display (union-set (list 2 3 4 5) (list 2 3 4 5)))
(newline) (display (union-set '() (list 2 3 4 5)))
(newline) (display (union-set '() '()))
