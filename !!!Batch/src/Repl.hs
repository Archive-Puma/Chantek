module Batch'''.Repl (runRepl) where

-- Modules
import Batch'''.Parser (runParser)
import Batch'''.Evaluator (runEval)

-- Haskell libraries
import System.IO (stdout, hFlush)

-- Display the welcome message
header :: IO ()
header = do
  putStrLn "chantek 2018 - Esoteric languages genius."
  putStrLn "(c)2018 CosasDePuma.  All rights reserved."
  putStrLn "Interactive mode. Press Ctrl + C to quit."
  putStrLn ""

-- Infinite loop (Read Eval Print Loop)
interactiveMode :: IO a
interactiveMode = do
  putStr "set str="
  hFlush stdout
  input <- getLine
  putStrLn $ runParser input >>= runEval
  interactiveMode

-- Show the message and run the Repl
runRepl :: IO a
runRepl = do
  header
  interactiveMode
