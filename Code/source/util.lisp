;;; 
;;; This file contains utility functions used in the entire package.
;;;

(in-package :gdl-user)


;; Input data reading functions

;; read string data - input file location - output list of strings read line by line from file
(defun readStringData (fileName)
  (with-open-file (in fileName)
    (let (result)
      (do ((line (read-line in nil nil) (read-line in nil nil)))
	  ((or (null line)(string-equal line ""))(nreverse result))
	(push line result))
)))

(defun splitData (dataList)
 (mapcan 'split dataList))
