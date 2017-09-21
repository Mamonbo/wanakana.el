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

(defun wanakana-japanesep (mozir)
  (loop for ch in (wanakana-private-make-itrator mozir)
	always
	(wanakana-char-japanesep ch)
	)
  )

(defun wanakana-mixedp (mozir pass-kanji)
  ;; emacs lisp のオプショナル引数は省略すると nil
  ;; になるので使わなかった。
  ;; 存在するか なので一文字づつの処理ではなく、纏めて処理している
  (let
      ((mozir-list (wanakana-private-make-itrator mozir) ))
    (and
     (if pass-kanji t
       (loop for ch in mozir-list
	     never
	     (wanakana-char-kanjip ch)
	     )
       )
     (loop for ch in mozir-list
	   thereis
	   (wanakana-char-kanap ch)
	   )
     (loop for ch in mozir-list
	   thereis
	   (wanakana-char-romajip ch)
	   )
     
     )
    
    )
  )
;; alliases
(provide 'wanakana-hantei)
