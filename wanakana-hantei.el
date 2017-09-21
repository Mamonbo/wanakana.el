(require 'cl-lib)
(require 'wanakana-private)
(require 'wanakana-char-hantei)

(defun wanakana-hiraganap (mozir)
  (loop for ch in (wanakana-private-make-itrator mozir)
	always
	(wanakana-char-hiraganap ch)
	)
  )
(defun wanakana-is-hiragana (mozir)
  (wanakana-hiraganap mozir)
  )


(defun wanakana-katakanap (mozir)
  (loop for ch in (wanakana-private-make-itrator mozir)
	always
	(wanakana-char-katakanap ch)
	)
  )

(defun wanakana-kanap (mozir)
  (loop for ch in (wanakana-private-make-itrator mozir)
	always
	(wanakana-char-kanap ch)
	)
  )

(defun wanakana-romajip (mozir)
  (loop for ch in (wanakana-private-make-itrator mozir)
	always
	(wanakana-char-romajip ch)
	)
  )

(defun wanakana-char-kanjip (mozir)
  (loop for ch in (wanakana-private-make-itrator mozir)
	always
	(wanakana-char-kanjip ch)
	)
  )
;; alliases
(provide 'wanakana-hantei)
