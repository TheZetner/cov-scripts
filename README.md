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

### Results

Split folder with 4 subfolders
- `faa`     - translated protein sequences for each gene
- `fai`     - fasta indices for sequences (calculated by `bedtools getfasta`)
- `fna`     - extracted nucleotide sequences
- `seqs`    - original sequences split apart

```
split/
├── faa
│   ├── alignedwuhan.id_MN908947.3.faa
│   ├── alignedwuhan.id_Wuhan__Hu-1__2019.faa
│   └── alignedwuhan.id_Test__Sample.faa
├── fai
│   ├── alignedwuhan.id_MN908947.3.fasta.fai
│   ├── alignedwuhan.id_Wuhan__Hu-1__2019.fasta.fai
│   └── alignedwuhan.id_Test__Sample.fasta.fai
├── fna
│   ├── alignedwuhan.id_MN908947.3.fna
│   ├── alignedwuhan.id_Wuhan__Hu-1__2019.fna
│   └── alignedwuhan.id_Test__Sample.fna
└── seqs
    ├── alignedwuhan.id_MN908947.3.fasta
    ├── alignedwuhan.id_Wuhan__Hu-1__2019.fasta
    └── alignedwuhan.id_Test__Sample.fasta
```

### Parsing Results 

```
seqkit locate -m 1 -p "TNSSPDDQIGYYRRAT" split/faa/*

seqID                           patternName             pattern                 strand  start   end     matched
N::MN908947.3                   TNSSPDDQIGYYRRAT        TNSSPDDQIGYYRRAT        +       76      91      TNSSPDDQIGYYRRAT
N::Wuhan/Hu-1/2019:28273-29533  TNSSPDDQIGYYRRAT        TNSSPDDQIGYYRRAT        +       76      91      TNSSPDDQIGYYRRAT
N::Test/Sample:28273-29533      TNSSPDDQIGYYRRAT        TNSSPDDQIGYYRRAT        +       76      91      TNSSPDGQIGYYRRAT
```