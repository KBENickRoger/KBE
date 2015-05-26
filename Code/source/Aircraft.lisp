(in-package :gdl-user)

(defparameter *dataFolder* (merge-pathnames "../data/"
					     (make-pathname :name nil
							    :type nil
							    :defaults excl:*source-pathname*))
)

(defparameter *outputFolder* (merge-pathnames "../output/"
					     (make-pathname :name nil
							    :type nil
							    :defaults excl:*source-pathname*))
)

(define-object Aircraft (base-object)
  
  :documentation
  (:author "Nick&Roger"
   :description "-")
  
  :input-slots
  ((dataFolder *dataFolder*)
   (outputFolder *outputFolder*)
   (inputDataFilename "inputData.dat")
   (constantDataFilename "constantData.dat")
   (aircraftDatabaseFilename "aircraftDatabase.dat")
   (wingAirfoil "whitcomb_cst.dat")
   (tailAirfoil "naca0012_cst.dat")
  )
  
  :computed-slots
  (
  
  (inputDataFilePath (merge-pathnames (the inputDataFilename) (the dataFolder)))
  (inputData (basicDataReader (the inputDataFilePath)))
  (aircraftDatabaseFilePath (merge-pathnames (the aircraftDatabaseFilename) (the dataFolder)))
  (aircraftDatabase (databaseReader (the aircraftDatabaseFilePath)))
  
  (fuselageTailCenterPoint (make-point 0 (+ (the fuselage lengthCenter) (the fuselage lengthNose)) 0))

  (output_Q3D? (the Q3DWriter Q3D_writer) )
  (output_PDF_main? (the drawingMain outputPDF!))
  (output_PDF_views? (the drawingViews outputPDF!))
  (output_STEP? (the (outputSTEP!)))
  
  ("longitudinal location of Wing AC"
  ACy (get-y (the wing center)))

  ("Sweep of horizontal tailplane"
  horizontalSweepLE (+ 10 (the input wingSweepLE)))
  
  (""
  offsetSpan (ecase (the input engineMounting)
				( 1 (/ (- (the wing span) (the fuselage diameter)) (+ 2 (the engines engineNumber)))) 
				( 2 (the input engineDiameter))))
  )
  :objects
  ((""
    tail :type (ecase (the input tailType)
					(1 'TailConventional)
					(2 'TailCruciform)
					(3 'TailT)
					(4 'TailV)
					(5 'TailC)
					(6 'TailH))
	:center (translate (the center) :rear (the input fuselageLengthTotal)
									:up  (* 3 (the fuselage section-offset-divergence))
									:down (* 0.9 (half (the fuselage diameter)))) 
	:surfaceHorizontal (the tailSizing tailSurfaceHorizontal)
	:surfaceVertical (the tailSizing tailSurfaceVertical)
	:tailParameters (ecase (the input tailType)
						(1 (the constants tailConventional))
						(2 (the constants tailCruciform))
						(3 (the constants tailT))
						(4 (the constants tailV))
						(5 (the constants tailC))
						(6 (the constants tailH)))
	:airfoil (the tailAirfoil)
	:horizontalSweepLE (the horizontalSweepLE)
	:mach (getf (the input cruiseCondition) :mach)
	:weightParams (list 
					:FW (m2ft (case (the input tailType) (2 0) (3 0) (otherwise (* 0.1 (the fuselage diameter)))))
					:Wdg (kg2lb(getf (the input cruiseCondition) :weight))
					:Nz (* 1.5 (getf (the input cruiseCondition) :limitLoad))
					:Lt (- (the fuselage lengthTotal) (get-y (the wing center)))
					:ky (* 0.3 (- (the fuselage lengthTotal) (get-y (the wing center))))
					:kz (- (the fuselage lengthTotal) (get-y (the wing center)))
					:de_dh 0.3
					:Ht_Hv (case (the input tailType) (2 1) (case 3 1) (otherwise 0))
					)
	)
 
   (""
    fuselage 
	:type 'Fuselage
	:finenessRatio (the input finenessRatio)
	:lengthTotal (the input fuselageLengthTotal)
	:divergence (the input divergence)
	)
		
   (""
    engines 
	:type 'EngineAssy
	:engineNumber (the input engineNumber)
	:position (ecase (the input engineMounting) 
				( 1 (the wing center)) 
				( 2 (the fuselageTailCenterPoint)))
	:offsetSweep (ecase (the input engineMounting)
				( 1 (* (sin(degrees-to-radians (the input wingSweepLE))) (the offsetSpan))) 
				( 2 0 ))
	:offsetSpan (the offsetSpan)
	:offsetEngineDiameter (ecase (the input engineMounting)
							( 1 0)
							( 2 (- (half (the input engineDiameter)))))
	:offsetFuselage (half (the fuselage diameter))
	:offsetDihedral (ecase (the input engineMounting)
					( 1 (* (sin(degrees-to-radians (the input wingDihedral))) (the offsetSpan)))
					( 2 0 ))
	:length (the input engineLength)
	:diameter (the input engineDiameter)
	:offsetWingFront (ecase (the input engineMounting)
				   ( 1 (half (the input wingChordRoot)))
	 			   ( 2 0 ))
	:offsetWingBottom (ecase (the input engineMounting)
				   ( 1 (* 0.75 (the input engineDiameter)))
	 			   ( 2 0 ))
	:ACy (the ACy)
	)
   
   (""
    wing 
    :type 'WingAssy
    :span (the input wingSpan)
    :kinkPos (the input wingKinkPos)
    :chordRoot (the input wingChordRoot)
    :taper (the input wingTaper)
    :dihedral (the input wingDihedral)
    :wingVerticalShift (ecase (the input wingConfiguration)
								(1 (- 0 (half (the fuselage diameter))))
								(2 0)
								(3 (+ 0 (half (the fuselage diameter)))))
    :wingPositioning (ecase (the input engineMounting)
						(1 (make-point 0 (+ (the fuselage lengthNose) (* 0.5 (the fuselage lengthCenter))) 0)) 
						(2 (make-point 0 (+ (the fuselage lengthNose) (* 0.6 (the fuselage lengthCenter))) 0)))
	:airfoil(the wingAirfoil)
	:sweepLE (the input wingSweepLE)
   )

   (""
    input :type 'InputData
              :parameters (the inputData)
			  :cruiseCondition (basicDataReader (merge-pathnames "cruiseCondition.dat" (the dataFolder))))
			  
	(""
	constants :type 'ConstantData
			  :parameters (basicDataReader (merge-pathnames (the constantDataFilename) (the dataFolder)))
			  :tailConventional (basicDataReader (merge-pathnames "tailConventional.dat" (the dataFolder)))
			  :tailCruciform(basicDataReader (merge-pathnames "tailCruciform.dat" (the dataFolder)))
			  :tailT (basicDataReader (merge-pathnames "tailT.dat" (the dataFolder)))
			  :tailV (basicDataReader (merge-pathnames "tailV.dat" (the dataFolder)))
			  :tailH (basicDataReader (merge-pathnames "tailH.dat" (the dataFolder)))
			  :tailC (basicDataReader (merge-pathnames "tailC.dat" (the dataFolder)))
	)
  
  (""
   tailSizing :type 'TailSizing
	:input (the input)
	:database (the aircraftDatabase)
	:tailArm (- (the fuselage lengthTotal) (get-y (the wing center)))
	:span (the wing span)
	:mac (the wing Cmac)
	:wingSurface (the wing surface)
	)

   (""
    Q3DWriter 
    :type 'outputQ3D
    :wing (the wing (wings 0))
	:wingAssy (the wing)
	:condition (the input cruiseCondition)
    )

	
	("Capability to evaluate Lift gradient, downwash gradient and lift gradient with fuselage"
	AeroGradients
	:type 'Aerodynamics
	:Vh_V (getf (the tail tailParameters) :Vh_V)
	:span (the wing span)
	:wingArea (the wing surface)
	:sweepLE (the input wingSweepLE)
	:rootChord (the wing chordRoot)
	:tipChord (the wing chordTip)
	:tailLength (sqrt(+ (expt (the tailSizing tailArm) 2)
							(expt (- (get-z (the tail center)) (get-z (the wing center))) 2)))
	:tailVLength (- (get-z (the tail center)) (get-z (the wing center)))
	:fuselageRadius (half (the fuselage diameter))
	:AR (the wing aspectRatio)
	:Mach (getf (the input cruiseCondition) :mach)
	)
	
	(""
	Locations 
	:type 'Locations
	:dEpsdAlph (the AeroGradients dEpsdAlph)
	:XacW (the ACy)
	:CLalphaWF (the AeroGradients CLalphaWF)
	:CLalpha (the AeroGradients CLalpha)
	:tailCLalpha (the tail CLalpha)
	:Vh_V (getf (the tail tailParameters) :Vh_V)
	:wingArea (the wing surface)
	:tailArea (the tailSizing tailSurfaceHorizontal)
	:tailArm (the tailSizing tailArm)
	:wingCmac (the wing Cmac)
	:wingTaper (the wing taper)
	:tailTaper (the tail taper)
	:span (the wing span)
	:wingSweepLE (the wing sweepLE)
	:fuselageRadius (half (the fuselage diameter))
	:spanNet (the AeroGradients spanNet)
	:wingCenter (the wing center)
	:Kn (ecase (the input engineMounting)
				(1 (- 4))
				(2 (- 2.5)))
	:Bn (the input engineDiameter)
	:l_n (ecase (the input engineMounting)
				( 1 (+ (the engines l_n) (* (the input engineNumber) (half (the input engineLength)))))
				( 2 (- (the engines l_n) (* (the input engineNumber) (half (the input engineLength))))))
	:rootChord (the wing chordRoot)
	:tipChord (the wing chordTip)
	)

	(ACCG
	:type 'ACCG
	:centerCG (make-point 0 (the Locations Xcg) 0)
	:centerAC (make-point 0 (the Locations XacTot) 0))
	
	(drawingMain
	:hidden? t
	:type 'Drawing-main
	:fuselage (the fuselage)
	:engines (the engines)
	:wing (the wing)
	:tail (the tail)
	
	)

	(drawingViews
	:hidden? t
	:type 'Drawing-views
	:fuselage (the fuselage)
	:engines (the engines)
	:wing (the wing)
	:tail (the tail)
	)
)
	

  :functions
  ((outputSTEP!
	()
	(with-format (step (merge-pathnames "Aircraft3D.stp" (the outputFolder)))
	(write-the cad-output-tree)))
	)
)





