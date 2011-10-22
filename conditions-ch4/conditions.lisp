(load "../lisp-unit/lisp-unit.lisp")
(use-package :lisp-unit)

;;; Comparing symbols
(define-test comparing-symbols-with-eq
             (assert-equal T (eq 'boot 'boot)))

;;; Comparing lists
(define-test comparing-lists-with-equal
             (assert-equal T (equal (list 2 4 5) (list 2 4 5)))
;;; Identical lists created in different ways still compare as the same
             (assert-equal T (equal '(2 5 7) (cons 2 (cons 5 (cons 7 ()))))))

;;; Comparing integers
(define-test comparing-integers-with-equal
             (assert-equal T (equal 15 15)))

;;; Comparing floating point numbers
(define-test comparing-floats-with-equal
             (assert-equal T (equal .125 .125)))

;;; Comparing strings
(define-test comparing-strings-with-equal
             (assert-equal T (equal "baz" "baz")))

;;; Comparing characters
(define-test comparing-characters-with-equal
             (assert-equal T (equal #\n #\n)))

;;; Unlike eq, eql handles comparisons of numbers and characters
(define-test comparing-numbers-with-eql
             (assert-equal T (eql 3 3))
             (assert-equal T (eql 5.5 5.5)))

(define-test comparing-characters-with-eql
             (assert-equal T (eql #\a #\a)))

;;; Unlike eq, equalp handles difficult comparison cases
(define-test comparing-strings-with-equalp
             (assert-equal T (equalp "Bob Smith" "bob smith"))
;;; Comparing integers against floating point numbers
             (assert-equal T (equalp 0 0.0)))

(run-tests)

