(in-package :gdl-user)

(define-object Fuselage (geom-base:cylinder)
  
  :documentation
  (:author "<name> (<username>@<organization>.com)"
   :description "")
  
  :input-slots
  ((""
    fuselageLengthTotal)
   
   (""
    fuselageTailRotAngle nil #|todo: default value|#)
   
   (""
    fuselageSlenderness))
  
  
  :computed-slots
  ((""
    radius (/ (the fuselageLengthTotal) (the fuselageSlenderness) 2) )
   
   (""
    length (the fuselageLengthTotal)))
  
  
  :objects
  ()
  
  
  :functions
  ())



