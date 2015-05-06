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
   
   (wingVerticalShift 0)
   
   (""
    wingPositioning (make-point 0 0 0))
	
	(""
	airfoil)
	
	(""
	sweepLE)
)
  
  
  :computed-slots
  ( 
	(center (translate (the wingPositioning) :up (the wingVerticalShift)))
	(chordTip (* (the taper)(the chordRoot)))
)
  
  
  :objects
  (("base-object box om positie van vleugel te laten zien"
    assyBox 
    :type 'box
    :length (the chordRoot)
    :width (the Span)
    :height 0
    :center (the center)
	:hidden? t
	)
   
   ("Wings!"
    wing 
	:type 'MainWing
	:sequence (:size 2)
	:side (ecase (the-child index) (0 :right) (1 :left))
	:span (half (the span))
	:chordRoot (the chordRoot)
	:chordTip (the chordTip)
	:kinkPos (the kinkPos)
	:rootPoint (the center)
	:airfoil (the airfoil)
	:sweepLE (the sweepLE)
	
	;;
	;; Left wing will get a left-handed coordinate system and be a mirror of the right.
	;;
	:orientation (let* ((hinge (the (face-normal-vector (ecase (the-child side)
	(:right :front)
	(:left :rear)))))
	(right (rotate-vector-d (the (face-normal-vector (the-child side)))
	(the dihedral)
	hinge)))
	(alignment :right right
				:top (cross-vectors hinge right)
				:front (the (face-normal-vector :front)))))
)
  
  
  :functions
  ())


