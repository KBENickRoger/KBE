(in-package :gdl-user)

(define-object Aircraft-tridrawing (base-drawing)

:hidden-objects ((Aircraft :type 'Aircraft))

:objects
((tri-view :type 'base-view
			:border-box? t
			:object-roots (list (the Aircraft fuselage) 
								(the Aircraft engines)
								(the Aircraft wing)
								(the Aircraft tail))
			:length (the length)
			:width (the width)
			:center (the center)
			:projection-vector (getf *standard-views* :trimetric)
			)

)
)

(define-object Aircraft-viewdrawing (base-drawing)

:hidden-objects ((Aircraft :type 'Aircraft))

:objects
((front-view :type 'base-view
			:border-box? t
			:object-roots (list (the Aircraft fuselage) 
								(the Aircraft engines)
								(the Aircraft wing)
								(the Aircraft tail))
			:length (half (half (the length)))
			:width	(the width)
			:center (translate (the center)
								:rear (* 3 (half (the-child length))))
			:projection-vector (getf *standard-views* :front)
			)
			
(top-view :type 'base-view
			:border-box? t
			:object-roots (list (the Aircraft fuselage) 
								(the Aircraft engines)
								(the Aircraft wing)
								(the Aircraft tail))
			:length (half (the length))
			:width (the width)
			:center (the center)
			:projection-vector (getf *standard-views* :top)
			)

(side-view :type 'base-view
			:border-box? t
			:object-roots (list (the Aircraft fuselage) 
								(the Aircraft engines)
								(the Aircraft wing)
								(the Aircraft tail))
			:length (half (half (the length)))
			:width (the width)
			:center (translate (the center)
								:front (* 3 (half (the-child length))))
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