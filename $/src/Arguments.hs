module Dollar.Arguments (runArgs) where

-- Modules
import Dollar.Repl (runRepl)

-- Haskell libraries
import System.Exit (exitWith, ExitCode(ExitSuccess))
import System.Environment (getArgs)

-- Dispay the help message
usage :: IO ()
usage = putStrLn "\n\
  \chantek 2018 - Esoteric languages genius.\n\
  \(c)2018 CosasDePuma.  All rights reserved.\n\
  \\n\
  \Usage:\n\
  \\t$ [-h] [-i] [-v] [filename...]\n\
  \Options\n\
  \\t-h, --help\t\tDisplay this help message\n\
  \\t-i, --interactive\tRun Repl (interactive mode)\n\
  \\t-v, --version\t\tDisplay version information and exit\n"

-- Display the version
version :: IO ()
version = putStrLn "chantek v0.2 haskell ~$"

-- Exit the program successfully
exit :: IO a
exit = exitWith ExitSuccess

-- Parse the arguments
parseArgs :: [String] -> IO String
parseArgs [] = runRepl >> exit                            -- Run Repl
parseArgs ["-i"] = runRepl >> exit
parseArgs ["--interactive"] = runRepl >> exit
parseArgs ["-h"] = usage >> exit                          -- Display a help message
parseArgs ["--help"] = usage >> exit
parseArgs ["-v"] = version >> exit                        -- Display the version of the program
parseArgs ["--version"] = version >> exit
parseArgs [('-':_)] = usage >> exit                       -- Display a help message
parseArgs filename = concat `fmap` mapM readFile filename -- Concatenate all the source files

-- Get and parse the arguments
runArgs :: IO String
runArgs = getArgs >>= parseArgs
