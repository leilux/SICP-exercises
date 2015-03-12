; 3.19
(define (loop? lst)
  (define w1 (walk lst 1))
  (define w2 (walk lst 2))
  (define (iter w1 w2)
	(cond ((or (null? w1) (null? w2)) #f)
		  ((eq? w1 w2) #t)
		  (else (iter (walk w1 1) (walk w2 2)))))
  (iter w1 w2))
(define (walk lst step)
  (cond ((null? lst) '())
		((= 0 step) lst)
		((walk (cdr lst) (- step 1)))))
;; test
(define (last-pair x)
  (if (null? (cdr x))
	x
	(last-pair (cdr x))))

(define x (list 1 2 3 4))
(define y (list 1 2 3 4))
(set-cdr! (last-pair y) y)

(newline) (display (loop? x))
(newline) (display (loop? y))
