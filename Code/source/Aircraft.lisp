(in-package :gdl-user)

(defparameter *dataFolder* (merge-pathnames "../data/"
					     (make-pathname :name nil
							    :type nil
							    :defaults excl:*source-pathname*))
)


(define-object Aircraft ()
  
  :documentation
  (:author "Nick&Roger"
   :description "-")
  
  :input-slots
  ((dataFolder *dataFolder*)
   (inputDataFilename "inputData.dat")
  )
  
  :computed-slots
  (
  (inputDataFilePath (merge-pathnames (the inputDataFilename) (the dataFolder)))
  (inputData (basicDataReader (the inputDataFilePath)))
  )
  
  :objects
  ((""
    tail :type 'TailAssy)
 
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
    :configuration (the input wingConfiguration)
    :wingPositioning (ecase (the input engineMounting)
						(1 (the fuselage fuselageCenter center)) 
						(2 (make-point 0 (+ (the fuselage lengthNose) (* 0.6 (the fuselage lengthCenter))) 0)))
   )

   (""
    input :type 'InputData
              :parameters (the inputData))
)
  
  :functions
  ()

)


