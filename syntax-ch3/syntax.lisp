(load "../lisp-unit/lisp-unit.lisp")
(use-package :lisp-unit)

;;; cons links any two pieces of data in your Lisp program
;;; regardless of type. When you call cons, the Lisp compiler
;;; allocates a small chunk of memory, the cons cell, that 
;;; can hold two references to the objects being linked.
;;; All lists are made of cons cells. A chain of cons cells
;;; and a list are exactly the same thing.
(define-test understanding-cons
  (assert-equal '(hello)          (cons 'hello nil))
  (assert-equal '(hello)          (cons 'hello ()))
  (assert-equal '(hello world)    (cons 'hello (cons 'world nil)))
  (assert-equal '(hello my world) (cons 'hello (cons 'my (cons 'world nil))))
  ;;; The assertion below deals with a cons cell returning
  ;;; a cons cell, not a regular list. The dot in the middle
  ;;; makes this a cons cell that links the two items together
  (assert-equal '(chicken . cat)  (cons 'chicken 'cat))
  )

(define-test understanding-car
  (assert-equal 'hello            (car (cons 'hello (cons 'world nil))))
  (assert-equal 'world            (car '(world)))
  (assert-equal 'hello            (car '(hello world)))
  )

(define-test understanding-cdr
  (assert-equal '(world)          (cdr '(hello world)))
  (assert-equal '(beef chicken)   (cdr '(goose beef chicken)))
  )

(define-test understanding-cadr
  (assert-equal 'program          (cadr '((my new) program task)))
  (assert-equal 'new              (cadr '(my new program task)))
  (assert-equal '(new program)    (cadr '(my (new program) task)))
  )

;;; cddr selects the rest of the rest of the items
(define-test understanding-cddr
  (assert-equal '(duck)           (cddr '((peas carrots tomatoes) (port beef chicken) duck)))
  )

;;; caddr selects the item of the rest of the rest of the items
(define-test understanding-caddr
  (assert-equal 'duck             (caddr '((peas carrots tomatoes) (pork beef chicken) duck)))
  )

;;; cddar selects the first item, then selects the rest of the 
;;; rest of the items
(define-test understanding-cddar
  (assert-equal '(tomatoes)       (cddar '((peas carrots tomatoes) (pork beef chicken) duck)))
  )

;;; cadadr selects the rest of the items, i.e. '((pork beef chicken) duck)
;;; then selects the first from that list, i.e. '(pork beef chicken)
;;; then selects the rest of the items from that list, i.e. '(beef chicken)
;;; then selects the first of the items from that list, i.e. 'beef
(define-test understanding-cadadr
  (assert-equal 'beef             (cadadr '((peas carrots tomatoes) (pork beef chicken) duck)))
  )

(define-test understanding-lists
  (assert-equal '(pork beef chicken)          (list 'pork 'beef 'chicken))
  (assert-equal (list 'pork 'beef 'chicken)   (cons 'pork (cons 'beef (cons 'chicken ()))))
  (assert-equal '(pork beef chicken)          (cons 'pork (cons 'beef (cons 'chicken ()))))
  )

(run-tests)
