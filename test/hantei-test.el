(require 'cl-lib)
(require 'wanakana)


;; wanakana-romajip
(assert (wanakana-romajip "Tōkyō and Ōsaka"))
(assert (wanakana-romajip "12a*b&c-d"))
(assert (not (wanakana-romajip "あアA")))
(assert (not (wanakana-romajip "お願い")))
;; 全角の！を弾く
(assert (not (wanakana-romajip "a！b&cーd")))

;; wanakana-japanesep
(assert (wanakana-japanesep "泣き虫"))
(assert (wanakana-japanesep "あア"))
;; 算用数字は全角半角両対応
(assert (wanakana-japanesep "２月1日"))
(assert (wanakana-japanesep "泣き虫。！〜＄"))
;; 半角アルファベットには nil を返えす
(assert (not (wanakana-japanesep "泣き虫.!~$")))
(assert (not (wanakana-japanesep "A泣き虫")))
(assert (not (wanakana-japanesep "A")))

;; wanakana-kanap
;; ひらがなとカタカナ
(assert (wanakana-kanap "あ"))
(assert (wanakana-kanap "ア"))
(assert (wanakana-kanap "あーア"))
(assert (not (wanakana-kanap "A")))
(assert (not (wanakana-kanap "あAア")))

;; wanakana-hiraganap
(assert (wanakana-hiraganap "げーむ"))
(assert (not (wanakana-hiraganap "A")))
(assert (not (wanakana-hiraganap "あア")))

;; wanakana-katakanap
(assert (wanakana-katakanap "ゲーム"))
(assert (not (wanakana-katakanap "あ")))
(assert (not (wanakana-katakanap "A")))
(assert (not (wanakana-katakanap "あア")))

;; wanakana-kanjip
(assert (wanakana-kanjip "刀"))
(assert (wanakana-kanjip "切腹"))
(assert (not (wanakana-kanjip "勢い")))
(assert (not (wanakana-kanjip "あAア")))
(assert (not (wanakana-kanjip "🦀"))) ; 蟹の絵文字

;; wanakana-mixedp
;; ローマ字とかなが含まれているかどうか
;; 第2引数で漢字を許可するかを指定する
(assert (wanakana-mixedp "ラマーズP" t))

(assert (wanakana-mixedp "Abあア"  t))
(assert (wanakana-mixedp "お腹A" t))
(assert (not (wanakana-mixedp "お腹A"  nil)))
(assert (not (wanakana-mixedp "ab"  t)))
(assert (not (wanakana-mixedp "あア"  t)))

