(in-package :gdl-user)

(define-object pairlisTest ()
:input-slots
((dataFolder *dataFolder*)
(aircraftDatabaseFilename "aircraftDatabase.dat"))

:computed-slots
((keys '(:manufacturer :type :engineNumber :engineMounting :tailType :tailVolumeHorizontal :tailVolumeVertical))
 (data '(boeing bla 3 2 3 0.82 0.110))
 (data2 (list '(boeing bla 3 2 3 0.82 0.110) '(airbus bloe 2 3 2 0.70 0.100)))
 (assocList (pairlis (the keys) (the data)))
 (propList (alist2plistWorking (the assocList)))
 (manufacturer (getf (the propList) :manufacturer))

 (assocList2 (mapcar 'pairWithKeyword (the data2)))
 (propList2 (mapcar 'alist2plistWorking (the assocList2)))

 (aircraftDatabaseFilePath (merge-pathnames (the aircraftDatabaseFilename) (the dataFolder)))
 (aircraftDatabase (databaseReader (the aircraftDatabaseFilePath)))
 (aircraftDatabase2 (mapcar 'pairWithKeyword (the aircraftDatabase)))
 (aircraftDatabase3 (mapcar 'alist2plistWorking (the aircraftDatabase2)))
)
 
)
