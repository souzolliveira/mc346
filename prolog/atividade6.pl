v(va).
v(vb).
v(vc).
v(vd).
v(ve).
v(vf).

a(va, vb).
a(va, vc).
a(vb, vd).
a(vc, vd).
a(vc, vf).
a(vd, ve).
a(vd, vf).
/* a(vf, va). */

conectado(V1, V2) :- a(V1, V2).
conectado(V1, V2) :- a(V1, X), conectado(X, V2).

/* ?-
*   conectado(va, ve). => True
*   conectado(ve, va). => False
*/