cat $1 | awk '{print $1 "\t" $2 "\t" $3 "\t" $5 "\t" $6 "\t" $7 "\t" $4 "\t" $8 "\t" $10 "\t" $9}' | awk NR\>1 - > $2