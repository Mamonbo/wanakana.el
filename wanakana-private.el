(defun wanakana-private-make-itrator (mozir)
  (mapcar 'char-to-string (append mozir nil))
  )

(defun wanakana-private-betweenp (ch lower-hex-string upper-hex-string)
  (let ((chnum (string-to-char ch))
	(lower-num (string-to-number lower-hex-string 16))
	(upper-num (string-to-number upper-hex-string 16))
	)
    (and (>= chnum lower-num) (<= chnum upper-num))
    )
  )

(defun wanakana-private-get-chunk (lst st ed)
  "chunk 用のリストlstのst番目からed番目を半開区間で返す 返すときは次
の処理を考え、文字列を結合する"
  (apply 'concat
	 (loop for idx from st below ed
	       collect (nth idx lst))
	 )
    )
(provide 'wanakana-private)
