(require 'wanakana-to-hiragana)

(let ((wanakana-use-obsolete-kana nil)
      )
  ;; wanakana-romaji-to-hiragana
  (assert (string-equal (wanakana-romaji-to-hiragana "hiragana")
			"ひらがな"))
  
  ;; wanakana-to-hiragana
  (assert (string-equal (wanakana-to-hiragana "toukyou, オオサカ")
			"とうきょう、 おおさか"))
  (assert (string-equal (wanakana-to-hiragana "only カナ" t)
			"only かな"))
    

  (assert (string-equal (wanakana-to-hiragana "wi") "うぃ"))
  (let ((wanakana-use-obsolete-kana t))
    (assert (string-equal (wanakana-to-hiragana "wi") "ゐ"))
    )
  )
