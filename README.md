# cov-scripts
Covid-19 Scripts

## translate-genes.sh

### Prep

- `mafft --auto --keeplength --addfragments <SEQS> MN908947.3.fasta > aligned.fasta`
- GFF3 of: https://www.ncbi.nlm.nih.gov/nuccore/NC_045512
- requires [seqkit](https://github.com/shenwei356/seqkit/) and [bedtools]()https://bedtools.readthedocs.io/en/latest/index.html


### Steps
0. get genes from gff3, rename from gene to actual Name value
1. seqkit split to split an aligned multifasta
2. bedtools getfasta to pull gene sequences from fasta files for translation
3. seqkit translate translate those gene sequences

### Run

`translate-genes.sh aligned.fasta`
