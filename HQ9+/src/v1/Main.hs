module Main where

{-
  lines of code: 116
  execution time: 0.030s (tested w/test.hq)
  includes: Repl (interactive mode)
-}

-- Haskell libraries
import System.Exit (exitWith, ExitCode(ExitSuccess))
import System.Environment (getArgs)

-- Modules
import HQ9.Parser (runParser)
import HQ9.Evaluator (runEval)
import HQ9.Repl (runRepl)

-- Dispay the help message
usage :: IO ()
usage = do
  putStrLn ""
  putStrLn "chantek 2018 - Esoteric languages genius."
  putStrLn "(c)2018 CosasDePuma.  All rights reserved."
  putStrLn ""
  putStrLn "Run interactive mode without using any arguments"
  putStrLn ""
  putStrLn "Usage:"
  putStrLn "\thq9 [-hv] filename"
  putStrLn "Options"
  putStrLn "\t-h, --help\t\tDisplay this help message"
  putStrLn "\t-v, --version\t\tDisplay version information and exit"
  putStrLn ""

-- Display the version
version :: IO ()
version = do
  putStrLn "chantek v2.1.1 haskell ~HQ9+"

-- Exit the program successfully
exit :: IO a
exit = exitWith ExitSuccess

-- Parse the arguments
parseArgs :: [String] -> IO String
parseArgs [] = runRepl >> exit                            -- Run Repl (Interactive mode)
parseArgs ["-h"] = usage >> exit                          -- Display a help message
parseArgs ["--help"] = usage >> exit
parseArgs ["-v"] = version >> exit                        -- Display the version of the program
parseArgs ["--version"] = version >> exit
parseArgs filename = concat `fmap` mapM readFile filename -- Concatenate all the source files

-- Entrypoint
main :: IO ()
main = do
  source <- getArgs >>= parseArgs     -- Get the source code from arguments or display messages
  runParser source >>= runEval source -- Tokenize the code and evaluate it
