; leaf : method
(define (make-leaf symbol weight)
  (list 'leaf symbol weight))

(define (leaf? object)
  (eq? (car object) 'leaf))

(define (symbol-leaf x) (cadr  x))
(define (weight-leaf x) (caddr x))
; tree : make
(define (make-code-tree left right)
  (list left
		right
		(append (symbols left) (symbols right))
		(+ (weight left) (weight right))))
; tree : method
(define (left-branch  tree) (car  tree))
(define (right-branch tree) (cadr tree))
(define (symbols tree)
  (if (leaf? tree)
	(list (symbol-leaf tree))
	(caddr tree)))
(define (weight tree)
  (if (leaf? tree)
	(weight-leaf tree)
	(cadddr tree)))
; decode
(define (decode bits tree)
  (define (decode-1 bits current-branch)
	(if (null? bits)
	  '()
	  (let ((next-branch
			  (choose-branch (car bits) current-branch)))
		(if (leaf? next-branch)
		  (cons (symbol-leaf next-branch)
				(decode-1 (cdr bits) tree))
		  (decode-1 (cdr bits) next-branch)))))
  (decode-1 bits tree))
(define (choose-branch bit branch)
  (cond ((= bit 0) (left-branch  branch))
		((= bit 1) (right-branch branch))
		(else (error "bad bit -- choose-branch-BRANCH" bit))))
;2.67
(define <----2.67----> #f)
(define sample-tree
  (make-code-tree (make-leaf 'A 4)
				  (make-code-tree
					(make-leaf 'B 2)
					(make-code-tree (make-leaf 'D 1)
									(make-leaf 'C 1)))))
(define sample-message-code '(0 1 1 0 0 1 0 1 0 1 1 1 0))
; test decode 
(newline) (display "test decode : code : (0 1 1 0 0 1 0 1 0 1 1 1 0)")
(newline) (display (decode sample-message-code sample-tree)) ; (a d a b b c a)

;; adjoin leaf set and by sorted
(define (adjoin-set x set)
  (cond ((null? set) (list x))
		((< (weight x) (weight (car set))) (cons x set))
		(else (cons (car set)
					(adjoin-set x (cdr set))))))
; make leaf set 
(define (make-leaf-set pairs)
  (if (null? pairs)
	'()
	(let ((pair (car pairs)))
	  (adjoin-set (make-leaf (car  pair)  ; symbol
							 (cadr pair)) ; weight
				  (make-leaf-set (cdr pairs))))))
;; test
; (newline) (display (make-leaf-set '((A 4) (B 5) (C 1) (D 1))))

; 2.68
(define <----2.68----> #f)
; encode
(define (encode message tree)
  (if (null? message)
	'()
	(append (encode-symbol (car message) tree)
			(encode (cdr message) tree))))
(define (encode-symbol symbol tree)
  (cond ((leaf? tree) '())
		((symbol-of-code-tree? symbol (symbols (left-branch  tree)))
		 (cons 0 (encode-symbol symbol (left-branch  tree))))
		((symbol-of-code-tree? symbol (symbols (right-branch tree)))
		 (cons 1 (encode-symbol symbol (right-branch tree))))
		(else (error "encode-symbol : the symbol must in the tree - " symbol))))

(define (symbol-of-code-tree? symbol symbol-list)
  (cond ((null? symbol-list) #f)
		((equal? symbol (car symbol-list)) #t)
		(else (symbol-of-code-tree? symbol (cdr symbol-list)))))
;; test
(newline) (display "test encode")
(newline) (display (encode (decode sample-message-code sample-tree) sample-tree))

; 2.69
(define <----2.69------> #f)
(define (generate-huffman-tree pairs)
  (successive-merge (make-leaf-set pairs)))
(define (successive-merge leaf-set-sorted)
  (let 
	((merge (make-code-tree (car  leaf-set-sorted)    ; 1th
							(cadr leaf-set-sorted)))) ; 2th
	(if (null? (cddr leaf-set-sorted))
	  merge
	  (successive-merge 
		(adjoin-set merge
					(cddr leaf-set-sorted)))))) ; 3th
;; test
(newline) (display "test generate-huffman-tree")
(newline) (display (generate-huffman-tree '((A 6) (B 5) (C 4) (D 2) (E 1))))
; (((leaf b 5) (leaf a 6) (b a) 11) (((leaf e 1) (leaf d 2) (e d) 3) (leaf c 4) (e d c) 7) (b a e d c) 18)

; 2.70
(define <----2.70----> #f)
(define huffman-tree-2.70 
  (generate-huffman-tree
	'((A 2) (NA 16) (BOOM 1) (SHA 3) (GET 2) (YIP 9) (JOB 2) (WAH 1))))
;; test
(display "\ntest 2.70 \n")
(display 
  (decode
	(encode '(GET A JOB SHA NA NA NA NA NA NA NA NA)
			huffman-tree-2.70)
	huffman-tree-2.70))
; 2.71
(define <----2.71----> #f)
; n=5 : max=4 min=1
; n=10: max=9 min=1

; 2.72
(define <----2.72----> #f)

