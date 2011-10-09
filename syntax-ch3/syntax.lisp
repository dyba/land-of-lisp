(load "lisp-unit.lisp")
(use-package :lisp-unit)

(define-test understanding-cons
  (assert-equal '(hello) (cons 'hello nil))
  (assert-equal '(hello) (cons 'hello ()))
  (assert-equal '(hello world) (cons 'hello (cons 'world nil)))
  (assert-equal '(hello my world) (cons 'hello (cons 'my (cons 'world nil))))
  )

(run-tests)
