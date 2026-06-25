module Main

import Mylib.MyList
import Mylib.MyPar
import Data.String
import Data.Vect

-- total
-- vectMap : Vect n x -> ((1 _ : x) -> y) -> Vect n y
-- vectMap [] f = []
-- vectMap (x :: xs) f = f x :: vectMap xs f

total
vectMap : Vect n x -> (x -> y) -> Vect n y
vectMap [] f = []
vectMap (x :: xs) f = f x :: vectMap xs (\z => f x)

total
stringDecoration: String -> String
stringDecoration a = "<" ++ a ++ ">"

main : IO ()
main = do
  -- 長さ 2 のリスト (型推論が効くので型注釈は必須ではありませんが、明示するとわかりやすいです)
  let vect1 : MyVect 2 String
      vect1 = "Apple" :: "Banana" :: Nil

  -- 長さ 3 のリスト
  let vect2 : MyVect 3 String
      vect2 = "Cherry" :: "Date" :: "Elderberry" :: Nil

  -- append で結合！
  -- コンパイラは裏で 2 + 3 = 5 であることを証明し、型が MyVect 5 String になることを保証します
  let combined = append vect1 vect2

  -- let mapped = Mylib.MyList.map stringDecoration combined

  -- 結果を出力する
  putStrLn "--- Idris 2 Vect Append Test ---"
  putStrLn ("Vect 1: " ++ show vect1)
  putStrLn ("Vect 2: " ++ show vect2)
  putStrLn ("Combined: " ++ show combined)

  -- ※ わざと型を間違えるとコンパイルエラーになることを確認する用（コメントアウトを外すとエラーになります）
  -- let wrongVect : MyVect 6 String
  --     wrongVect = append vect1 vect2

  let std_vect1 : Data.Vect.Vect 3 String = ["hello", "world", "tom"]
  let std_vect2 : Data.Vect.Vect 2 String = ["hello", "world"]


  let std_vect_combed = std_vect1 ++ std_vect2

  let test = ?std_vect_combed

  printLn std_vect1


