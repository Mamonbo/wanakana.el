(require 'wanakana)
(require 'wanakana-to-hiragana)
(require 'wanakana-hantei)


(defun wanakana-to-katakana (mozir &optional pass-romaji)
  (cond
   (pass-romaji (wanakana-hiragana-to-katakana mozir))
   ((or (wanakana-romajip mozir) (wanakana-mixedp mozir t))
    (wanakana-hiragana-to-katakana (wanakana-romaji-to-hiragana mozir))
    )
   (t (wanakana-hiragana-to-katakana mozir))
   )
  )
(provide 'wanakana-to-katakana)
