proc addWater {outName cubeSize} {
    set halfSize [expr {0.5*$cubeSize}]
    #set min "-$halfSize -$halfSize -$halfSize"
    #set max "$halfSize $halfSize $halfSize"
    set min "0 0 0"
    set max "$cubeSize $cubeSize $cubeSize"
        solvate 4abeta_Adna_noWater.psf 4abeta_Adna_noWater.pdb -o $outName -minmax "{$min} {$max}"
}

addWater 4abeta_Adna_Water 100
