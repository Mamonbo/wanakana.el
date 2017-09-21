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
(provide 'wanakana-private)
