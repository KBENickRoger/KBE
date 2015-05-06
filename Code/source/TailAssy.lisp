(in-package :gdl-user)

(define-object TailAssy (base-object)
  
  :input-slots
  ((tailType 1))
  
  
  :computed-slots
  ((surfaceHorizontal 100)
   (surfaceVertical 100)
   )
  
  
  :objects
  ((tailConventional :type 'tailConventional
		     :surfaceHorizontal (the surfaceHorizontal)
		     :surfaceVertical (the surfaceVertical)))
  
  
  :functions
  ())


