(require 'cl-lib)
(require 'wanakana-private)

(defun wanakana-katakana-to-hiragana (kata)
  "
カタカナをひらがなに変換する
こちらはバッテリー付属案件とまでは行かない
ー をひらがなに戻す作業がある
"
  (let* ((han (japanese-katakana kata))
	 (prev-kana nil)
	 (han-itrator (wanakana-private-make-itrator han))
	 (kaeshi nil)
	 )

    (loop for ch in han-itrator
	  collect (cond
		   ((or (string-equal ch "ー") (string-equal ch "〜"))
		    (if (wanakana-hiraganap prev-kana)
			;; decode long vowel
			;; ひらがなをローマ字に落してから最後の1文字を
			;; 取ってひらがなに戻す
			(let
			    ((romaji-itrator
			      (wanakana-private-make-itrator
			       (cdr (assoc ch wanakana-to-romaji-cell-list)))))
			  (cdr (assoc
			   (nth (1- (length romaji-itrator))
				romaji-itrator)
			   
			   wanakana-long-vowels-cell-list
			   ))
			  )
			;; path through
			ch
		      )
		    )
		   ((and (wanakana-hiraganap ch)
			 (not (member ch wanakana-zenkaku-yakumono-list)))
		    (setq prev-kana ch)
		    ch
		    )
		   (t
		    (setq prev-kana nil)
		    ch
		    )
		   )
	  )
    )
  )
