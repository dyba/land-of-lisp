(load "nodes.lisp")

;;; describe-location <location> <nodes>
;;;
;;; This function returns the description of the <location>
;;; you provide. You must also provide the <nodes> that 
;;; have all possible locations with their associated
;;; descriptions.
(defun describe-location (location nodes)
  (cadr (assoc location nodes)))

;;; describe-path <edge>
;;;
;;; This function returns a short sentence describing the 
;;; next location available if you follow the <edge>.
(defun describe-path (edge)
  `(There is a ,(caddr edge) going ,(cadr edge) from here.))

;;; describe-paths <location> <edges>
;;;
;;; This function returns a richer sentence describing all
;;; <edges> leading to a new location from your current
;;; <location>.
(defun describe-paths (location edges)
  (apply #'append (mapcar #'describe-path (cdr (assoc location edges))))
  )

