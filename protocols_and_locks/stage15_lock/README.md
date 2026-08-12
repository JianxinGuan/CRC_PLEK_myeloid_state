# Stage 15: locked GEO source-association meta-analysis

Five formal GEO cohorts from Stage 13 were analyzed under PTS-CRC-1.0.0: GSE12945, GSE17536, GSE29621, GSE39582 and GSE41258 (1,055 samples total).

The primary effects are within-cohort Spearman correlations pooled on the Fisher-z scale using REML random-effects meta-analysis. Supporting models jointly adjust for fixed endothelial, neutrophil, myeloid/macrophage, CD8/T-cell, fibroblast/stromal, leukocyte and erythrocyte scores. Results are source-proxy co-expression associations, not cell fractions or causal source estimates.

Primary decisions:

- H1, 10-gene identity/adhesion axis with endothelial state: not replicated.
- H2, 3-gene granule/effector axis with neutrophil state: replicated across all five cohorts.

See `09_STAGE15_DECISION.csv` and `12_中文结论与论文处理建议.md` for the decision boundary and manuscript interpretation.

