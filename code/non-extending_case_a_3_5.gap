# GAP code, see https://www.gap-system.org/
# Finite quotient of an NEC group with signature (0;+;[t];{(u)})
# acting with said signature as the full group Aut(S)
# on a non-orientable surface S.

# input data
t := 3;;
u := 5;;

# Base group.
f := FreeGroup( "a", "c");;
a := f.1;; c := f.2;;

# relator with odd number of c
w := c * (a^-1*c)^6 * ((a*c) * (a^-1*c)^4)^2 * ((a*c)^2 * (a^-1*c)^2)^2;;


# finite group acting with signature sigma
G := f / [ a^t, c^2, (a^(-1)*c*a*c)^u, w];;
a := G.1;; c := G.2;;

# Show properties and orders:
Print (
    "\n  Properties of G:\n-------------------------------------",
    "\n Size: ", Size(G),
    "\n Orders of the elements: \n ", 
    " o(a) = ", Order(a), " | ",
    " o(c) = ", Order(c), " | ",
" o([a,c]]) = ", Order(a*c*a^-1*c), "\n "
);

# Try to define the target map h : a |-> a^(-1), c |-> c.
Print("\n Map h: a |-> a^(-1), c |-> c :\n");
h := GroupGeneralMappingByImages( G, G, [a, c], [a^(-1), c] );;

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
hw := (a^-1*c)^5 * (a*c)^2 * (a^-1*c)^3 * (a*c)^3 * (a^-1*c) * (a*c)^7 * (a^-1*c)^2 * (a*c)^2;;
hG := FactorGroupFpGroupByRels(G, [hw]);;
a := hG.1;; c := hG.2;;
Print (
"\n  Properties of h(G):\n-------------------------------------",
    "\n Size: ", Size(hG),
    "\n Orders of the elements: \n ", 
    " o(a) = ", Order(a), " | ",
    " o(c) = ", Order(c), " | ",
    " o([a,c]]) = ", Order(a*c*a^-1*c), "\n "
);
