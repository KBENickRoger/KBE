(in-package :gdl-user)

(define-object Engine (cylinder)
  
  :documentation
  (:author ""
   :description "")
  
  :input-slots
  ((length radius center ACy) 
   )
  
  
  :computed-slots
  (("Distance between engine center and AC"
  l_n (- (the ACy) (get-y (the center))))
  )
  
  
  
  :objects
  ((cylinder 
  :type 'cylinder
  :closed? t
  :length (the length)
  :radius (the radius)
  :center (the center))
  
  (cone
  :type 'cone
  :closed? t
  :length (the length)
  :radius-1 (the radius)
  :radius-2 (half (the radius))
  :center (translate (the center) :rear (the length)))
  
  (solid
    :type 'united-solid
    :display-controls (list :line-thickness 0.5)
    :brep (the cylinderSolid)
    :other-brep (the coneSolid))
  
  )
  
  
  :hidden-objects
  (
  (cylinderSolid
  :type 'cylinder-solid
  :length (the length)
  :radius (the radius)
  :center (the center))
  
  (coneSolid
  :type 'cone-solid
  :length (the length)
  :radius-1 (the radius)
  :radius-2 (half (the radius))
  :center (translate (the center) :rear (the length)))
  )
  
  
  
  :functions
  ()
  )

