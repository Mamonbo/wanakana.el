(defun wanakana-private-make-itrator (mozir)
  (mapcar 'char-to-string (append mozir nil))
  )

(provide 'wanakana-private)
