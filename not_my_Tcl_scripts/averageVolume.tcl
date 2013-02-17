#! /usr/bin/tclsh

proc vecscale {c v} {
    set r ""
    foreach x $v {
	lappend r [expr {$c*$x}]
    }
    return $r
}

set files $argv
foreach file $files {
    puts "
---- $file ----
"

    if { ! [string equal ".xst" [string range $file end-3 end]] } {
	puts stderr "Warning: $file does not resemble and xst file"
    }
    
    set vList ""
    set ch [open $file] ;# open $file for reading
    while {[gets $ch line] > 0} { ## read each line of $ch
	## $line = one of the following
	## #$LABELS step a_x a_y a_z b_x b_y b_z c_x c_y c_z o_x o_y o_z s_x s_y s_z s_u s_v s_w
	## 0 40 0 0 0 40 0 0 0 40 0 0 0 0 0 0 0 0 0
	
	if {[string index $line 0] == "\#"} { continue } ;# skip comments
	if {[lindex $line 0] < 10000} { continue } ;# skip initial data
	
	set x [lindex $line 1]
	set y [lindex $line 5]
	set z [lindex $line 9]
	if { [catch {set v [expr {$x*$y*$z}]} error] } {
	    puts "x = $x"
	    puts "y = $y"
	    puts "z = $z"
	    error $error
	}
	lappend vList $v
	# puts $v
    }
    close $ch
    
    ## do analysis
    set vInverseSum 0
    set count 0
    foreach v $vList {
	## assume PV = NRT so that  < P > = P_target ~ < V¯¹ >
	## so the volume we want to set our system to will be < V¯¹ >¯¹
	
	## then cellSize = sqrt( <V¯¹>¯¹ )
	set vInverseSum [expr {$vInverseSum + (1./$v)}]
	incr count
    }
    set vTarget [expr { double( $count ) / $vInverseSum }]

    ## cell at last frame
    set cellV0 [expr {$x*$y*$z}]
    set cellIsotropic [vecscale [expr {pow(double($vTarget)/$cellV0,1./3)}] "$x $y $z"]
    set cellConstArea "$x $y [expr {double($vTarget)/$cellV0*$z}]"

    puts "Average target volume is                 $vTarget Å³"
    puts ""
    puts "For an isotropic unit cell, 
  paste the following into your namd configuration file:"
    foreach {x y z} $cellIsotropic { break }
    puts "
cellBasisVector1 $x 0  0
cellBasisVector2 0  $y 0
cellBasisVector3 0  0  $z
"

    puts "For a unit cell with constant area, 
  paste the following into your namd configuration file:"
    foreach {x y z} $cellConstArea { break }
    puts "
cellBasisVector1 $x 0  0
cellBasisVector2 0  $y 0
cellBasisVector3 0  0  $z
"
}

# open