; 3.26
(load "tree.scm")

(define (make-table compare)
  (let ((t '()))
	(define (empty?) (tree-empty? t))
	(define (insert! given-key value)
	  (set! t (tree-insert! t given-key value compare))
	  'ok)
	(define (lookup given-key)
	  (let ((result (tree-secarch t given-key compare)))
		(if (null? result)
		  #f
		  (tree-value result))))
	(define (dispatch m)
	  (cond ((eq? m 'insert!) insert!)
			((eq? m 'lookup) lookup)
			((eq? m 'empty?) (empty?))
			(else (error "unknown mode" m))))
	dispatch))
;; 如需做二维表
;; key1 (key v L R) v指向key2的树
