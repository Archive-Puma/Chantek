module HQ9.Parser (Instructions(HelloWorld, Quine, Bottles, Increment), runParser) where

import Data.Char (toUpper)
import Data.Maybe (catMaybes)
import Text.Parsec (anyChar, oneOf, many, parse, (<|>))
import Text.Parsec.String (Parser)
import Control.Monad.State (liftM)

data Instructions =
  HelloWorld
  | Quine
  | Bottles
  | Increment
  deriving Show

instruction :: Parser (Maybe Instructions)
instruction = oneOf "HQ9+" >>= \ins -> return . Just $ case ins of
  'H' -> HelloWorld
  'Q' -> Quine
  '9' -> Bottles
  '+' -> Increment

comments :: Parser (Maybe Instructions)
comments = anyChar >> return Nothing

parseSource :: Parser [Instructions]
parseSource = liftM catMaybes $ many $ instruction <|> comments

runParser source = do
  case parse parseSource "Parser :: HQ9+" $ map toUpper source of
    Right ins -> return ins
