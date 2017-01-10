#!/bin/bash
# Create edges between nodes represented in the CSV ASPATH
# e.g "10,34,106,45782" will become:
#	"10,34
#	 34,106
#	 106,45782"
#
perl -pe 's/((?<!^)\b[0-9]+\b(?<!$))/\1|\1/g;s/\|/\n/g' |\

#
# ensure the lower ASN is always on the left
#
awk -F',' '{if ($1 < $2) {print $1","$2} else {print $2","$1}}' |\

#
# collapse duplicate entries and sort numerically
#
sort -u -t , -k1,1n -k2,2n
