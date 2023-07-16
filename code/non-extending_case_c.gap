# GAP code, see https://www.gap-system.org/
# Finite quotient of an NEC group with signature (0;+;[-];{(2,4,8)})
# acting on a non-orientable surface with said signature.


# Base group.
f := FreeGroup( "a", "b", "c");;
a := f.1;; b := f.2;; c := f.3;;

# First group.
G1 := f / [ a^2, b^2, c^2, (a*b)^2, (b*c)^4, (c*a)^8, (a*c*b)^5 ];;
a := G1.1;; b := G1.2;; c := G1.3;;

# Show properties and orders:
Print (
    "\n  Properties of the quotient:\n-------------------------------------",
    "\n Size: ", Size(G1),
    "\n Orders of the elements: \n ", 
    " o(a) = ", Order(a), " | ",
    " o(b) = ", Order(b), " | ",
    " o(c) = ", Order(c), " | ",
    " o(ab) = ", Order(a*b)," | ",
    " o(bc) = ", Order(b*c)," | ",
    " o(ca) = ", Order(a*c), "\n "
);;

K := Subgroup(G1, [b,c]);;
Print("\nIs <b,c> normal in G1? ", IsNormal(G1,K), "\n");
NclK := NormalClosure(G1, K);;
Print("Index in G1 of the normal closure of <b,c>: ", Index(G1, NclK), "\n");
