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
(provide 'wanakana-char-hantei)
