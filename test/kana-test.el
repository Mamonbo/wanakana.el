(require 'wanakana-to-kana)

(let ((wanakana-use-obsolete-kana nil))
  (assert (string-equal (wanakana-to-kana "onaji BUTTSUUJI") "おなじ ブッツウジ"))
  (assert (string-equal (wanakana-to-kana "ONAJI buttsuuji") "オナジ ぶっつうじ"))
  (assert (string-equal (wanakana-to-kana "座禅‘zazen’スタイル") "座禅「ざぜん」スタイル"))
  (assert (string-equal (wanakana-to-kana "batsuge-mu") "ばつげーむ"))
  ;; 約物の変換
  (assert (string-equal (wanakana-to-kana "!?.:/,~-‘’“”[](){}")
			"！？。：・、〜ー「」『』［］（）｛｝"))
  )

(let
    ((wanakana-use-obsolete-kana t))
  (assert (string-equal (wanakana-to-kana "we") "ゑ"))
  )

