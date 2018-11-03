module Brainfuck.Interactive (runRepl) where

import Brainfuck.Parser (runParser)

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
  ast <- runParser input
  print ast
  interactiveMode

runRepl = do
  header
  interactiveMode
