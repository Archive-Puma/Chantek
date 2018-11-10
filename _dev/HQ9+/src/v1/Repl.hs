module HQ9.Repl (runRepl) where

import HQ9.Parser (runParser)
import HQ9.Evaluator (runEval)

import System.IO (stdout, hFlush)

-- Show the header of the Interactive mode
header :: IO ()
header = do
  putStrLn "chantek 2018 - Esoteric languages genius."
  putStrLn "(c)2018 CosasDePuma.  All rights reserved."
  putStrLn "Interactive mode. Press Ctrl + C to quit."
  putStrLn ""

-- Repl
interactiveMode :: IO ()
interactiveMode = do
  putStr "? - "
  hFlush stdout
  input <- getLine                  -- Read the stdin
  runParser input >>= runEval input -- Tokenize the input and evaluate it
  putStrLn ""
  interactiveMode                   -- Repeat

runRepl = do
  header
  interactiveMode
