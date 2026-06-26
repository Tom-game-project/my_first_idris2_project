# idris2練習・実験用レポジトリ


```sh
nix-shell -p idris2Packages.idris2Lsp idris2
```

```sh
nix develop
```

この環境のなかでエディタを開く


## インタプリタを起動して、関数の証明状態などをみる

```sh
# rlwrapを使うとreadline未対応のインタプリタに対して履歴操作などが可能
rlwrap idris2 Main.idr
```

```sh
Main> :total [関数名] -- totalityの確認
Main> :doc [関数名] -- 関数の情報
Main> :printdef [関数名] -- 関数の定義の確認
Main> :l "<file name>" -- ファイルのロード
Main> :r  -- ファイルのリロード
Main> :exec [関数名] -- 関数を実行
```

## コンパイル

```
idris2 Main.idr -o vect_test
```

## NOTE

## モジュール

https://idris2.readthedocs.io/en/latest/tutorial/modules.html#export-modifiers

## 停止性

停止性（Termination）を満たしていること。（無限ループしない）
網羅性（Coverage / Exhaustivity）を満たしていること。（パターンマッチの漏れがなく、実行時エラーやクラッシュが絶対に起きない）

全域性(totality) ＝ 停止性 ＋ 網羅性

- Coverage（網羅性）
  すべてのあり得る入力パターンに対して、処理が定義されていること。

- Termination（停止性）

  すべての再帰呼び出しにおいて、引数が「構造的減少（Structural Decreasing）」を満たしていること。

## MonadとAlternative

- `>>=` が「文脈を維持したまま、値を受け渡す操作（AND）」

- `<|>` が「値には干渉せず、文脈（成功/失敗）に応じてルートを切り替える操作（OR）」

### bind（>>=）とは何か？

箱を安全に開けて、中身（a）を取り出し、それを機械に渡し、出てきた新しい箱（m b）を返す

```idris2
(>>=) : m a -> (a -> m b) -> m b

Monad m => m a -> (a -> m b) -> m b
```

文脈を保持しつつ中身の処理をしたい場合

### (<|>) とは何か？

```idris2
(<|>) : Alternative f => f a -> f a -> f a
```

結合則を満たす
```latex
$(A \circ B) \circ C = A \circ (B \circ C)$
```

コンテクストを扱うためのレベル

レベル1：Functor（ファンクター）

    能力: 箱を開けずに、中身のデータだけを別のデータに変換できる（map）。

    例: 「文字列のパーサー」を「数字のパーサー」に変換する。

レベル2：Applicative（アプリカティブ）

    能力: 普通のデータを、ポイッと新しい箱に入れることができる（pure）。

    条件: レベル1（Functor）の免許をすでに持っていること。

    理由: 箱を作れるなら、当然その箱の中身を変換することもできるべきだから。

レベル3A：Monad（モナド）

    能力: 前の箱の中身を見てから、次に使う箱を動的に決めることができる（>>= / bind）。

    条件: レベル2（Applicative）の免許を持っていること。

    理由: 先ほど書いた bind の最後の行で pure を使ったように、連鎖の最後には「新しい箱に包んで返す」処理が頻出するから。

レベル3B：Alternative（オルタナティブ）

    能力: 箱が失敗した時に、別の箱を試すことができる（<|> と empty）。

    条件: これもレベル2（Applicative）の免許を持っていること。

## TODO

- Data.Views
  複雑な再帰の停止性をコンパイラに教える手段

- SnocList
  リストを後ろから読む

