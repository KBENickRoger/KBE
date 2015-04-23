(in-package :kbe)

(define-object Aircraft ()
  
  :documentation
  (:author "<name> (<username>@<organization>.com)"
   :description "")
  
  :input-slots
  ()
  
  
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

