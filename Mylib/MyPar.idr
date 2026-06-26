module Mylib.MyPar

%default total

-- 「パーサー」とは、「文字列を受け取り、成功すれば (パース結果, 残りの文字列) を返す関数」を包んだもの
public export total
record Parser a where
  constructor MkParser
  parse : String -> Maybe (a, String)

-- 条件（述語）を満たす1文字を読むパーサー
public export total
predChar : (Char -> Bool) -> Parser Char
predChar predicate = MkParser $ \input =>
  case strUncons input of
    Nothing => Nothing
    Just (c, rest) =>
      if predicate c
        then Just (c, rest)
      else Nothing

||| pure
public export total
pureParser: a -> Parser a
pureParser x = MkParser (\str => Just (x, str))

||| then parser
||| `>>=`
public export total
bind: Parser a -> (a -> Parser b) -> Parser b
bind p f = MkParser (\str => 
    case p.parse str of
      Nothing => Nothing
      Just (res, rest) => (f res).parse rest
  )

||| or parser
||| `<|>`
public export total
or_else: Parser a -> Parser a -> Parser a
or_else p1 p2 = MkParser (\str => 
    case p1.parse str of
      Nothing => p2.parse str
      Just success => Just success -- そのまま返却
  )

-- 特定の1文字を読むパーサー
public export total
charP : Char -> Parser Char
charP expected = predChar (== expected)

-- 数字を1文字読むパーサー
public export total
digit : Parser Char
digit = predChar isDigit


-- -- 
-- -- test
-- --

-- "A:B" などを読み取るコンビネータ
total
parseKV : Parser (Char, Char)
parseKV =
  -- 1. 最初の文字を読み、結果を `key` と名付ける
  bind digit $ \key =>
    -- 2. 次に ':' を読む（結果は使わないので `_` で捨てる）
    bind (charP ':') $ \_ =>
      -- 3. 次の文字を読み、結果を `val` と名付ける
      bind digit $ \val =>
        -- 4. 最後に、今まで集めた key と val をタプルにして返す
        pureParser (key, val)

-- 実行して動作確認するためのテスト用エントリーポイント
export
testParser : IO ()
testParser = do
  putStrLn "--- Test Started ---"
  
  -- 成功するパターン ("1:2" -> 余りは "")
  printLn $ parseKV.parse "1:2"
  
  -- 余りが出るパターン ("1:2" -> 余りは "123")
  printLn $ parseKV.parse "1:2123"
  
  -- 失敗するパターン（コロンがない）
  printLn $ parseKV.parse "1-2"
  
  putStrLn "--- Test Finished ---"
