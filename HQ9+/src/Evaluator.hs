module HQ9.Evaluator (runEval) where

import HQ9.Parser (Instructions(HelloWorld, Quine, Bottles, Increment))

import System.Exit (exitWith, ExitCode(ExitSuccess))

-- https://stackoverflow.com/questions/6270324/in-haskell-how-do-you-trim-whitespace-from-the-beginning-and-end-of-a-string
import Data.Char (isSpace)
trim :: String -> String
trim = f . f
   where f = reverse . dropWhile isSpace


-- TODO: 99 Bottles


runEval [] _ _ = exitWith ExitSuccess

runEval (HelloWorld:rest) source accumulator = do
  putStrLn "Hello World!"
  runEval rest source accumulator

runEval (Quine:rest) source accumulator = do
  putStrLn $ trim source
  runEval rest source accumulator

runEval (Bottles:rest) source accumulator = do
  -- TODO: 99 Bottles
  runEval rest source accumulator

runEval (Increment:rest) source accumulator =
  runEval rest source (accumulator + 1)

runEval (_:rest) source accumulator = runEval rest source accumulator
