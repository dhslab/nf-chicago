# nf-chicago
## Pipeline for detection of DNA looping interactions in capture Hi-C data


[![Nextflow](https://img.shields.io/badge/nextflow%20DSL2-%E2%89%A522.10.1-23aa62.svg)](https://www.nextflow.io/)
[![run with docker](https://img.shields.io/badge/run%20with-docker-0db7ed?labelColor=000000&logo=docker)](https://www.docker.com/)
[![run with singularity](https://img.shields.io/badge/run%20with-singularity-1d355c.svg?labelColor=000000)](https://sylabs.io/docs/)


**nf-chicago** is a pipeline for calling DNA looping interactions in capture Hi-C/Micro-C data using [CHiCAGO](https://www.bioconductor.org/packages/devel/bioc/vignettes/Chicago/inst/doc/Chicago.html) (Capture Hi-C Analysis of Genomic Organisation) library. **CHiCAGO compatible bam files** are required to run this workflow.

The workflow and scripts here are based on [this Dovetail tutorial](https://dovetail-capture.readthedocs.io/en/latest/interactions.html) about data analysis for promoter capture on Hi-C libraries using RE-free methods (Omni-C® or Micro-C® assays) . Check the tutorial for more details about how to prepare required input files, including [CHiCAGO compatible bam files](https://dovetail-capture.readthedocs.io/en/latest/fastq_to_bam.html#chibam). You can use [this pipeline](https://github.com/dhslab/nf-core-hic) to generate CHiCAGO compatible bam.

## Usage
   ```bash
   nextflow run dhslab/nf-chicago -r main -latest \
   -profile YOURPROFILE(S) \
   --input <SAMPLESHEET> \
   --design_directory <DESIGN_DIRECTORY> \
   --rmap <DIGEST_MAP_FILE> \
   --baitmap <BAITMAP_FILE> \
   --outdir <OUTDIR> 
   ```
### **Directory tree for run output:**

```
.
├── test1
│   ├── chicago_calls
│   │   ├── data
│   │   │   ├── test1.Rds
│   │   │   ├── test1.bedpe
│   │   │   ├── test1.ibed
│   │   │   └── test1_params.txt
│   │   ├── diag_plots
│   │   │   ├── test1_distFun.pdf
│   │   │   ├── test1_oeNorm.pdf
│   │   │   └── test1_techNoise.pdf
│   │   ├── enrichment_data
│   │   └── examples
│   │       └── test1_proxExamples.pdf
│   └── preprocessing
│       ├── test1.chinput
│       └── test1_bait2bait.bedpe
└── test2
    ├── chicago_calls
    │   ├── data
    │   │   ├── test2.Rds
    │   │   ├── test2.bedpe
    │   │   ├── test2.ibed
    │   │   └── test2_params.txt
    │   ├── diag_plots
    │   │   ├── test2_distFun.pdf
    │   │   ├── test2_oeNorm.pdf
    │   │   └── test2_techNoise.pdf
    │   ├── enrichment_data
    │   └── examples
    │       └── test2_proxExamples.pdf
    └── preprocessing
        ├── test2.chinput
        └── test2_bait2bait.bedpe
```