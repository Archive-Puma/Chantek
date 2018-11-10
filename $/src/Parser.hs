module Dollar.Parser where

-- Haskell libraries
import Text.Parsec (char, digit, many, many1, optionMaybe, parse, (<|>))
import Text.Parsec.String (Parser)

-- Remove all the non-instructions chars
removeComments :: String -> String
removeComments source = filter (`elem` ("$+\n" ++ ['0'..'9'])) source

-- Parse instructions
instruction :: Parser (Int,Int)
instruction = do
  register <- many1 digit
  char '$'
  modifier <- optionMaybe (char '+')
  number <- many1 digit
  optionMaybe $ char '\n'
  return $ case modifier of
    Nothing -> ((read register), (read number))
    Just m  -> ((read register), (read number)*(-1))

-- Parse blank new lines
newline :: Parser (Int,Int)
newline = (char '\n') >> return (-1,-1)

-- Parse many (zero or more) instructions
program :: Parser [(Int,Int)]
program = many (instruction <|> newline)

-- Run the parser
runParser :: Monad m => String -> m [(Int,Int)]
runParser source = case parse program "Parser: $" $removeComments source of
  Right ast -> return ast
