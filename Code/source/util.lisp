;;; 
;;; This file contains utility functions used in the entire package.
;;;

(in-package :gdl-user)

;; --- angle manipulation ---

; converts radians to degrees
(defun radtodeg (r) (* 180.0 (/ r pi)))

; converts degrees to radians
(defun degtorad (d) (* pi (/ d 180.0)))


;; --- IS vs imperial conversion ---

; convert meter to ft
(defun m2ft (m) (* 3.28 m))

; convert m^2 to ft^2
(defun sqm2sqft (sqm) (* 10.7639104 sqm))

; convert kg to lb
(defun kg2lb (kg) (* 2.2 kg))

; convert lb to kg
(defun lb2kg (lb) (/ lb 2.2))

; convert from lbf to N
(defun lbf2N (lbf) (* 4.448222 lbf)) 



;; --- Input data reading functions ---

;; read string data - input file location - output list of strings read line by line from file
(defun readStringData (fileName)
  (with-open-file (in fileName)
    (let (result)
      (do ((line (read-line in nil nil) (read-line in nil nil)))
	  ((or (null line)(string-equal line ""))(nreverse result))
	(unless (char-equal (char line 0) #\;) (push line result)))
)))

;; split data - input string data list from readStringData - output same list, but with lines split in two strings
(defun splitData (dataList)
 (mapcar 'split dataList))

;; transData - transcribes a list of two strings into a keyword property pair e.g.: "wingspan" "10" to :wingspan 10
(defun transData (inputList)
  (list (make-keyword (first inputList)) (parser (first (last inputList)))
))

;; parser - reads from string while suppressing evaluation
(defun parser (string) 
 (let ((*read-eval* nil)) (with-input-from-string (stream string) (read stream)))
)

;; parseList - parses a list of strings using the parser function above
(defun parseList (list)
	(mapcar 'parser list)
)

;; basicDataReader - input file location - output property list plist of data file 
(defun basicDataReader (filename)
  (mapcan 'transData (splitData (readStringData filename)))
)

;; basicNumberReader - input file location - output list of parsed numbers
(defun basicNumberReader (filename)
	(mapcar 'parser (mapcan 'split (readStringData filename)))
)

;; pairList - function that pares the strings in a list with a given list of keywords
(defun pairWithKeyword (list)
	(pairlis '(:manufacturer :type :engineNumber :engineMounting :tailType :tailVolumeHorizontal :tailVolumeVertical) list)
)
				
				
;; databaseReader - made for reading in the aircraft database
(defun databaseReader (fileName)
 (mapcar 'alist2plistWorking (mapcar 'pairWithKeyword (mapcar 'parseList (splitData (readStringData fileName)))))
)

;; --- Math functions ---
(defun ! (n)
    (labels
        ((fact1 (n m)
             (if (zerop n)
                 m
                 (fact1 (1- n) (* m n)))))
    (fact1 n 1)))

;; --- GENDL bug fixes ---

(defun alist2plistWorking (alist)
  "Plist. Converts an assoc-list to a plist.
:arguments (alist \"Assoc-List\"). Supports both alists
with list syntax or dotted style notation. Examples:

gdl-user> (alist2plist '((:foo . 1) (:bar . 2)))
(:foo 1 :bar 2)

gdl-user> (alist2plist '((:foo 1) (:bar 2)))
(:foo 1 :bar 2)
"

  (when alist
    (cons (first (first alist))
          (cons
       ;; test cdr list syntax (1 2)
       ;; or dotted pair notation (1 . 2)
       (let ((token (rest (first alist))))
         (if (consp token)
         ;; list syntax
         (first token)
         ;; dotted pair
         token))
       ;; recurse
           (alist2plistWorking (rest alist)))))
)
