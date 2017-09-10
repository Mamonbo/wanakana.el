(require 'cl-lib)
(require 'wanakana)

;; wanakana-hiragana-to-katakana
;;hiragana only
(assert (string-equal (wanakana-hiragana-to-katakana "ひらがな") "ヒラ
ガナ"))
;;hiragana and alphabets
(assert (string-equal (wanakana-hiragana-to-katakana
		       "ひらがな is a type of kana")
		      "ヒラガナ is a type of kana")
	)

