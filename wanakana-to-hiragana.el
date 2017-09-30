(require 'wanakana-to-kana)
(require 'wanakana-hantei)

(defun wanakana-romaji-to-hiragana (mozir)
  (wanakana-to-kana mozir t) ; 強制的にひらがなにするために
			     ; ignore-case を立てる
  )

(defun wanakana-to-hiragana (mozir &optional pass-romaji)
  (cond
   (pass-romaji (wanakana-katakana-to-hiragana mozir))
   ((wanakana-romajip mozir) (wanakana-romaji-to-hiragana mozir))
   ((wanakana-mixedp mozir t)
    (wanakana-romaji-to-hiragana (wanakana-katakana-to-hiragana
				  mozir)))
   (t (wanakana-katakana-to-hiragana mozir))
   )
   
  )


(provide 'wanakana-to-hiragana)
