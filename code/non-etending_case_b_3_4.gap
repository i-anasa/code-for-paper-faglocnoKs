# GAP code, see https://www.gap-system.org/
# Finite quotient of an NEC group with signature (0;+;[-];{(t,t,u)})
# acting with said signature as the full group Aut(S)
# on a non-orientable surface S.

# input data
t := 3;;
u := 4;;

# Base group.
f := FreeGroup( "a", "b", "c");;
a := f.1;; b := f.2;; c := f.3;;

# NEC group with signature sigma
G := f / [ a^2, b^2, c^2, (a*b)^3, (b*c)^3, (c*a)^4, ((b*a*c*a)^2*c)^3 ];;
a := G.1;; b := G.2;; c := G.3;;

# Show properties and orders:
Print (
    "\n  Properties of the quotient:\n-------------------------------------",
    "\n Size: ", Size(G),
    "\n Orders of the elements: \n ", 
    " o(a) = ", Order(a), " | ",
    " o(b) = ", Order(b), " | ",
    " o(c) = ", Order(c), " | ",
    " o(ab) = ", Order(a*b), " | ",
    " o(bc) = ", Order(b*c), " | ",
    " o(ca) = ", Order(c*a), "\n "
);;

# Try to define the target map h.
Print("\n Map h: a |-> c, b |-> b, c |-> a :\n");
h := GroupGeneralMappingByImages( G, G, [a, b, c], [c, b, a] );;

# Check whether it is a valid map.
if IsMapping(h) then
    # Check whether it is injective (ker T = {1}).
    if Size(Kernel(h)) = 1 then
        Print("   ... is a bijective homomorphism. \n");
    fi;
# Not a valid map.
else
    Print("   ... is not a valid homomorphism. \n");
    Print(" Images of identity: ", Size(ImagesElm( h, One(G))), " \n");
fi;

# Result of adding image relator
hw := ((b*c*a*c)^2*a)^3;;
hG := FactorGroupFpGroupByRels(G, [hw]);;
a := hG.1;; b := hG.2;; c := hG.3;;
Print (
    "\n  Properties of the quotient:\n-------------------------------------",
"\n Size: ", Size(hG),
    "\n Orders of the elements: \n ", 
    " o(a) = ", Order(a), " | ",
    " o(b) = ", Order(b), " | ",
    " o(c) = ", Order(c), " | ",
    " o(ab) = ", Order(a*b), " | ",
    " o(bc) = ", Order(b*c), " | ",
    " o(ca) = ", Order(c*a), "\n "
);;
