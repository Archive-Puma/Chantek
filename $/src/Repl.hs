module Dollar.Repl (runRepl) where

-- Modules
import Dollar.Parser (runParser)
import Dollar.Evaluator (emptyTape, runEval)

-- Haskell libraries
import System.IO (stdout, hFlush)

-- Display the welcome message
header :: IO ()
header = do
  putStrLn "chantek 2018 - Esoteric languages genius."
  putStrLn "(c)2018 CosasDePuma.  All rights reserved."
  putStrLn "Interactive mode. Press Ctrl + C to quit."

-- Infinite loop (Read Eval Print Loop)
interactiveMode :: [Int] -> IO a
interactiveMode tape = do
  putStrLn ""
  putStr "$ - "
  hFlush stdout
  getLine >>= runParser >>= runEval tape >>= interactiveMode

-- Show the message and run the Repl
runRepl :: IO a
runRepl = do
  header
  interactiveMode emptyTape
