; 2.81
; a)
; 不使用报错
; 使用解释器假死

; b)
; (trace apply-genetic)
; (apply-generic 'exp (make-scheme-number 1) (make-scheme-2))
; 查找 'exp 通用操作失败，试图通过进行类型强制
; (apply-generic 'exp (scheme-number->scheme-number (make-scheme-number 1)) (make-scheme-2))
; 强制完成，继续查找
; (apply-generic 'exp (make-scheme-number 1) (make-scheme-2))
; 再次查找失败，再次进行类型强制
; (apply-generic 'exp (scheme-number->scheme-number (make-scheme-number 1)) (make-scheme-2))
; 强制再次完成（其实根本没做什么），继续查找（然后再次失败）
; ... 无限循环

; c)
(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
	(let ((proc (get op type-tags)))
	  (if proc
		(apply proc (map contents args))
		(if (= (length args) 2)
		  (let ((type1 (car type-tags))
				(type2 (cadr type-tags))
				(a1 (car args))
				(a2 (cadr args)))
			(if (equal? type1 type2)                                    ; 新增
			  (error "No method for these types" (list op type-tags))   ; 
			  (let ((t1->t2 (get-coercion type1 type2))
					(t2->t1 (get-coercion type2 type1)))
				(cond (t1->t2
						(apply-generic op (t1->t2 a1) a2))
					  (t2->t1
						(apply-generic op a1 (t2->t1 a2)))
					  (else
						(error "No method for these types"
							   (list op type-tags)))))))
		  (error "No method for these types"
				 (list op type-tags)))))))
 
