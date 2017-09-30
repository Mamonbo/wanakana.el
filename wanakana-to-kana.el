(require 'wanakana)
(require 'wanakana-private)

(defun wanakana-chunk-to-kana (mozir)
  "wanakana-to-kana本体から呼び、chunkの候補を貰い、拾う文字数とひらが
  なのリストを返す 貰ったチャンクが駄目でも、後ろを切ったので再び探索
  する 小文字で来ることを前提にしている"
  ;; 4文字チャンクの処理(ltsu,chya,shya など)
  (let* ((chunk-size (length mozir))
	 (input-list (wanakana-private-make-itrator mozir))
	 (kana-char nil)
	 (precheck t)
	 (do-normal-check t)
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
	(when (string-equal (car input-list) "n")
	  (cond ((= chunk-size 2)
		 ;; IME mode でないときに、"n "のときは"ん "にする
		 (when (and (not wanakana-IME-mode)
			    (string-equal (cadr input-list) " "))
		   (setq kana-char "ん ")
		   (setq do-normal-check nil)
		   )
		 ;; IME mode のときに、"n'" のときは "ん" にする
		 (when (and wanakana-IME-mode
			    (string-equal mozir "n'"))
		   (setq kana-char "ん")
		   (setq do-normal-check nil)
		   )
		 )
		((= chunk-size 3)
		 ;; nn + 母音 のエッジケース を書くとしたらここに
		 (when (and (wanakana-char-consonatp (cadr
						      input-list)
						     nil )
			    (wanakana-char-vowelp (caddr
						   input-list)
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
	;; "Ttu" と入力すると、原作では 1,2文字目が違うので、"Tつ" と
	;; 出力される
	;; しかし、 "ッつ" の方が自然と思ったので、原作と異なる挙動に
	;; 変更した
	(when (and (>= chunk-size 2)
		   (not (string-equal (car input-list) "n"))
		   (wanakana-char-consonatp
		    (car input-list) t)
		   (string-equal (car input-list)
				 (cadr input-list))
		   )
	  (setq kana-char "っ")
	  (setq chunk-size 1)
	  (setq do-normal-check nil)
	  )
	)
      )

    (when do-normal-check
      ;; テーブルから探す
      (setq kana-char (cdr (assoc mozir
				  wanakana-from-romaji-cell-list)))
      )

    ;; 旧仮名に対応
    (when wanakana-use-obsolete-kana
      (cond ((string-equal kana-char "うぃ")
	     (setq kana-char "ゐ"))
	    ((string-equal kana-char "うぇ")
	     (setq kana-char "ゑ"))
	    )
      )
    
    (if kana-char
	(list chunk-size kana-char)
      (if (= chunk-size 1)
	  ;; どうにも見付からないときは素通りさせる
	  (list 1 mozir)
	;; 1 文字減らして再探索する
	(wanakana-chunk-to-kana (wanakana-private-get-chunk
				 input-list 0
				 (if (and (= chunk-size 4)
					  do-normal-check)
				     (- chunk-size 2)
				   (1- chunk-size)
				   )))
	)
      )
    )
  )

(defun wanakana-to-kana (mozir &optional ignore-case)
  "ignore-case 有効時には大文字で入力されても、ひらがなにされる"
  (let ((kaeshi "")
	(input-list (wanakana-private-make-itrator mozir))
	(input-lower-list  (wanakana-private-make-itrator (downcase mozir)))
	(input-length (length mozir))
	(cursor 0)
	(kana-char "")
	(chunk-size 0)
	(hiroi nil)
	)
    (while (< cursor input-length)
      
      (setq hiroi (wanakana-chunk-to-kana
		   (wanakana-private-get-chunk input-lower-list cursor
						  (min input-length
						       (+ cursor 4)) )))

      ;; IME mode では一部の条件で "n" を入力した傍から "ん" 変換され
      ;; るのを防止する
      (when (and wanakana-IME-mode
		 (string-equal (nth cursor input-lower-list) "n"))
	(when (or
	       ;; カーソルの末端のとき
	       (= cursor (1- input-length))
	       ;; "ny" で入力途中のとき
	       (and
		(string-equal (nth (1+ cursor) input-lower-list) "y")
		(not (wanakana-char-vowelp (nth (+ cursor 2)
					   input-lower-list) t))
		)
	       ;; カーソル戻して途中に "n" と入力したとき
	       (wanakana-char-kanap (nth (1+ cursor) input-lower-list))
	       )
	  ;; hiroi を偽装する
	  (setq hiroi '("n" 1))
	  )
	)
      (setq kana-char (cadr hiroi))
      
      ;; 1文字目が大文字だったら、カタカナにする
      (when (not ignore-case)
	(when (wanakana-char-uppercasep (nth cursor input-list))
	  (setq kana-char (wanakana-hiragana-to-katakana kana-char))
	  )
	)

      (setq kaeshi (concat kaeshi kana-char))
      (setq cursor (+ cursor (car hiroi)))
      )
    kaeshi
    )
  )


(provide 'wanakana-to-kana)
