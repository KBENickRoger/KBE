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
    airfoil "naca0012_cst.dat")
   
   (""
   taper nil)
   
   (""
   dihedral 0)
   
   (MACHidden? t)
   
   (horizontalSweepLE)
   
   (tailSurfaceType)
   
   (""
   Vh_V nil)
   
   (Eta 0.95)
   
   (mach nil)
   
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
	
	("Lift gradient horizontal tailSurface"
	 CLalpha (ecase (the tailSurfaceType)
				(1 (/ (* 2 pi (the AR)) (+ 2 (sqrt(+ 4 (* (expt (/ (* (the AR) (the BetaH)) (the Eta)) 2)) (+ 1 (/ (expt (tan (the wingSweep05)) 2) (expt (the BetaH) 2)))))) ) )
				(2 nil)))
				
	 ("Prandtl-Glauert correction at tail"
	BetaH (ecase (the tailSurfaceType)
				(1 (sqrt(- 1 (expt (* (the Vh_V) (the mach)) 2))))
				(2 nil)))
	 
	 ("sweep horizontal tail at half chord"
	 Sweep05 (asin (/ (+ (- (the chordTip) (the chordRoot)) (* (the span) (sin (degrees-to-radians (horizontalSweepLE))))) (the span))))
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
  :sweepLE (ecase (the tailSurfaceType)
				(1 (horizontalSweepLE))
				(2 37))
  :orientation (let* ((hinge (the (face-normal-vector (ecase (the-child side)
	(:right :front)
	(:left :rear)))))
	(right (rotate-vector-d (the (face-normal-vector (the-child side)))
	(the dihedral)
	hinge)))
	(alignment :right right
				:top (cross-vectors hinge right)
				:front (the (face-normal-vector :front))))
	:MACHidden? (the MACHidden?)
  )
    
  )
  
  :functions
  ())