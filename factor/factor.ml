(* val factor : int -> int list = <fun> *)
let factor n =
	let rec aux n fct l=
		if n <= 1 then 
			List.rev l
		else if n mod fct = 0 then (* is factor *)
			aux (n / fct) fct (fct::l)
		else (* not a factor *)
			aux n (fct + 1) l
	in
	if n<0 then -1 :: (aux (-n) 2 [])
	else 1 :: (aux n 2 [])

(* note: fct is always a prime number *)
(* this is because any non-prime number would not be divisible (n mod fct <> 0) *)
(* since the primes that compose it will have already passed through the loop *)
(* meaning they've been factored out *)

(* e.g.:  n=12 *)
(*        fct = 2:  12 mod 2 = 0   then   factor 6 2 [2]  		*)
(*                  6 mod 2 = 0    then   factor 3 2 [2;2]   	*)
(*                  3 mod 2 <> 0   then   factor 3 3 [2;2]    *)
(*        fct = 3:  3 mod 3 = 0    then   factor 1 3 [3;2;2]  *)
(*                  n = 1          then   [1;2;2;3]  					*)
(* non-prime numbers have already been factored out *)