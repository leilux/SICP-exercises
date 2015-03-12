;; 3.24 table
(define (make-table)
  (let ((local-table (list '*table*)))
	(define (assoc-m key record)
	  (cond ((null? record) #f)
			((same-key? key (caar records)) (car records))
			(else (assoc-m key (cdr records)))))
	(define (same-key? x y)
	  (if (< (abs (- x y) 0.01)) #t #f))
	(define (lookup key-1 key-2)
	  (let ((subtable (assoc-m key-1 (cdr local-table))))
		(if subtable
		  (let ((record (assoc-m key-2 (cdr subtable))))
			(if record
			  (cdr record)
			  #f))
		  #f)))
	(define (insert! key-1 key-2 value)
	  (let ((subtable (assoc-m key-1 (cdr local-table))))
		(if subtable
		  (let ((record (assoc-m key-2 (cdr subtable))))
			(if record
			  (set-cdr! record value)
			  (set-cdr! subtable
						(cons (cons key-2 value)
							  (cdr subtable)))))
		  (set-cdr! local-table
					(cons (list key-1
								(cons key-2 value))
						  (cdr local-table)))))
	  'ok)
	(define (dispatch m)
	  (cond ((eq? m 'lookup-proc) lookup)
			((eq? m 'insert-proc!) insert!)
			(else (error "unknown operation -- TABLE" m))))
	dispatch))
(define operation-table (make-table))
(define get (operation-table 'lookup-proc))
(define put (operation-table 'insert-proc!))

