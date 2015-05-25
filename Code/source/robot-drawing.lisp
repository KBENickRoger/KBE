(in-package :gdl-user)

(define-object robot-drawing (base-drawing)

  :hidden-objects ((robot-assembly :type 'robot:assembly))

  :objects
  ((tri-view :type 'base-view
	     :border-box? t
	     :object-roots (list (the robot-assembly robot))
	     :length (half (the length))
	     :projection-vector (getf *standard-views* :trimetric))
   )

  :functions
  ((write-drawing! 
    ()
    (with-format (pdf (merge-pathnames "views2.pdf" (the outputFolder))
		    :page-length (the page-length) :page-width (the page-width))
      (write-the cad-output)))))

(define-object blaat ()

:computed-slots
((hoi? (the (hello 1))))

:functions
((hello (a) (+ a 1)))
)
