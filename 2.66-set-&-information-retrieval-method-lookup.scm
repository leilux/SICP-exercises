; 2.66
(define (entry tree) (car tree))

(define (left-branch tree) (cadr tree))

(define (right-branch tree) (caddr tree))

(define (make-tree entry left right)
  (list entry left right))
;; lookup
(define (lookup given-key set-of-record)
  (cond ((null? set-of-record) #f)
		((= x (key (entry set-of-record))) #t)
		((< x (key (entry set-of-record)))
		 (lookup given-key (left-branch set-of-record)))
		((> x (key (entry set-of-record)))
		 (lookup given-key (right-branch set-of-record)))))

