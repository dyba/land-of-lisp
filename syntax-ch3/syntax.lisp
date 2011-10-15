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

(run-tests)
