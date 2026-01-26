# LCM
There is two ways to approach this problem

1. **Using prime factorization**: We factor both numbers and process the two lists of factors so as to get a list that combines the two of them without repeating those shared by the two of them

![Venn Diagram](https://en.wikipedia.org/wiki/File:Least_common_multiple.svg)

2. **Using the greatest common divisor**:
Taking the fundamental theorem of arithmetic as a basis, we can infer that the product of two numbers equals to the product of their lcm and gcd.
$$ a \,·\, b \: = \: lcm(a,b)\,·\, gcd(a,b) \quad \Rightarrow \quad lcm(a,b) \:= \:\frac{a\,·\,b}{gcd(a,b)} $$

## Using prime factorization
Perharps this might come as the most intuitive solution for the problem. The implementation however is considerably more complex. Moreover, the time complexity is considearbly increased, meaning a longer runtime.

However, it might be interesting to prove so by coding it:  
(also for illustration purposes)  
```ocaml
let lcm a b =
	let fct_a = factor a in (* O(√a) *)
	let fct_b = factor b in (* O(√a) *)
	let rec merge l1 l2 = 
		match l1, l2 with
		(* we finish one of the lists *)
		  [], l -> l
		| l, [] -> l
        (* compare the head on both lists *)
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
    let l = merge fct_a fct_b in (* O(log a + log b) *)
	List.fold_left ( * ) 1 l (* O(log l) *)
```
<span style="color: gray">Please refer to [this folder](/arithmetics/factorization/) for information on the implementation of _factor_</span>

We ended up with a time complexity of O(√a + √b).

## Using the greatest common divisor
On the other hand, computing the gcd proves to be considerably more efficient O(log(min(x, y))).

Most notably though, the implementation is ridiculously simpler.

```ocaml
let lcm a b =
	(a * b) / (Gcd.gcd a b)
```
<span style="color: gray">Please refer to [this folder](/arithmetics/gcd/) for information on the implementation of _gcd_</span>