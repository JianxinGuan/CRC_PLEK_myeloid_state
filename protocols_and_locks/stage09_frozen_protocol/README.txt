CRC PLATELET-RELATED TRANSCRIPTIONAL STATE PROTOCOL FREEZE

Version: PTS-CRC-1.0.0
Freeze date: 2026-08-08
Status: FROZEN_BEFORE_MULTICOHORT_STRUCTURAL_ANALYSIS

This directory freezes the analysis definitions before Stage-10 multicohort structural analysis.
It does not contain or inspect survival, recurrence, response, stage, CMS, MSI, or association results.

Primary candidate: original 13-gene total state.
Prespecified axis: 10-gene identity/adhesion state.
Exploratory prespecified axis: PF4/PPBP/PLEK granule/effector state.

Start with 08_FROZEN_PROTOCOL.md, 01_frozen_state_gene_sets.tsv, 05_frozen_QC_and_decision_rules.tsv, and 07_frozen_prohibited_adaptive_actions.tsv.
The original machine-readable bundle and protocol-generation script are
not redistributed in this lightweight release because they are local
intermediate artifacts. The retained TSV and Markdown files define the
frozen protocol. `10_checksums_sha256.tsv` is an archival manifest of the
original freeze, not a checksum manifest for the lightweight release.
