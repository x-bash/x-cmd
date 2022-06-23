BEGIN{  if (CMD == "") CMD = "pbcopy";  }
{
    if (! match(s, "\033\]52;[^\007]+\007")) next                       # # Reference: https://github.com/matvore/pb52/blob/master/pb52.c
    copy = substr(s, RSTART+6, RLENGTH-7)
    gsub("\"", "\\\"", copy)
    "printf \"%s\"" "\"" copy "\" | base64 -d | " CMD | getline     # # printf "\033]52;;$(printf "%s" "x-cmd" | base64)\a" | awk -f ocs52.awk
}
