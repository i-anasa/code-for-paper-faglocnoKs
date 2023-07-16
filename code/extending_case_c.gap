# GAP code, see https://www.gap-system.org/
# Finite quotient of an NEC group with signature (0;+;[-];{(2,4,8)})
# acting on a non-orientable surface with said signature.


# Base group.
f := FreeGroup( "a", "b", "c");;
a := f.1;; b := f.2;; c := f.3;;

# First group.
G1 := f / [ a^2, b^2, c^2, (a*b)^2, (b*c)^4, (c*a)^8, (c*a*c*a*c*b)^3, (a*c*b*c*b)^4*b ];;
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

K := Subgroup(G1, [b,c, a*c*a]);;
Print("\nIs K=<b,c,aca> normal in G1? ", IsNormal(G1,K), "\n");
Print("Index [G1,K]: ", Index(G1, K), "\n");

# Parent group.
a := f.1;; b := f.2;; c := f.3;;
Gp := f / [ a^2, b^2, c^2, (a*b)^2, (b*c)^3, (c*a)^8, (b*c*a*c*a)^6, (c*a*c*a*b*c*a*b)^3*(c*a)^3*b*c*a ];;
a := Gp.1;; b := Gp.2;; c := Gp.3;;

# Show properties and orders:
Print (
"\n  Properties of the parent group:\n-------------------------------------",
"\n Size: ", Size(Gp),
    "\n Orders of the elements: \n ", 
    " o(a) = ", Order(a), " | ",
    " o(b) = ", Order(b), " | ",
    " o(c) = ", Order(c), " | ",
    " o(ab) = ", Order(a*b)," | ",
    " o(bc) = ", Order(b*c)," | ",
    " o(ca) = ", Order(a*c), "\n "
);;

isom := IsomorphismGroups(G1, Subgroup(Gp, [b,a, c*a*c]));
