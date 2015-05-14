(in-package :gdl-user)

(define-object pairlisTest ()
:input-slots
()

:computed-slots
((keys '(:manufacturer :type :engineNumber :engineMounting :tailType :tailVolumeHorizontal :tailVolumeVertical))
 (data '("boeing" "bla" 3 2 3 0.82 0.110))
 (assocList (pairlis (the keys) (the data)))
 (propList (alist2plistWorking (the assocList)))
 (manufacturer (getf (the propList) :manufacturer))
)
 
)

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
           (alist2plistWorking (rest alist))))))


