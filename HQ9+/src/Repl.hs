module HQ9.Repl (runRepl) where

import HQ9.Parser (runParser)
import HQ9.Evaluator (runEval)

import System.IO (stdout, hFlush)

header :: IO ()
header = do
  putStrLn "chantek 2018 - Esoteric languages genius."
  putStrLn "(c)2018 CosasDePuma.  All rights reserved."
  putStrLn "Interactive mode. Press Ctrl + C to quit."
  putStrLn ""

interactiveMode :: IO ()
interactiveMode = do
  putStr "? - "
  hFlush stdout
  input <- getLine
  runParser input >>= runEval input
  putStrLn ""
  interactiveMode

runRepl = do
  header
  interactiveMode
