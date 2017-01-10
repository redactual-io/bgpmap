#!/bin/bash
mrt_file=$1
ref_as=$2
help () {
	local err_msg=$1
	echo -e "\t\t$0 <bgp table file> <reference ASN>"
	if [[ ${err_msg:-null} != "null" ]]; then
		echo -e "\t\tERROR: $err_msg"
	fi
	exit
}
if [[ ${mrt_file:-null} == "null" ]]; then
	help "missing bgp table file"
elif [[ ! -f ${mrt_file} ]]; then
	help "file does not exist" 		
elif [[ ${ref_as:-null} == "null" ]]; then
	help "provide reference ASN of bgp table file"
elif ! [[ ${ref_as} =~ ^[0-9]+$ ]]; then
	help "the reference ASN must be a number"
fi
#grab the file name without the extension
fname=$(cut -d . -f1 <<< $mrt_file)
# dump the MRT format BGP table
bgpdump $mrt_file |\
# extract only the ASPATH's from each entry
sed -rn 's/ASPATH:\ //gp' |\
# remove empty lines
grep -v "^\s*$" |\
# insert the ref_as at the beginning of each path
# remove aggregate as-sets
# collapse path prepending
# convert to CSV format
# remove spaces and tabs
perl -pe "s/^/$ref_as\ /g;\
s/^(([0-9]+\s)+)(\{[0-9,]+\})/\1/g;\
s/((\b[0-9]+\b)\s)(\b\1\b)*\b\2\b/\2/g;\
s/(\d)\s+(\d)/\1,\2/g;\
s/(\ |\t)//g" |\
# split the output for multithreaded processing and generate edges
parallel --pipe ./edge_gen.sh |\
# collect edge output and deduplicate 
sort -u -t , -k1,1n -k2,2n |\
pigz --fast > $fname-BASE.gz
