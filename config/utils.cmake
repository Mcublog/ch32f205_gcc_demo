function(LOG_INFO text)
    message("[INFO] " ${ARGV})
endfunction()

function(LOG_DEBUG text)
    message("[DEBUG] " ${ARGV})
endfunction()

function(LOG_WARN text)
    message("[WARN] " ${ARGV})
endfunction()