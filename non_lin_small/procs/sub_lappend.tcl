proc sub_lappend {listname idx args} {
    upvar 1 $listname l
    set subl [lindex $l $idx]
    lappend subl {*}$args
    lset l $idx $subl
}