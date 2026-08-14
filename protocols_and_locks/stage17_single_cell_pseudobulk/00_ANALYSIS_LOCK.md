# Stage 17 single-cell source and pseudobulk lock

- Locked on 2026-08-09 before inspecting Stage 17 gene-expression results.
- Primary dataset: CELLxGENE CRC core atlas version 4a8b9568-965e-46b8-a427-baab6bf018e5 (3,790,266 cells; complete H5AD verified in Stage 12).
- Primary population: cells with `sample_type == tumor`; blood, normal, polyp, lymph-node and metastasis samples are excluded.
- Unit of inference: donor x broad cell type pseudobulk; minimum 20 cells per donor-cell-type group and at least 10 donors for correlation testing.
- Target genes: PLEK, PPBP and PF4. Frozen score: mean log1p CPM of all three. Post-result sensitivity score: PLEK+PPBP, labelled sensitivity only.
- Neutrophil markers: FCGR3B, CSF3R, S100A8, S100A9, CXCR2, CEACAM8 and FPR1.
- Platelet-identity markers: GP1BA, GP5, GP6, GP9, ITGA2B, ITGB3, MPIG6B, P2RY12, TREML1 and TUBB1.
- Cell-level outputs: positive-cell count/fraction, mean raw count, positive-cell mean, donor coverage and within-cell marker co-detection.
- Pseudobulk outputs: summed raw counts normalized by observed total counts to log1p CPM; donor-level gene/module correlations within cell type.
- Ambient/doublet sensitivity: PPBP/PF4-positive cells with no platelet-identity marker and only one target count are flagged as ambient-like; cells co-detecting >=2 platelet-identity markers plus PPBP/PF4 are molecularly supported. Dataset reports all cells as SOLO singlets, so no additional model-based doublet removal is possible.
- Multiple testing: BH FDR within each analysis family.
- Prohibited: treating cells as independent replicates, changing cell-count thresholds after viewing results, claiming causal origin from co-expression, or treating absent platelets as proof of biological absence.

