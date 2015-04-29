(in-package :gdl-user)



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
    fuselage :type 'Fuselage)
   (""
    engine :type 'Engine)
   
   (""
    wing :type 'WingAssy)

   (""
    input :type 'InputData
              :parameters (the inputData))
)
  
  :functions
  ()

)

(defparameter *dataFolder*
  (make-pathname :name nil
:type nil
:defaults (merge-pathnames "../data/"
#+allegro excl:*source-pathname*
#+lispworks dspec:*source-pathname*
;; in future: (glisp:source-pathname)
)))

