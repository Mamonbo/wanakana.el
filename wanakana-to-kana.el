(require 'wanakana)
(require 'wanakana-private)

(defun wanakana-chunk-to-kana (mozir)
  "wanakana-to-kana本体から呼び、chunkの候補を貰い、拾う文字数とひらが
  なのリストを返す 貰ったチャンクが駄目でも、後ろを切ったので再び探索
  する"
  ;; 4文字チャンクの処理(ltsu,chya,shya など)
  (let* ((chunk-size (length mozir))
	 (chunk-lowercase (downcase mozir))
	 (chunk-lowercase-list (wanakana-private-make-itrator chunk-lowercase))
	 (kana-char "")
	 (input-list (wanakana-private-make-itrator mozir))
	 (precheck t)
	 )
    (if (= chunk-size 4)
	(let ((consonant (wanakana-private-get-chunk input-list 0 3)))
	  (setq do-normal-check (member consonant
					wanakana-four-char-edgecases-list))
	  ;; 駄目なのが分ったら早めに処理をスキップする
	  )
      (progn
	;; n + 子音(yを除く)のとき、"ん"を出して抜ける
	;; 一般的なIMEで使える "nn" での "ん" は使用出来ず
	;; 例えば "nna" は "んな" と表示される
	;; 代わりに "n'" と入力する
	(when (string-equal (car chunk-lowercase-list) "n")
	  (cond ((= chunk-size 2)
		 ;; IME mode でないときに、"n "のときは"ん "にする
		 (when (and (not wanakana-IME-mode)
			    (string-equal (cadr chunk-lowercase-list) " "))
		   (setq kana-char "ん ")
		   (setq do-normal-check nil)
		   )
		 ;; IME mode のときに、"n'" のときは "ん" にする
		 (when (and wanakana-IME-mode
			    (string-equal chunk-lowercase "n'"))
		   (setq kana-char "ん")
		   (setq do-normal-check nil)
		   )
		 )
		((= chunk-size 3)
		 ;; nn + 母音 のエッジケース を書くとしたらここに
		 (when (and (wanakana-char-consonatp (cadr
						      chunk-lowercase-list)
						     nil )
			    (wanakana-char-vowelp (caddr
						   chunk-lowercase-list)
						  t)
			    )
		   (setq kana-char "ん")
		   (setq chunk-size 1)
		   (setq do-normal-check nil)
		   )
		 )
		)
	  )
	;; 子音を重ねることで促音を出す
	;; 変換表に無いので処理をする
	(when (and (>= chunk-size 2)
		   (not (string-equal (car chunk-lowercase-list) "n"))
		   (wanakana-char-consonatp
		    (car chunk-lowercase-list) t)
		   (string-equal (car chunk-lowercase-list)
				 (cadr chunk-lowercase-list))
		   )
	  (setq kana-char "っ")
	  (setq chunk-size 1)
	  (setq do-normal-check nil)
	  )
	)
      )

    (when do-normal-check
      ;; テーブルから探す
      )

    (if kana-char
	(list chunk-sise kana-char)
      (if (= chunk-size 1)
	  ;; どうにも見付からないときは素通りさせる
	  (list 1 mozir)
	;; 1 文字減らして再探索する
	(wanakana-chunk-to-kana (wanakana-private-get-chunk
				 input-list 0
				 (if (= chunk-size 4) (- chunk-size 2)
				   (1- chunk-size)
				   )))
	)
      )
    )
  )

(defun wanakana-to-kana (mozir &optional ignore-case)
  "ignore-case 有効時には大文字で入力されても、ひらがなにされる"
  ;; STARTED:卑賤しい命令型のコードを関数型にする
  (let ((kaeshi-kana-list () )
	(input-list (wanakana-private-make-itrator mozir))
	(input-length (length mozir))
	(cursor 0)
	(chunk "")
	(chunk-lowercase "")
	(kana-char "")
	(chunk-size 0)
	(precheck t)
	)
    (while (< cursor input-length)
      (setq kana-char "")
      (setq chunk-size (min 4 (- input-length cursor) ))
      (while (> chunk-size 0)
	(setq chunk (wanakana-private-get-chunk
		     input-list cursor (+ cursor chunk-size)))
	(setq chunk-lowercase (downcase chunk))


	(if (= chunk-size 4)
	    (let ((consonant (downcase (wanakana-private-get-chunk
					input-list cursor (+ cursor 3))) ))
	      (setq do-nomal-check
		    (member consonant
			    wanakana-four-char-edgecases-list)
		    )
	      )
	  (progn
	    ;; n + 子音(yを除く)のとき、"ん"を出して抜ける
	    (setq do-nomal-check t)
	    (when (string-equal (car (wanakana-private-make-itrator
				    chunk-lowercase)) "n")
	      (when (= chunk-size 2)
		;; IME mode でないときに、"n "のときは"ん "にする
		(when (and (not wanakana-IME-mode)
		     (string-equal (cadr (wanakana-private-make-itrator
					  chunk-lowercase))
				   " "))
		  (setq kana-char "ん ")
		  (setq do-normal-check nil)
		  )

		;; IME mode のときに、"n'" のときは "ん" にする
		(when (and wanakana-IME-mode (string-equal
					      chunk-lowercase "n'"))
		  (setq kana-char "ん")
		  (setq do-normal-check nil)
		  )
		)
	      ;; nn + 母音 のエッジケース
	      (when (and (wanakana-char-consonatp
			  (cadr (wanakana-private-make-itrator
				 chunk-lowercase)) nil )
			 (wanakana-char-vowelp
			  (caddr (wanakana-private-make-itrator
				  chunk-lowercase)) t ))
		(setq chnuk-size 1)
		(setq chunk )
		  )
	      )
	    )
	  )

	(when do-normal-check
	  
	  )
	(if (string-equal kana-char "")
	    ;; fail
	    (if (= chunk-size 4)
		(setq chunk-size 2)
	      (setq chunk-size (1- chunk-size))
	      )
	  ;; success
	  (setq chunk-size -1)
	  )
	)

      ;; 最後まで駄目だったら、仕方無いのでアルファベットのまま表示す
      ;; る
      (when (kana-char "")
	(setq kana-char chunk)
	)

      ;; 旧仮名に対応
      (when wanakana-use-obsolete-kana
	(cond ((string-equal chunk-lowercase "wi")
	       (setq kana-char "ゐ"))
	      ((string-equal chunk-lowercase "we")
	       (setq kana-char "ゑ"))
	      )
	)
      )
    (apply 'concat kaeshi-kana-list)
    )
  )


(provide 'wanakana-to-kana)
