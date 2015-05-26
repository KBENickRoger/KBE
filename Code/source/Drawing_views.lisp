(in-package :gdl-user)

(define-object Drawing-views (base-drawing)

:input-slots
(
 (outputFolder *outputFolder*)
 (fuselage) 
 (engines) 
 (wing) 
 (tail)
)

:computed-slots
(
(objectList (list (the fuselage) (the engines) (the wing) (the tail)))
(outputPDF! (the (output!)))  
)

:objects
(
(front-view :type 'base-view
			:border-box? t
			:object-roots (the objectList)
			:length (half (half (the length)))
			:width	(the width)
			:center (translate (the center)
								:rear (* 3 (half (the-child length))))
			:projection-vector (getf *standard-views* :front)
			)
			
(top-view :type 'base-view
			:border-box? t
			:object-roots (the objectList)
			:length (half (the length))
			:width (the width)
			:center (the center)
			:projection-vector (getf *standard-views* :top)
			)

(side-view :type 'base-view
			:border-box? t
			:object-roots (the objectList)
			:length (half (half (the length)))
			:width (the width)
			:center (translate (the center)
								:front (* 3 (half (the-child length))))
			:projection-vector (getf *standard-views* :right)
			)
)

:functions
((output! 
  ()
  (with-format (pdf (merge-pathnames "Drawing-views.pdf" (the outputFolder))
		    :page-length (the page-length) :page-width (the page-width))
    (write-the cad-output)))))


