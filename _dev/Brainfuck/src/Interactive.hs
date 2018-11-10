module Brainfuck.Interactive (runRepl) where

import Brainfuck.Parser

import System.IO (stdout, hFlush)

header :: IO ()
header = do
  putStrLn "chantek 2018 - Esoteric languages genius."
  putStrLn "(c)2018 CosasDePuma.  All rights reserved."
  putStrLn "Interactive mode. Press Ctrl + C to quit."
  putStrLn ""

interactiveMode memory = do
  putStr "? - "
  hFlush stdout
  input <- getLine
  let ast = parse input
  run memory $ instruct ast
  interactiveMode memory

runRepl = do
  header
  interactiveMode emptyMemory
