(in-package :gdl-user)


(define-object points-curve (fitted-curve)

  :input-slots (points-data)
  
  :computed-slots 
  (
  (center (make-point 0 0 0))
  (orientation nil)
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

