(in-package :gdl-user)

(define-object InputPDF (base-drawing)

:input-slots
(
 (outputFolder *outputFolder*)
 (input)
)

:computed-slots
(
(outputPDF! (the (output!)))
)

:hidden-objects
(
			(text-block :type 'Input-text-block
							 :margins (twice (twice (the text-view left-margin)))
							 :width (the text-view width)
							 :length (the text-view length)
							 :inputList (list 
							:Wing_Parameters " "							 
							:Wing_Span (the input wingSpan)
							:Wing__ChordRoot (the input wingChordRoot)
							:Wing_KinkPos (the input wingKinkPos)
							:Wing_Taper (the input wingTaper)
							:Wing_Dihedral (the input wingDihedral)
							:Wing_Configuration (the input wingConfiguration)
							:Wing_SweepLE (the input wingSweepLE)
							:Tail-Input " "
							:Tail-type (ecase (the input tailType)
											(1 "Conventional")
											(2 "Cruciform")
											(3 "T-Tail")
											(4 "V-Tail")
											(5 "C-Tail")
											(6 "H-Tail"))
							:Fuselage-Paramaters " "
							:Fineness_Ratio (the input finenessRatio)
							:Fuselage_Length (the input fuselageLengthTotal)
							:Divergence (the input divergence)
							:Engine-Parameters " "
							:Enengine_Mounting (ecase (the input engineMounting)
														(1 "Wing-mounted")
														(2 "Fuselage-mounted"))
							:Number_of_engines (the input engineNumber)
							:Eengine_Diameter (the input engineDiameter)
							:Length_of_engines (the input engineLength)
							:Cruise_Conditions " "	
							:Velocity (getf (the input cruiseCondition) :V)
							:Atmospheric_density (getf (the input cruiseCondition) :rho)
							:Altitude (getf (the input cruiseCondition) :altitude)
							:Mach (getf (the input cruiseCondition) :mach)
							:Weight_N (getf (the input cruiseCondition) :weight)
							:Q3D_viscous (getf (the input cruiseCondition) :viscous)
							 ))
							 

)
		
:objects
(
(text-view :type 'base-view
			:objects (list (the text-block))
			:length (the length)
			:width (the width)
			:projection-vector (getf *standard-views* :top)
			:center (the center)
)
)

:functions
(
(output! 
  ()
  (with-format (pdf (merge-pathnames "Input.pdf" (the outputFolder))
		    :page-length (the page-length) :page-width (the page-width))
    (write-the cad-output)))
)
)
