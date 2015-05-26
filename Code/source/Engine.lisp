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
  :length (the length)
  :radius (the radius)
  :center (the center))
  
  (cone
  :type 'cone
  :length (the length)
  :radius-1 (the radius)
  :radius-2 (half (the radius))
  :center (translate (the center) :rear (the length)))
  )
  
  
  :functions
  ())

