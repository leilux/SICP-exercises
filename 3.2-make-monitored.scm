; 3.2
(define (make-monitored f)
  (begin
	(set! count 0)
	(lambda (c) 
	  (cond ((eq? c 'how-many-calls?) count)
			((eq? c 'reset-count) (set! count 0))
			((number? c) (begin (set! count (+ count 1))(f c) ))
			(else "no option -- MAKE-MONITORED" c)))))
;; test
(define s (make-monitored sqrt))
(newline) (display (s 100))
(newline) (display (s 'how-many-calls?))
(newline) (display (s 100))
(newline) (display (s 'how-many-calls?))

