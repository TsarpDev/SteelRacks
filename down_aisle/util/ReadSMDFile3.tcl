# READSDMFILE3.TCL
# -------------------------------------------------------------------------read gm input format
#
# Written: MHS
# Date: July 2000
# UPDATED: 21/07/2004 by D.Vamvatsikos
#          It now returns NPTS as well. Also, if the output file already exists it
#          will not overwrite it. So, if you process many times the same file the
#          output file is not re-created each time: the process is much faster.
# UPDATED: 11/10/2004 by D.Vamvatsikos
#          Changed so that it will not output another file if the "header" is actually a tail
#          and will still read the NPTS and DT. This is to make it compatible with my practice
#          for processing record-files to run with traceIDA.
#          It will also replace files with the PEER info in the header with the same file 
#          with the PEER info in the tail!!
# UPDATED: 27/02/2006 by D.Vamvatsikos
#          Updated to handle PEER NGA records as well.
#          It also performs faster (and easier understood) parsing of the DT,NPTS line using "scan"
#          both for older PEER and newer PEER NGA records
# UPDATED 13/Feb/2013 by D. Vamvatsikos
#          Now it handles the even newer style of PEER record headers. The algorithm has been 
#          made more general to use a "trial-and-error" process of header parsing to manage 
#          different styles.

# 
# A procedure which parses a ground motion record from the PEER or PEER NGA
# strong motion database by finding dt,npts in the record header, then
# echoing data values to the output file.
#
# Formal arguments
#	inFilename -- file which contains PEER strong motion record
#	dt -- time step determined from file header
#       npts - number of acceleration points determined from file header
#
# Assumptions
#	The header in the PEER record is, e.g., formatted as follows:
# PACIFIC ENGINEERING AND ANALYSIS STRONG-MOTION DATA    ( OR PEER STRONG MOTION DATABASE RECORD)
# IMPERIAL VALLEY 10/15/79 2319, EL CENTRO ARRAY 6, 230                           
# ACCELERATION TIME HISTORY IN UNITS OF G                                         
# NPTS=  3930, DT= .00500 SEC
#
#      The header in the PEER NGA record is formatted as follows:
# PEER NGA STRONG MOTION DATABASE RECORD
# CORINTH EQ, 02/24/81, M6.7, CORINTH, TRANSVERSE                                 
# ACCELERATION TIME HISTORY IN UNITS OF G
# 4094    0.0100    NPTS, DT
# 
# OR (note the extra spacing before headers)
#
#   PEER NGA STRONG MOTION DATABASE RECORD
#   FRIULI, ITALY 05/06/76 2000, BARCIS, 000                                        
#   ACCELERATION TIME HISTORY IN UNITS OF G
#   NPTS=3309,    DT=0.0050SEC



proc ReadSMDFile3 {inFilename dt npts} {

	# Pass dt, npts by reference
	upvar $dt DT
        upvar $npts NPTS


	# Open the input file and catch the error if it can't be read
	if [catch {open $inFilename r} inFileID] {
		puts stderr "Cannot open $inFilename for reading"
	} else {
                set outFileID 0
               

		# Flag indicating dt is found and that ground motion
		# values should be read -- ASSUMES dt is on last line
		# of header!!!
		set flag 0
                set lcount 0

		# Look at each line in the file
		foreach line [split [read $inFileID] \n] {
                    
                        incr lcount
                        #puts $lcount
                    
			if {[llength $line] == 0} {
				# Blank line --> do nothing
				continue
			} elseif {$flag != 0} {
                                # We have read the DT and NPTS line
                                # Only numerical values will follow!!
                                if {$outFileID!=0} {
				        # Echo ground motion values to output file
				        puts $outFileID $line
                                } else {
                                        # No need to overwrite existing file. Exit
                                        break
                                }
 			} else {
                                if {$lcount<=4} {
                                  set header($lcount) $line
                                }
				# Search header lines for dt, npts. Split at spaces and commas
                                # this will produce the list: NPTS= {} 7928 {} DT= 0.0500 SEC
                                # with {} representing empty elements (length 0) which must be dropped
                                # NEW APPROACH: Split at spaces, commas, '='. This works with newer NGA
                                # headers as well (13/Feb/2012). Also remove the need for peerflag.
                                # Simply if one scanning format fails, go to the next.
				foreach word [split $line { ,=}] {
                                        if {[string match $word "NPTS"] == 1} {
                                            #puts "Parsing:$line"
					    scan $line "%d %f" NPTS DT
					    if {![info exists DT]} {
                                               # the previous line has failed. This means that the new 
                                               # first generation peer headers are present
                                               #   NPTS=3309,    DT=0.0050SEC
                                               scan $line "NPTS=%d , DT=%f" NPTS DT
					    }
                                            if {![info exists DT]} {
                                               # the previous line has failed. This means that the new 
                                               # generation of NGA headers is present. Use older scanning format
                                               #   NPTS=3309,    DT=0.0050SEC
                                               scan $line "   NPTS=%d,    DT=%f" NPTS DT
					    }
                                            #puts "NPTS=$NPTS DT=$DT"
					    # signal that you have read DT, NPTS. Any following lines 
					    # with numbers will trigger modification of the record to move
					    # the header to the end.
					    set flag 1
					    if {$lcount<=4} {
                                               set outFilename "$inFilename.temp"
                                               set outFileID [open $outFilename w]
                                            }
					    break
					} 
				}
			}
		}
                if {$outFileID!=0} {
                	# Place the header and close the output file
                        for {set i 1} {$i<=4} {incr i} {
                           puts $outFileID $header($i)
                        }
   		        close $outFileID 
                        file copy -force $outFilename $inFilename
                        file delete $outFilename
                }

		# Close the input file
		close $inFileID
	}
}

