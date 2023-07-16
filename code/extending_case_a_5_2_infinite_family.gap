# GAP code, see https://www.gap-system.org/
# Quotient of an NEC group with signature (0;+;[t];{(u)})
# that has an infinite family of finite quotients
# acting on non-orientable surfaces with said signature.

# input data
t := 5;;
u := 2;;

# tab size (for tabular outputs).
ts := 35;;

# Base group.
f := FreeGroup( "a", "c");;
a := f.1;; c := f.2;;

# conjugated elements
x1 := (a*c)^5;;
x2 := a^-1*x1*a;;
x3 := a^-1*x2*a;;
x4 := c*x3*c;;
x5 := a^-1*x4*a;;
x6 := a^-1*x5*a;;
x := [x1, x2, x3, x4, x5, x6];;

# NEC group with signature sigma
G := f / [ a^t, c^2, (a^(-1)*c*a*c)^u ];;
a := G.1;; c := G.2;;
x_G := List(x, i -> ElementOfFpGroup( FamilyObj( G.1 ), i ));;

# normal surface group.
N := Subgroup(G, x_G);;
Print("\n  Is N normal in G? ", IsNormal(G, N), ".\n");

# Conjugation table of the generators of (normal) subgroup L 
hom := IsomorphismFpGroupByGenerators(N, x_G, "x");;
Print(
    "\n Generators of the (normal) subgroup L. Conjugation table:\n\n  xi  ",
    PrintString("xi^a",ts), PrintString("xi^c",ts), 
    "\n--------------------------------------------------------------------------"
);
for j in x_G do 
    Print(
        "\n  ", Image(hom,j), "  ",
        PrintString(Image(hom,a^-1*j*a), ts),
        PrintString(Image(hom,c*j*c), ts)
    );
od;

# presentation
P    := PresentationFpGroup( Range(hom) );;

# Simplify and print a presentation for N
Print("\n\n\nPresentation for N:\n");
TzGoGo(P);;
Print(
    "\n Generators: ",
    GeneratorsOfPresentation(P), "\n Relators:\n"
);;
TzPrintRelators(P);
Print("\n\n\n");


# Add the commutator relator k
### [((c*a)^5)^a, (a*c)^5 ] (1,3)
Print("Assuming further that x1 commutes with x3:\n");; 
k := x_G[1]^-1*x_G[3]^-1*x_G[1]*x_G[3];;
GmodK := FactorGroupFpGroupByRels( G, [k] );;
#projk := GroupHomomorphismByImages( G, GmodK, [a,c], [GmodK.1, GmodK.2] );

Print("\nPresentation for the subgroup L (in G/K):\n");
# again, the extra relator, and their conjugates.
x_K := List(x, i -> ElementOfFpGroup( FamilyObj( GmodK.1 ), i ));;
N := Subgroup(GmodK, x_K);;
isom := IsomorphismFpGroupByGenerators(N, x_K, "x");;
P    := PresentationFpGroup( Range(isom) );;
TzGoGo(P);;
TzPrintRelators(P);

# Reveal the Abelian structure of N
RN := FpGroupPresentation( P );;
Print("\nAbelian invariants of L:\n", AbelianInvariants( RN ), "\n");
Print("\nIs L Abelian? ", IsAbelian(RN), "\n");

# Base finite group
G1 := GmodK/N;;
# rename generators
a := G1.1;; c := G1.2;;

# Show properties and orders:
Print (
    "\n  Properties of the quotient:\n-------------------------------------",
    "\n Size: ", Size(G1),
    "\n Description: ", StructureDescription(G1),
    "\n Id: ", IdGroup(G1),
    "\n Orders of the elements: \n ", 
    " o(a) = ", Order(a), " | ",
    " o(c) = ", Order(c), " | ",
    " o(ab) = ", Order(a*c*a^2*c), "\n "
);;
