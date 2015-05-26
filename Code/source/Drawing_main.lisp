(in-package :gdl-user)

(define-object Drawing-main (base-drawing)

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
(outputPDF! (the (output!)))
)

:hidden-objects 
(
				 (text-block :type 'Aircraft-text-block
							 :margins (twice (twice (the text-view left-margin)))
							 :width (the text-view width)
							 :length (the text-view length)
							 :inputList (list 
							 :Fuselage-length 10 ;(+ (the input fuselageLengthCenter) (the input fuselageLengthNose) (the input fuselageLengthTail))
							 :Fuselage-slenderness-ratio 0 ;(the input Fuselage-slenderness-ratio)
							 :Wing-Span (the wing span)
							 :Wing-Sweep 0 ; (the wing sweepLE)
							 :Wing-Taper 0 ; (the wing taper)
							 :Wing-C_mac 0 ;(the wing Cmac)
							 :Wing-Surface-Area 0 ;(the wing surface)
							 :Engine-number 0 ;(the engines engineNumber)
							 :EnginePos 0 ; (ecase (the input engineMounting)
										; ( 1 "Wing-podded")
										; ( 2 "Fuselage-podded")))
							 ))
)
 
:objects
(
(text-view :type 'base-view
			:border-box? t
			:objects (list (the text-block))
			:length (half (the length))
			:width (the width)
			:projection-vector (getf *standard-views* :top)
			:center (translate (the center) 
								:front (half (the-child length)))
)

(tri-view :type 'base-view
			:border-box? t
			:object-roots (list (the fuselage) 
								(the engines)
								(the wing)
								(the tail))
			:length (half (the length))
			:width (the width)
			:center (translate (the center)
								:rear (half (the-child length)))
			:projection-vector (getf *standard-views* :trimetric)
)	
)

:functions
((output! 
  ()
  (with-format (pdf (merge-pathnames "Drawing-main.pdf" (the outputFolder))
		    :page-length (the page-length) :page-width (the page-width))
    (write-the cad-output)))))

