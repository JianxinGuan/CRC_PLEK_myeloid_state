# Stage 13 analysis lock

Lock time: before outcome-model execution.

Protocol: `PTS-CRC-1.0.0`.

## Primary question

Is the frozen continuous 13-gene platelet-related transcriptional state associated
with overall survival consistently across independent primary CRC GEO cohorts?

## Cohort set

- Include: GSE12945, GSE17536, GSE29621, GSE39582, GSE41258.
- Exclude GSE17537 because it belongs to the same study family as GSE17536.
- Exclude GSE87211 because the audited endpoint is DSS rather than OS.
- Exclude GSE14333 because OS is unavailable.
- GSE39582 is retained as a descriptive anchor but cannot be the sole confirmation;
  an analysis excluding it is mandatory.

## Locked models

- Endpoint: reconstructed and audited OS time/event.
- Exposure: within-cohort standardized score; HR is reported per 1 SD.
- Primary model: univariable Cox proportional hazards model.
- Adjustment sensitivity: Cox model adjusted for submitted stage.
- Pooling: REML random-effects meta-analysis of log HR.
- Report: HR, 95% CI, p, tau-squared, Q, I-squared and prediction interval.

## Frozen hierarchy

- Primary: `platelet_total_state_13`.
- Secondary: `platelet_identity_adhesion_10` and
  `platelet_granule_effector_3`.
- Negative controls: erythrocyte, leukocyte and endothelial frozen modules.
- Matched null: the 1,000 per-cohort matched random modules frozen in Stage 10.

## Mandatory sensitivity analyses

- Exclude GSE39582.
- Exclude GSE41258, which has 11/13 total-state genes.
- Remove PF4, PPBP or PLEK individually from the 13-gene score.
- Compare the observed pooled effect with 1,000 pooled matched-random effects.

No cohort, gene or model may be selected using the observed direction or p value.
