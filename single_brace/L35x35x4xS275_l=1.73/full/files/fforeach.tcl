proc fforeach {fforeach_line_ref fforeach_file_path fforeach_body} {
    upvar $fforeach_line_ref fforeach_line
        set fforeach_fid [open $fforeach_file_path r]
    fconfigure $fforeach_fid -encoding utf-8
    while {[gets $fforeach_fid fforeach_line] >= 0} {
        # ------- FOREACH BODY ------------<
            uplevel $fforeach_body
        # ------END FOREACH BODY----------->
    }          
        close $fforeach_fid
 }

