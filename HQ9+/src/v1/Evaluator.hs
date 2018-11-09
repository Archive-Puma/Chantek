module HQ9.Evaluator (runEval) where

import HQ9.Parser (Instructions(HelloWorld,Quine,Bottles,Increment))

bottles 0 = do
  putStrLn "No more bottles of beer on the wall, no more bottles of beer."
  putStrLn "Go to the store and buy some more, 99 bottles of beer on the wall."
bottles 1 = do
  putStrLn "1 bottle of beer on the wall, 1 bottle of beer."
  putStrLn "Take one down and pass it around, no more bottles of beer on the wall."
  putStrLn ""
  bottles 0
bottles n = do
  putStrLn $ show n ++ " bottles of beer on the wall, " ++ show n ++ " bottles of beer."
  putStrLn $ "Take one down and pass it around, " ++ show (n - 1) ++ " bottles of beer on the wall."
  putStrLn ""
  bottles $ n - 1



runEval source ast = run (ast, 0)
  where
    run :: ([Instructions], Integer) -> IO ()
    run ([],accumulator) = return ()
    run (HelloWorld:rest, accumulator) = do
      putStrLn "Hello World!"
      run(rest, accumulator)
    run (Quine:rest, accumulator) = do
      putStrLn source
      run(rest, accumulator)
    run (Bottles:rest, accumulator) = do
      bottles 99
      run(rest, accumulator)
    run (Increment:rest, accumulator) =
      run(rest, (+1) accumulator)
