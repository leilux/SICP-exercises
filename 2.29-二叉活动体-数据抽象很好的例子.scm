;;-------------------------------- T E S T ---------------------;+
(define (title n)												;|
  (begin                                                        ;|
	(display "\n - - - - ")	(display n) (display " - - - -\n")));|
(define (test f a b)                                            ;|
  (newline)                                                     ;|
  (if (> a b)                                                   ;|
	(display "test over !\n")                                   ;|
	(begin                                                      ;|
	  (display a) (display " : ") (display (f a))               ;|
	  (test f (+ a 1) b))))                                     ;|
; --------------------------------------------------------------;+
; 2.29
;; a)
;; make mobile - using "list"
(define (make-mobile L-branch R-branch)
  ;(list L-branch R-branch))
  (cons L-branch R-branch))
;; make branch
(define (make-branch len structure)
  ;(list len structure))
  (cons len structure))
;; get R L branch
(define (L-branch mobile)
  ;(list-ref mobile 0))
  (car mobile))
(define (R-branch mobile) 
  ;(list-ref mobile 1))
  (cdr mobile))
;; get branch attr
(define (branch-length branch)
  (car branch))
(define (branch-structure branch)
  ;(list-ref branch 1))
  (cdr branch))

;; b)
(define (total-weight mobile)
  (define L-b (L-branch mobile))
  (define R-b (R-branch mobile))
  (cond ((null? mobile) 0)
		(else (+
				(if (pair? (branch-structure L-b))
				  (total-weight (branch-structure L-b))
				  (branch-structure L-b))
				(if (pair? (branch-structure R-b))
				  (total-weight (branch-structure R-b))
				  (branch-structure R-b))))))
;; test
(define b-b (make-branch 1 2))
(define a-b (make-branch 1 3))
(define t1 (make-mobile b-b a-b))

(define c-b (make-branch 1 t1))
(define t2 (make-mobile a-b c-b))
(newline) (display (total-weight t1))
(newline) (display (total-weight t2))
;; c)
(define (has-sub-mobile? branch)
  (pair? (branch-structure branch)))

(define (branch-weight branch)
  (define structure (branch-structure branch))
  (if (has-sub-mobile? branch)
	(total-weight structure)
	structure))

(define (weight branch)
  (*
	(branch-length branch)
	(branch-weight branch)))

(define (balance? t)
  (let ((l-b (L-branch t))
		(r-b (R-branch t)))
	(and (= (weight l-b) (weight r-b))
		 (if (has-sub-mobile? l-b) (balance? l-b) #t)
		 (if (has-sub-mobile? r-b) (balance? r-b) #t))))
;; test
(define b-b (make-branch 1 2))
(define a-b (make-branch 1 2))
(define t1 (make-mobile b-b a-b))

(define c-b (make-branch 1 t1))
(define t2 (make-mobile a-b c-b))
(newline) (display (balance? t1))
(newline) (display (balance? t2))

;; ;; 2.29 - 另一个版本
;; ;(define (make-mobile left right) (list left right))
;; ;(define (make-branch length structure) (list length structure))
;; ;(define (left-branch mobile) (car mobile))
;; ;(define (right-branch mobile) (car (cdr mobile)))
;; ;(define (branch-length branch) (car branch))
;; ;(define (branch-structure branch) (car (cdr branch)))
;; 
;; (define (make-mobile left right) (cons left right))
;; (define (make-branch length structure) (cons length structure))
;; (define (left-branch mobile) (car mobile))
;; (define (right-branch mobile) (cdr mobile))
;; (define (branch-length branch) (car branch))
;; (define (branch-structure branch) (cdr branch))
;; 
;; (define (mobile? structure) (pair? structure))
;; 
;; (define (branch-weight branch)
;;   (let ((structure (branch-structure branch)))
;;     (if (mobile? structure) (total-weight structure)
;;         structure)))
;; 
;; (define (total-weight mobile)
;;   (+ (branch-weight (left-branch mobile))
;;      (branch-weight (right-branch mobile))))
;; 
;; (define (weight branch)
;;   (* (branch-length branch) (branch-weight branch)))
;; 
;; (define (balance? mobile)
;;   (let ((left (left-branch mobile))
;;         (right (right-branch mobile)))
;;     (and (= (weight left) (weight right))
;;          (if (mobile? (branch-structure left)) (balance? left) #t)
;;          (if (mobile? (branch-structure right)) (balance? right) #t))))
;; 
