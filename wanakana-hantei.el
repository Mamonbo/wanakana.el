(require 'cl-lib)
(require 'wanakana-private)


(defun wanakana-hiraganap (mozir)
  (loop for ch in (wanakana-private-make-itrator mozir)
	always
	(wanakana-private-betweenp ch "3040" "309F")
	)
  )
(defun wanakana-is-hiragana (mozir)
  (wanakana-hiraganap mozir)
  )


(provide 'wanakana-hantei)
