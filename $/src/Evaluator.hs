module Dollar.Evaluator (emptyTape, runEval) where

-- Haskell libraries
import Data.Char (chr)

-- Evaluate a instruction
runEval :: [Int] -> [(Int, Int)] -> IO [Int]
runEval tape [] = return tape
runEval tape ((-1,-1):rest) = runEval tape rest
runEval tape ((0,number):rest) = do
  if number < 0
    then putChar $ chr $ number * (-1)
    else putChar $ chr $ tape !! (number - 1)
  runEval tape rest
runEval tape ((register,number):rest) = do
  if number < 0
    then runEval (take (register - 1) tape ++ [number * (-1)] ++ drop (register) tape) rest
    else runEval (take (register - 1) tape ++ [tape !! (number - 1)] ++ drop (register) tape) rest

-- Creates an inifinite empty tape
emptyTape :: [Int]
emptyTape = repeat 0
