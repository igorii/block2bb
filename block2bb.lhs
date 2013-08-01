block2bb
========

Description
-----------

This is a very simple parser for Literate Haskell files that use a tex-like notation for denoting blocks of code. The expected format is:
\{code}    -> begins a block of code
\{endCode} -> ends a block of code
Both blocks of code and Bird Beak lines are converted to Bird Beak notation to be compiled. All other lines are considered comments.

Reasoning
---------

There are many advantages to useing a block notation rather than '>' on each line, especially for larger blocks of code. For a quick idea, see [...]

Use
---

See README.md

> module Main where 

The application accepts filenames from the command line, and thus needs to import `getArgs` from System.Environment. `getArgs` is an IO action of the form `IO [String]`, which returns a list of the command line arguments. For example, calling getArgs on a function `foo` called as `./foo a1 a2 a3` would return ["a1", "a2", "a3"].

> import System.Environment (getArgs)

The main logic works by recursively cycling through two functions. These are the first two functions defined. The first is the entry point, and takes a list of strings (the string representation of each line of a file). This function simply returns each line of the file until it parses a `"\{code}"` string. 

At the point when a `"\{code}"` string is found, the second function takes over. This second function prepends a "> " to each line until a `"\{endCode}"` string is found. At that point, the first function again takes over. 

The pattern repeats until the list of strings is exhausted.

> processFile :: [String] -> [String]
> processFile []     = []
> processFile (l:ls) = case l of
>   "\\{code}" -> processCode ls
>   otherwise  -> [l] ++ processFile ls

> processCode :: [String] -> [String]
> processCode []     = []
> processCode (l:ls) = case l of 
>   "\\{endCode}" -> processFile ls
>   otherwise     -> [">" ++ l] ++ processCode ls
 
`convertFile` simply turns a file into `[String]`, which is processed with `processFile`, and then written to a new file with the extension ".bb.lhs".

> convertFile file = do
>   contents <- readFile file
>   let newFile = (dropExtension file) ++ ".bb.lhs"
>   writeFile newFile $ unlines $ processFile $ lines contents

Here is a simple recursive convenience function to drop the extension of a file. All characters that appear before the first '.' are returned.

> dropExtension        :: String -> String
> dropExtension []     = []
> dropExtension (x:xs) =  case x of
>   '.' -> []
>   otherwise -> [x] ++ dropExtension xs

And the main function, simpler still. Get the arguments, and call `convertFile` on each. Since the result of getArgs is `IO [String]` rather than a plain `[String]`, `mapM` is used here rather than `map`. `mapM` works as a replacement for `map` when dealing with data within a monad.

> main = do
>   args <- getArgs
>   mapM convertFile args

