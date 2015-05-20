(in-package :gdl-user)

(define-object TailSurface (base-object)
  
  :documentation
  (:author "<name> (<username>@<organization>.com)"
   :description "")
  
  :input-slots
  ((""
    symmetry nil )
   
   (""
    area nil )
   
   (""
    AR nil )
   
   (""
    airfoil "NACA_0012_xyz.dat" )
   
   (""
   taper nil)
   
   (""
   dihedral 0)
   
	)
  
  
  :computed-slots
  (
  
    (""
    span (sqrt (* (the area) (the AR))))
	
	(""
	chordAverage (/ (the area) (the span)))
  
	(""
    chordRoot (/ (* 2 (the chordAverage)) (+ 1 (the taper)))) 
   
   (""
    chordTip (* (the chordRoot) (the taper)))
   
   (""
    rootCenter (translate (the center) :front (half (the chordRoot))) )
	
	(""
	sweepOffset (the (liftingSurface 0) sweepOffset))
)
  
  
  :objects
  (
  (liftingSurface :type 'WingTrunk
  :sequence (:size (if (the symmetry) 2 1))
  :side (ecase (the-child index) (0 :right) (1 :left))
  :chordRoot (the chordRoot)
  :chordTip (the chordTip)
  :span (if (the symmetry) (half (the span)) (the span))
  :airfoil (the airfoil) 
  :rootPoint (the rootCenter)
  :sweepLE 20
  :orientation (let* ((hinge (the (face-normal-vector (ecase (the-child side)
	(:right :front)
	(:left :rear)))))
	(right (rotate-vector-d (the (face-normal-vector (the-child side)))
	(the dihedral)
	hinge)))
	(alignment :right right
				:top (cross-vectors hinge right)
				:front (the (face-normal-vector :front))))
  )
  )
  
  :functions
  ())