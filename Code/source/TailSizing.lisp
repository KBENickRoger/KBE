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
  ((inputDataFilePath1 (merge-pathnames (the inputDataTailfilename) (the dataFolder)))
  (inputDataFilePath2 (merge-pathnames (the inputDataTailVolHorfilename) (the dataFolder)))
  (inputDataFilePath3 (merge-pathnames (the inputDataTailVolVerfilename) (the dataFolder)))
  
  (inputDataTail (basicDataReader (the inputDataFilePath1)))
  (inputDataTailVolHor (basicDataReader (the inputDataFilePath2)))
  (inputDataTailVolVer (basicDataReader (the inputDataFilePath3)))
  
  
  (("Statistically based Horizontal Tail volume Coefficient"
    TailVolHor nil #|todo|# )
   
   ("Statistically based Vertical Tail volume Coefficient"
    TailVolVer nil #|todo|# )))
  
  
  :objects
  ()
  
  
  :functions
  ())

