#!/bin/bash


cat Bdna_princ.pdb | sed '$d' | sed '$d' > 4abeta_Bdna.pdb

cat 1iyt-1.pdb | awk '{if(NF==12) printf("ATOM  %5d%4s%5s C%4d    %8.3f%8.3f%8.3f%6.2f%6.2f%12s \n",$2,$3,$4,$6,$7,$8,$9,$10,$11,$12)}' >> 4abeta_Bdna.pdb


cat 1iyt-2.pdb | awk '{if(NF==12) printf("ATOM  %5d%4s%5s D%4d    %8.3f%8.3f%8.3f%6.2f%6.2f%12s \n",$2,$3,$4,$6,$7,$8,$9,$10,$11,$12)}' >> 4abeta_Bdna.pdb

cat 1iyt-3.pdb | awk '{if(NF==12) printf("ATOM  %5d%4s%5s E%4d    %8.3f%8.3f%8.3f%6.2f%6.2f%12s \n",$2,$3,$4,$6,$7,$8,$9,$10,$11,$12)}' >> 4abeta_Bdna.pdb

cat 1iyt-4.pdb | awk '{if(NF==12) printf("ATOM  %5d%4s%5s F%4d    %8.3f%8.3f%8.3f%6.2f%6.2f%12s \n",$2,$3,$4,$6,$7,$8,$9,$10,$11,$12)}' >> 4abeta_Bdna.pdb

tail -n 2 Bdna_princ.pdb >> 4abeta_Bdna.pdb
