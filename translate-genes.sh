#!/bin/bash --login

# translate-genes.sh <ALIGNED SEQUENCES>
# requires seqkit and bedtools
# seqkit split to split an aligned multifasta
# bedtools getfasta to pull gene sequences from fasta files for translation
# seqkit translate translate those gene sequences

# head -n 2 NC_045512.2.gff3 > genes.gff3
# grep "\sgene\s" NC_045512.2.gff3 >> genes.gff3
# 
# sed -i 's/gene\(.*\)Name\=\([^;]*\);\(.*\)/\2\1\3/g' genes.gff3
# 
# seqkit split --force -i -O split $1

for i in `ls split/*.fasta`;
   do ID=`grep ">" $i`;   
   F=${i%.*};
   sed -i "s|$ID|>NC_045512.2|g" $i; 
   bedtools getfasta -name -rna -fullHeader -fi $i -fo $F.fna -bed genes.gff3;
   sed -i "s|>NC_045512.2|$ID|g" $i; 
   sed -i "s|NC_045512.2|${ID//>}|g" $F.fna; 
   seqkit translate $F.fna > $F.faa;   
done

