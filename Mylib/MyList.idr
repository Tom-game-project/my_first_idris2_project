module Mylib.MyList

import Data.Maybe

%default total

public export total
data MyVect : Nat -> Type -> Type where
  Nil: MyVect Z a
  (::) : a -> (1 _ : MyVect k a) -> MyVect (S k) a

public export total
append: MyVect n a -> (1 _ : MyVect m a) -> MyVect (n + m) a
append [] y = y
append (x :: z) y = x :: append z y

public export total 
map: ((1 _ : a) -> b) -> (1 _ :MyVect n a) -> MyVect n b
map f [] = []
map f (x :: y) = f x :: map f y

-- =========================================
-- 2. MyVect を文字列に変換できるようにする（Rust の impl Display に相当）
-- =========================================
-- 「中身の型 a が Show を実装しているなら、MyVect も Show できる」という宣言 `Show => a`の部分
-- 
public export total
Show a => Show (MyVect n a) where
  show Nil = "[]"
  show (x :: Nil) = "[" ++ show x ++ "]"
  show (x :: xs) = "[" ++ show x ++ ", " ++ dropBracket (show xs)
    where
      -- ネストした括弧を外すための補助関数
      -- 例: "[1, [2, [3]]]" -> "[1, 2, 3]" のように綺麗に見せるための処理
      dropBracket : String -> String
      dropBracket str = substr 1 (minus (length str) 1) str

