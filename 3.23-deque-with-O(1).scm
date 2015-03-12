(define (r) (restart 1))
; 3.23
; make : 
(define (make-node item prev-p next-p)
  (cons item (cons prev-p next-p)))
(define (make-deque) (cons '() '()))
; predicate : 
(define (empty-deque? deque)
  (null? (get-front-ptr deque)))
; get-item
(define (front-deque deque)
  (if (empty-deque? deque)
	(error "front-deque" deque)
	(car (get-front-ptr deque))))
(define (rear-deque deque)
  (if (empty-deque? deque)
	(error "rear-deque" deque)
	(car (get-rear-ptr deque))))
; get-node
(define (get-front-ptr deque) (car deque))
(define (get-rear-ptr deque)  (cdr deque))
; set-node
(define (set-node-p! node item) (set-car! (cdr node) item))
(define (set-node-n! node item) (set-cdr! (cdr node) item))
; set-deque
(define (set-front-prt! deque item) (set-car! deque item))
(define (set-rear-prt! deque item) (set-cdr! deque item))
; change
;		front-insert-deque!
(define (insert-front-deque! deque item)
  (define new-node (make-node item '() '()))
  (define new-node1 (make-node item '() '()))
  (cond ((empty-deque? deque)
		 (set-car! deque new-node)
		 (set-cdr! deque new-node1)
		 deque)
		((equal? (get-front-ptr deque) (get-rear-ptr deque)) ; reamin 1
		 (set-node-n! new-node (get-rear-ptr deque))
		 (set-node-p! (get-rear-ptr deque) new-node)
		 (set-front-prt! deque new-node)
		 deque)
		(else
		  (set-node-n! new-node (get-front-ptr deque))
		  (set-node-p! (get-front-ptr deque) new-node)
		  (set-front-prt! deque new-node)
		  deque)))
;		rear-insert-deque!
(define (insert-rear-deque! deque item)
  (define new-node (make-node item '() '()))
  (define new-node1 (make-node item '() '()))
  (cond ((empty-deque? deque)
		 (set-car! deque new-node1)
		 (set-cdr! deque new-node)
		 deque)
		((equal? (get-front-ptr deque) (get-rear-ptr deque)) ; remain 1
		 (set-node-p! new-node (get-front-ptr deque))
		 (set-node-n! (get-front-ptr deque) new-node)
		 (set-rear-prt! deque new-node)
		 deque)
		(else
		  (set-node-n! (get-rear-ptr deque) new-node)
		  (set-node-p! new-node (get-rear-ptr deque))
		  (set-rear-prt! deque new-node)
		  deque)))
;		front-delete-deque!
(define (delete-front-deque! deque)
  (cond ((empty-deque? deque) ; reamin 0
		 (error "delete! called with an empty deque" deque))
		((equal? (cddr (get-front-ptr deque)) (get-rear-ptr deque)) ; remain 2
		 (set-node-p! (get-rear-ptr deque) '())
		 (set-front-prt! deque (get-rear-ptr deque))
		 deque)
		((equal? (get-front-ptr deque) (get-rear-ptr deque)) ; remain 1
		 (set-front-prt! deque '())
		 (set-rear-prt!  deque '())
		 deque)
		(else
		  (set-front-prt! deque (cddr (get-front-ptr deque)))
		  (set-node-p! (get-front-ptr deque) '())
		  deque)))
;		rear-delete-deque!
(define (delete-rear-deque! deque)
  (cond ((empty-deque? deque)
		 (error "delete! called with an empty deque" deque))
		((equal? (cddr (get-front-ptr deque)) (get-rear-ptr deque))
		 (set-node-n! (get-front-ptr deque) '())
		 (set-rear-prt! deque (get-front-ptr deque))
		 deque)
		((equal? (get-front-ptr deque) (get-rear-ptr deque)) ; remain 1
		 (set-front-prt! deque '())
		 (set-rear-prt!  deque '())
		 deque)
		(else
		  (set-rear-prt! deque (cadr (get-rear-ptr deque)))
		  (set-node-n! (get-rear-ptr deque) '())
		  deque)))
; display
(define (display-deque deque)
  (define (has-prev-node? node) (not (null? (cadr node))))
  (define (prev-node node) (cadr node))
  (define (iter node temp)
	(cond ((empty-deque? deque)
		   (display "it's empty"))
		  ((has-prev-node? node)
		   (iter (prev-node node) (cons (car node) temp)))
		  (else (display (cons (car node) temp)))))
  (iter (get-rear-ptr deque) '()))

;; test
(define q1 (make-deque))q
(newline) (display-deque (insert-front-deque! q1 'a))
(newline) (display-deque (insert-rear-deque! q1 'e))
(newline) (display-deque (insert-rear-deque!  q1 'b))
(newline) (display-deque (insert-front-deque! q1 'c))

(newline) (display-deque (delete-rear-deque! q1))
(newline) (display-deque (insert-rear-deque!  q1 'b))
(newline) (display-deque (delete-front-deque! q1))
(newline) (display-deque (delete-front-deque! q1))
(newline) (display-deque (delete-rear-deque!  q1))
(newline) (display-deque (delete-rear-deque!  q1))
(newline) (display-deque (delete-rear-deque!  q1))


