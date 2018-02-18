proc proc_ref {name arglist body} {
    set header {}
    foreach a $arglist {
        if {[string first * $a] == 0} {
            append header "upvar 1 \[set $a] [string range $a 1 end];"
        }
    }
    proc $name $arglist $header$body
}


################################################################################################
#											EXPLAINING
################################################################################################


############ APPEND EXAMPLE	############
if 0 {
	set vec {}	#a blank list
	for {set i 1} { $i<= 10} {incr i} {
		append vec "[expr $i*10]\n";	#put each value in list vec
	}	
	puts "$vec";	#it will print 10\n20\n ....
}

############ UPVAR EXAMPLE	############
if 0 {
	set b 3;	#	b=3
	upvar	0	b	w;	# upvar level Var Pseudoname.	w=$b
	incr w;				#	b=b+1=4
	puts "$b";			#	4
}

############ PROC REF EXAMPLE	############
if 0 {

	proc proc_ref {name arglist body} {
		set header {}
		foreach a $arglist {
			if {[string first * $a] == 0} {
				append header "upvar 1 \[set $a] [string range $a 1 end];"
			}
		}
		puts	"$header";	# it will print:	upvar 1 [set *v] v;
		puts	"$header$body";		# it will print the whole body of the proc my_proc:		upvar 1 [set *v] v;puts "$v";
		proc $name $arglist $header$body
	}
	
	
	proc2 my_proc {a *v c} {puts "$v"}

	set a 3;
	set v {5	8	9	10};
	set c 4;
	my_proc	a	v	c;	#it will print:	5	8	9	10. 

}