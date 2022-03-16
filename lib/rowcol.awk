# 1:2:3
function handle( astr, obj, idx,    arr, arrl ){
    arrl = split(astr, arr, ":")
    # print "astr: " idx "\t" astr "\t" arr[1] "\t" arr[2] "\t" arr[3]

    if (arrl == 1) {
        obj[idx "S"] = arr[1]
        obj[idx "E"] = arr[1] + 1
        obj[idx "P"] = 1
    } else {
        obj[idx "S"] = arr[1]
        obj[idx "E"] = (arr[2] == "") ? "" : arr[2]
        obj[idx "P"] = (arr[3] == "") ? 1 : arr[3]
    }
}

BEGIN{
    if (ROW == "") {
        rowl = 1
        row[ rowl "S" ] = 1
        row[ rowl "E" ] = ""
        row[ rowl "P" ] = 1
    } else {
        rowl = split(ROW, row, ",")
        for (i=1; i<=rowl; ++i) {
            handle( row[i], row, i )
        }
    }
}

{
    for (i=1; i<=rowl; ++i) {
        row_start   = row[ i "S" ]
        row_end     = row[ i "E" ]
        row_sep     = row[ i "P" ]
        print row_start ":\t" row_end "=\t" row_sep

        if (row_end != "") {
            if (row_end < 0) {
                data[ NR ] = $0
                continue
            }
            if (NR >= row_end) continue
        }

        if (NR < row_start)     continue
        if (row_sep != 1) {
            if ((NR - row_start) % row_sep == 0 ) continue
        }

        print $0
    }
}
