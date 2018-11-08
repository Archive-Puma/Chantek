module Main where

import System.Exit (exitWith, ExitCode(ExitSuccess))
import System.Environment (getArgs)

import HQ9.Parser (runParser)
import HQ9.Evaluator (runEval)
import HQ9.Repl (runRepl)

usage = do
  putStrLn ""
  putStrLn "chantek 2018 - Esoteric languages genius."
  putStrLn "(c)2018 CosasDePuma.  All rights reserved."
  putStrLn ""
  putStrLn "Usage:"
  putStrLn "\thq9 [-hqv] filename"
  putStrLn "Options"
  putStrLn "\t-h, --help\t\tDisplay this help message"
  putStrLn "\t-q, --quiet, --silent\tSuppress messages"
  putStrLn "\t-v, --version\t\tDisplay version information and exit"
  putStrLn ""

version = do
  putStrLn "chantek v2.1 haskell ~HQ9+"

exit = exitWith ExitSuccess

parseArgs [] = runRepl >> exit                            -- Run Repl (Interactive mode)
parseArgs ["-h"] = usage >> exit                          -- Display a help message
parseArgs ["--help"] = usage >> exit
parseArgs ["-v"] = version >> exit                        -- Display the version of the program
parseArgs ["--version"] = version >> exit
parseArgs filename = concat `fmap` mapM readFile filename -- Concatenate all the source files

main :: IO ()
main = do
  source <- getArgs >>= parseArgs     -- Get the program arguments
  runParser source >>= runEval source -- Tokenize the code and evaluate it
