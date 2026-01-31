(* val move : int * int -> string *)
let move = function
    1, 2 -> " 1 -> 2    3 \n"
  | 1, 3 -> " 1 ---2--> 3 \n"
  | 2, 1 -> " 1 <- 2    3 \n"
  | 2, 3 -> " 1    2 -> 3 \n"
  | 3, 1 -> " 1 <--2--- 3 \n"
  | 3, 2 -> " 1    2 <- 3 \n"
  (* Exception for invalid moves *)
  | _, _ -> raise(Failure "move")

(* val spare : int -> int -> int *)
let spare src tar=
    if src = 1 || tar = 1 then
        if src = 2 || tar = 2 then
            3
        else
            2
    else
        1

(* val hanoi : int -> int -> int -> string *)
let rec hanoi n src tar =
    (* n número de discos, 1 <= src <= 3, 1 <= tar <= 3, src <> tar *)
    if n = 0 then "" else
    let spare = spare src tar in
    hanoi (n-1) src spare ^ move (src, tar) ^ hanoi (n-1) spare tar

let hanoi n src tar =
    if n = 0 || src = tar then "\n"
    else hanoi n src tar
       
(* val print_hanoi : int -> int -> int -> unit *)
let print_hanoi n src tar =
    if n < 0 || src < 1 || src > 3 || tar < 1 || tar > 3
       then print_endline  " ** ERROR ** \n"
       else print_endline (" =========== \n" ^ 
                           hanoi n src tar ^
                           " =========== \n")

(* hanoi n=3 src=3 tar=2 *)
 (* ===========                                                           *)
 (* 1    2 <- 3 | n=1 src=3 tar=2  |                   |                  *)
 (* 1 <--2--- 3                    | n=2 src=3 tar=1   |                  *)
 (* 1 <- 2    3 | n=1 src=2 tar=1  |                   |                  *)
 (* 1    2 <- 3                                        | n=3 src=3 tar=2  *)
 (* 1 ---2--> 3 | n=1 src=1 tar=3  |                   |                  *)
 (* 1 -> 2    3                    | n=2 src=1 tar=2   |                  *)
 (* 1    2 <- 3 | n=1 src=3 tar=2  |                   |                  *)
 (* ===========                                                           *)

(* middle move at 2^(n-1) *)
let rec middlemove = function
    1 -> 1
  | n -> 2 * middlemove (n-1)

(* val nth_hanoi_move : int -> int -> int -> int -> int * int *)
let rec nth_hanoi_move n nd src tar =
    let spare = spare src tar in
    let middle = middlemove nd in
        if n = middle
            then (src, tar)
        else if n < middle
            then nth_hanoi_move n (nd-1) src spare
        else
            nth_hanoi_move (n - middle) (nd-1) spare tar