# GAP code, see https://www.gap-system.org/
# Explores the SmallGroups library built in GAP
# to find non-orientable surface-kernel quotients 
# of an NEC group with signature (0;+;[-];{(2,m,n)})

# Warnings:
# 1. Not all orders are included in the library.
#   For details, see https://docs.gap-system.org/pkg/smallgrp/doc/chap0.html
# 2. For certain orders, the database contains a large number of
#   non-isomorphic groups. Computations can take a long time.

# input data ###################
# periods
m := 4 ;; n := 6;;

# orders multiple of...
base := 4*m*n/(m*n-2*m-2*n);; # comes from Riemann-Hurwitz formula
size := base;;

# presentation for the NEC triangle group  
f := FreeGroup( "a", "b", "c" );;
Gmm := f / [ f.1^2, f.2^2, f.3^2, (f.1*f.2)^2, (f.2*f.3)^m, (f.3*f.1)^n ];;

# counter
total := 0;;

# loop over orders multiple of 'base'
while total = 0 do

    Print("\n  Size ", size, "\n -------------------\n");
    
    nb := NumberSmallGroups(size);;
    
    # loop over all small groups of that order
    for j in [1..nb] do

        count := 0;;
        
        G := SmallGroup(size, j);
        
        # find all quotients (all epimorphisms Gmm -> G)
        quots := GQuotients( Gmm, G );

        # loop over all quotients
        for q in quots do
            a := Image(q, Gmm.1);; b := Image(q, Gmm.2);; c := Image(q, Gmm.3);; 
            
            # check that it is an unbordered surface kernel
            if Order(a)=2 and Order(b)=2 and Order(c)=2 and Order(a*b)=2 
              and Order(b*c)=m and Order(c*a)=n then
              
              K := Subgroup(G, [a*b, b*c]);

              # check that the kernel is non-orientable
              i := Index(G, K);
              if i = 1 then # non-orientable kernel

                  # check orders - make sure it acts with the desired signature
                  if Order(a)=2 and Order(b)=2 and Order(c)=2 and Order(a*b)=2 
                      and Order(b*c)=m and Order(c*a)=n then

                      # info on the group
                      Print("\n Group:  ", StructureDescription(G), "\n");

                      # get a permutation representation and refine it further
                      i := IsomorphismPermGroup(G);;
                      j := SmallerDegreePermutationRepresentation(Range(i));
                      Print("\n a = ", Image(j,Image(i,a)),
                          "\n b = ", Image(j,Image(i,b)),
                          "\n c = ", Image(j,Image(i,c)), "\n");

                      # update counters
                      count := count + 1;
                      
                  fi; #non-orientable
                  
              fi; # unbordered surface kernel

        od; # loop over quotients
        
        total := total + count;; # update counter
        
    od; # loop over groups of a given order
    
    size := size + base;
     
od; # next order

Print("\n*******************\n Groups found: ", total, ".\n");
