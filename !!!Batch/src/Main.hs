module Main where

-- Modules
import Batch'''.Parser (runParser)
import Batch'''.Evaluator (runEval)
import Batch'''.Arguments (runArgs)

-- Entrypoint
main :: IO ()
main = do
  source <- runArgs
  putStr $ runParser source >>= runEval
