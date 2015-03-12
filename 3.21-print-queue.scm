; select
(define (front-prt queue) (car queue))
(define (rear-ptr  queue) (cdr queue))
(define (empty-queue? queue)
  (null? (front-prt queue)))
; change
(define (set-front-prt! queue item) (set-car! queue item))
(define (set-rear-prt!  queue item) (set-cdr! queue item))
; make
(define (make-queue) (cons '() '()))

(define (front-queue queue)
  (if (empty-queue? queue)
	(error "front called with an empty queue" queue)
	(car (front-prt queue))))
; op
; insert
(define (insert-queue! queue item)
  (let ((new-pair (cons item '())))
	(cond ((empty-queue? queue)
		   (set-front-prt! queue new-pair)
		   (set-rear-prt! queue new-pair)
		   queue)
		  (else
			(set-cdr! (rear-ptr queue) new-pair)
			(set-rear-prt! queue new-pair)
			queue))))
; delete
(define (delete-queue! queue)
  (cond ((empty-queue? queue)
		 (error "delete! called with an empty queue" queue))
		(else
		  (set-front-prt! queue (cdr (front-prt queue)))
		  queue)))
; 3.21
(define (print-queue queue)
  (display (front-prt queue)))

; (define q1 (make-queue))
; (newline) (print-queue (insert-queue! q1 'a))
; (newline) (print-queue (insert-queue! q1 'b))
; (newline) (print-queue (delete-queue! q1))
; (newline) (print-queue (delete-queue! q1))
