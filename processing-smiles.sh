#!/bin/bash

## written by lina <lina.oahz@gmail.com> on 4/10/2015
## to remove . part in smiles and remove the duplicate

echo "s/\[Na+\]\.//g
s/\[Fe+3\].//g
s/\[Cd++\]\.//g
s/\[Zn++\]\.//g
s/O\.O\.//g
s/Cl\.//g
s/\[Br-\]\.//g
s/\[Co++\]\.//g
s/\[Cl-\]\.//g
s/\[Cu++\]\.//g
s/\[Gd+3\]\.//g
s/\[Hg++\]\.//g
s/\[I-\]\.//g
s/\[K+\]\.//g
s/\[NH4+\]\.//g
s/\[Mn++\]\.//g
s/\[OH-\]\.//g
s/\[Ca++\]\.//g
s/\[Mg++\]\.//g
s/NN\.//g
s/^O\.//g
s/\[Pb++\]\.//g
s/^OO\.//g
s/\[Li+\]\.//g
s/I\.//g
s/\[Mn+\]\.//g
s/\[Sr++\]\.//g
s/\[Ba++\]\.//g
s/\[Tl+\]\.//g
s/Br\.//g
s/\[Cr+3\]\.//g
s/\[Fe++\]\.//g
s/\[Ni++\]\.//g
s/\[H+\]\.//g
s/\[Be++\]\.//g
s/\[Cr++\]\.//g
s/\[Sb+3\]\.//g
s/\[Cu+\]\.//g
s/\[NH3+\]O\.//g
s/\[Sb-3\]\.//g
s/^CN\.//g
s/^CNC\.//g
s/^CCN\.//g
s/^NCCO\.//g
s/^NCCCO\.//g
s/\[Ag+\]\.//g
" > sed.script


for f in *.smiles
    do
        more $f | awk '{if(length($1)>=10){print $0}}' > ${f}.1

        more $f.1 | sed  '/\./d' > ${f}.2
        more $f.1 | sed -n '/\./p' >> ${f}.2

        sed -f sed.script ${f}.2  |  sed  '/\./d' | awk '{if(length($1)>=10){print}}' > ${f}.3

    ######### process the dot part; 

        sed -f sed.script ${f}.2  |  sed -n '/\./p'  > ${f}.4
        
        more ${f}.4  | awk -F"." '{if(NF==2){print $1,$2}}'  | awk '{if(length($1)>=length($2)){print $1,$NF}else{print $2,$NF}}' > ${f}.5

        more ${f}.4 |  awk -F"." '{if(NF>2){print}}' > ${f}.6

        more ${f}.6  | sed 's/\./ /g'| awk '{m=length($1);n=1; for(i=2;i<NF; i++){if(length($i)>m){m=length($i);n=i}}{print $n,$NF}}' >> ${f}.5 

        more ${f}.5 | awk '{if(length($1)>=10){print}}' >>  ${f}.3

    ######## remove duplicate
    
    more ${f}.3 | awk '!a[$1]++'  > ${f}.7   

    done    
