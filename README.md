# CRC PLEK-associated myeloid state

This repository accompanies the manuscript **Deconstructing a platelet-related composite transcriptional state in colorectal cancer**. The study is positioned as a deconstructive biological-association analysis. Its reproducible signal is a PLEK-associated myeloid state with neutrophil-related enrichment; it is not interpreted as platelet-specific, neutrophil-specific, mechanistic, or prognostic.

## Repository contents

- `manuscript/`: the final submission manuscript.
- `figures/`: final main and supplementary figure files used by the manuscript; PDF files are the submission versions and PNG files support document embedding.
- `figure_data/`: compact CSV data underlying plotted figures.
- `results/`: final supplementary tables used by the manuscript.
- `protocols_and_locks/`: frozen analysis plans and version-control lock records.
- `scripts/`: retained statistical and reproducibility utilities. Internal one-off document-production scripts are intentionally excluded from the public release.
- `environment/`: session information and figure provenance files.
- `checksums/`: SHA-256 manifest for this repository.
- `REPRODUCTION.md`: environment, source-data, run-order, and release limitations.

## Environment and use

- R 4.5.3 was used for the modified Hartung-Knapp meta-analysis.
- Python 3.13 was used for figure assembly, audit utilities, and document checks.
- The release is intended for research reproducibility and audit, not clinical decision-making.
- Public source datasets must be retrieved from their original repositories using the accession identifiers reported in the manuscript.

## Citation

If you use this code, derived data, or analysis workflow, please cite the accompanying manuscript and the specific GitHub release or commit used. The repository metadata in `CITATION.cff` provides the citation record.

The MIT License applies only to original code. It does not relicense third-party datasets, manuscript text, figures, or supplementary materials.

## Data policy

Raw GEO/TCGA downloads, H5AD/RDS expression objects, SOFT archives, and cache files are intentionally excluded because of size and redistribution constraints. The manuscript identifies the public accessions and the analysis outputs needed to audit the reported claims. Raw data should be retrieved from the original GEO/TCGA portals using the accession identifiers in the manuscript and source-stage records.

Internal submission checklists, intermediate Word-editing scripts, local working notes, and superseded result summaries are intentionally not part of this research record.

## Analysis status

The staged analysis locks are internal, version-controlled artifacts. They are not prospective external preregistration. CMS analyses are exploratory, spatial data are supplementary, and the broad conclusion is limited to reproducible biological association.

## Contact

Corresponding author: Yongbin Qin, Yulin Red Cross Hospital, yongbinqin1988@163.com.
