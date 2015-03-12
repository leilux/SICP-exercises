(load "ToDo-list-agenda.scm")

(define (half-adder a b s c)
  (let ((d (make-wire)) (e (make-wire)))
	(or-gate a b d)
	(and-gate a b c) ; carry
	(inverter c e)
	(and-gate d e s) ; sum
	'ok))
(define (full-adder a b c-in sum c-out)
  (let ((s (make-wire))
		(c1 (make-wire))
		(c2 (make-wire)))
	(half-adder b c-in s c1)
	(half-adder a s sum c2)
	(or-gate c1 c2 c-out)
	'ok))
(define (inverter-S-3 in out)
  (let ((a (make-wire)) (b (make-wire)))
	(inverter in a) 
	(inverter a b)
	(inverter b out)
	'ok))
; logical obj
; -
(define (inverter input output)
  (define (invert-input)
	(let ((new-value (logical-not (get-signal input))))
	  (after-delay inverter-delay
				   (lambda () 
					 (set-signal! output new-value)))))
  (add-action! input invert-input)
  'ok)
; and
(define (and-gate a1 a2 output)
  (define (and-action-procedure)
	(let ((new-value
			(logical-and (get-signal a1) (get-signal a2))))
	  (after-delay and-gate-delay
				   (lambda ()
					 (set-signal! output new-value)))))
  (add-action! a1 and-action-procedure)
  (add-action! a2 and-action-procedure)
  'ok)
; or
; 3.28
(define (or-gate a1 a2 output)
  (define (or-action-procedure)
	(let ((new-value (logical-or (get-signal a2) (get-signal a2))))
	  (after-delay
		or-gate-delay
		(lambda ()
		  (set-signal! output new-value)))))
  (add-action! a1 or-action-procedure)
  (add-action! a2 or-action-procedure)
  'ok)
; 3.29
(define (or-gate-com a1 a2 output)
  (let ((o1 (make-wire)))
	(and-gate a1 a2 o1)
	(inverter o1 output)
	'ok))
; 3.30
(define (ripple-carry-adder list-A list-B list-S C)
  (define (iter A B S value-of-c)
	(if (and (null? A) (null? B) (null? S))
	  'ok
	  (let ((Ak (car A))
			(Bk (car B))
			(Sk (car S))
			(remain-A (cdr A))
			(remain-B (cdr B))
			(remain-S (cdr S))
			(Ck (make-wire)))
		(set-signal! Ck value-of-c)
		(full-adder Ak Bk Ck Sk C)
		(iter remain-A remain-B remain-S (get-signal C)))))
  (iter list-A list-B list-S (get-signal C)))
; ripple-carry-adder = full-adder-delay
;                    = or-gate-delay + 2 * (half-adder-delay)
;                    = or-gate-delay + 2 * (or-gate-delay + inveter-delay + (2 * and-gate-delay))
;                    = or-gate-delay + (2 * or-gate-delay) + (2 * inveter-delay) + (4 * and-gate-delay)
;                    = (3 * or-gate-delay) + (2 * inveter-delay) + (4 * and-gate-delay)
; delay : N * ripple-carry-adder

; logical opt
(define (logical-not s)
  (cond ((= s 0) 1)
		((= s 1) 0)
		(else (error "invalid signal" s))))
(define (logical-and s1 s2)
  (cond ((and (= s1 0) (= s2 1)) 0)
		((and (= s1 0) (= s2 0)) 0)
		((and (= s1 1) (= s2 0)) 0)
		((and (= s1 1) (= s2 1)) 1)
		(else (error "invalid signal" s1 s2))))
(define (logical-or s1 s2)
  (cond ((and (= s1 0) (= s2 1)) 1)
		((and (= s1 0) (= s2 0)) 0)
		((and (= s1 1) (= s2 0)) 1)
		((and (= s1 1) (= s2 1)) 1)
		(else (error "invalid signal" s1 s2))))
; wire
(define (make-wire)
  (let ((signal-value 0) (action-produres '()))
	; set-signal!
	(define (set-my-signal! new-value)
	  (if (not (= signal-value new-value))
		(begin (set! signal-value new-value)
			   (call-each action-produres))
		'done))
	; accept-action-procedure!
	(define (accept-action-procedure! proc)
	  (set! action-produres (cons proc action-produres))
	  (proc))
	; disptch
	(define (disptch m)
	  (cond ((eq? m 'get-signal) signal-value)
			((eq? m 'set-signal!)  set-my-signal!)
			((eq? m 'add-action!) accept-action-procedure!)
			(else (error "unknown op -- WIRE" m))))
	disptch))

(define (call-each procedures)
  (if (null? procedures)
	'done
	(begin 
	  ((car procedures))
	  (call-each (cdr procedures)))))
(define (get-signal wire)
  (wire 'get-signal))
(define (set-signal! wire new-value)
  ((wire 'set-signal!) new-value))
(define (add-action! wire action-produre)
  ((wire 'add-action!) action-produre))
; agenda
(define (after-delay delay-m logical-out)
  (add-to-agenda! (+ delay-m (current-time the-agenda))
				  logical-out
				  the-agenda))
(define (propagate)
  (if (empty-agenda? the-agenda)
	'done
	(let ((first-item (first-agenda-item the-agenda)))
	  (first-item)
	  (remove-first-agenda-item! the-agenda)
	  (propagate))))
;; probe
(define (probe name wire)
  (add-action! 
	wire
	(lambda ()
	  (newline) 
	  (display name) (display " ")
	  (display (current-time the-agenda))
	  (display " New-value = ") (display (get-signal wire)))))

;; test 
(define s! set-signal!)
(define p propagate)
(define the-agenda (make-agenda))
(define inverter-delay 2)
(define and-gate-delay 3)
(define or-gate-delay 5)

; (define input-1 (make-wire))
; (define input-2 (make-wire))
; (define sum     (make-wire))
; (define carry  (make-wire))
; ; add-action
; (probe 'sum sum)
; (probe 'carry carry)
; (probe 'in_1 input-1)
; (probe 'in_2 input-2)
; 
; (half-adder input-1 input-2 sum carry)
; (newline) (display "begin..\n")
; 
; (newline) (display ": ") (set-signal! input-1 1)
; (newline) (display ": ") (propagate)
; (newline) (display ": ") (set-signal! input-2 1)
; (newline) (display ": ") (propagate)

(define in (make-wire))
(define out (make-wire))
(probe 'in in)
(probe 'out out)
(inverter-S-3 in out)
(newline) (display "0")
(p)
(display "\nbegin..")
(newline) (set-signal! in 1)
(newline) (display "1")(p)
(newline) (set-signal! in 0)
(newline) (display "2") (p)
(newline) (set-signal! in 1)
(newline) (display "3") (p)
