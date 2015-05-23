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
							 :margins (twice (twice (the text-view left-margin)))
							 :width (the text-view width)
							 :length (the text-view length)
							 :Fuselage-length 0 ;(+ (the input fuselageLengthCenter) (the input fuselageLengthNose) (the input fuselageLengthTail))
							 :Fuselage-slenderness-ratio 0 ;(the input Fuselage-slenderness-ratio)
							 :Wing-Span (the Aircraft wingAirfoil)
							 :Wing-Sweep 0 ; (the wing sweepLE)
							 :Wing-Taper 0 ; (the wing taper)
							 :Wing-C_mac 0 ;(the wing Cmac)
							 :Wing-Surface-Area 0 ;(the wing surface)
							 :Engine-number 0 ;(the engines engineNumber)
							 :EnginePos 0 ; (ecase (the input engineMounting)
										; ( 1 "Wing-podded")
										; ( 2 "Fuselage-podded")))
							 ))
 
:objects
((text-view :type 'base-view
			:border-box? t
			:objects (list (the text-block))
			:length (half (the length))
			:width (the width)
			:projection-vector (getf *standard-views* :top)
			:center (translate (the center) 
								:front (half (the-child length))))

(tri-view :type 'base-view
			:border-box? t
			:object-roots (list (the Aircraft fuselage) 
								(the Aircraft engines)
								(the Aircraft wing)
								(the Aircraft tail))
			:length (half (the length))
			:width (the width)
			:center (translate (the center)
								:rear (half (the-child length)))
			:projection-vector (getf *standard-views* :trimetric)
			)			

))

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
((Fuselage-length Fuselage-slenderness-ratio Wing-Span Wing-Sweep Wing-Taper Wing-C_mac Wing-Surface-Area Engine-number EnginePos))

:functions
 ((content
    ()
    (tt:compile-text (:font "Helvetica" :font-size 12.0)
      (tt:vspace 100)

      (tt:paragraph () "Aircraft Data")
      (let ((width (- (the width) (the margins))))
	(tt:table (:col-widths (list (* 2/3 width) (* 1/3 width)))
	  (dolist (slot (list :Fuselage-length :Fuselage-slenderness-ratio :Wing-Span :Wing-Sweep :Wing-Taper :Wing-C_mac :Wing-Surface-Area :Engine-number :EnginePos))
	    (tt:row ()
	      (tt:cell (:background-color "#FFFFFF") (tt:put-string (format nil "~a" (string-capitalize slot))))
	      (tt:cell () 
		(tt:paragraph (:h-align :center) (tt:put-string (format nil "~a" (the (evaluate slot))))))))))))))