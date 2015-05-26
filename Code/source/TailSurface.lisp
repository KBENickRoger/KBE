(in-package :gdl-user)

(define-object TailSurface (base-object)
  
  :documentation
  (:author "<name> (<username>@<organization>.com)"
   :description "")
  
  :input-slots
  (
	(""
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
   
   (""
   MACHidden? t)
   
   (""
   horizontalSweepLE)
   
   (""
   tailSurfaceType 1)
   
   (""
   Vh_V 1)
   
   (""
   Eta 0.95)
   
   (""
   mach 1)
   
   (""
   weightParams nil)
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
				(1 (/ (* 2 pi (the AR)) (+ 2 (sqrt(+ 4 (* (expt (/ (* (the AR) (the BetaH)) (the Eta)) 2)) (+ 1 (/ (expt (tan (the Sweep05)) 2) (expt (the BetaH) 2)))))) ) )
				(2 0)))
				
	 ("Prandtl-Glauert correction at tail"
	BetaH (ecase (the tailSurfaceType)
				(1 (sqrt(- 1 (expt (* (the Vh_V) (the mach)) 2))))
				(2 0)))
	 
	 ("sweep horizontal tail at half chord"
	 Sweep05 (asin (/ (+ (- (the chordTip) (the chordRoot)) (* (the span) (sin (degrees-to-radians (the horizontalSweepLE))))) (the span))))
	 
	 ("Tail weight calculator"
	 weight (ecase (the tailSurfaceType)
			 (1 (the (WHorizontal)))
			 (2 (the (WVertical)))))
	 
	 ;; get the weight params out of the list for easier reading later
	 (FW (getf (the weightParams) :FW))
	 (Wdg (getf (the weightParams) :Wdg))
	 (Nz (getf (the weightParams) :Nz))
	 (Lt (getf (the weightParams) :Lt))
	 (ky (getf (the weightParams) :ky))
	 (kz (getf (the weightParams) :kz))
	 (se_sh (getf (the weightParams) :se_sh))
	 (Ht_Hv (getf (the weightParams) :Ht_Hv))
	 (wingSweepQCrad (asin (/ (+ (half (- (the chordTip) (the chordRoot))) (* (the span) (sin (degrees-to-radians (ecase (the tailSurfaceType) (1 (the horizontalSweepLE))(2 37)))))) (the span))))
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
				(1 (the horizontalSweepLE))
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
  (
  (WHorizontal ()
  (* 			0.0379 1 	
				(expt (+ 1 (/ (the FW) (the span))) -0.25) 
				(expt (the Wdg) 0.639) 
				(expt (the Nz) 0.1) 
				(expt (the area) 0.75)
				(expt (the Lt) -1)
				(expt (the ky) 0.704)
				(expt (cos (the wingSweepQCrad)) -1)
				(expt (the AR) 0.166)
				(expt (+ 1 (the se_sh)) 0.1))
  )
  
  (WVertical ()
  (*			0.0026
				(expt (+ 1 (the Ht_Hv)) 0.225)
				(expt (the Wdg) 0.556)
				(expt (the Nz) 0.536)
				(expt (the Lt) -0.5)
				(expt (the area) 0.5)
				(expt (the AR) 0.35)
				(expt (the (liftingSurface 0) profile max-thickness) -0.5))
  
  )
  
  )
  
  )
  
  
  
  