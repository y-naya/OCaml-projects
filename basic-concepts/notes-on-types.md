# Ocaml data types 
Types in ocaml are extremely well defined and they must always be checked before compilation.

## Floats and Integers
To especify a number is a float, you must always use a period even if there is no decimal part.
```ocaml
0;;
(* - : int = 0 *)

0.;; 
(* - : float = 0. *)
```

Even operators are functions with very specific imputs. For example, to substract float variables we must use `-.` instead of `-`, for the latter only works on integers. 

```ocaml
2. - 0.5;;
(* Type error *)

2. -. 0.5;;
(* - : float = 1.5 *)
```

However, operators like `**` work solely on floats, just like `mod` does just on integers.


Similarly, mathematical functions such as `sqrt`, `sin`, etc. can only be used on floats


Conversion between floats and integers can be done with the functions `float_of_int` and `int_of_float`. The function `truncate` works just like the latter.

You might also want to use the following functions so as to priorly decide how round the float into an integer. Note however that some  these functions' output is still a float.
```ocaml
# floor 4.3;;
- : float = 4.
# ceil 4.3;;
- : float = 5.
# Float.round 4.3;;
- : float = 4.
# Float.round 4.7;;        
- : float = 5.
```

### nan
```ocaml
0. /. 0.;;
(* - : float = nan *)
```

**IMPORTANT!**  
Negative values must always be in between parenthesis to be considered a nnumerical value.  
Else, the `-` operator will be expecting two integers to substract.

```ocaml
float_of_int -2
(* Error: This expression has type int -> float
    but an expression was expected of type int *)
float_of_int (-2);;
(* - : float = -2. *)
```
The same happens with floats, since the value to the left of the operator is the first to be type-checked.  
Also, operators have priority over the rest of functions. It won't matter if our function expects int or float, since the function itself is expected to be an int.
```ocaml
float_of_int -2.;;
(* Error: This expression has type int -> float
    but an expression was expected of type int *)
# int_of_float -2.;;
(* Error: This expression has type float -> int
    but an expression was expected of type int *)
# int_of_float (-2.);;  
(* - : int = -2 *)
```

## Functions
Note that the type of a function follows the following pattern:  
**input-type -> output-type**  
when there are several inputs:  
(ex. func i1 i2 i3 i4 )  
**i1-type -> i2-type -> i3-type -> i4-type -> output-type**

