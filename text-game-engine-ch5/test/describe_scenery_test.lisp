(load "test_helper.lisp")
(use-package :lisp-unit)

(defparameter *my-house* '((living-room (I am in the living room.))
                           (bathroom (I am in the bathroom.))
                           (kitchen (I am in the kitchen.))))

(defparameter *house-edges* '((living-room (bathroom south door)
                                           (kitchen west hall))
                              (bathroom (living-room north door))
                              (kitchen (living-room east hall))))

(defparameter *house-objects* '(whiskey bucket frog chain))

(defparameter *house-object-locations* '((whiskey living-room)
                                         (bathroom toilet-paper)
                                         (kitchen cup)))

(define-test describe-location-test
  (assert-equal '(I am in the living room.) (describe-location 'living-room *my-house*))
  (assert-equal '(I am in the bathroom.) (describe-location 'bathroom *my-house*))
  (assert-equal '(I am in the kitchen.) (describe-location 'kitchen *my-house*)))

(define-test describe-path-test
  (assert-equal '(There is a door going south from here.) (describe-path '(bathroom south door))))

(define-test describe-paths-test
  (assert-equal '(There is a door going south from here. There is a hall going west from here.) (describe-paths 'living-room *house-edges*)))

(define-test objects-at-test
  (assert-equal '(whiskey) (objects-at 'living-room *house-objects* *house-object-locations*)))

(run-tests)
