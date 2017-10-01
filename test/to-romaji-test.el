(require 'wanakana-to-romaji)
(require 'cl-lib)

(assert (string-equal (wanakana-to-romaji "ひらがな カタカナ")
		      "hiragana katakana"))
(assert (string-equal (wanakana-to-romaji "ひらがな カタカナ" t)
		      "hiragana KATAKANA"))
