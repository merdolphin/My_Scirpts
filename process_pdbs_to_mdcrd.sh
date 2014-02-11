#!/bin/bash

sed -n '6,43546p' complex_6.pdb > complex_6_m1.pdb

sed -f script -i complex_6_m1.pdb
