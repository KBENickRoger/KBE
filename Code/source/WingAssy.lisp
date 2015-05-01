(in-package :gdl-user)

(define-object WingAssy (base-object)
  
  :documentation
  (:author ""
   :description "")
  
  :input-slots
  (("Total wingspan in [m]"
    span 10)
   
   ("Position of the kink in the wing [%]"
    kinkPos 0.3)
   
   ("Length of the chord at the root of the wing [m]"
    chordRoot 2)
   
   ("Taper ratio []"
    taper 0.5)
   
   ("Dihedral angle []"
    dihedral 5)
   
   ("Wing configuration 1 low 2 mid 3 heigh"
    configuration 1)
)
  
  
  :computed-slots
  (
)
  
  
  :objects
  (("base-object box om positie van vleugel te laten zien"
    assyBox 
    :type 'box
    :length (the chordRoot)
    :width (the Span)
    :height 0)

   ("wing left (bakboord)"
    lWing :type 'MainWing)

   ("wing right (stuurboord"
    rWing :type 'MainWing)
)
  
  
  :functions
  ())


