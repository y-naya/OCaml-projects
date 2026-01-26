# Euclidean Algorithm
An efficient method for computing the greatest common divisor (GCD).

> The greatest common divisor of two numbers does not change if the larger number is replaced by its difference with the smaller number

This replacement reduces the larger of the two numbers. Repeating this process gives successively smaller pairs of numbers until the two numbers become equal. When that occurs, that number is the GCD of the original two numbers.

```ocaml
let rec gcd' x y =
  (** precondition: x > 0 *)
  if (x = y) then x
  else if (x > y) then gcd' (x - y) y
  else gcd' x (y - x)
```

A more efficient version of the algorithm shortcuts these steps, **replacing the larger of the two numbers by its remainder when divided by the smaller of the two**. The algorithm stops when reaching a zero remainder.

```ocaml
let rec gcd x y =
  (** precondition: x > 0, y != 0 *)
  if (x = 0) then y
  else if (y = 0) then x
  else if (x > y) then gcd (x mod y) y
  else gcd x (y mod x)
```