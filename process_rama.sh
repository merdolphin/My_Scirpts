#/bin/bash

for res in VAL-1 HIS-2 HIS-3 GLN-4 LYS-5 LEU-6 VAL-7 PHE-8 PHE-9 ALA-10 GLU-11 ASP-12  

do 

grep -e "$res\$" rama_0.xvg | awk '{print $1,$2}' > dihedral_$res.xvg


done

cp dihedral_*-1.xvg temp0.xvg
for i in {2..12}
do
paste temp0.xvg dihedral_*-$i.xvg > temp.xvg
mv temp.xvg temp0.xvg
done

rm dihe*.xvg
mv temp0.xvg ../dpca/pca_whole 
