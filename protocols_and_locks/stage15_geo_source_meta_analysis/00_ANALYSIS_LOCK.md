# Stage 15 locked cross-cohort source-association analysis

- Locked before inspecting Stage 15 associations: 2026-08-09.
- Protocol: PTS-CRC-1.0.0; frozen rank-mean scores and >=70% module coverage.
- Cohorts: GSE12945, GSE17536, GSE29621, GSE39582, GSE41258, identical to the five formal Stage 13 GEO cohorts.
- Primary H1: platelet_identity_adhesion_10 is positively associated with the fixed endothelial module.
- Primary H2: platelet_granule_effector_3 is positively associated with the fixed neutrophil module.
- Primary effect: within-cohort Spearman correlation, Fisher-z transformed, random-effects REML meta-analysis.
- Supporting effect: standardized coefficient from a jointly adjusted model containing endothelial, neutrophil, myeloid/macrophage, CD8/T-cell, fibroblast/stromal, leukocyte and erythrocyte module scores.
- Specificity checks: both platelet axes against all source modules and frozen negative controls; leave-one-cohort-out meta-analysis; heterogeneity and prediction intervals; VIF audit.
- FDR: primary H1/H2 are a two-test BH family. Supporting association families are adjusted separately.
- Prohibited: cohort/gene selection based on results, gene reweighting, outcome analysis, cutpoint optimization, removal of heterogeneous cohorts after result inspection.
- Interpretation: module associations are co-expression/source proxies, not cell fractions or causal cell-of-origin proof.

