(in-package :gdl-user)

(define-object Fuselage ()
  
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
    fuselageRadius (/ (the fuselageLengthTotal) (the fuselageSlenderness) 2) ))
    
  
  :objects
  ((""
    Hull :type 'geom-base:cylinder)
   
   (""
    Tailsect :type 'geom-base:cone)
   
   (""
    Nose :type 'geom-base:cone))
  
  
  :functions
  ())



