# GAP code, see https://www.gap-system.org/
# Quotient of an NEC group with signature (0;+;[-];{(t,t,u)})
# that has an infinite family of finite quotients
# acting on non-orientable surfaces with said signature.

# input data
t := 3;;
u := 5;;

# Base group.
f := FreeGroup( "a", "b", "c");;
a := f.1;; b := f.2;; c := f.3;;

# conjugated elements
x1 := (a*c*b)^3;;
x2 := a*x1*a;;      
x3 := b*x2*b;;
x4 := c*x3*c;; 
x5 := b*x4*b;; 
x6 := a*x5*a;;
x := [x1, x2, x3, x4, x5, x6];;

# NEC group with signature sigma
G := f / [ a^2, b^2, c^2, (a*b)^t, (b*c)^t, (c*a)^u ];;
a := G.1;; b := G.2;; c := G.3;;
x_G := List(x, i -> ElementOfFpGroup( FamilyObj( G.1 ), i ));;

# normal surface group.
N := Subgroup(G, x_G);;
Print("\n  Is N normal in G? ", IsNormal(G, N), ".\n");

# Conjugation table of the generators of (normal) subgroup L 
hom := IsomorphismFpGroupByGenerators(N, x_G, "x");;
Print(
    "\n Generators of the (normal) subgroup L. Conjugation table:\n\n  xi  ",
    PrintString("xi^a",25), PrintString("xi^b",25), PrintString("xi^c",25), 
    "\n--------------------------------------------------------------------------"
);
for j in x_G do 
    Print(
        "\n  ", Image(hom,j), "  ",
        PrintString(Image(hom,a*j*a), 25),
        PrintString(Image(hom,b*j*b), 25),
        PrintString(Image(hom,c*j*c), 25)
    );
od;

# Simplify and print a presentation for N
Print("\n\n\nPresentation for N:\n");
P    := PresentationFpGroup( Range(hom) );;
TzGoGo(P);;
Print(
    "\n Generators: ",
    GeneratorsOfPresentation(P), "\n Relators:\n"
);;
TzPrintRelators(P);
Print("\n\n\n");


# Add the commutator relator k
### [(acb)^3, ((cba)^(b))^3]
Print("Assuming further that x1 commutes with x3:\n");; 
k := x_G[1]^-1*x_G[3]^-1*x_G[1]*x_G[3];;
GmodK := FactorGroupFpGroupByRels( G, [k] );;

Print("\nPresentation for the subgroup L (in G/K):\n");
# again, the extra relator, and their conjugates.
x_K := List(x, i -> ElementOfFpGroup( FamilyObj( GmodK.1 ), i ));;
L := Subgroup(GmodK, x_K);;
isom := IsomorphismFpGroupByGenerators(L, x_K, "x");;
P    := PresentationFpGroup( Range(isom) );;
TzGoGo(P);;TzGoGo(P);;TzGoGo(P);;
TzPrintRelators(P);

# Reveal the Abelian structure of N
RN := FpGroupPresentation( P );;
Print("\nAbelian invariants of L:\n", AbelianInvariants( RN ), "\n");
Print("\nIs L Abelian? ", IsAbelian(RN), "\n");

# Base finite group
G1 := GmodK / L;;
# rename generators
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
