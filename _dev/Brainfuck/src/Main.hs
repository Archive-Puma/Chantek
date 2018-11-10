module Main where

import Brainfuck.Parser
-- import Brainfuck.Interactive (runRepl)

import System.Exit (exitWith, ExitCode(ExitSuccess))
import System.Environment (getArgs)

usage = do
  putStrLn ""
  putStrLn "chantek 2018 - Esoteric languages genius."
  putStrLn "(c)2018 CosasDePuma.  All rights reserved."
  putStrLn ""
  putStrLn "Usage:"
  putStrLn "\tbrainfuck [-hv] filename"
  putStrLn "Options"
  putStrLn "\t-h, --help\t\tDisplay this help message"
  putStrLn "\t-v, --version\t\tDisplay version information and exit"
  putStrLn ""

version = do
  putStrLn "chantek v0.2 haskell ~brainfuck"

exit = exitWith ExitSuccess

parseArgs ["-h"] = usage >> exit
parseArgs ["--help"] = usage >> exit
parseArgs ["-v"] = version >> exit
parseArgs ["--version"] = version >> exit
parseArgs filename = concat `fmap` mapM readFile filename

main :: IO ()
main = do
  source <- getArgs >>= parseArgs
  if source == ""
    then do
      exit --runRepl
    else do
      let ast = parse source
      run emptyMemory $ instruct ast
      print ast
