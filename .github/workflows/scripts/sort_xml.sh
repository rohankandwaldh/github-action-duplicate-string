awk '
BEGIN { FS="<"; OFS="\t" }
{
    idx = ( (NF == 3) && (pNF == 3) ? idx : NR )
    print idx, $0
    pNF = NF
}
' "${@:--}" |
sort -k1,1n -k2,2 |
cut -f2-