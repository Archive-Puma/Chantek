
module Brainfuck.Parser (
  emptyMemory,instruct,parse,run,
  Memory, Instructions, Program
) where

import Data.Char (chr,ord)
import System.IO (stdout, stdin, hFlush)

{-
    THE PARSER
-}

data Instructions =
  Next
  | Previous
  | Increment
  | Decrement
  | Input
  | Output
  | LoopR
  | LoopL
  deriving (Show)
type Program = [Instructions]

instructions = map toInstruction . filter (`elem` "><+-,.[]")
  where
    toInstruction ins = case ins of
      '>' -> Next
      '<' -> Previous
      '+' -> Increment
      '-' -> Decrement
      ',' -> Input
      '.' -> Output

loop = between (char '[') (char ']') 

parse :: String ->  Program
parse = instructions <|> loop

{-
    THE MEMORY
-}

data Memory a = Memory [a] a [a]

emptyMemory :: Memory Int
emptyMemory = Memory zeros 0 zeros
  where zeros = repeat 0

instruct :: Program -> Memory Instructions
instruct (ins:instructions) = Memory [] ins instructions

{-
    THE INSTRUCTIONS
-}

next,previous :: Memory a -> Memory a
next      (Memory left middle (r:right)) = Memory (middle:left) r right
previous  (Memory (l:left) middle right) = Memory left l (middle:right)
increment,decrement :: Memory Int -> Memory Int
increment (Memory left middle right) = Memory left (middle + 1) right
decrement (Memory left middle right) = Memory left (middle - 1) right
output :: Memory Int -> IO ()
output  (Memory _ middle _) = do
  hFlush stdout
  putChar $ chr middle

{-
    THE EVALUATOR
-}

nextInstruction :: Memory Int -> Memory Instructions -> IO ()
nextInstruction memory (Memory _ _ [])  = return ()
nextInstruction memory instructions     = run memory $ next instructions

run :: Memory Int -> Memory Instructions -> IO ()
run memory instructions@(Memory _ Next _)                 = nextInstruction (next memory) instructions
run memory instructions@(Memory _ Previous _)             = nextInstruction (previous memory) instructions
run memory instructions@(Memory _ Increment _)            = nextInstruction (increment memory) instructions
run memory instructions@(Memory _ Decrement _)            = nextInstruction (decrement memory) instructions
run (Memory left _ right) instructions@(Memory _ Input _) = do
  input <- getChar
  nextInstruction (Memory left (ord input) right) instructions
run memory instructions@(Memory _ Output _)               = do
  output memory
  nextInstruction memory instructions
