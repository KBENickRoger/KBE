(in-package :gdl-user)

(define-object WingTrunk (box)
  
  :documentation
  (:author "Nick"
   :description "")
  
  :input-slots
  ((""
  chordRoot 1) 
  
  (""
  chordTip 1) 
  
  (""
  span 1)
  
  (""
  airfoil)
  
  (dataFolder *dataFolder*)
  (rootPoint)
  (sweepLE)
  (MACHidden? t)
  (side 0)
   )
  
  
  :computed-slots
  ((length (the chordRoot))
	(width (the span))
	(height (the thickness))
	(thickness 1)
	(center (translate-along-vector (the rootPoint)
			(the (face-normal-vector :right))
			(half (the span))))
	(sweepOffset (* (the span)(tan (degtorad (the sweepLE)))))
	(taper (/ (the chordTip) (the chordRoot)))
	
  
	("Trunk aerodynamic surface"
	surface (* (the span) (half (+ (the chordTip) (the chordRoot)))))
	
	("Trunk Cmac"
	Cmac (* (the chordRoot) (/ 2 3) 
			(/ (+ 1 (the taper) (expt (the taper) 2)) (+ 1 (the taper))))
	)
	
	("Trunk spanwise position of Cmac"
	YCmac (* (the span) (/ (- (the chordRoot) (the Cmac)) (- (the chordRoot) (the chordTip))))
	)
	
	)
  :objects
  ((box
	:type 'box
	:hidden? t
	)
	
	(profile 
	:type 'cst-curve
	:cst (basicNumberReader (merge-pathnames (the airfoil) (the dataFolder)))
	:hidden? t
	)
	
	(root-profile :type 'boxed-curve
	:curve-in (the profile)
	:orientation (alignment :top (the (face-normal-vector :right))
			:rear (the (face-normal-vector :top))
			:right (the (face-normal-vector :rear)))
	:scale-y (the chordRoot)
	:scale-x (/ (the chordRoot) (the profile chord))
	:center (the (edge-center :left :front))
	:hidden? t
	:display-controls (list :color :orange :transparency 0.7)
	)

	(tip-profile :type 'boxed-curve
	:curve-in (the profile)
	:orientation (alignment :top (the (face-normal-vector :right))
			:rear (the (face-normal-vector :top))
			:right (the (face-normal-vector :rear)))
	:scale-y (the chordTip)
	:scale-x (/ (the chordTip) (the profile chord))
	:center  (translate (the (edge-center :right :front)) :rear (the sweepOffset))
	:hidden? t
	)
	
	(loft :type 'lofted-surface
	:end-caps-on-brep? t
	:curves (list (the root-profile) (the tip-profile)))
	

	(MAC :type 'boxed-curve
	:curve-in (the profile)
	:orientation (alignment :top (the (face-normal-vector :right))
			:rear (the (face-normal-vector :top))
			:right (the (face-normal-vector :rear)))
	:scale-y (the Cmac)
	:scale-x (/ (the Cmac) (the profile chord))
	:center (translate (the rootPoint)
						:right (the YCmac)
						:rear (* (tan (degtorad (the sweepLE))) (the YCmac)) 
						:front (half (the chordRoot)))
	:hidden? (the MACHidden?)
	:display-controls (list :color :orange)
	)
	
	)
  
  :functions
  ()
  
  )