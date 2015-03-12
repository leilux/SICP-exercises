(define (entry tree) (car tree))

(define (left-branch tree) (cadr tree))

(define (right-branch tree) (caddr tree))

(define (make-tree entry left right)
  (list entry left right))

(define (element-of-set? x set) ; O(log n)
  (cond ((null? set) #f)
		((= x (entry set)) #t)
		((< x (entry set))
		 (element-of-set? x (left-branch set)))
		((> x (entry set))
		 (element-of-set? x (right-branch set)))))

(define (adjoin-set x set) ; O(log n)
  (cond ((null? set) (make-tree x '() '()))
		((= x (entry set)) set)
		((< x (entry set)) 
		 (make-tree (entry set)
					(adjoin-set x (left-branch set))
					(right-branch set)))
		((> x (entry set))
		 (make-tree (entry set)
					(left-branch set)
					(adjoin-set x (right-branch set))))))
; 2.63 turn tree as list
(define (tree->list-1 tree) ; O(n^2)
  (if (null? tree)
	'()
	(append (tree->list-1 (left-branch tree))
			(cons (entry tree)
				  (tree->list-1 (right-branch tree))))))

(define (tree->list-2 tree) ; O(n)
  (define (copy-to-list tree result-list)
	(if (null? tree)
	  result-list
	  (copy-to-list (left-branch tree)
					(cons (entry tree)
						  (copy-to-list (right-branch tree)
										result-list)))))
  (copy-to-list tree '()))
; pic 2-16 's tree --data
(define tree1 (list 7 
					(list 3 
						  (list 1 '() '()) 
						  (list 5 '() '())) 
					(list 9
						  '()
						  (list 11 '() '()))))
(define tree2 (list 3
					(list 1 '() '())
					(list 7 
						  (list 5 '() '())
						  (list 9 '() (list 11 '() '())))))
(define tree3 (list 5
					(list 3 
						  (list 1 '() '()) 
						  '())
					(list 9 
						  (list 7 '() '())
						  (list 11 '() '()))))
;; test
(newline) (display (tree->list-1 tree1)) ;; (1 3 5 7 9 11)
(newline) (display (tree->list-1 tree2)) ;; (1 3 5 7 9 11)
(newline) (display (tree->list-1 tree3)) ;; (1 3 5 7 9 11)
(newline) (display (tree->list-2 tree1)) ;; (1 3 5 7 9 11)
(newline) (display (tree->list-2 tree2)) ;; (1 3 5 7 9 11)
(newline) (display (tree->list-2 tree3)) ;; (1 3 5 7 9 11)
; a) 都相同
; b) tree->list-1 O(n^2), 每个点都调用 append O(n) 
;    tree->list-2 O(n）

; 2.64
(define (make-branch-tree elements)
  (car (partial-tree elements (length elements))))

(define (partial-tree elts n) ; O(n)
  (if (= n 0)
	(cons '() elts)
	(let ((left-size (quotient (- n 1) 2)))
	  (let ((left-result (partial-tree elts left-size))) ; left-branch + the other elements
		(let ((left-tree (car left-result))
			  (non-left-elts (cdr left-result))
			  (right-size (- n (+ left-size 1))))
		  (let ((this-entry (car non-left-elts)) ; the root 
				(right-result (partial-tree (cdr non-left-elts) ; right-branch + the other elements
											right-size)))
			(let ((right-tree (car right-result))
				  (remaining-elts (cdr right-result)))
			  (cons (make-tree this-entry left-tree right-tree) ; construct tree 
					remaining-elts)))))))) 
;; test 
(newline) (display (make-branch-tree (list 1 3 5 7 9 11) ))
; a) 
; (5 
;  (1 
;   () 
;   (3 () () ))
;  (9 
;   (7 () ()) 
;   (11 () ())))
; b) O(n)

; 2.65
;; abstruct
(define (tree-op op tree1 tree2)
  (make-branch-tree
	(op (tree->list-2 tree1)
		(tree->list-2 tree2))))
; union-set
(define (union-set-L set1 set2) 
  (cond ((null? set1) set2)
		((null? set2) set1)
		(else 
		  (let ((x1 (car set1)) (x2 (car set2)))
			(cond ((= x1 x2) (cons x1 (union-set-L (cdr set1) (cdr set2))))
				  ((< x1 x2) (cons x1 (union-set-L (cdr set1) set2)))
				  ((> x1 x2) (cons x2 (union-set-L set1 (cdr set2)))))))))
(define (union-set tree1 tree2) ; O(n)
  (tree-op union-set-L tree1 tree2))

; intersection-set
(define (intersection-set-L set1 set2)
  (if (or (null? set1) (null? set2))
	'()
	(let ((x1 (car set1)) (x2 (car set2)))
	  (cond ((= x1 x2)
			 (cons x1
				   (intersection-set-L (cdr set1)
									 (cdr set2))))
			((< x1 x2)
			 (intersection-set-L (cdr set1) set2))
			((> x1 x2)
			 (intersection-set-L set1 (cdr set2)))))))
(define (intersection-set tree1 tree2) ; O(n)
  (tree-op intersection-set-L tree1 tree2))

;; data
(define tree4 (list 7 
					(list 3 
						  (list 2 '() '()) 
						  (list 5 '() '())) 
					(list 9
						  '()
						  (list 11 '() '()))))
(define tree5 (list 3
					(list 1 '() '())
					(list 7 
						  (list 5 '() '())
						  (list 9 '() (list 11 '() '())))))
;; test
(newline) (display "test union-set")
(newline) (display (union-set tree4 tree5))
(newline) (display "test intersection-set")
(newline) (display (intersection-set tree4 tree5))

