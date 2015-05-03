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
	:lengthTotal (the input fuselageLength)
	:finenessRatio (the input finenessRatio)
	:lengthCenter (the input fuselageLengthCenter)
	:lengthNose	(the input fuselageLengthNose)
	)
		
   (""
    engines 
	:type 'EngineAssy
	:engineNumber (the input engineNumber)
	:position (ecase (the input engineMounting) 
				( 1 (the wing wingFromNose)) ( 2 (the fuselage lengthTotal)))
	:offsetSweep (ecase (the input engineMounting)
				( 1 1) ( 2 0))
	:offsetSpan (ecase (the input engineMounting)
				( 1 (/ (- (the wing span) (the fuselage diameter)) (the engines engineNumber))) ( 2 0))
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
    :wingFromNose 5
)

   (""
    input :type 'InputData
              :parameters (the inputData))
)
  
  :functions
  ()

)


