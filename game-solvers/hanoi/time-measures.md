These are just time measurments to check if the time complexity was right,
you can absolutely ignore them.  
I just had to do them back when I coded this, so I thought that sice they were already done I might as well leave them, I'm not even translating my notes from back then.

The function used to do the measurements is the following.  
It's very simple, just takes into account the time interval, which can be misleading when we have other tasks running on the background and taking up cpu time.
```ocaml
let rec crono f x = 
    let t = Sys.time () in
    f x; Sys.time () -. t
```




```
crono (nth_hanoi_move 1 20 1) 2;;
resultados:
9.00000000036982328e-06
1.0000000000065512e-05
9.99999999962142283e-06
1.100000000020529e-05
1.0000000000065512e-05
1.09999999997612e-05
1.0000000000065512e-05
1.100000000020529e-05
1.2000000000345068e-05
9.99999999962142283e-06
media: 1.04e-05

crono (nth_hanoi_move 1 30 1) 2;;
resultados:
1.70000000001557794e-05
1.6000000000016e-05
1.6000000000016e-05
1.70000000001557794e-05
1.6000000000016e-05
1.70000000001557794e-05
1.69999999997116902e-05
1.70000000001557794e-05
1.50000000003203127e-05
1.50000000003203127e-05
media: 1.63e-05

crono (nth_hanoi_move 1 40 1) 2;;
resultados:
2.30000000001062688e-05
2.40000000002460467e-05
2.40000000002460467e-05
2.1000000000270802e-05
2.3000000000550358e-05
2.30000000001062688e-05
2.09999999998267128e-05
1.99999999996869349e-05
2.1000000000270802e-05
2.40000000002460467e-05
media: 2.24e-05

crono (nth_hanoi_move 1 50 1) 2;;
resultados:
3.29999999997276916e-05
3.00000000001965361e-05
2.90000000000567582e-05
3.30000000001717808e-05
3.50000000004513367e-05
2.89999999996126689e-05
3.29999999997276916e-05
2.99999999997524469e-05
3.39999999998674696e-05
3.2000000000032e-05
media: 3.18e-05

crono (nth_hanoi_move 1 60 1) 2;;
resultados:
4.29999999997932036e-05
3.69999999998427143e-05
4.30000000002372929e-05
3.79999999999824922e-05
4.30000000002372929e-05
4.50000000000727596e-05
4.29999999997932036e-05
4.59999999997684483e-05
3.70000000007308927e-05
4.39999999999329816e-05
media: 4.19e-05

let media a b c d e f g h i j = (a+.b+.c+.d+.e+.f+.g+.h+.i+.j) /. 10.

comparación:
discos (nd) | tiempo (s)
20          | 1.04e-05
30          | 1.63e-05
40          | 2.24e-05
50          | 3.18e-05
60          | 4.19e-05

Si suponemos que la complejidad es O(nd) para comprobarlo podríamos dividir el tiempo entre el número de discos y ver si los resultados rondan una misma constante
1.04e-05 /. 20. = 5.20e-07
1.63e-05 /. 30. = 5.43e-07
2.24e-05 /. 40. = 5.60e-07
3.18e-05 /. 50. = 6.36e-07
4.19e-05 /. 60. = 6.98e-07

En el caso de mi código, considero que la complejidad es O(nd * log nd)

1.04e-05 /. (20. *.  Float.log2 20.) = 1.20e-07
1.63e-05 /. (30. *.  Float.log2 30.) = 1.10e-07
2.24e-05 /. (40. *.  Float.log2 40.) = 1.05e-07
3.18e-05 /. (50. *.  Float.log2 50.) = 1.12e-07
4.19e-05 /. (60. *.  Float.log2 60.) = 1.18e-07
```