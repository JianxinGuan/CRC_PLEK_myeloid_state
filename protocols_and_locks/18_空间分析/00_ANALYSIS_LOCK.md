# Stage 18 spatial analysis lock

- Locked on 2026-08-09 before downloading/inspecting spatial expression results.
- Dataset: Valdeolivas et al., npj Precision Oncology 2024, DOI 10.1038/s41698-023-00488-4; CELLxGENE collection 68cba939-4e72-4405-80ef-512a05044fba.
- Design: 7 CRC donors, two Visium sections per donor, 14 sections, 4,992 candidate spots per section.
- Primary spatial hypothesis: PLEK expression and the frozen three-gene score positively colocalize with the fixed neutrophil marker module within sections.
- Secondary hypotheses: PPBP/PF4 with platelet-identity module; target genes/axis with endothelial module; PLEK+PPBP sensitivity score with neutrophil module.
- Gene modules: neutrophil = FCGR3B, CSF3R, S100A8, S100A9, CXCR2, CEACAM8, FPR1; platelet identity = GP1BA, GP5, GP6, GP9, ITGA2B, ITGB3, MPIG6B, P2RY12, TREML1, TUBB1; endothelial = PECAM1, VWF, EMCN, KDR, FLT1, CDH5, ENG, PLVAP, RAMP2, ESAM.
- Scores: log-normalized expression followed by within-section gene-wise Z scores and equal-weight module means. Missing genes are reported; modules require >=70% coverage and the frozen three-gene axis requires 3/3.
- Spatial unit: section-level Spearman association and nearest-neighbor spatial-lag association. Sections are combined within donor before random-effects meta-analysis across 7 donors.
- Spatial null: 1,000 coordinate permutations per section for primary PLEK/three-gene associations, seed 20260818 + section index.
- Multiple testing: primary PLEK and frozen-axis hypotheses form one BH family; secondary families are adjusted separately.
- Prohibited: selecting sections/genes from observed results, treating spots as independent patients, optimizing distance thresholds, or claiming cell-cell contact/causality from Visium spots.
- Applicability rule: if target or source module coverage/detection is inadequate, report the spatial dataset as non-informative rather than a biological negative.
- Target detectability threshold: at least 20 positive in-tissue spots and >=1% detection within a section for gene-level association interpretation.
