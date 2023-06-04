# GAP code, see https://www.gap-system.org/
# Infinite family of finite groups
# acting with signature (0;+;[-];{(2,4,6)})

# tab size (for tabular outputs).
ts := 23;;

# NEC group with signature (0; +; [-]; {(2,4,6)})
f3 := FreeGroup(3);;
G := f3 / [
    f3.1^2, f3.2^2, f3.3^2, (f3.1*f3.2)^2, (f3.2*f3.3)^4, (f3.3*f3.1)^6
];;
a := G.1;; b := G.2;; c := G.3;;

# gens of a surface group
x1 := (a*b*c)^3;;    
x2 := a*x1*a;;
x3 := c*x2*c;;
x4 := a*x3*a;;

# surface group Lambda
xs := [ x1, x2, x3, x4 ];;
L := Subgroup(G, xs);;
Print("L=<x1,..,x4> normal in Gamma? ", IsNormal(G,L), "\n");;

# Conjugation table of x1,..,x4
hom := IsomorphismFpGroupByGenerators(L, xs, "x");;
Print(
    "\nConjugation table:\n\n  xi  ", PrintString("xi^a",ts),
    PrintString("xi^b",ts), PrintString("xi^c",ts),
"\n----------------------------------------------------------------------------"
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

# find a presentation for L
I := Range(hom);;
P := PresentationFpGroup(I);;
TzGoGo(P);;
Print(
    "Presentation for L:\n Generators: ",
    GeneratorsOfPresentation(P), "\n Relators:\n"
);;
TzPrintRelators(P);

# target surface group
f4 := FreeGroup(4);;
S := f4 / [ f4.1^2 * f4.2^2 * f4.3^2 * f4.4^2 ];;
# alternative set of generators for L
# derived from the one relator presentation.
ys := [ L.1*L.3*L.2^-1 , L.2 * L.3^-2 , L.3 , L.4*L.3^-1*L.1^-1 ];;
isom := GroupHomomorphismByImages( S, L, [S.1, S.2, S.3, S.4], ys );;
if IsBijective(isom) then
    Print("L is the desired surface group.\n\n");; 
fi;

# Add the commutator relator
Print("\nAssuming further that x1 commutes with x2:\n\n");; 
k := x1^-1 * x2^-1 * x1 * x2;;
G := FactorGroupFpGroupByRels( G, [k] );;
a := G.1;; b := G.2;; c := G.3;;

# gens of surface group in G
x1 := (a*b*c)^3;;
x2 := a*x1*a;;
x3 := c*x2*c;;
x4 := a*x3*a;;
N    := Subgroup(G, [ x1, x2, x3, x4 ]);;
# find a presentation
hom := IsomorphismFpGroupByGenerators(N, [ x1, x2, x3, x4 ]);;
I := Range(hom);;
P := PresentationFpGroup(I);;
TzGoGo(P);;
GeneratorsOfPresentation(P);;
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
