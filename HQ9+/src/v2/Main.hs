module Main where

import System.Exit (exitWith, ExitCode(ExitSuccess))
import System.Environment (getArgs)

import HQ9

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

parseArgs ["-h"] = usage >> exit
parseArgs ["--help"] = usage >> exit
parseArgs ["-v"] = version >> exit
parseArgs ["--version"] = version >> exit
parseArgs filename = concat `fmap` mapM readFile filename

main :: IO ()
main = do
  source <- getArgs >>= parseArgs
  runParser source
