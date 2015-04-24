(in-package :gdl-user)

(define-object WingAssy ()
  
  :documentation
  (:author "<name> (<username>@<organization>.com)"
   :description "")
  
  :input-slots
  ((""
    wingSpan nil #|todo: default value|#)
   
   (""
    wingKinkPos nil #|todo: default value|#)
   
   (""
    wingRootChord nil #|todo: default value|#)
   
   (""
    wingTaper nil #|todo: default value|#)
   
   (""
    wingDihedral nil #|todo: default value|#))
  
  
  :computed-slots
  ((""
    wingTipChord (* (the wingRootChord) (the wingTaper))))
  
  
  :objects
  ((""
    wingTrunk :type 'WingTrunk))
  
  
  :functions
  ())


