module Main where

{-
  lines of code: 53
  execution time: 0.045s (tested w/test.hq)
-}

-- Haskell libraries
import Data.Char (toUpper)
import System.Exit (exitWith, ExitCode(ExitSuccess))
import System.Environment (getArgs)
import Control.Monad.State (evalState, get, put, State)

-- Dispay the help message
usage :: IO ()
usage = do
  putStrLn ""
  putStrLn "chantek 2018 - Esoteric languages genius."
  putStrLn "(c)2018 CosasDePuma.  All rights reserved."
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
  putStrLn "chantek v2.1.2 haskell ~HQ9+"

-- Exit the program successfully
exit :: IO a
exit = exitWith ExitSuccess

-- Parse the arguments
parseArgs :: [String] -> IO String
parseArgs [] = usage >> exit                            -- Run Repl (Interactive mode)
parseArgs ["-h"] = usage >> exit                          -- Display a help message
parseArgs ["--help"] = usage >> exit
parseArgs ["-v"] = version >> exit                        -- Display the version of the program
parseArgs ["--version"] = version >> exit
parseArgs filename = concat `fmap` mapM readFile filename -- Concatenate all the source files

-- Monad.State
type Program = (Int, String)

-- Return the "99 Bottles of Beer" song
bottles :: Int -> String -> String
bottles 0 song = song ++ "No more bottles of beer on the wall, no more bottles of beer.\nGo to the store and buy some more, 99 bottles of beer on the wall.\n"
bottles 1 song = bottles 0 $ song ++ "1 bottle of beer on the wall, 1 bottle of beer.\nTake one down and pass it around, no more bottles of beer on the wall.\n\n"
bottles n song = bottles (n - 1) $ song ++ show n ++ " bottles of beer on the wall, " ++ show n ++ " bottles of beer.\nTake one down and pass it around, " ++ show (n - 1) ++ " bottles of beer on the wall.\n\n"

-- Evaluate the source code
run :: String -> String -> State Program String
run [] _ = do
  (_,result) <- get
  return result
run (ins:rest) source = do
  (accumulator,result) <- get
  case ins of
    'H' -> put (accumulator,result ++ "Hello World!\n")   -- Hello World
    'Q' -> put (accumulator,result ++ source ++ "\n")     -- Quine
    '9' -> put (accumulator,result ++ bottles 99 "")      -- 99 Bottles of Beer
    '+' -> put (accumulator + 1,result)                   -- Increment Accumulator
  run rest source

-- Parse the source code and remove comments
parse :: String -> String
parse source = [ toUpper ins | ins <- source, ins `elem` "hqHQ9+" ]

-- Entrypoint
main :: IO ()
main = do
  source <- getArgs >>= parseArgs               -- Get the source code from arguments or display messages
  putStr $ evalState (run (parse source) source) (0,"") -- Tokenize the code and evaluate it
