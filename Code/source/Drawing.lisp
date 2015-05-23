(in-package :gdl-user)

(defparameter *outputFolder* (merge-pathnames "../output/"
					     (make-pathname :name nil
							    :type nil
							    :defaults excl:*source-pathname*))
)

(define-object Aircraft-tridrawing (base-drawing)

:input-slots
((outputFolder *outputFolder*))

:hidden-objects ((Aircraft :type 'Aircraft)

				 (text-block :type 'Aircraft-text-block
							 :width (the text-view width)
							 :length (the text-view length)
							 :Fuselage-length nil
							 :Fuselage-slenderness-ratio nil
							 :Wing-Span nil
							 :Wing-Sweep nil
							 :Wing-Taper nil
							 :Wing-Surface-Area nil
							 :Engine-number nil
							 :EnginePos nil
							 ))

:objects
((text-view :type 'base-view
			:left-margin
			:right-margin
			:border-box? t
			:objects (list (the text-block))
			:length (half (the length))
			:width (the width)
			:projection-vector (getf *standard-views* :top)
			:center (translate (the center) 
								:rear (half (the-child length))))

(tri-view :type 'base-view
			:border-box? t
			:object-roots (list (the Aircraft fuselage) 
								(the Aircraft engines)
								(the Aircraft wing)
								(the Aircraft tail))
			:length (the length)
			:width (the width)
			:center (translate (the center)
								:front (half (the-child length)))
			:projection-vector (getf *standard-views* :trimetric)
			)


 ()			
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

:functions
((write-drawing
	()
	(with-format (pdf (merge-pathnames "Aircraft-drawing.pdf" (the outputFolder))
						:page-length (the page-length) :page-width (the page-width)
	(write-the cad-output))))
	
 (write-step
	()
	(with-format (step (merge-pathnames "Aircraft3D.stp" (the outputFolder))
	(write-the cad-output-tree))))
))

(define-object Aircraft-text-block (typeset-block)

:input-slots
(Fuselage-length Fuselage-slenderness-ratio Wing-Span Wing-Sweep Wing-Taper Wing-Surface-Area Engine-number EnginePos)

:functions
((content
 ()
 (tt:compile-text(:font "Calibri" :font-size 12.0)
 (tt:vspace 100)
 (tt:paragraph () "Aircraft Data")
 (tt:table (:col-widths (list 220 (- (the width) 220)))
 (dolist (slot (list :Fuselage-length 
					 :Fuselage-slenderness-ratio
					 :Wing-Span
					 :Wing-Sweep
					 :Wing-Taper
					 :Wing-Surface-Area
					 :Engine-number
					 :EnginePos))
		(tt:row ()
		  (tt:cell (:background-color "#1E1E1E") (tt:put-string (format nil "~a" (string-capitalize slot))))
		  (tt:cell ()
		  (tt:paragraph (:h-align :center) (tt:put-string (format nil "~a" (the (evaluate slot)))))))))))))
















