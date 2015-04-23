(in-package :gdl-user)

(define-object Engine (cylinder)
  
  :documentation
  (:author "Nick"
   :description "23-4 Nick: made a simple cylider engine")
  
  :input-slots
  (engineLength engineDiameter)
  
  
  :computed-slots
  ((length (the engineLength))
   (radius (half (the engineDiameter)))
  )
  
  
  :objects
  ()
  
  
  :functions
  ())

