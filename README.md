I have yet to do a decent README file for the root of this repo but I'm still working on double checking my code before posting so please bear with me for the time being :)

# Index
1. [Basic Concepts on OCaml](/basic-concepts/)   
    Reccomended for those new to the language, so they can quickly grasp how types work
2. [Arithmetics](/arithmetics/)
3. [Game Solvers](/game-solvers/)
4. [Data Structures](/data-structures/)

> [!NOTE]
> To compile code:  
> `ocamlc -c file.mli file.ml`  
> `ocamlopt -o fast_fibto fast_fibto.ml`
> To use cmo inside ocaml console  
> `#load "file.cmo";;`

---
# Contents
Classification depending on what you might be interested from a programing point of view:

## Recursion
### Not tail-recursive
[factorization](/arithmetics/factorization/)  
[hanoi](/game-solvers/hanoi/)

### Tail-recursive
[lists](/data-structures/lists/) - tail-recursive and not tail-recursive functions are explicitly indicated



## Backtracking

## Custom Types