# Frozen protocol: platelet-related transcriptional states in CRC

Protocol version: `PTS-CRC-1.0.0`  
Freeze date: `2026-08-08`  
Status: `FROZEN_BEFORE_MULTICOHORT_STRUCTURAL_ANALYSIS`

## Scientific question

Determine the cellular source, internal heterogeneity, and CRC microenvironment relationships of platelet-related transcriptional signals. The protocol does not assume that bulk-tissue expression measures platelet infiltration, abundance, or activation.

## Frozen states

1. `platelet_total_state_13`: the original frozen 13-gene candidate and primary score.
2. `platelet_identity_adhesion_10`: a prespecified biological decomposition covering identity, receptors, adhesion, signaling, and structure.
3. `platelet_granule_effector_3`: an exploratory prespecified PF4/PPBP/PLEK axis; it is not presented as an independently validated module.

The two sub-axes are a biological decomposition of the original 13 genes. No gene was selected using survival, recurrence, response, stage, CMS, or MSI.

## Primary Stage-10 analysis

Stage 10 is strictly outcome-blind. It evaluates coverage, score distributions, state relationships, scoring-method concordance, gene contribution, leave-one-out stability, control correlations, and 1000 matched random modules in each technically eligible cohort.

GSE39582 is a descriptive anchor because its Stage-08 structure is already known. It cannot serve as the sole confirmation dataset. GSE17536/GSE17537 study-family dependence must be handled explicitly.

## Interpretation boundary

Allowed wording: platelet-related transcriptional state, platelet-associated signal, identity/adhesion axis, and granule/effector axis. Source attribution requires single-cell evidence; spatial localization or abundance claims require spatial/IHC evidence.

## Later analyses

Single-cell source attribution is primary source validation. TCGA microenvironment associations and clinical variables are secondary. CMS, MSI, stage, and survival must not be opened until the outcome-blind structural outputs and code version are locked.

## Version control

Any change to genes, weights, scoring, eligibility, controls, hierarchy, or thresholds requires a new semantic protocol version, a written reason, new checksums, and independent validation. The current version must remain archived and reported.
