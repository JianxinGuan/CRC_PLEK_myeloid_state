# Key-audit input data dictionary

The public release excludes large intermediate files. The six inputs below are sufficient to rerun the two retained key-audit scripts. They contain cohort- or donor-level derived summaries, not raw patient-level expression matrices.

| Environment variable | Required file role | Required columns | Source stage | Access |
|---|---|---|---|---|
| `STAGE15_SPEARMAN` | GEO cohort-level state/source correlations | `cohort`, `state`, `source`, `n`, `rho`, `fisher_z`, `se_z` | GEO source meta-analysis stage | Available to qualified reviewers on request |
| `STAGE16_ROBUSTNESS` | GEO gene and leave-one-gene robustness effects | `cohort`, `score_id`, `n`, `rho`, `fisher_z`, `se_z` | Three-gene robustness stage | Available to qualified reviewers on request |
| `STAGE13_COX` | GEO survival meta-analysis effects | `cohort`, `module`, `model`, `n`, `events`, `log_hr`, `se` | GEO outcome meta-analysis stage | Available to qualified reviewers on request |
| `STAGE15_ADJUSTED` | Jointly adjusted GEO source-model coefficients | `cohort`, `state`, `source`, `n`, `beta`, `se` | GEO source meta-analysis stage | Available to qualified reviewers on request |
| `MNDA_SENSITIVITY` | Seven- versus eight-gene neutrophil-module sensitivity effects | `cohort`, `module_version`, `n`, `rho` | MNDA sensitivity stage | Available to qualified reviewers on request |
| `PSEUDOBULK_SOURCE` | Tumor donor pseudobulk and neutrophil-fraction table | `donor_id`, `study_id`, `cells`, `neutrophil_fraction`, `PLEK`, `PPBP`, `PF4`, `granule3_axis`, `PLEK_PPBP_sensitivity` | Single-cell pseudobulk stage | Available to qualified reviewers on request |

Public source datasets should be retrieved from GEO, TCGA and CELLxGENE using the accessions and dataset identifiers in the manuscript. The files above are derived intermediate summaries required for the key-audit scripts; they are not redistributed in this lightweight release.
