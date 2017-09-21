(require 'cl-lib)


(defun wanakana-hiraganap (mozir)
  (loop for ch in (wanakana-private-make-itrator mozir)
	always
	(assoc ch wanakana-to-romaji-cell-list)
	)
  )
(defun wanakana-is-hiragana (mozir)
  (wanakana-hiraganap mozir)
  )

(provide 'wanakana-hantei)
