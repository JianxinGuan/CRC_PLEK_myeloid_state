# Stage 16 analysis lock

- Locked on 2026-08-09 before inspecting Stage 16 results.
- Protocol/cohorts: PTS-CRC-1.0.0; GSE12945, GSE17536, GSE29621, GSE39582 and GSE41258.
- Fixed target: platelet_granule_effector_3 = PF4, PPBP and PLEK.
- Fixed association: positive association with the Stage 14/15 neutrophil source module.
- Primary robustness analyses: single-gene percentile ranks; three leave-one-gene-out two-gene rank-mean scores; original three-gene rank mean.
- Technical scoring sensitivity: mean gene-wise Z score and median gene-wise Z score.
- Null analysis: 1,000 cohort-specific three-gene modules jointly matched to PF4/PPBP/PLEK on expression mean and variability, excluding all frozen platelet, control and source-module genes. Seed = 20260816 + cohort index.
- Meta-analysis: cohort Spearman correlations pooled on Fisher-z scale using random-effects REML; report heterogeneity, prediction intervals and leave-one-cohort-out results.
- Multiple testing: BH families for three single genes, three leave-one-gene-out scores, and technical scoring methods.
- A three-gene-axis conclusion requires: at least 2/3 single genes positive with FDR < 0.05; all three leave-one-gene-out pooled effects positive; both alternative scores positive; and matched-random empirical one-sided P < 0.05.
- Prohibited: changing genes, cohorts, score direction, null matching, or decision criteria after result inspection.
- Interpretation boundary: co-expression does not establish direct neutrophil transcription or causal cellular origin.

