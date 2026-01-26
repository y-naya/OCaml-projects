(* val gcd' : int -> int -> int *)
(** computes the greatest common divisor using subtraction *)
let rec gcd' x y =
  (** precondition: x > 0 *)
  if (x = y) then x
  else if (x > y) then gcd' (x - y) y
  else gcd' x (y - x)
(* takes too many steps => long computational time *)

(* val gcd_steps' : int -> int -> int *)
(** shows how many steps the gcd' function takes *)
let gcd_steps' x y =
  (** precondition: x > 0 *)
  let rec step x y s =
    if (x = y) then (x, s)
    else if (x > y) then step (x - y) y (s + 1)
    else step x (y - x) (s + 1)
  in
  step x y 0

(* val gcd : int -> int -> int *)
(** computes the greatest common divisor using the remainder of the division *)
let rec gcd x y =
  (** precondition: x > 0 *)
  if (x = 0) then (y, s)
  else if (y = 0) then (x, s)
  else if (x > y) then gcd (x mod y) y
  else gcd x (y mod x)

(* val gcd : int -> int -> int *)
(** shows how many steps the gcd function takes *)
let gcd_steps x y =
  (** precondition: x > 0, y != 0 *)
  let rec step x y s =
    if (x = 0) then (y, s)
    else if (y = 0) then (x, s)
    else if (x > y) then step (x mod y) y (s + 1)
    else step x (y mod x) (s + 1)
  in
  step x y 0