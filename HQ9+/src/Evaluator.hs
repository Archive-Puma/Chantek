module HQ9.Evaluator (runEval) where

import HQ9.Parser (Instructions(HelloWorld, Quine, Bottles, Increment))

import System.Exit (exitWith, ExitCode(ExitSuccess))
import Control.Monad (forM_, foldM)

-- https://stackoverflow.com/questions/6270324/in-haskell-how-do-you-trim-whitespace-from-the-beginning-and-end-of-a-string
import Data.Char (isSpace)
trim :: String -> String
trim = f . f
   where f = reverse . dropWhile isSpace

bottles 0 = do
  putStrLn "No more bottles of beer on the wall, no more bottles of beer."
  putStrLn "Go to the store and buy some more, 99 bottles of beer on the wall."
bottles 1 = do
  putStrLn "1 bottle of beer on the wall, 1 bottle of beer."
  putStrLn "Take one down and pass it around, no more bottles of beer on the wall."
  putStrLn ""
  bottles 0
bottles n = do
  putStrLn $ show n ++ " bottles of beer on the wall, " ++ show n ++ " bottles of beer."
  putStrLn $ "Take one down and pass it around, " ++ show (n - 1) ++ " bottles of beer on the wall."
  putStrLn ""
  bottles $ n - 1

runEval instructions source accumulator = forM_ instructions $ \ins -> case ins of
  HelloWorld -> putStrLn "Hello World!"
  Quine -> putStrLn $ trim source
  Bottles -> bottles 99
  Increment -> show $ succ accumulator

-- TODO: Accumulator
