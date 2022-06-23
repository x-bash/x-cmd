# Reference: https://github.com/matvore/pb52/blob/master/pb52.c
# printf "\033]52;;$(printf "%s" "x-cmd" | base64)\a" | awk -f ocs52.awk
BEGIN{  if (CMD == "") CMD = "pbcopy";  }
function check_prefix( s ){
    match(s, "\033\]52;[^\007]+\007") || return
    copy = substr(s, RSTART+6, RLENGTH-7)
    gsub("\"", "\\\"", copy)
    "printf \"%s\"" "\"" copy "\" | base64 -d | " CMD | getline
}
{   check_prefix( $0 ); }
