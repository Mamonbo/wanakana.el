;; 判定ロジックが各関数毎に微妙に異なるのでそれぞれの関数を書いてある
;; private 関数の方針なので、is-hoge の方は提供しない
;; (全文字判定の方で代用出来るからね)

(require 'wanakana-private)
(defun wanakana-char-hiraganap (ch)
  (or
   (string-equal ch "ー")
   (wanakana-private-betweenp ch "3041" "3096")
   )
  )


(defun wanakana-char-katakanap (ch)
  (wanakana-private-betweenp ch "30A1" "30FC")
  )

(defun wanakana-char-kanap (ch)
  (or
   ;; ひらがな
   (wanakana-char-hiraganap ch)
   ;; カタカナ
   (wanakana-char-katakanap ch)
   ;; 句読点
   (wanakana-private-betweenp ch "FF61" "FF65")
   ;; 半角カナ
   (wanakana-private-betweenp ch "FF66" "FF9F")
   )
  )

(defun wanakana-char-romajip (ch)
  (or
   ;; 普通のアルファベット(制御文字付き)
   (wanakana-private-betweenp ch "0000" "007F")
   ;; ヘボン式で使う長音付き母音
   (wanakana-private-betweenp ch "0100" "0101"); Ā ā
   (wanakana-private-betweenp ch "0112" "0113"); Ē ē
   (wanakana-private-betweenp ch "012A" "012B"); Ī ī
   (wanakana-private-betweenp ch "014C" "014D"); Ō ō
   (wanakana-private-betweenp ch "016A" "016B"); Ū ū
   
   ;; 所謂かっこいい引用符
   (wanakana-private-betweenp ch "2018" "2019")
   (wanakana-private-betweenp ch "201C" "201D")
   )
  )

(defun wanakana-char-kanjip (ch)
  (wanakana-private-betweenp ch "4E00" "9FAF")
  )

(defun wanakana-char-japanesep (ch)
  (or
   ;; ひらがな
   ;; カタカナ
   ;; 句読点
   ;; 半角カナ
   (wanakana-char-kanap ch)
   ;; 句読点
   (wanakana-private-betweenp ch "3000" "303F")
   (wanakana-private-betweenp ch "30FB" "30FC")
   ;; 全角句読点いろいろ(ZENKAKU_PUNCTUATION)
   (wanakana-private-betweenp ch "FF01" "FF0F")
   (wanakana-private-betweenp ch "FF1A" "FF1F")
   (wanakana-private-betweenp ch "FF3B" "FF3F")
   (wanakana-private-betweenp ch "FF5B" "FF60")
   ;; 全角通貨記号
   (wanakana-private-betweenp ch "FFE0" "FFEE")
   ;; その他
   ;; 半角算用数字
   (wanakana-private-betweenp ch "0030" "0039")
   ;; 全角算用数字
   (wanakana-private-betweenp ch "FF10" "FF19")
   
   (wanakana-private-betweenp ch "4E00" "9FFF")
   (wanakana-private-betweenp ch "3400" "4DBF")
   )
  )

(defun wanakana-char-uppercasep (ch)
  (wanakana-private-betweenp ch "0041" "005A")
  )

(defun wanakana-char-lowercasep (ch)
  (wanakana-private-betweenp ch "0061" "007A")
  )

(defun wanakana-char-vowelp (ch include-y)
  "与えられた文字が英語での母音であるか include-y を真にするとyも母音として判定する case insensitive"
  (let ((lo (downcase ch)))
    (if (and include-y (string-equal lo "y"))
	t
      (and
       (wanakana-char-lowercasep lo)
       (member lo wanakana-long-vowels-cell-list)
       )
      )
    )
  )

(defun wanakana-char-consonatp (ch include-y)
  "与えられた文字が英語での子音であるか include-y を真にするとyも子音として判定する case insesitive"
  (let ((lo (downcase ch))
	)
    (and
     (wanakana-char-lowercasep lo)
     (not (wanakana-char-vowelp lo (not include-y)))
     )
    )
  )

(provide 'wanakana-char-hantei)
