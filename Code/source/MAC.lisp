(in-package :gdl-user)

(define-object MAC (base-object)

:input-slots
(
  (airfoil)
  (dataFolder *dataFolder*)
  (Cmac)

)

:computed-slots
()

:objects
(

	(profile 
	:type 'cst-curve
	:cst (basicNumberReader (merge-pathnames (the airfoil) (the dataFolder)))
	:hidden? t
	)
	
	(MAC :type 'boxed-curve
	:curve-in (the profile)
	:orientation (alignment :top (the (face-normal-vector :right))
			:rear (the (face-normal-vector :top))
			:right (the (face-normal-vector :rear)))
	:scale-y (the Cmac)
	:scale-x (/ (the Cmac) (the profile chord))
	:center (the center)
	:hidden? nil
	:display-controls (list :color :orange)
	)

)




)