(in-package :kbe)

(define-object ConTail (Tail)
  
  :documentation
  (:author "<name> (<username>@<organization>.com)"
   :description "")
  
  :input-slots
  ((TaperHor :settable)
  ()
  )
  
  
  :computed-slots
  ((SurfaceAreaHor ())
  (SurfaceAreaVert))
  
  
  :objects
  ((""
    wingTrunk :type 'WingTrunk))
  
  
  :functions
  ())

