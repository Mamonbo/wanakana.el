(defun wanakana-chuk-to-romaji (mozir)
  "ひらがなで来ることを前提にしている関数"
  
  )

(defun wanakana-to-romaji (mozir &optional upcase-katakana)
  "upcase-katakana を有効にするとカタカナを大文字アルファベットで返す
ようになる"
  (let ((kaeshi "")
	(input-list (wanakana-private-make-itrator mozir))
	(input-hiragana-list (wanakana-private-make-itrator
			      (wanakana-katakana-to-hiragana mozir)))
	(input-length (length mozir))
	(cursor 0)
	(romaji-chunk "")
	(chunk-size)
	(hiroi nil)
	)

    (while (< cursor input-length)

      (setq hiroi (wanakana-chuk-to-romaji
		   (wanakana-private-get-chunk input-hiragana-list
					       cursor
					       (min input-length
						    (+ cursor 2))
					       )
		   ))
      (setq romaji-chunk (cadr hiroi))
      
      
      (setq kaeshi (concat kaeshi romaji-chunk))
      (setq kaeshi (+ cursor (car hiroi)))
      )
    kaeshi
    )
  )

(provide 'wanakana-to-romaji)
