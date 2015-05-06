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
   )
  
  
  :computed-slots
  ((length (the chordRoot))
	(width (the span))
	(height (the thickness))
	(airfoilFile (merge-pathnames (the airfoil) (the dataFolder)))
	(pointsData (with-open-file (in (the airfoilFile)) (read in)))
	(thickness 1)
	(center (translate-along-vector (the rootPoint)
			(the (face-normal-vector :right))
			(half (the span))))
	)
  
  
  :objects
  ((box
	:type 'box)
	
	(profile 
	:type 'profile-curve
	:points-data (the pointsData)
	:hidden? nil
	)
	
	(root-profile :type 'boxed-curve
	:curve-in (the profile)
	:orientation (alignment :top (the (face-normal-vector :right))
			:rear (the (face-normal-vector :top))
			:right (the (face-normal-vector :rear)))
	:scale-y (/ (the thickness) (the profile max-thickness))
	:scale-x (/ (the chordRoot) (the profile chord))
	:center (the (edge-center :left :front))
	:hidden? nil
	:display-controls (list :color :orange :transparency 0.7)
	)

	(tip-profile :type 'boxed-curve
	:curve-in (the profile)
	:orientation (alignment :top (the (face-normal-vector :right))
			:rear (the (face-normal-vector :top))
			:right (the (face-normal-vector :rear)))
	:scale-y (/ (the thickness) (the profile max-thickness))
	:scale-x (/ (the chordTip) (the profile chord))
	:center  (the (edge-center :right :front))
	:hidden? nil
	)
	
	(loft :type 'lofted-surface
	:end-caps-on-brep? t
	:curves (list (the root-profile) (the tip-profile)))
	)  
  
  :functions
  ())

  
  
(define-object profile-curve (fitted-curve)
  :input-slots (points-data)
  
  :computed-slots 
  (
  (center (make-point 0 0 0))
  (data-name (string-append (first (the points-data))
							(second (the points-data))))

	(point-coordinates (rest (rest (the points-data))))

(x-coords (plist-keys (the point-coordinates)))
(y-coords (plist-values (the point-coordinates)))

(max-x (most 'get-x (the points)))
(min-x (least 'get-x (the points)))
(max-y (most 'get-y (the points)))
(min-y (least 'get-y (the points)))

(chord (- (get-x (the max-x))
(get-x (the min-x))))

(max-thickness (- (get-y (the max-y))
(get-y (the min-y))))

(points (mapcar #'(lambda(x y) (make-point x y 0))
(the x-coords)
(the y-coords)))))

