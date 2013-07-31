A simple application to convert tex-like Literate Haskell files into bird beak style for reading with pandoc.

> module Main where 

> processFile []     = []
> processFile (l:ls) = case l of
>   "\\{code}" -> processCode ls
>   otherwise  -> [l] ++ processFile ls

> processCode []     = []
> processCode (l:ls) = case l of 
>   "\\{endCode}" -> processFile ls
>   otherwise     -> [">" ++ l] ++ processCode ls

> main = do
>   file <- readFile "test.lhs"
>   putStr $ unlines $ processFile $ lines file


>--   let converted = unlines $ processFile $ lines file in
>--       putStr converted
