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
  
  (inputDataTail (basicDataReader (the inputDataFilePath1)))
  (inputDataTailVolHor (basicDataReader (the inputDataFilePath2)))
  (inputDataTailVolVer (basicDataReader (the inputDataFilePath3)))
  
  ;!!!!! A function to add the variable names in the plist with every a/c is still too be added.!!!!!!!!!!!!!!!!!!!
  
  ;Selection function to use only appropriate aircraft
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

