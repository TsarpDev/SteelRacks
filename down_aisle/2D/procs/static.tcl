


 namespace eval ::static {
	addNamespace	[namespace current];
 }
 proc static {name {value ""}} {
    set caller [lindex [info level -1] 0]
    namespace eval ::static::$caller {}
    set qname ::static::${caller}::$name
    if {![info exists $qname]} {set $qname $value}
    uplevel 1 [list upvar #0 $qname $name]
 }

 
################################################################################################
#											EXPLAINING
################################################################################################

############ 	############
if 0 {
	# Example: proc Aa calls proc Bb that calls proc Cc. i.e. Aa->Bb->Cc.
	# C calls the proc static:	static X 23.2 
	# This results the following:

	
	proc static {name {value ""}} {								# name = "X"	,	value = "23.2"
		set caller [lindex [info level -1] 0];					# caller = "Cc"	
		namespace eval ::static::$caller {}						# new namespace	::static::Cc
		set qname ::static::${caller}::$name;					# qname = "::static::Cc::X"
		if {![info exists $qname]} {set $qname $value}			# if ::static::Cc::X is a new variable then X=23.2
		uplevel 1 [list upvar #0 $qname $name];					# uplevel 1: execute the command [list upvar #0 $qname $name] at the previous level: in proc Cc
																# [ list upvar #0 ::static::Cc::X X]	create variable ::static::Cc::X in the global level and link it with X in level Cc
	}




}