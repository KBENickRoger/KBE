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
  (dihedral 0)
  (MACHidden? t)
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
	
	
	(flatCurve
	:type 'flat-curve
	:inputCurve (first (the straightCurve b-spline-data-list))
	:display-controls (list :color :red)
	)
	
	(airfoil-curve-object :type 'b-spline-curve
		       :control-points (the flatCurve control-points)
	)
	
	(intersection :type 'brep-intersect
    :brep (the loft brep)
    :other-brep (the intersectionSurface brep)
	:display-controls (list :color :green))
	
	(straightCurve 
	:type 'boxed-curve
	:curve-in (the intersection (edges 0))
	:display-controls (list :color :blue)
	:orientation (alignment :top   (rotate-vector-d (the (face-normal-vector :top)) (the dihedral) (the (face-normal-vector :rear)))
							:right (rotate-vector-d (the (face-normal-vector :right)) (- 0 (the sweepLE)) (the (face-normal-vector :top)))
							))
	
	;; xfoil class to obtain a set of polars for one airfoil for a given range of alpha's (Cl-alpha, Cd-alpha, Cm-alpha, Xtr-alpha)
	(xfoil-polar :type 'xfoil-analysis-polar         
	      :curve-in (the airfoil-curve-object) ;; specify the 2D airfoil curve object that you want to analyze: should be defined in x-y plane, 
	                                           ;; chord parallel to x-axis, LE pointing to the negative x-direction
	      
	      :data-folder *xfoil-folder*  ;;specify the location of the xfoil.exe program file
	      :mach-number 0
	      :reynolds-number 10E6
	      :lower-alfa -4                 ;; starting alpha of requested polar, [deg]
	      :upper-alfa 14                 ;; final alpha of requested polar, [deg]
	      :alfa-increment 0.5)          ;; alpha increment of requested polar, [deg]


	;; xfoil class to analyse a single operating point of an airfoil at a given alpha (Cl, Cd, Cm, boundary layer properties)
	(xfoil-point :type 'xfoil-analysis-pointBL
	      :curve-in (the airfoil-curve-object)  ;;see above
	      :data-folder *xfoil-folder*           ;;specify the location of the xfoil.exe program file
	      :mach-number 0
	      :reynolds-number 10E6
	      :alfa-in 3)   ;; angle-of-attack for which to analyse airfoil, [deg]
	
	)

	
	:hidden-objects
	(
	(intersectionSurface 
	:type 'rectangular-surface
	:center (the center)
	:orientation (alignment :right (the (face-normal-vector :top))
							:top (rotate-vector-d (the (face-normal-vector :right)) (the sweepLE) (the (face-normal-vector :top))))
	:length (* 2 (the chordRoot))
	:width (the chordRoot))
	


	
	)
  
  :functions
  ()
  
  )
  
  (define-object boxed-curve-axis (boxed-curve  axis-system-mixin))
  
  (define-object flat-curve (fitted-curve)
  :input-slots
  (inputCurve)
  
  :computed-slots
  (
  (x-coords (mapcar 'get-y (the inputCurve)))
  (y-coords (mapcar 'get-z (the inputCurve)))
  
  (LEpoint (least 'get-x (the flatpoints)))
  (x-shift (get-x (the LEpoint)))
  (y-shift (get-y (the LEpoint)))
  
  (x-coords2 (mapcar #'(lambda (point) (- (get-x point) (the x-shift))) (the flatpoints)))
  (y-coords2 (mapcar #'(lambda (point) (- (get-y point) (the y-shift))) (the flatpoints)))
  
  (points (mapcar #'(lambda(x y) (make-point x y 0))
  (the x-coords)
  (the y-coords)))
  
  (flatpoints (mapcar #'(lambda(x y) (make-point x y 0))
  (the x-coords)
  (the y-coords)))
  
  (otherpoints (mapcar #'(lambda(x y) (make-point x y 0))
  (the x-coords2)
  (the y-coords2)))
  
  )
  
  )
  