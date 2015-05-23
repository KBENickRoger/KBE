(in-package :gdl-user)

(define-object Aircraft-drawing (base-drawing)

:hidden-objects ((Aircraft :type 'Aircraft))

:objects
((tri-view :type 'base-view
			:border-box? t
			:object-roots (list (the Aircraft fuselage) 
								(the Aircraft engines)
								(the Aircraft wing)
								(the Aircraft tail))
			:length (half (the length))
			:width (half (the width))
			:center (translate (the center)
								:rear (half (the-child length))
								:right (half (the-child width)))
			:projection-vector (getf *standard-views* :trimetric)
			)

(front-view :type 'base-view
			:border-box? t
			:object-roots (list (the Aircraft fuselage) 
								(the Aircraft engines)
								(the Aircraft wing)
								(the Aircraft tail))
			:length (half (the length))
		:width (half (the width))
			:center (translate (the center)
								:rear (half (the-child length))
								:left (half (the-child width)))
			:projection-vector (getf *standard-views* :front)
			)
			
(top-view :type 'base-view
			:border-box? t
			:object-roots (list (the Aircraft fuselage) 
								(the Aircraft engines)
								(the Aircraft wing)
								(the Aircraft tail))
			:length (half (the length))
			:width (half (the width))
			:center (translate (the center)
								:front (half (the-child length))
								:left (half (the-child width)))
			:projection-vector (getf *standard-views* :top)
			)

(side-view :type 'base-view
			:border-box? t
			:object-roots (list (the Aircraft fuselage) 
								(the Aircraft engines)
								(the Aircraft wing)
								(the Aircraft tail))
			:length (half (the length))
			:width (half (the width))
			:center (translate (the center)
								:front (half (the-child length))
								:right (half (the-child width)))
			:projection-vector (getf *standard-views* :right)
			)


)

;:functions
;((write-drawing
;	()
;	(with-format (pdf (merge-pathnames "Aircraft-drawing.pdf" (*data-folder*))
;						:page-length (the page-length) :page-width (the page-width)
;	(write-the cad-output)))))
)
