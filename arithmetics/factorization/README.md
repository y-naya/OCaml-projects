# Factorization
## Trial Division
The most laborious but easiest to understand of the integer factorization algorithms.
 > If the integer to be factored (n), can be divided by each number in turn that is less than or equal to the square root of n. <br> - Fibonacci

For example: to find the prime factors of n = 70, one can try to divide 70 by successive primes: first, 70 / 2 = 35; next, neither 2 nor 3 evenly divides 35; finally, 35 / 5 = 7, and 7 is itself prime. So 70 = 2 × 5 × 7. 

```ocaml
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
```

Note that **fct is always a prime number**, this is because all non-prime numbers are composed by prime factors, which have already passed through the loop.

---

For example, factoring 20 would look like this:
```
factor 20                         aux 20 2 []
fct = 2:    20 mod 2 = 0   then   aux 10 2 [2]
            10 mod 2 = 0   then   aux 5 2 [2;2]
            5 mod 2 <> 0   then   aux 5 3 [2;2]
fct = 3:    5 mod 3 <> 0   then   aux 5 4 [2;2]
fct = 4:    5 mod 4 <> 0   then   aux 5 5 [2;2]
fct = 5:    5 mod 5 = 0    then   aux 1 5 [5;2;2]
            n = 1          then   [1;2;2;5]
```
By the time we reach fct=4 we've already factored 2 out of the number until it can no longer be divisible by 2, therefore it can't be divisible by 4 either.