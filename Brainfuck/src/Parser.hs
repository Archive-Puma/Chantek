-- https://github.com/niklasb/haskell-brainfuck
-- let helloworld = "++++++++++[>+++++++>++++++++++>+++>+<<<<-]>++.>+.+++++++..+++.>++.<<+++++++++++++++.>.+++.------.--------.>+.>."
module Main where

import Data.Maybe (catMaybes)
import Control.Monad.State (liftM)

import Text.Parsec (noneOf, between, char, many, parse, oneOf, (<|>))
import Text.Parsec.String (Parser)

data Instructions =
  Next
  | Previous
  | Increment
  | Decrement
  | Input
  | Output
  | Loop [Instructions]
  | Comment
  deriving Show

instructions :: Parser (Maybe Instructions)
instructions = oneOf "><+-,." >>= \ins -> return . Just $ case ins of
  '>' -> Next
  '<' -> Previous
  '+' -> Increment
  '-' -> Decrement
  ',' -> Input
  '.' -> Output

loops :: Parser (Maybe Instructions)
loops = between (char '[') (char ']') (parseSource >>= return . Just . Loop)

comments :: Parser (Maybe Instructions)
comments = noneOf "]" >> return Nothing

parseSource :: Parser [Instructions]
parseSource = liftM catMaybes $ many $ instructions <|> loops <|> comments

main :: IO ()
main = do
  source <- readFile "helloworld.bf"
  putStrLn source
  case parse parseSource "Parser :: Brainfuck" source of
    Left err -> print err
    Right ins -> print ins
