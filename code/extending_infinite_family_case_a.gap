# GAP code, see https://www.gap-system.org/
# Quotient of an NEC group with signature (0;+;[t];{(u)})
# that has an infinite family of finite quotients
# acting on non-orientable surfaces with said signature.

# input data
t := 3;;
u := 4;;
p := 9;;
# extra relator
rel := "(ac)^7";;
# commutator of generators..
k := [1,5];;


# tab size (for tabular outputs).
ts := 30;;

# Base group.
f := FreeGroup( "a", "c");;
a := f.1;; c := f.2;;
# extra relator as a word in the free group gens.
fr := ParseRelators([a,c], rel);;

# NEC group with signature sigma
G := f / [ a^t, c^2, (a^(-1)*c*a*c)^u ];;
a := G.1;; c := G.2;;
# projection map f -> G
proj := GroupHomomorphismByImages( f, G, [f.1,f.2], [a,c] );;

# Normal closure L of the extra relator
r := Image(proj, fr);;
L := Subgroup(G, r);;
PL := PresentationNormalClosureRrs( G, L, "X" );;

# Generators of L
x_f := PrimaryGeneratorWords(PL);;     # in f
x := List(x_f, i -> Image(proj, i));;  # in G
L := Subgroup(G, x);;

# Conjugation table of the generators of (normal) subgroup L 
hom := IsomorphismFpGroupByGenerators(L, x, "x");;
Print(
    "\n Generators of the (normal) subgroup L. Conjugation table:\n\n  xi  ",
    PrintString("xi^a",ts), PrintString("xi^c",ts), 
    "\n--------------------------------------------------------------------------"
);
for j in x do 
    Print(
        "\n  ", Image(hom,j), "  ",
        PrintString(Image(hom,a^-1*j*a), ts),
        PrintString(Image(hom,c*j*c), ts)
    );
od;

# Simplify and print a presentation for L
Print("\n\n\nPresentation for L:\n");
TzGoGo(PL);;
Print(
    "\n Generators: ",
    GeneratorsOfPresentation(PL), "\n Relators:\n"
);;
TzPrintRelators(PL);
Print("\n\n\n");

# Add the commutator relator k
Print("Assuming further that x", k[1], " commutes with x", k[2], ":\n");; 
rels := [ x[k[1]]^-1*x[k[2]]^-1*x[k[1]]*x[k[2]]];;
Print(rels, "\n");

GmodK := FactorGroupFpGroupByRels( G, rels );;
projk := GroupHomomorphismByImages( f, GmodK, [f.1, f.2], [GmodK.1, GmodK.2] );;

Print("\nPresentation for the subgroup L (in G/K):\n");
# again, the extra relator, and their conjugates.
x_G := List(x_f, i -> Image(projk, i));;
N := Subgroup(GmodK, x_G);;
isom := IsomorphismFpGroup(N);;
RN   := Range(isom);;
P    := PresentationFpGroup(RN);;
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
