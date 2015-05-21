(in-package :gdl-user)

(define-object Aircraft-drawing (base-drawing)

:hidden-objects ((Aircraft :type 'Aircraft))

:objects
((tri-view :type 'base-view
			:object-roots (list (the Aircraft))
			:length (half (the length))
			:width (half (the width))
			:center (translate (the center)
								:front (half (the length))
								:right (half (the width)))
			:projection-vector (getf *standard-views* :trimetric)
			)

(front-view :type 'base-view
			:object-roots (list (the Aircraft))
			:length (half (the length))
			:width (half (the width))
			:center (translate (the center)
								:front (half (the length))
								:left (half (the width)))
			:projection-vector (getf *standard-views* :front)
			)
			
(top-view :type 'base-view
			:object-roots (list (the Aircraft))
			:length (half (the length))
			:width (half (the width))
			:center (translate (the center)
								:rear (half (the length))
								:left (half (the width)))
			:projection-vector (getf *standard-views* :top)
			)

(side-view :type 'base-view
			:object-roots (list (the Aircraft))
			:length (half (the length))
			:width (half (the width))
			:center (translate (the center)
								:rear (half (the length))
								:right (half (the width)))
			:projection-vector (getf *standard-views* :right)
			)


))