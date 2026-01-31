# List

As an exercise I've done the [implementation of most of the functions in the module List](/data-structures/lists/myList.ml) from the Standard Library of OCaml based solely on their [official documentation](https://ocaml.org/manual/5.4/api/List.html), which describes their behavior and whether or not they are tail-recursive.

There's also a file in there with some [listing functions](/data-structures/lists/listing.ml) described on [its corresponding mli](/data-structures/lists/listing.mli). These are implemented in such a way that they are all tail-recursive.


## Folding

### Fold Left
The operation ***fold_left*** from the List module offers a time and memory efficient (since it is tail-recursive) tool for operating over all the elements of a list and an accumulator from left to right. 

The head of the list is removed, and the result of operating this element (the mentioned head) with the accumulator replaces the accumulator in the following call. When the list is empty, the final result is returned.

The implementation of this function is the following:
#### `fold_left : ('acc -> 'b -> 'acc) -> 'acc -> 'b list -> 'acc`
```ocaml
let rec fold_left op acc = function
    []    -> acc
  | h::t  -> fold_left op (op acc h) t;;
```

#### The product of all the elements in an `int list`
```ocaml
let i_prod list = fold_left ( * ) 1 list
```

#### The product of all the elements in an `float list`
```ocaml
let f_prod list = fold_left ( *. ) 1. list
```

#### Find the minimum element in a list
```ocaml
let lmin = function 
    [] -> raise(Failure "lmin: the list has no elements")
  | h::t -> fold_left min h t
```

#### Finds both the minimum and maximum element in a list
```ocaml
let min_max =
  (* val f : 'a -> ('a * 'a) -> ('a * 'a) *)
  let f (acc1, acc2) item = (min item acc1, max item acc2) in function
    [] -> raise(Failure "lmin: the list has no elements")
  | h::t -> fold_left f (h, h) t
```

#### Reverse the list
```ocaml
let cons list item = item::list

let rev list =
  fold_left List.cons [] list
```

#### Append two lists more efficiently
`rev_append` appends lists faster and using less memory that `@` does since it is tail-recursive.

The difference is that l1 is reversed, the output would be the same as `(List.rev l1) @ l2` but the execution is much more efficient.

```ocaml
let cons list item = item::list

let rev_append l1 l2 = fold_left List.cons l2 l1
```

#### Map a list more efficiently
Similar to the previous case, the list is mapped but reversed on the process.

Has the same output as `List.rev (List.map f l)` but is much more efficient.

```ocaml
let rev_map f list = 
  let aux auxlist x = (f x)::auxlist
  in fold_left aux [] list
```

#### Concatenate strings on a `string list`
```ocaml
let concat list = fold_left (^) "" list
```

### Fold Right

Works like List.fold_left but begins to operate the list from the end, which leaves pending calls to be answered occuping the stack (meaning it is **not tail-recursive**).  
This is the reason why the function is not of much interest.

```ocaml
let rec fold_right op list acc =
  match list with
    []    -> acc
  | h::t  -> op h (fold_right op t acc)
```