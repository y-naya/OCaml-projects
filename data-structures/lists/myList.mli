val hd : 'a list -> 'a
(* Raises Failure if the list is empty *)

val tl : 'a list -> 'a list
(* Raises Failure if the list is empty *)

val last : 'a list -> 'a 
(* Return the last element of the given list *)
(* Not in module List *)
(* tail recursive *)

val length : 'a list -> int
(* not tail recursive *)

val length' : 'a list -> int
(* tail recursive *)

val compare_lengths : 'a list -> 'b list -> int
(* Returns 0 if both list have same length, 1 if first one is longer, -1 if first one is shorter *)
(* The computation stops after reaching the end of the shortest list *)
(* tail recursive *)

val append : 'a list -> 'a list -> 'a list
(* not tail recursive *)

val rev_append : 'a list -> 'a list -> 'a list
(* tail recursive *)

val rev : 'a list -> 'a list
(* tail recursive *)

val concat : 'a list list -> 'a list
(* not tail recursive *)

val flatten : 'a list list -> 'a list
(* not tail recursive *)

val init : int -> (int -> 'a) -> 'a list
(* Since 4.06 *)
(* tail recursive *)

val nth : 'a list -> int -> 'a
(* Raises Failure if the list is too short *)
(* Raises Invalid_argument if n is negative *)
(* tail recursive *)

val map : ('a -> 'b) -> 'a list -> 'b list
(* not tail recursive *)

val rev_map : ('a -> 'b) -> 'a list -> 'b list
(* tail recursive *)

val map2 : ('a -> 'b -> 'c) -> 'a list -> 'b list -> 'c list
(* Raises Invalid_argument if the two lists have different lengths *)
(* not tail recursive *)

val combine : 'a list -> 'b list -> ('a * 'b) list
(* Raises Invalid_argument if the two lists have different lengths *)
(* not tail recursive *)

val split : ('a * 'b) list -> 'a list * 'b list
(* not tail recursive *)

val find : ('a -> bool) -> 'a list -> 'a
(* tail recursive *)

val filter : ('a -> bool) -> 'a list -> 'a list
(* not tail recursive *)

val filter' : ('a -> bool) -> 'a list -> 'a list
(* tail recursive *)

val partition : ('a -> bool) -> 'a list -> 'a list * 'a list
(* not tail recursive *)

val partition' : ('a -> bool) -> 'a list -> 'a list * 'a list
(* tail recursive *)

val for_all : ('a -> bool) -> 'a list -> bool
(* tail recursive *)

val exists : ('a -> bool) -> 'a list -> bool
(* tail recursive *)

val mem : 'a -> 'a list -> bool
(* tail recursive *)

val fold_left : ('a -> 'b -> 'a) -> 'a -> 'b list -> 'a
(* tail recursive *)

val fold_right : ('a -> 'b -> 'b) -> 'a list -> 'b -> 'b
(* not tail recursive *)
