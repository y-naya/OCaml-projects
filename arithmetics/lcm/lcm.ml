let lcm' a b =
	let fct_a = Factor.factor a in
	let fct_b = Factor.factor b in
	let rec merge l1 l2 =
		match l1, l2 with
		(* we finish one of the lists *)
		  [], l -> l
		| l, [] -> l

		| h1::t1, h2::t2 ->
			(* common factor *)
			if h1 = h2 then
				h1 :: merge t1 t2
			(* take smaller factor *)
			(* since we go from smaller to larger factors *)
			(* and the larger could be present in the other list *)
			else if h1 < h2 then
				h1 :: merge t1 l2
			else
				h2 :: merge l1 t2
	in
	List.fold_left ( * ) 1 (merge fct_a fct_b)

let lcm a b =
	(a * b) / (Gcd.gcd a b)