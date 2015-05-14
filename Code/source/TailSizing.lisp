(in-package :gdl-user)

(define-object TailSizing ()
  
  :documentation
  (:author "Roger & Nick)"
   :description "File to size the tail from statistical data input, by means of selecting appropriate aircraft and averaging their tail volume coefficients")
  
  :input-slots
  ((input)
   (database)
  )
  
  
  :computed-slots
  ( 
  (selection (select (where :engineNumber (the input engineNumber) :engineMounting (the input engineMounting) :tailType (the input tailType)) (the database)))
  
  
  ;Selection function to use only appropriate aircraft
  ;Still needs accounting for C, H or Vtail (no matching tails)
  ;(tailVolHor (mapcan #'(if (and (:num = (the EngineNum)) (:pos = (the EnginePos)) (:tail = (the tailType))) (append :volume 'VolumelistH)) 'InputdataTailVolHor))
  
  ; Average tailvolume coefficient
  ;("Statistically based Horizontal Tail volume Coefficient"
   ; tailVolHor (/ (sum-elements (the VolumelistH)) (:length (the VolumelistH)) ))
   
  ; ("Statistically based Vertical Tail volume Coefficient"
  ;  tailVolVer (/ (sum-elements (the VolumelistV)) (:length (the VolumelistV)) ))

  (tailVolumeHorizontal (/ (sumParameter :tailVolumeHorizontal (the selection)) (length (the selection))))
  (tailVolumeVertical (/ (sumParameter :tailVolumeVertical (the selection)) (length (the selection))))
  )
  
  :objects
  ()
  
  
  :functions
  ( )
  
  
  )

  (defun select (selector-fn db)
	(remove-if-not selector-fn db))

  (defun where (&key engineNumber engineMounting tailType)
	#'(lambda (entry)
		(and
		(if engineNumber (= (getf entry :engineNumber) engineNumber) t)
		(if engineMounting (= (getf entry :engineMounting) engineMounting))
		(if tailType (= (getf entry :tailType) tailType))))
	)
	
	(defun sumParameter (parameter list)
		(if (null list) 0 
			(+ (getf (first list) parameter) (sumVolume (rest list)))
		)
	)