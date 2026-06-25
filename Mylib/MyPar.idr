module Mylib.MyPar

-- 「パーサー」とは、「文字列を受け取り、成功すれば (パース結果, 残りの文字列) を返す関数」を包んだもの
public export
record Parser a where
  constructor MkParser
  runParser : String -> Maybe (a, String)

-- 条件（述語）を満たす1文字を読むパーサー
public export
satisfy : (Char -> Bool) -> Parser Char
satisfy predicate = MkParser $ \input =>
  case strUncons input of
    Nothing => Nothing
    Just (c, rest) =>
      if predicate c
        then Just (c, rest)
      else Nothing

-- 特定の1文字を読むパーサー
char : Char -> Parser Char
char expected = satisfy (== expected)

-- 数字を1文字読むパーサー
digit : Parser Char
digit = satisfy isDigit

