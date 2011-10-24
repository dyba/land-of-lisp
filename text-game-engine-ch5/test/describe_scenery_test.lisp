(load "test_helper.lisp")
(use-package :lisp-unit)

(defparameter *my-house* '((living-room (I am in the living room.))
                           (bathroom (I am in the bathroom.))
                           (kitchen (I am in the kitchen.))))

(define-test describe-location-test
  (assert-equal '(I am in the living room.) (describe-location 'living-room *my-house*))
  (assert-equal '(I am in the bathroom.) (describe-location 'bathroom *my-house*))
  (assert-equal '(I am in the kitchen.) (describe-location 'kitchen *my-house*)))

(run-tests)

