(load "nodes.lisp")

;;; describe-location <location> <nodes>
;;;
;;; This function returns the description of the <location>
;;; you provide. You must also provide the <nodes> that 
;;; have all possible locations with their associated
;;; descriptions.
(defun describe-location (location nodes)
  (cadr (assoc location nodes)))

