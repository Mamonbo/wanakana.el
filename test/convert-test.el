(require 'cl-lib)
(require 'wanakana)

;; wanakana-hiragana-to-katakana
;;hiragana only
(assert (string-equal (wanakana-hiragana-to-katakana "ひらがな")
		      "ヒラガナ"))
;;hiragana and alphabets
(assert (string-equal (wanakana-hiragana-to-katakana
		       "ひらがな is a type of kana")
		      "ヒラガナ is a type of kana")
	)

;; wanakana-katakana-to-hiragana
;; katakana only
(assert (string-equal (wanakana-katakana-to-hiragana "カタカナ")
		      "かたかな"))
;; katakana and alphabet
(assert (string-equal (wanakana-katakana-to-hiragana
		       "カタカナ is a type of kana")
		      "かたかな is a type of kana"))

;; "ー"のデコード(読み仮名的な利用法か)
;; "お"の後の長音が"う"になるのは意図的
(assert (string-equal (wanakana-katakana-to-hiragana
		       "オートミール")
		      "おうとみいる"))
