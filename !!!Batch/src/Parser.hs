module Batch'''.Parser where

-- Haskell libraries
import Text.Parsec (char, many, many1, oneOf, optionMaybe, parse)
import Text.Parsec.String (Parser)

-- Remove all the non-instructions chars
removeComments :: String -> String
removeComments source = filter (`elem` "?!+-") source

-- Parse instructions
instruction :: Parser String
instruction = do
  char '?'
  letter <- many1 (char '!')
  modifier <- optionMaybe (oneOf "+-")
  char '?'
  return $ case modifier of
    Nothing -> letter
    Just m  -> m:letter

-- Parse many (zero or more) instructions
program :: Parser [String]
program = many instruction

-- Run the parser
runParser :: Monad m => String -> m [String]
runParser source = case parse program "Parser: !!!Batch" $removeComments source of
  Right ast -> return ast
