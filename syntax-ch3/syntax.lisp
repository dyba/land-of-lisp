(load "lisp-unit.lisp")
(use-package :lisp-unit)

(define-test understanding-cons
  (assert-equal '(hello)          (cons 'hello nil))
  (assert-equal '(hello)          (cons 'hello ()))
  (assert-equal '(hello world)    (cons 'hello (cons 'world nil)))
  (assert-equal '(hello my world) (cons 'hello (cons 'my (cons 'world nil))))
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

(define-test understanding-lists
  (assert-equal '(pork beef chicken)          (list 'pork 'beef 'chicken))
  (assert-equal (list 'pork 'beef 'chicken)   (cons 'pork (cons 'beef (cons 'chicken ()))))
  )

(run-tests)
