# idris2練習・実験用レポジトリ

```sh
nix-shell -p idris2Packages.idris2Lsp idris2
```

```sh
nix develop
```


# インタプリタを起動して、関数の証明状態などをみる

```sh
idris2 Main.idr
```

```sh
Main> :total [関数名] -- totality
Main> :doc [関数名] -- 関数の情報
Main> :printdef [関数名] -- 関数の定義の確認
```

# コンパイル

```
idris2 Main.idr -o vect_test
```

