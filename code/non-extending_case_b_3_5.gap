# GAP code, see https://www.gap-system.org/
# Finite quotient of an NEC group with signature (0;+;[-];{(3,3,5)})
# acting with said signature as the full group Aut(S)
# on a non-orientable surface S.

# antipodal generating set
x := (1,2,3)(4,5,6)(7,8,9);;   # ab
y := (1,6,10)(3,4,7);;         # bc

# mirror symmetry
b :=(1,6)(2,5)(3,4)(8,9);;

# group
G := Group([x, y]);;
Print("<x,y> contains the mirror symmetry b? ", b in G, "\n");

# generators
a := x * b;;  c := b * y;;

# generators and products
Print (
    "\n  Generators:\n",
    "   a = ", a, "\n",
    "   b = ", b, "\n",
    "   c = ", c, "\n",
    "\n  Products:\n",
    "   ab = ", x, "\n",
    "   bc = ", y, "\n",
    "   ca = ", c*a, "\n"
);;

# Show properties and orders:
Print (
    "\n  Properties of G:\n-------------------------------------",
    "\n Size: ", Size(G),
    "\n Description: ", StructureDescription(G), "\n",
    "\n Orders of the elements: \n ", 
    " o(a) = ", Order(a), " | ",
    " o(b) = ", Order(b), " | ",
    " o(c) = ", Order(c), " | ",
    " o(ab) = ", Order(a*b), " | ",
    " o(bc) = ", Order(b*c), " | ",
    " o(ca) = ", Order(c*a), "\n "
);;

# Try to define the target map h : a |-> a^(-1), c |-> c.
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
