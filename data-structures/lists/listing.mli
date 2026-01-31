val from0to : int -> int list
(* from0to n = [0; 1; 2; ... ; n] 
   raises Exception Failure if n < 0 *)

val to0from : int -> int list
(* to0from n  = [n; n-1; ... ; 0]
   raises Exception Failure if n < 0 *)
val pair : 'a -> 'b list -> ('a * 'b) list
(* pair x [y1; y2; ...; yn] = [(x, y1; (x, y2); ... ; (x, yn)] *)

val remove_first : 'a -> 'a list -> 'a list
(* remove_first x l returns a list like l,
   but without the first occurrence of the value x.
   If the value x does not appear in l, returns l *)

val remove_all : 'a -> 'a list -> 'a list
(* remove_all x l returns a list like l,
   but without any occurrences of the value x *)

val ldif : 'a list -> 'a list -> 'a list
(* ldif l1 l2 returns a list like l1,
   but without any occurrences of the values that appear in l2 *)