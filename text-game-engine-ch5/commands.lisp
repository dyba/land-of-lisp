(defparameter *nodes* '((living-room (you are in the living-room.
                            a wizard is snoring loudly on the couch.))
                        (garden (you are in a beautiful garden.
                            there is a well in front of you))
                        (attic (you are in the attic.
				there is a giant welding torch in the corner.))))

(defparameter *edges* '((living-room
			 (garden west door)
			 (attic upstairs ladder))
			(garden
			 (living-room east door))
			(attic
			 (living-room downstairs ladder))))

(defparameter *objects* '(whiskey bucket frog chain))

(defparameter *object-locations* '((whiskey living-room)
				   (bucket living-room)
				   (chain garden)
				   (frog garden)))

(defparameter *location* 'living-room)

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
  (apply #'append (mapcar #'describe-path (cdr (assoc location edges)))))

;;; objects-at <location> <objects> <object-location-mapping>
;;;
;;; This function returns a list of objects from all of 
;;; <objects> in the world that are found in the 
;;; given <location>.
(defun objects-at (loc objs obj-locs)
  (labels ((at-loc-p (obj)
             (eq (cadr (assoc obj obj-locs)) loc)))
    (remove-if-not #'at-loc-p objs)))

;;; describe-object <location> <objects> <object-location-mappings>
;;;
;;; This function returns a sentence description of the 
;;; <objects> in a given <location> by looking at the
;;; <object-location-mappings>.
(defun describe-objects (loc objs obj-loc)
  (labels ((describe-object (obj)
              `(you see a ,obj on the floor.)))
    (apply #'append (mapcar #'describe-object (objects-at loc objs obj-loc)))))

;; Impure functions...

(defun look ()
  (append (describe-location *location* *nodes*)
	  (describe-paths *location* *edges*)
	  (describe-objects *location* *objects* *object-locations*)))

(defun walk (direction)
  (let ((next (find direction
		    (cdr (assoc *location* *edges*))
		    :key #'cadr)))
    (if next
	(progn (setf *location* (car next))
	       (look))
	'(you cannot go that way.))))

(defun pickup (object)
  (cond ((member object
		 (objects-at *location* *objects* *object-locations*))
	 (push (list object 'body) *object-locations*)
	 `(you are now carrying the ,object))
	(t '(you cannot get that.))))

(defun inventory ()
  (cons 'items- (objects-at 'body *objects* *object-locations*)))

;; TODO: drop an item from your inventory
;; TODO: Set a limit on how many items you can carry

(defparameter *allowed-commands* '(look walk pickup inventory))

(defun game-repl ()
  (let ((cmd (game-read)))
    (unless (eq (car cmd) 'quit)
      (game-print (game-eval cmd))
      (game-repl))))

(defun game-read ()
  (let ((cmd (read-from-string (concatenate 'string "(" (read-line) ")"))))
    (flet ((quote-it (x)
	     (list 'quote x)))
      (cons (car cmd) (mapcar #'quote-it (cdr cmd))))))

(defun game-eval (sexp)
  (if (member (car sexp) *allowed-commands*)
      (eval sexp)
      '(I do not know that command.)))

(defun tweak-text (lst caps lit)
  (when lst
    (let ((item (car lst))
	  (rest (cdr lst)))
      (cond ((eql item #\space) (cons item (tweak-text rest caps lit)))
	    ((member item '(#\! #\? #\.)) (cons item (tweak-text rest t lit)))
	    ((eql item #\") (tweak-text rest caps (not lit)))
	    (lit (cons item (tweak-text rest nil lit)))
	    (caps (cons (char-upcase item) (tweak-text rest nil lit)))
	    (t (cons (char-downcase item) (tweak-text rest nil nil)))))))

(defun game-print (lst)
  (princ (coerce (tweak-text (coerce (string-trim "() "
						  (prin1-to-string lst))
				     'list)
			     t
			     nil)
		 'string))
  (fresh-line))
