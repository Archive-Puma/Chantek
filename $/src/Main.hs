module Main where

-- Modules
import Dollar.Parser (runParser)
import Dollar.Evaluator (emptyTape,runEval)
import Dollar.Arguments (runArgs)

-- Entrypoint
main :: IO ()
main = runArgs >>= runParser >>= runEval emptyTape >> return ()