## Unit
Is primarily used for functions that don't receive ay arguments or doesn't reply with any output.  
Some of these functions leave side effects (ex. the system's I/O). 
```ocaml
# ();;
- : unit = ()

# read_line;;
- : unit -> string = <fun>

# read_line ();;
hi
- : string = "hi"
```

## Characters and Strings
Characters are associated to an integer
```ocaml
int_of_char 'A';;
(* - : int = 65 *)

char_of_int 66;;
(* - : char = 'B' *)

Char.code 'B';;
(* - : int = 66 *)

'\067';;
(* - : char = 'C' *)
```

Characters can be treated as integers
```ocaml
Char.chr (Char.code 'M' + Char.code 'a' - Char.code 'A');;
(* - : char = 'm' *)
```

Strings are differentiated because of the use of `"`
```ocaml
"A";;
(* - : string = "A" *)
```

They can be concatenated using the operator `^`
```ocaml
"1999" ^ "1";;
(* - : string = "19991" *)
```

You can easily convert a number on a string to an int and viceversa.  
Do note that 0 to the left are not taken into account.
```ocaml
int_of_string "1999";;
(* - : int = 1999 *)
string_of_int 10;;
(* - : string = "10" *)

string_of_int 010;;
(* - : string = "10" *)
```

## Bool
We operate with bool values using the following operators:
```ocaml
not true;;
(* - : bool = false *)

true && false;;
(* - : bool = false *)

true || false;;
(* - : bool = true *)
```

We also obtain bool values from comparisons.
Strings can be compared character by character from left to right
```ocaml
'1' < '2';;
(* - : bool = true *)

"1" < "2";;
(* - : bool = true *)

2 < 12;;
(* - : bool = true *)

"2" < "12";;
(* - : bool = false *)

"one"<"four";;
(* - : bool = false *)
```

## Tuples
The tuple itself is considered a type. It has a determined number of elements separated by commas, not necessarily with the same type.  

```ocaml
('1', '2');;
(* - : char * char = ('1', '2') *)

(1, '2');;
(* - : int * char = (1, '2') *)

1, ('a', 'b');;
(* - : int * (char * char) = (1, ('a', 'b')) *)
```

## Lists
You can have a list of any (one) type and it becomes a type itself. For example:
```ocaml
[3; 2; 1; 0];;
(* - : int list = [3; 2; 1; 0] *)

['a'; 'b'];;
(* - : char list = ['a', 'b'] *)

(* ['a'; 2];; *)
(* Type Error *)

[[];[1]];;
(* - : int list list = [[]; [1]] *)

[1; 2; 3] @ [1; -1];;
(* - : int list = [1; 2; 3; 1; -1] *)
```

Beware of using `;`instead of `,` so as to not create accidental tuples. The operator `@` is used to conncatenate lists of the same type.

---

# User-defined types
IMPORTANT: types are defined with the statement: `type ... = ...`

The **type name** (right after `type`) must be written in lowercase.

After the `=` comes the **type definition**, there's 3 cases for type definition: enumeration, records and aliases

## Enumerated data type
It is defined by an explicit list of constructors. These constructors must be capitalized

```ocaml
type mark = F | E | D | C | B | A
```
Note that the ordering is defined following the definition order (ex. F < B).  
Constructors allow pattern-matching

### Constructors can carry data
```ocaml
type commit =
    Hash of string
  | Tag of string
  | Branch of string
  | Head
  | Fetch_head
  | Orig_head
  | Merge_head
```
Note that wrapping product types with parentheses turns them into a single parameter (a tuple).  
This is often preferable due to the following behaviour:
```ocaml
# type t =
  | C1 of int * bool
  | C2 of (int * bool);;
type t = C1 of int * bool | C2 of (int * bool)

# let p = (4, false);;
val p : int * bool = (4, false)

# C1 (5, true);;
- : t = C1 (5, true)

# C1 p;;
Error: The constructor C1 expects 2 argument(s),
       but is applied here to 1 argument(s)

# C2 (5,true);;
- : t = C2 (5, true)

# C2 p;;
- : t = C2 (4, false)
```
However, you may wannt to take out the paranthesis to create a constructor that works like an operator (refer to the list example in polymorphic data types).

### Recursive types
Note that they don't need the `rec` prefix (like recursive functions do).  
They tend to have a recursive constructor a non-recursive one.

```ocaml
type nat = Zero | Succ of nat

let one = Succ Zero

let two = Succ one

let pred = function
  Succ n -> n
| Zero -> raise (Failure “pred”)
```

The types **Array** and **Object** contain values of the recursive type **json**
```ocaml
type json =
    Null
  | Bool of bool
  | Int of int
  | Float of float
  | String of string
  | Array of json list
  | Object of (string * json) list
```

### Polymorphic data types
For example:
```ocaml
type 'a option = None | Some of 'a
```
Where `'a` can be **any type**.  
In every new instance `'a`can take up any possible type.

The type **list** is polymorphic aswell.
```ocaml
type 'a list = [] | (::) of 'a * 'a list
```

## Records
Record types differ from tuples in the sense that they must be declared before being used so as to set up the fields (in both number and type). Fields are also named.
```ocaml
# type character = {
  name : string;
  level : int;
  race : string;
  class_type : character_class;
  alignment : firmness * rectitude;
  armor_class : int;
};;
type character = {
  name : string;
  level : int;
  race : string;
  class_type : character_class;
  alignment : firmness * rectitude;
  armor_class : int;
}

# let ghorghor_bey = {
    name = "Ghôrghôr Bey";
    level = 17;
    race = "half-ogre";
    class_type = Fighter;
    alignment = (Chaotic, R_Neutral);
    armor_class = -8;
  };;
val ghorghor_bey : character =
  {name = "Ghôrghôr Bey"; level = 17; race = "half-ogre";
   class_type = Fighter; alignment = (Chaotic, R_Neutral); armor_class = -8}

# ghorghor_bey.alignment;;
- : firmness * rectitude = (Chaotic, R_Neutral)

# ghorghor_bey.class_type;;
- : character_class = Fighter

# ghorghor_bey.level;;
- : int = 17
```

To construct a new record with some field values changed without typing in the unchanged fields we can use record update syntax as shown:
```ocaml
# let togrev  = { ghorghor_bey with name = "Togrev"; level = 20; armor_class = -6 };;
val togrev : character =
  {name = "Togrev"; level = 20; race = "half-ogre"; class_type = Fighter;
   alignment = (Chaotic, R_Neutral); armor_class = -6}
```

Note that records behave like single constructor variants. That allows pattern matching on them.
```ocaml
# match ghorghor_bey with { level; _ } -> level;;
- : int = 17
```

## Aliases

You can create aliases for any type. Makes documantation more readable.
```ocaml
(* Tuples as parameters *)
# let tuple_sum (x, y) = x + y;;
val tuple_sum : int * int -> int = <fun>

# let f ((x, y) as arg) = tuple_sum arg;;
val f : int * int -> int = <fun>


(* Records as parameters *)
# type dummy_record = {a: int; b: int};;
type dummy_record = { a : int; b : int; }

# let record_sum ({a; b}: dummy_record) = a + b;;
val record_sum : dummy_record -> int = <fun>

# let f ({a;b} as arg) = record_sum arg;;
val f : dummy_record -> int = <fun>
```

This is also useful for matching variant values of parameters.
```ocaml
# let meaning_of_life = function Some _ as opt -> opt | None -> Some 42;;
val meaning_of_life : int option -> int option = <fun>
```


---
For more information refer to the [official documentation](https://ocaml.org/docs/basic-data-types)