# GAP code, see https://www.gap-system.org/
# Quotient of an NEC group with signature (0;+;[-];{(2,5,6)})
# that has an infinite family of finite quotients
# acting on non-orientable surfaces with said signature. 

# tab size (for tabular outputs.
ts := 20;;

# NEC group quotient acting with signature (0; +; [-]; {(2,5,6)})
f3 := FreeGroup(3);;
G := f3 / [
    f3.1^2, f3.2^2, f3.3^2, (f3.1*f3.2)^2, (f3.2*f3.3)^5, (f3.3*f3.1)^6,
    (f3.1*f3.2*f3.3)^5
];;
a := G.1;; b := G.2;; c := G.3;;

# gens of a normal subgroup with finite quotient:
x1 := ((a*c)^3*b)^2;;
x2 := c*x1*c;;
x3 := a*x2*a;;
x4 := b*x3*b;;

# normal subgroup
xs := [ x1, x2, x3, x4 ];;
N := Subgroup(G, xs);; 
Print("N=<x1,..,x4> normal in Gamma? ", IsNormal(G,N), "\n");;

# Conjugation table of x1,..,x4
hom := IsomorphismFpGroupByGenerators(N, [ x1, x2, x3, x4 ], "x");;
Print(
    "\nConjugation table:\n\n  xi  ", PrintString("xi^a",ts),
    PrintString("xi^b",ts), PrintString("xi^c",ts),
    "\n---------------------------------------------------------------------"
);
for j in xs do 
    Print(
        "\n  ", Image(hom,j), "  ",
        PrintString(Image(hom,a*j*a), ts),
        PrintString(Image(hom,b*j*b), ts),
        PrintString(Image(hom,c*j*c), ts)
    );
od;

Print("\n\n");

# find a presentation:
P := PresentationFpGroup( Range(hom) );;
TzGoGo(P);;
Print(
    "Presentation of N:\n Generators: ",
    GeneratorsOfPresentation(P), "\n"
);;
TzPrintRelators(P);

# Base finite group
G1 := G/N;;
#rename generators
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
    " o(ab) = ", Order(a*b), " | ",
    " o(bc) = ", Order(b*c), " | ",
    " o(ca) = ", Order(c*a), "\n "
);;
