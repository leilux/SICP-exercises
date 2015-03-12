(load "book/p198-queue.scm")

(define (make-time-segment time queue) (cons time queue))
(define (segment-time s) (car s))
(define (segment-queue s) (cdr s))

(define (make-agenda) (list 0))
(define (current-time agenda) (car agenda))
(define (set-current-time! agenda time)
  (set-car! agenda time))
(define (segments agenda) (cdr agenda))
(define (set-segments! agenda segments)
  (set-cdr! agenda segments))
(define (first-segment agenda) (car (segments agenda)))
(define (rest-segment agenda) (cdr (segments agenda)))
(define (empty-agenda? agenda) (null? (segments agenda)))

(define (add-to-agenda! time action agenda)
  (define (belongs-before? segments)
	(or (null? segments)
		(< time (segment-time (car segments)))))
  (define (make-new-time-segment time action)
	(let ((q (make-queue)))
	  (insert-queue! q action)
	  (make-time-segment time q)))
  (define (add-to-segments! segments) ; 处理两种情况 = first, > first 处理不了 < first 
	(if (= (segment-time (car segments)) time) ; =
	  (insert-queue! (segment-queue (car segments))
					 action)
	  (let ((rest (cdr segments)))
		(if (belongs-before? rest)
		  (set-cdr! segments                   ; < next
					(cons (make-new-time-segment time action)
						  (cdr segments)))
		  (add-to-segments! rest)))))          ; > next
  (let ((segments-m (segments agenda)))
	(if (belongs-before? segments-m)
	  (set-segments! agenda
					 (cons (make-new-time-segment time action)
						   segments-m))
	  (add-to-segments! segments-m))))

(define (remove-first-agenda-item! agenda)
  (let ((q (segment-queue (first-segment agenda))))
	(delete-queue! q)
	(if (empty-queue? q)
	  (set-segments! agenda (rest-segment agenda)))))

(define (first-agenda-item agenda)
  (if (empty-agenda? agenda)
	(error "agenda is empty -- FIRDT-AGENDA-ITEM")
	(let ((first-seg (first-segment agenda)))
	  (set-current-time! agenda (segment-time first-seg))
	  (front-queue (segment-queue first-seg)))))
