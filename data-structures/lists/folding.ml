(* val fold_left : ('acc -> 'b -> 'acc) -> 'acc -> 'b list -> 'acc *)
(* tail recursive *)
let rec fold_left op acc = function
    []    -> acc
  | h::t  -> fold_left op (op acc h) t

let i_prod list = fold_left ( * ) 1 list

let f_prod list = fold_left ( *. ) 1. list

let lmin = function 
    [] -> raise(Failure "lmin: the list has no elements")
  | h::t -> fold_left min h t

let min_max = (* tested *)
  (* val f : 'a -> ('a * 'a) -> ('a * 'a) *)
  let f (acc1, acc2) item = (min item acc1, max item acc2) in function
    [] -> raise(Failure "lmin: the list has no elements")
  | h::t -> fold_left f (h, h) t

(* necessary function for rev and rev_append *)
let cons list item = item::list

let rev list =
  fold_left List.cons [] list

let rev_append l1 l2 = fold_left List.cons l2 l1

let rev_map f list = 
  let aux auxlist x = (f x)::auxlist
  in fold_left aux [] list

let concat list = fold_left (^) "" list