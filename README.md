# CRC PLEK-associated myeloid state

This repository accompanies the manuscript **Deconstructing a platelet-related composite transcriptional state in colorectal cancer**. The study is positioned as a deconstructive biological-association analysis. Its reproducible signal is a PLEK-associated myeloid state with neutrophil-related enrichment; it is not interpreted as platelet-specific, neutrophil-specific, mechanistic, or prognostic.

## Repository contents

- `manuscript/`: submission manuscript, revision record, and Scientific Reports checklist.
- `figures/`: main and supplementary figure files used by the manuscript.
- `figure_data/`: compact CSV data underlying plotted figures.
- `results/`: final tables and audit outputs, including modified Hartung-Knapp meta-analysis, MNDA sensitivity, single-cell study-level robustness, and GSE41258 coverage.
- `protocols_and_locks/`: frozen analysis plans and version-control lock records.
- `scripts/`: analysis and manuscript-generation scripts retained for provenance.
- `environment/`: session information and figure provenance files.
- `checksums/`: SHA-256 manifest for this repository.

## Data policy

Raw GEO/TCGA downloads, H5AD/RDS expression objects, SOFT archives, and cache files are intentionally excluded because of size and redistribution constraints. The manuscript identifies the public accessions and the analysis outputs needed to audit the reported claims. Raw data should be retrieved from the original GEO/TCGA portals using the accession identifiers in the manuscript and source-stage records.

## Analysis status

The staged analysis locks are internal, version-controlled artifacts. They are not prospective external preregistration. CMS analyses are exploratory, spatial data are supplementary, and the broad conclusion is limited to reproducible biological association.

## Contact

Corresponding author: Yongbin Qin, Yulin Red Cross Hospital, yongbinqin1988@163.com.
