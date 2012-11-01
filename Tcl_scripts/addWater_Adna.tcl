proc addWater {outName cubeSize} {
    set halfSize [expr {0.5*$cubeSize}]
    set min "-$halfSize -$halfSize -$halfSize"
    set max "$halfSize $halfSize $halfSize"
        solvate -o $outName -minmax "{$min} {$max}"
}

addWater 1iyt-Water 80
