# Stage 13: locked GEO overall-survival meta-analysis

## Status

Completed under frozen protocol `PTS-CRC-1.0.0`. Cohorts, endpoint, models and
sensitivities were written to `00_ANALYSIS_LOCK.md` before outcome-model execution.

## Primary analysis

Five GEO cohorts were included: GSE12945, GSE17536, GSE29621,
GSE39582 and GSE41258. The analytic Cox models contained 1,044 samples and 398
deaths after requiring positive follow-up time.

For the frozen 13-gene total state, the REML pooled hazard ratio per within-cohort
SD was 1.006 (95% CI 0.911-1.112, p=0.903; I2=0%). The stage-adjusted result was
HR 1.000 (95% CI 0.907-1.103, p=0.998). None of the five cohort-specific effects
was significant, and no primary-score proportional-hazards test had p<0.05.

Excluding the known GSE39582 anchor gave HR 0.950 (95% CI 0.825-1.093), while
excluding GSE41258, which has 11/13 genes, gave HR 1.018 (95% CI 0.908-1.142).

## Frozen secondary axes and controls

- Identity/adhesion axis: HR 0.909 (95% CI 0.778-1.063), attenuating to HR 0.987
  after stage adjustment.
- Granule/effector axis: HR 1.027 (95% CI 0.930-1.134).
- Erythrocyte control: HR 0.959 (95% CI 0.837-1.099).
- Leukocyte control: HR 0.932 (95% CI 0.844-1.029).
- Endothelial control: HR 1.150 (95% CI 1.043-1.268, p=0.0049), remaining
  significant after stage adjustment (HR 1.146, p=0.0084).

Removing PF4 or PLEK did not alter the null conclusion. Removing PPBP shifted the
estimate toward a protective association, but it remained non-significant and
heterogeneous (HR 0.856, 95% CI 0.717-1.023; I2=53%).

## Matched-random null

One thousand matched random modules were pooled across the same five cohorts.
The observed absolute pooled effect was only at the 7.3rd percentile of the random
null, with empirical two-sided p=0.927. The 13-gene state therefore shows no
survival association beyond matched random expression modules.

## Interpretation

The frozen 13-gene platelet-related transcriptional state is not an OS prognostic
marker in these GEO cohorts. This result should be reported as a prespecified
negative finding. It does not test or exclude non-survival microenvironment
associations, but it prohibits development of this state as a prognostic model on
the current evidence.

The significant endothelial control shows that clinically relevant bulk-tissue
microenvironment variation exists in the same datasets and reinforces the need to
adjust future TCGA association analyses for purity, stromal and endothelial
components.

## Released audit material

The lightweight release does not include the Stage 13 intermediate result directory or exploratory figures. The submitted manuscript, Figure 2, and supplementary workbook provide the citable presentation of these results. Full recomputation requires retrieval of the cited GEO matrices and the complete analysis workspace.
