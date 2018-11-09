module HQ9.Parser (
  runParser, Instructions(HelloWorld,Quine,Bottles,Increment)
) where

import Data.Char (toUpper)
import Text.Parsec (anyChar, many, parse)
import Text.Parsec.String (Parser)

-- Instructions in HQ9+
data Instructions =
  HelloWorld | Quine | Bottles | Increment
-- How to show Instructions in stdout
instance Show Instructions where
  show HelloWorld  = "H"
  show Quine       = "Q"
  show Bottles     = "9"
  show Increment   = "+"

-- Parse many (zero or more) instructions
program :: Parser [Instructions]
program = many instructions

-- Parse single instructions
instructions :: Parser Instructions
instructions = do
  ins <- anyChar        -- Take any char of the source code
  return $ case ins of  -- Return a value depends of the char
    'H' -> HelloWorld
    'Q' -> Quine
    '9' -> Bottles
    '+' -> Increment

-- Remove all the non-instructions chars
removeComments :: String -> String
removeComments source = filter (`elem` "HQ9+") $ map toUpper source

-- runParser using the source code with the comments removed
runParser source = do
  case parse program "Parser :: HQ9+" $ removeComments source of
    Right source' -> return source'
