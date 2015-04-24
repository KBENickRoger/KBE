(in-package :gdl-user)



(define-object Aircraft ()
  
  :documentation
  (:author "Nick&Roger"
   :description "24/4 Nick: added global (**) parameter for dataFolder, function for reading data files")
  
  :input-slots
  ((dataFolder *dataFolder*)
   (inputDataFile (merge-pathnames "inputData.txt" (the dataFolder))))
  
  
  :computed-slots
  ()
  
  
  :objects
  ((""
    tail :type 'ConTail)
   
   (""
    tail :type 'VTail)
   
   (""
    fuselage :type 'Fuselage)
   
   (""
    tail :type 'CTail)
   
   (""
    engine :type 'Engine)
   
   (""
    wing :type 'WingAssy))
  
  
  :functions
  ())

(defparameter *dataFolder*
  (make-pathname :name nil
:type nil
:defaults (merge-pathnames "../data/"
#+allegro excl:*source-pathname*
#+lispworks dspec:*source-pathname*
;; in future: (glisp:source-pathname)
)))

