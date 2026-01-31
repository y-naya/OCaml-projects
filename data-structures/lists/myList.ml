(* val hd : 'a list -> 'a *)
let hd = function
    []    -> raise(Failure "hd: the list is empty")
  | h::_  -> h

(* val tl : 'a list -> 'a list *)
(* Raises Failure if the list is empty *)
let tl = function
    [] -> raise(Failure "tl: the list is empty")
  | _::t -> t


(* val last : 'a list -> 'a  *)
(* Return the last element of the given list *)
(* Not in module List *)
(* tail recursive *)
let rec last = function
    []    -> raise (Failure "last: the list is empty")
  | h::[] -> h
  | h::t  -> last t

(* fold_left done earlier for convinience *)
(* val fold_left : ('acc -> 'b -> 'acc) -> 'acc -> 'b list -> 'acc *)
(* tail recursive *)
let rec fold_left op acc list = 
  match list with
    []    -> acc
  | h::t  -> fold_left op (op acc h) t

(* val length : 'a list -> int *)
(* not tail recursive *)
let rec length = function
    [] -> 0
  | _::t -> 1 + length t

(* val length' : 'a list -> int *)
(* tail recursive *)
let length' list = fold_left (fun acc _ -> acc + 1) 0 list

(* val compare_lengths : 'a list -> 'b list -> int *)
(* Returns 0 if both lists have same length, 1 if first one is longer, -1 if first one is shorter *)
(* The computation stops after reaching the end of the shortest list *)
(* tail recursive *)
let rec compare_lengths l1 l2 =
  match l1, l2 with
    [],[] -> 0
  | _ ,[] -> 1
  | [], _ -> -1
  | _::t1, _::t2 -> compare_lengths t1 t2


(* val append : 'a list -> 'a list -> 'a list *)
(* not tail recursive *)
let rec append l1 l2 =
  match l1 with
    [] -> l2
  | h::t -> h :: append t l2


(* val rev_append : 'a list -> 'a list -> 'a list *)
(* tail recursive *)
(* EXAMPLE:                                     *)
(* l1:      [ 1; 2; 3; 4; 5]   t2: [ 9; 10; 11] *)
(* result:  [ 5; 4, 3; 2; 1; 9; 10; 11]         *)
let rec rev_append l1 l2=
  match l1 with
    [] -> l2
  | h::t -> rev_append t (h::l2)


(* val rev : 'a list -> 'a list *)
(* tail recursive *)
let rev list = 
	let rec reversal newlist = function
    []    -> newlist
  | h::t  -> let res = h::newlist
							in reversal res t
	in reversal [] list

(* val concat : 'a list list -> 'a list *)
(* not tail recursive *)
let rec concat = function
    [] -> []
  | h1::t -> append h1 (concat t)

(* val flatten : 'a list list -> 'a list *)
(* not tail recursive *)
let flatten = concat

(* val init : int -> (int -> 'a) -> 'a list *)
(* tail recursive *)
let init len f =
  if len = 0 then []
  else
    let rec apply list f x =
      if x = (-1) then list
      else
        let newlist = (f x)::list in
          apply newlist f (x-1)
    in apply [] f (len-1)

(* val nth : 'a list -> int -> 'a *)
(* Raises Failure if the list is too short *)
(* Raises Invalid_argument if n is negative *)
(* tail recursive *)
let rec nth list n =
  match list, n with
    [], _   -> raise (Failure "nth: the list is too short")
  | h::t, 0 -> h
  | _::t, n -> if (n < 0) then raise (Invalid_argument "nth: n cannot be negative")
               else nth t (n-1)

(* val map : ('a -> 'b) -> 'a list -> 'b list *)
(* not tail recursive *)
let rec map f = function
    [] 	 -> []
	| h::t -> (f h)::(map f t)

(* val rev_map : ('a -> 'b) -> 'a list -> 'b list *)
(* tail recursive *)
let rev_map f list =
	let rec apply f auxlist = function
			[] 	 -> auxlist
		| h::t -> apply f ((f h)::auxlist) t
	in rev(apply f [] list)

(* val map2 : ('a -> 'b -> 'c) -> 'a list -> 'b list -> 'c list *)
(* Raises Invalid_argument if the two lists have different lengths *)
(* tail recursive *)
let map2 f l1 l2 =
	let rec apply f auxlist l1 l2 =
		let fail = raise (Invalid_argument "map2: lists must have the same length")
		in match l1, l2 with
			[],[] -> auxlist
		| _, [] -> fail
		| [], _ -> fail
		| h1::t1, h2::t2 -> apply f ((f h1 h2)::auxlist) t1 t2
	in rev(apply f [] l1 l2)
(* not tail recursive *)
let rec map2' f l1 l2 =
	let fail = raise (Invalid_argument "map2': lists must have the same length")
	in match l1, l2 with
		[],[] -> []
	| _, [] -> fail
	| [], _ -> fail
	| h1::t1, h2::t2 -> (f h1 h2)::(map2' f t1 t2)

(* val combine : 'a list -> 'b list -> ('a * 'b) list *)
(* Raises Invalid_argument if the two lists have different lengths *)
(* not tail recursive *)
let rec combine l1 l2 =
	match l1, l2 with
	[], [] -> []
	| _, [] | [], _ -> raise (Invalid_argument "combine: lists must have the same length")
	| h1::t1, h2::t2 -> (h1, h2)::(combine t1 t2)


(* val split : ('a * 'b) list -> 'a list * 'b list *)
(* not tail recursive *)
let rec split = function
		[] 		-> [],[]
	| (a,b)::t 	-> 
			match split t with
			ta, tb -> a::ta, b::tb

(* val find : ('a -> bool) -> 'a list -> 'a *)
(* tail recursive *)
let rec find f = function
		[] -> raise (Not_found)
	| h::t -> if f h then h
						else find f t

(* val filter : ('a -> bool) -> 'a list -> 'a list *)
(* not tail recursive *)
let rec filter f = function
    [] -> []
  | h::t -> if f h then h::(filter f t)
            else filter f t

(* val filter' : ('a -> bool) -> 'a list -> 'a list *)
(* tail recursive *)
let filter' f list = 
  let rec aux res = function
      []   -> res
    | h::t -> if f h then aux (h::res) t
              else aux res t
  in rev (aux [] list)

(* val partition : ('a -> bool) -> 'a list -> 'a list * 'a list *)
(* not tail recursive *)
let rec partition f = function
    [] -> [], []
  | h::t -> match f h, partition f t with
              true, (l1, l2) -> h::l1, l2
              | _,  (l1, l2) -> l1, h::l2

(* val partition' : ('a -> bool) -> 'a list -> 'a list * 'a list *)
(* tail recursive *)
let partition' f list =
  let rec aux l1 l2 = function
      []   -> l1, l2
    | h::t -> if f h then aux (h::l1) l2 t
              else aux l1 (h::l2) t
  in aux [] [] (rev list)

(* val for_all : ('a -> bool) -> 'a list -> bool *)
(* tail recursive *)
let rec for_all f = function
		[] -> true
	| h::t -> if f h then for_all f t
						else false

(* val exists : ('a -> bool) -> 'a list -> bool *)
(* tail recursive *)
let rec exists f = function
		[] -> false
	| h::t -> if f h then true
						else exists f t

(* val mem : 'a -> 'a list -> bool *)
(* tail recursive *)
let rec mem a = function
    []   -> false
  | h::t -> h = a || mem a t

(* val fold_left : ('acc -> 'b -> 'acc) -> 'acc -> 'b list -> 'acc *)
(* tail recursive *)
let rec fold_left op acc = function
    []    -> acc
  | h::t  -> fold_left op (op acc h) t

(* val fold_right : ('a -> 'acc -> 'acc) -> 'a list -> 'acc -> 'acc *)
(* not tail recursive *)
let rec fold_right op list acc =
  match list with
    []    -> acc
  | h::t  -> op h (fold_right op t acc)

