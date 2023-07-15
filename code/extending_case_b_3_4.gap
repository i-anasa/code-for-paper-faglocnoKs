# GAP code, see https://www.gap-system.org/
# Finite quotient of an NEC group with signature (0;+;[-];{(t,t,u)})
# acting on a non-orientable surface with said signature.

# input data
t := 3;;
u := 4;;
# extra relator
rel := "(abc)^7";;

# Base group.
f := FreeGroup( "a", "b", "c");;
a := f.1;; b := f.2;; c := f.3;;
# extra relator as a word in the free group gens.
fr := ParseRelators([a,b,c], rel);;

# First group.
G1 := f / [ a^2, b^2, c^2, (a*b)^t, (b*c)^t, (c*a)^u, fr[1] ];;
a := G1.1;; b := G1.2;; c := G1.3;;

# Show properties and orders:
Print (
    "\n  Properties of the quotient:\n-------------------------------------",
    "\n Size: ", Size(G1),
    "\n Description: ", StructureDescription(G1),
    "\n Id: ", IdGroup(G1),
    "\n Orders of the elements: \n ", 
    " o(a) = ", Order(a), " | ",
    " o(b) = ", Order(b), " | ",
    " o(c) = ", Order(c), " | ",
    " o(ab) = ", Order(a*b)," | ",
    " o(bc) = ", Order(b*c)," | ",
    " o(ca) = ", Order(a*c), "\n "
);;

# Parent group.
a := f.1;; b := f.2;; c := f.3;;
Gp := f / [ a^2, b^2, c^2, (a*b)^2, (b*c)^t, (c*a)^(2*u), (c*a*c*a*b)^7 ];;
a := Gp.1;; b := Gp.2;; c := Gp.3;;

# Show properties and orders:
Print (
    "\n  Properties of the parent group:\n-------------------------------------",
    "\n Size: ", Size(Gp),
    "\n Description: ", StructureDescription(Gp),
    "\n Id: ", IdGroup(Gp),
    "\n Orders of the elements: \n ", 
    " o(a) = ", Order(a), " | ",
    " o(b) = ", Order(b), " | ",
    " o(c) = ", Order(c), " | ",
    " o(ab) = ", Order(a*b)," | ",
    " o(bc) = ", Order(b*c)," | ",
    " o(ca) = ", Order(a*c), "\n "
);;

isom := IsomorphismGroups(G1, Subgroup(Gp, [a*c*a, b,c]));
