(require 'wanakana-to-katakana)


(let ((wanakana-use-obsolete-kana nil)     
      )
  (assert (string-equal (wanakana-to-katakana "toukyou, おおさか")
			"トウキョウ、 オオサカ"))
  (assert (string-equal (wanakana-to-katakana "only かな" t)
			"only カナ"))
  (assert (string-equal (wanakana-to-kana "wi") "ウィ"))

  (setq wanakana-use-obsolete-kana t)
  (assert (string-equal (wanakana-to-kana "wi") "ヰ"))
  )
