; 3.18
(define (loop? lst)
  (define identity (cons '() '()))
  (define (iter lst)
	(cond ((null? lst) #f)
		  ((eq? identity (car lst)) #t)
		  (else 
			(begin
			  (set-car! lst identity)
			  (iter (cdr lst))))))
  (iter lst))
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
