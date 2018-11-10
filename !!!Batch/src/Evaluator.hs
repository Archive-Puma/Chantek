module Batch'''.Evaluator (runEval) where

-- Evaluate a instruction
eval :: String -> Char
eval ('+':str) = ['A'..'Z'] !! (length str - 1)
eval ('-':str) = ("& ?!%/.:" ++ ['0'..'9'] ++ "=+-<>@*") !! (length str - 1)
eval str = ['a'..'z'] !! (length str - 1)

runEval = map eval
