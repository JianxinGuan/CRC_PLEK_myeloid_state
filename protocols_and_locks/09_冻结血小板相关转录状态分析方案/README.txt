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
Machine-readable definitions are stored in frozen_protocol_bundle_PTS-CRC-1.0.0.rds.
Verify every file against 10_checksums_sha256.tsv before downstream use.

Reproduce: D:/R-project/R-4.5.3/R-4.5.3/bin/Rscript.exe "G:/New_CRC_Platelet/09_冻结血小板相关转录状态分析方案/freeze_platelet_transcriptional_state_protocol.R"
