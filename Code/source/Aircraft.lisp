(in-package :gdl-user)

(defparameter *dataFolder* (merge-pathnames "../data/"
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
   (inputDataFilename "inputData.dat")
   (aircraftDatabaseFilename "aircraftDatabase.dat")
   (wingAirfoil "NACA_0012_xyz.dat")
  )
  
  :computed-slots
  (
  (inputDataFilePath (merge-pathnames (the inputDataFilename) (the dataFolder)))
  (inputData (basicDataReader (the inputDataFilePath)))
  (aircraftDatabaseFilePath (merge-pathnames (the aircraftDatabaseFilename) (the dataFolder)))
  (aircraftDatabase (databaseReader (the aircraftDatabaseFilePath)))
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
	:center (translate (the center) :rear (the fuselage lengthTotal))
	:surfaceHorizontal (the tailSizing tailSurfaceHorizontal)
	:surfaceVertical (the tailSizing tailSurfaceVertical)
	:tailParameters (ecase (the input tailType)
						(1 (the constants tailConventional))
						(2 (the constants tailCruciform))
						(3 (the constants tailT))
						(4 (the constants tailV))
						(5 (the constants tailC))
						(6 (the constants tailH)))
	)
 
   (""
    fuselage 
	:type 'Fuselage
	:finenessRatio (the input finenessRatio)
	:lengthCenter (the input fuselageLengthCenter)
	:lengthNose	(the input fuselageLengthNose)
	:lengthTail (the input fuselageLengthTail)
	)
		
   (""
    engines 
	:type 'EngineAssy
	:engineNumber (the input engineNumber)
	:position (ecase (the input engineMounting) 
				( 1 (the wing center)) 
				( 2 (the fuselage fuselageTail center)))
	:offsetSweep (ecase (the input engineMounting)
				( 1 1) 
				( 2 0))
	:offsetSpan (ecase (the input engineMounting)
				( 1 (/ (- (the wing span) (the fuselage diameter)) (+ 2 (the engines engineNumber)))) 
				( 2 (the input engineDiameter)))
	:offsetFuselage (half (the fuselage diameter))
	:length (the input engineLength)
	:diameter (the input engineDiameter)
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
						(1 (the fuselage fuselageCenter center)) 
						(2 (make-point 0 (+ (the fuselage lengthNose) (* 0.6 (the fuselage lengthCenter))) 0)))
	:airfoil(the wingAirfoil)
	:sweepLE (the input wingSweepLE)
   )

   (""
    input :type 'InputData
              :parameters (the inputData))
			  
	(""
	constants :type 'ConstantData
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

	)
  :functions
  ()

)


