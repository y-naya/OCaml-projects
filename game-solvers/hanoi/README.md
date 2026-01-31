# The Tower of Hanoi
This game consists on a mathematical puzzle where there's 3 rods and a number of disks, all with different diameters, which can slide onto any rod.   

At the start of the game, all disks are stacked on one rod in decreasing order, with the shortest diameter at the top.  

The *objective* of this game is to **move the entire stack of disks from one rod to another**.   
The *rules* are the following:
 - ***Only one disk may be moved at a time***  
    (meaning only one disk can taken from the rods and  must place it on a rod before taking other out)
 - ***Disks can only be taken from the top and placed at the top***  Therefore, a move consists on moving a disk from the top of a rod to the top of another.
 - ***A disk cannot be placed over one of smaller size***

---

## Recursive solution
Lets assign a number from 1..n to all the disks in ascending order of size (the smallest would be 1).

This solution consists on moving *m-1* disks from the source to the spare tower, leaving the *m* disk as the top of the source tower.  
Then, we move disk *m* from source (src) to target (tar) rod.  
Finally we move the *m-1* disks from the spare rod to the target.

### solver

#### `hanoi : int -> int -> int -> string`

Solves the problem displaying the moves on a string.

`n` is the number of disks used  
`src` is the rod where all disks and at the starting point  
`tar` is where we want all the disks at the end
```ocaml
let rec hanoi n src tar =
    if n = 0 then "" (* finished *)
    else
        (* find move*)
        let spare = spare src tar in
        (* continue *)
        hanoi (n-1) src spare ^ move (src, tar) ^ hanoi (n-1) spare tar
```
Adding this redefinition allows for the origin and destination rod to be the same (easiest case, no moves necessary)
```ocaml
let hanoi n src tar =
    if n = 0 || src = tar then "\n"
    else hanoi n src tar
```

#### `move : int * int -> string`

Converts a tuple indicating the move into its string representation.

The tuple takes the origin rod as the first argument and the destinantion as the second.

```ocaml
let move = function
    1, 2 -> " 1 -> 2    3 \n"
  | 1, 3 -> " 1 ---2--> 3 \n"
  | 2, 1 -> " 1 <- 2    3 \n"
  | 2, 3 -> " 1    2 -> 3 \n"
  | 3, 1 -> " 1 <--2--- 3 \n"
  | 3, 2 -> " 1    2 <- 3 \n"
  | _, _ -> raise(Failure "move")
```

#### `spare : int -> int -> int`

Returns the rod that is neither the origin or the destination.
```ocaml
let spare src tar=
    if src = 1 || tar = 1 then
        if src = 2 || tar = 2 then
            3
        else
            2
    else
        1
```

### solution printer
#### `print_hanoi : int -> int -> int -> unit`
Prints the solution.

```ocaml
let print_hanoi n src tar =
    if n < 0 || src < 1 || src > 3 || tar < 1 || tar > 3
       then print_endline  " ** ERROR ** \n"
       else print_endline (" =========== \n" ^ 
                           hanoi n src tar ^
                           " =========== \n")
```

### Visual example
```
hanoi n=3 src=3 tar=2
===========
1    2 <- 3 | n=1 src=3 tar=2  |                   |
1 <--2--- 3                    | n=2 src=3 tar=1   |
1 <- 2    3 | n=1 src=2 tar=1  |                   |
1    2 <- 3                                        | n=3 src=3 tar=2
1 ---2--> 3 | n=1 src=1 tar=3  |                   |
1 -> 2    3                    | n=2 src=1 tar=2   |
1    2 <- 3 | n=1 src=3 tar=2  |                   |
===========
```

### Return the nth move in a problem


We use the divide and conquer so that we only go down one of the branches on the recursion tree, therefore shortening its computation time.

#### `nth_hanoi_move : int -> int -> int -> int -> int * int`

`n` nth move of the recursive solution for the problem
`nd

```ocaml
let rec nth_hanoi_move n nd src tar =
    let spare = spare src tar in
    let middle = middlemove nd in
        if n = middle
            then (src, tar)
        else if n < middle
            then nth_hanoi_move n (nd-1) src spare
        else
            nth_hanoi_move (n - middle) (nd-1) spare tar
```