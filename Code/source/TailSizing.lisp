(in-package :gdl-user)

(define-object TailSizing ()
  
  :documentation
  (:author "Roger & Nick)"
   :description "File to size the tail from statistical data input, by means of selecting appropriate aircraft and averaging their tail volume coefficients")
  
  :input-slots
   ((dataFolder *dataFolder*)
   (inputDataTailfilename "inputDataTail.dat")
   (inputDataTailVolHorfilename "tailDataHor.dat")
   (inputDataTailVolVerfilename "tailDataVer.dat")
  )
  
  
  :computed-slots
  ;Read in file with aircraft
  ((inputDataFilePath1 (merge-pathnames (the inputDataTailfilename) (the dataFolder)))
  (inputDataFilePath2 (merge-pathnames (the inputDataTailVolHorfilename) (the dataFolder)))
  (inputDataFilePath3 (merge-pathnames (the inputDataTailVolVerfilename) (the dataFolder))
  )
  
  (inputDataTail (advancedDataReader (the inputDataFilePath1)))
  (inputDataTailVolHor (advancedDataReader (the inputDataFilePath2)))
  (inputDataTailVolVer (advancedDataReader (the inputDataFilePath3)))
    
  ;Selection function to use only appropriate aircraft
  ;Still needs accounting for C, H or Vtail (no matching tails)
  (mapcar #'(if (and (:num = (the EngineNum)) (:pos = (the EnginePos)) (:tail = (the tailType))) (append :volume 'VolumelistH)) 'InputdataTailVolHor)
  
  ; Average tailvolume coefficient
  (("Statistically based Horizontal Tail volume Coefficient"
    tailVolHor (/ (sum-elements (the VolumelistH)) (:length (the VolumelistH)) )
   
   ("Statistically based Vertical Tail volume Coefficient"
    tailVolVer (/ (sum-elements (the VolumelistV)) (:length (the VolumelistV)) )
	)
  
  
  :objects
  ()
  
  
  :functions
  ())

