# Reproduction guide

This release supports audit and partial reproduction of the reported analyses. It is not a one-command rerun package: the complete rerun requires retrieval of the documented public source datasets and the corresponding intermediate analysis inputs.

## Release

- Release: `v1.0.1-submission`
- Repository: https://github.com/JianxinGuan/CRC_PLEK_myeloid_state
- Scope: Scientific Reports submission release for the CRC PLEK-associated myeloid-state manuscript.

## Environment

- R 4.5.3 for the modified Hartung-Knapp meta-analysis.
- Python 3.13 for audit utilities and document/figure checks.
- Required R/Python package versions are recorded in `environment/` where available.

## Data sources

Retrieve source data from the original repositories using the accessions listed in the manuscript and the frozen cohort registers under `protocols_and_locks/`. GEO, TCGA and CELLxGENE data are not redistributed in this repository and remain governed by their original terms.

## Contents and order

1. Read `protocols_and_locks/stage09_frozen_protocol/08_FROZEN_PROTOCOL.md` and the later stage lock files.
2. Inspect the compact inputs under `figure_data/` and the reported result tables under `results/`.
3. Run `scripts/run_modified_hartung_knapp.R` after placing the documented stage inputs in the complete analysis workspace.
4. Compare generated estimates with the manuscript and supplementary tables.

The scripts use `PROJECT_ROOT`, `OUTPUT_ROOT`, and input-specific environment variables rather than a machine-specific absolute path. Set the five input variables below before running the meta-analysis script: `STAGE15_SPEARMAN`, `STAGE16_ROBUSTNESS`, `STAGE13_COX`, `STAGE15_ADJUSTED`, and `MNDA_SENSITIVITY`. The study-level script uses `PSEUDOBULK_SOURCE`. These files are large intermediate inputs and are intentionally excluded from this lightweight release.

## Exclusions

Patient-level identifiable information, raw GEO/TCGA/CELLxGENE downloads, expression objects, caches, logs and local prescreening utilities are excluded. The file-level decisions are recorded in `checksums/RELEASE_INVENTORY_v1.0.1-submission.csv`.

## Citation

Cite the accompanying manuscript and the exact GitHub release or commit used. The MIT licence applies only to original code; source data and manuscript materials retain their applicable terms.

