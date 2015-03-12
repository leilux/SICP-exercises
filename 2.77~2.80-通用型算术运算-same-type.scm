(define (attach-tag type-tag contents)
  (cons type-tag contents))
(define (type-tag datum)
  (if (pair? datum)
	(car datum)
	(error "bad tagged datum -- TYPE-TAG" datum)))
(define (contents datum)
  (if (pair? datum)
	(cdr datum)
	(error "bad tagged datum -- CONTENTS" datum)))

;; scheme-number
(define (install-scheme-number-package)
  (define (tag x) (attach-tag 'scheme-number x))
  (put 'add '(scheme-number scheme-number) 
	   (lambda (x y) (tag (+ x y))))
  (put 'sub '(scheme-number scheme-number) 
	   (lambda (x y) (tag (- x y))))
  (put 'mul '(scheme-number scheme-number) 
	   (lambda (x y) (tag (* x y))))
  (put 'div '(scheme-number scheme-number) 
	   (lambda (x y) (tag (/ x y))))
  (put 'make 'scheme-number (lambda (x) (tag x)))
  ; new add 2.79
  (put 'equ? '(scheme-number scheme-number)
	   (lambda (x y) (= x y)))
  'done)

(define (make-scheme-number n)
  ((get 'make 'scheme-number) n))

;; 有理数
(define (install-rational-package)
  ;; internal procedures
  (define (numer x) (car x))
  (define (denom x) (cdr x))
  (define (make-rat n d)
	(let ((g (gcd n d)))
	  (cons (/ n g) (/ d g))))
  (define (add-rat x y)
	(make-rat (+ (* (numer x) (denom y))
				 (* (numer y) (denom x)))
			  (* (denom x) (denom y))))
  (define (sub-rat x y)
	(make-rat (- (* (numer x) (denom y))
				 (* (numer y) (denom x)))
			  (* (denom x) (denom y))))
  (define (mul-rat x y)
	(make-rat (* (numer x) (numer y))
			  (* (denom x) (denom y))))
  (define (div-rat x y)
	(make-rat (* (numer x) (denom y))
			  (* (denom x) (numer y))))
  ;; interface to rest of the system
  (define (tag x) (attach-tag 'rational x))
  (put 'add '(rational rational)
	   (lambda (x y) (tag (add-rat x y))))
  (put 'mul '(rational rational)
	   (lambda (x y) (tag (mul-rat x y))))
  (put 'sub '(rational rational)
	   (lambda (x y) (tag (sub-rat x y))))
  (put 'div '(rational rational)
	   (lambda (x y) (tag (div-rat x y))))
  (put 'make 'rational
	   (lambda (n d) (tag (make-rat n d))))
  ; new add 2.79
  (put 'equ? '(rational rational)
	   (lambda (x y)
		 (and (= (numer x) (numer y))
			  (= (denom x) (denom y)))))
  'done)
(define (make-rational n d)
  ((get 'make 'rational) n d))

;; complex-rectangular
(define (install-rectangular-package)
  ;; internal procedures
  (define (real-part z) (car z))
  (define (imag-part z) (cdr z))
  (define (make-from-real-imag x y) (cons x y))
  (define (magnitude z)
	(sqrt (+ (square (real-part z))
			 (square (imag-part z)))))
  (define (angle z)
	(atan (imag-part z) (real-part z)))
  (define (make-from-mag-ang r a)
	(cons (* r (cos a)) (* r (sin a))))
  ;; interface to the rest of the system
  (define (tag x) (attach-tag 'rectangular x))
  (put 'real-part '(rectangular) real-part)
  (put 'imag-part '(rectangular) imag-part)
  (put 'magnitude '(rectangular) magnitude)
  (put 'angle	  '(rectangular) angle)
  (put 'make-from-real-imag 'rectangular
	   (lambda (x y) (tag (make-from-real-img x y))))
  (put 'make-from-mag-ang	'rectangular
	   (lambda (x y) (tag (make-from-mag-ang  r a))))

  'done)
;; complex-polar
(define (install-polar-package)
  ;; internal procedures
  (define (magnitude z) (car z))
  (define (angle	 z) (cdr z))
  (define (make-from-mag-ang r a) (cons r a))
  (define (real-part z)
	(* (magnitude z) (cos (angle z))))
  (define (imag-part z)
	(* (magnitude z) (sin (angle z))))
  (define (make-from-real-imag x y)
	(cons (sqrt (+ (square x) (square y)))
		  (atan y x)))
  ;; interface to the rest of the system
  (define (tag x) (attach-tag 'polar x))
  (put 'real-part '(polar) real-part)
  (put 'imag-part '(polar) imag-part)
  (put 'magnitude '(polar) magnitude)
  (put 'angle	  '(polar) angle)
  (put 'make-from-real-imag 'polar
	   (lambda (x y) (tag (make-from-real-imag x y))))
  (put 'make-from-mag-ang 'polar 
	   (lambda (r a) (tag (make-from-mag-ang r a))))
  'done)

;; complex
(define (install-complex-package)
  ;; imported procedures from rectangular and polar packages
  (define (make-from-real-imag x y)
	((get 'make-from-real-imag 'rectangular) x y))
  (define (make-from-mag-ang r a)
	((get 'make-from-mag-ang 'polar) r a))
  ;; internal procedures
  (define (add-complex z1 z2)
	(make-from-real-imag (+ (real-part z1) (real-part z2))
						 (+ (imag-part z1) (imag-part z2))))
  (define (sub-complex z1 z2)
	(make-from-real-imag (- (real-part z1) (real-part z2))
						 (- (imag-part z1) (imag-part z2))))
  (define (mul-complex z1 z2)
	(make-from-mag-ang (* (magnitude z1) (magnitude z2))
					   (+ (angle z1) (angle z2))))
  (define (div-complex z1 z2)
	(make-from-mag-ang (/ (magnitude z1) (magnitude z2))
					   (- (angle z1) (angle z2))))
  ;; interface to rest of the system
  (define (tag z) (attach-tag 'complex z))
  (put 'add '(complex complex)
	   (lambda (z1 z2) (tag (add-complex z1 z2))))
  (put 'sub '(complex complex)
	   (lambda (z1 z2) (tag (sub-complex z1 z2))))
  (put 'mul '(complex complex)
	   (lambda (z1 z2) (tag (mul-complex z1 z2))))
  (put 'div '(complex complex)
	   (lambda (z1 z2) (tag (div-complex z1 z2))))
  (put 'make-from-real-imag 'complex
	   (lambda (x y) (tag (make-from-real-imag x y))))
  (put 'make-from-mag-ang 'complex
	   (lambda (r a) (tag (make-from-mag-ang r a))))
  ;; add 2.77
  (put 'real-part '(complex) real-part)
  (put 'imag-part '(complex) imag-part)
  (put 'magnitude '(complex) magnitude)
  (put 'angle     '(complex) angle)
  ; new add 2.79
  (put 'equ? '(complex complex)
	   (lambda (z1 z2)
		 (and (= (real-part x) (real-part y))
			  (= (imag-part x) (imag-part y)))))
  'done)

(define (make-complex-from-real-imag x y)
  ((get 'make-from-real-imag 'complex) x y))
(define (make-from-mag-ang r a)
  ((get 'make-from-mag-ang 'complex) r a))
; 2.77
; (magnitude z)                                                   ; 这个 magnitude 是最外层的通用操作
; (apply-generic 'magnitude z)
; (map type-tag (list z))                                         ; => '(complex)
; (get 'magnitude '(complex))                                     ; => magnitude  ; 这个 magnitude 是定义于 complex 包中的 magnitude
; (apply magnitude (map contents (list z)))                       ; =>  (apply magnitude '((rectangular 3 . 4)))
; (magnitude '(rectangular 3 . 4))
; (apply-generic 'magnitude '(rectangular 3 . 4))
; (map type-tag (list '(rectangular 3 . 4)))                      ; => '(rectangular)
; (get 'magnitude '(rectangular))                                 ; => magnitude  ; 这个 magnitude 是定义于 rectangular 包中的 magnitude
; (apply magnitude (map contents (list '(rectangular 3 . 4))))    ; => (apply magnitude '((3 . 4)))
; (magnitude '(3 . 4))
; (sqrt (+ (square (real-part '(3 . 4)))
;          (square (imag-part '(3 . 4)))))
; 5

; 2.78
; (define (attach-tag type-tag contents)
;   (if (number? contents)
; 	contents
; 	(cons type-tag contents)))
; (define (type-tag datum)
;   (cond ((number? datum) 'scheme-number)
; 		((pair? datum) (car datum))
; 		(else (error "Bad tagged datum -- TYPE-TAG" datum))))
;; op
(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
	(let ((proc (get op type-tags)))
	  (if proc 
		(apple proc (map contents args))
		(error
		  "no method for these types -- APPLY-GENERIC"
		  (list op type-tags))))))
(define (real-part z) (apply-generic 'real-part z))
(define (imag-part z) (apply-generic 'imag-part z))
(define (magnitude z) (apply-generic 'magnitude z))
(define (angle z) (apply-generic 'angle z))
; 2.79
(define (equ? x y)
  (apply-generic 'equ? x y))
; 2.80 same to 2.79
