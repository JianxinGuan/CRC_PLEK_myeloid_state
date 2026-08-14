options(stringsAsFactors = FALSE, warn = 1)

out_dir <- "G:/New_CRC_Platelet/09_冻结血小板相关转录状态分析方案"
dir.create(out_dir, recursive = TRUE, showWarnings = FALSE)

required_packages <- "digest"
if (!requireNamespace(required_packages, quietly = TRUE)) stop("Package digest is required")
sha256 <- function(path) toupper(digest::digest(file = path, algo = "sha256"))
write_csv <- function(x, name) write.csv(x, file.path(out_dir, name), row.names = FALSE, na = "")
write_tsv <- function(x, name) write.table(x, file.path(out_dir, name), sep = "\t", quote = FALSE,
                                           row.names = FALSE, na = "")

protocol_version <- "PTS-CRC-1.0.0"
freeze_date <- "2026-08-08"
module_source_sha256 <- "090EB7A81EE2DF8708A2004EDA310C959E779941C4A50B7C60483D7EFAE02D37"

total_state <- c("GP1BA", "GP5", "GP6", "GP9", "ITGA2B", "ITGB3", "MPIG6B",
                 "P2RY12", "PF4", "PLEK", "PPBP", "TREML1", "TUBB1")
identity_adhesion <- c("GP1BA", "GP5", "GP6", "GP9", "ITGA2B", "ITGB3", "MPIG6B",
                       "P2RY12", "TREML1", "TUBB1")
granule_effector <- c("PF4", "PPBP", "PLEK")

state_info <- list(
  platelet_total_state_13 = list(genes = total_state, tier = "primary_frozen_candidate",
    interpretation = "Overall platelet-related transcriptional state; not a direct abundance measure"),
  platelet_identity_adhesion_10 = list(genes = identity_adhesion, tier = "prespecified_biological_axis",
    interpretation = "Platelet identity, receptor, adhesion, signaling, and structural axis"),
  platelet_granule_effector_3 = list(genes = granule_effector, tier = "exploratory_prespecified_axis",
    interpretation = "Granule/effector-associated axis; three genes and not a validated standalone module")
)

gene_rows <- do.call(rbind, lapply(names(state_info), function(state) {
  z <- state_info[[state]]
  data.frame(protocol_version = protocol_version, state_id = state, state_tier = z$tier,
             gene_order = seq_along(z$genes), gene = z$genes, direction = "up", weight = 1,
             interpretation = z$interpretation, frozen = TRUE)
}))
write_tsv(gene_rows, "01_frozen_state_gene_sets.tsv")

controls <- list(
  erythrocyte_control = c("HBB", "HBA1", "HBA2", "ALAS2", "SLC4A1", "GYPA", "AHSP", "EPB42"),
  leukocyte_control = c("PTPRC", "LST1", "TYROBP", "FCER1G", "CTSS", "CD74", "HLA-DRA", "CORO1A"),
  endothelial_control = c("PECAM1", "VWF", "EMCN", "KDR", "FLT1", "CDH5", "ENG", "PLVAP", "RAMP2", "ESAM")
)
control_rows <- do.call(rbind, lapply(names(controls), function(module) data.frame(
  protocol_version = protocol_version, control_module = module,
  gene_order = seq_along(controls[[module]]), gene = controls[[module]], direction = "up", weight = 1,
  source = "Stage 02 purified platelet/multilineage reference validation", frozen = TRUE)))
write_tsv(control_rows, "02_frozen_control_gene_sets.tsv")

scoring <- data.frame(
  item = c("primary_score", "rank_universe", "weights", "ties", "minimum_coverage",
           "missing_gene_handling", "three_gene_axis_rule", "alternative_score_1",
           "alternative_score_2", "scale_direction", "outcome_blinding", "random_seed_base",
           "matched_random_modules", "random_matching", "random_exclusions"),
  frozen_value = c(
    "Mean within-sample percentile rank of detected frozen members",
    "All finite mapped gene-level expression features after removing sample and endpoint fields",
    "Equal", "Average ranks", "At least 70% of frozen members measurable with non-zero variance",
    "Score detected frozen members only and report numerator/denominator; never impute absent genes",
    "Requires 3/3 genes because ceiling(0.70*3)=3",
    "Mean gene-wise Z score; technical sensitivity only",
    "Median gene-wise Z score; technical sensitivity only",
    "Higher score means higher relative expression of state genes",
    "No survival, recurrence, response, stage, CMS, MSI, or clinical association inspected in structural analysis",
    "20260808 plus a documented deterministic cohort index",
    "1000 per cohort and state",
    "Joint expression-mean and variability strata; nearest-feature fallback documented",
    "Exclude all three platelet states, erythrocyte, leukocyte, endothelial genes, blank symbols and zero-variance genes"
  ), protocol_version = protocol_version)
write_tsv(scoring, "03_frozen_scoring_specification.tsv")

analysis_hierarchy <- data.frame(
  order = 1:13,
  analysis = c(
    "Gene coverage and missingness", "Score distribution and usable variation",
    "Identity/adhesion versus granule/effector axis relationship",
    "Cross-cohort reproducibility of state structure", "Alternative scoring concordance",
    "Gene-to-score contribution", "Leave-one-gene-out stability", "Within-state pairwise coherence",
    "Erythrocyte/leukocyte/endothelial control correlations", "Matched-random module comparison",
    "CRC single-cell source attribution", "TCGA microenvironment association with purity adjustment",
    "CMS, MSI, stage and survival association"
  ),
  tier = c(rep("primary_outcome_blind", 10), "primary_source_validation", "secondary_association", "secondary_clinical"),
  permitted_stage = c(rep("Stage 10", 10), "Stage 11", "After Stages 10-11", "After Stages 10-11"),
  endpoint_access = c(rep("PROHIBITED", 11), "PERMITTED_WITH_FROZEN_MODEL", "PERMITTED_WITH_FROZEN_MODEL"),
  protocol_version = protocol_version
)
write_tsv(analysis_hierarchy, "04_frozen_analysis_hierarchy.tsv")

qc <- data.frame(
  criterion = c(
    "state_gene_coverage", "missing_expression", "primary_score_sd", "primary_score_unique_fraction",
    "primary_vs_mean_z_rho", "primary_vs_median_z_rho", "maximum_gene_score_abs_rho",
    "top_minus_second_abs_rho", "minimum_leave_one_out_rho", "maximum_control_abs_rho",
    "coherence_random_percentile", "score_sd_random_percentile", "cross_cohort_availability",
    "cross_cohort_axis_relationship"
  ),
  pass_rule = c(
    ">=0.70 (granule/effector requires 3/3)", "0 missing values among scored gene-sample cells",
    ">=0.01 on percentile-rank scale", ">=0.90", ">=0.80", ">=0.80", "<=0.90", "<=0.20",
    ">=0.90", "<=0.70", ">=0.95", ">=0.95", ">=3 independent cohorts per state",
    "Report cohort-specific rho and random-effects summary; no sign-based gene selection"
  ),
  caution_rule = c(
    "Not applicable below eligibility threshold", ">0 triggers audit", "0.005-0.01", "0.75-0.90",
    "0.70-0.80", "0.70-0.80", "0.90-0.95", "0.20-0.30", "0.85-0.90", "0.70-0.85",
    "0.80-0.95", "0.80-0.95", "2 cohorts", "Substantial heterogeneity must be reported, not optimized away"
  ),
  failure_implication = c(
    "Do not score that state in that cohort", "Resolve mapping/data defect before scoring",
    "State has inadequate measurable spread", "Score is excessively tied", "Method-sensitive state",
    "Method-sensitive state", "Potential single-gene dominance", "Potential single-gene dominance",
    "Unstable state membership", "Possible blood/endothelial confounding",
    "No coherence advantage over matched modules", "No variability advantage over matched modules",
    "Insufficient evidence for cross-cohort claim", "Treat axes as heterogeneous; do not force a pooled single module"
  ), protocol_version = protocol_version)
write_tsv(qc, "05_frozen_QC_and_decision_rules.tsv")

cohorts <- data.frame(
  cohort = c("GSE12945", "GSE14333", "GSE17536", "GSE17537", "GSE29621", "GSE39582", "GSE41258", "GSE87211", "GSE71187"),
  current_expression_source = c("existing gene-level RDS", "verified GPL570 series matrix", rep("existing gene-level RDS", 7)),
  total_state_usable = c(11, 13, 13, 13, 13, 13, 11, 13, 5),
  total_state_denominator = 13,
  stage10_role = c("eligible", "eligible_after_gene-level construction", "eligible", "eligible_same_study_family",
                   "eligible_conditional", "descriptive_anchor_not_selection", "eligible_conditional", "eligible", "excluded"),
  restriction = c("P2RY12 and TREML1 absent", "Build expression from frozen GPL570 mapping",
                  "Do not treat as independent of GSE17537 without dependence handling",
                  "Do not treat as independent of GSE17536 without dependence handling", "Verify primary tumor subset",
                  "Stage 08 results known; cannot be sole confirmation cohort", "P2RY12 and TREML1 absent; use primary CRC only",
                  "Endpoint semantics irrelevant in Stage 10; DSS noted for later clinical analysis", "Below 70% coverage"),
  endpoint_blind_stage10 = TRUE, protocol_version = protocol_version
)
write_tsv(cohorts, "06_frozen_cohort_register.tsv")

prohibited <- data.frame(
  rule_id = sprintf("P%02d", 1:10),
  prohibited_action = c(
    "Add, remove, or replace genes after viewing clinical outcomes",
    "Choose total versus sub-axis score using survival significance",
    "Choose rank, mean-Z, or median-Z scoring using clinical associations",
    "Use optimal cutpoints or minimum-P cutpoint searches as primary analysis",
    "Exclude cohorts because effect direction or P value is unfavorable",
    "Relabel platelet-related transcriptional signal as platelet infiltration or abundance without source evidence",
    "Treat the three-gene granule/effector axis as a previously validated module",
    "Combine GSE17536 and GSE17537 as independent evidence without accounting for study-family dependence",
    "Inspect stage, CMS, MSI, survival, recurrence, or response during Stage 10 structural analysis",
    "Suppress failed QC, heterogeneity, control correlations, or random-module results"
  ),
  permitted_resolution = c(
    "Create a versioned revision with biological rationale and validate independently",
    "Report all frozen scores under the stated hierarchy",
    "Use rank score as primary and both Z-score methods as sensitivity analyses",
    "Use continuous scores; any cutpoint display is secondary and prespecified",
    "Include every technically eligible cohort and report heterogeneity",
    "Use platelet-related or platelet-associated transcriptional state wording",
    "Label it exploratory and seek cross-cohort/single-cell support",
    "Use one cohort, hierarchical handling, or explicit sensitivity analysis",
    "Keep endpoint and phenotype fields outside the Stage 10 scoring workspace",
    "Report complete prespecified tables and decision status"
  ), protocol_version = protocol_version)
write_tsv(prohibited, "07_frozen_prohibited_adaptive_actions.tsv")

protocol_md <- c(
  "# Frozen protocol: platelet-related transcriptional states in CRC", "",
  paste0("Protocol version: `", protocol_version, "`  "), paste0("Freeze date: `", freeze_date, "`  "),
  "Status: `FROZEN_BEFORE_MULTICOHORT_STRUCTURAL_ANALYSIS`", "",
  "## Scientific question", "",
  "Determine the cellular source, internal heterogeneity, and CRC microenvironment relationships of platelet-related transcriptional signals. The protocol does not assume that bulk-tissue expression measures platelet infiltration, abundance, or activation.", "",
  "## Frozen states", "",
  "1. `platelet_total_state_13`: the original frozen 13-gene candidate and primary score.",
  "2. `platelet_identity_adhesion_10`: a prespecified biological decomposition covering identity, receptors, adhesion, signaling, and structure.",
  "3. `platelet_granule_effector_3`: an exploratory prespecified PF4/PPBP/PLEK axis; it is not presented as an independently validated module.", "",
  "The two sub-axes are a biological decomposition of the original 13 genes. No gene was selected using survival, recurrence, response, stage, CMS, or MSI.", "",
  "## Primary Stage-10 analysis", "",
  "Stage 10 is strictly outcome-blind. It evaluates coverage, score distributions, state relationships, scoring-method concordance, gene contribution, leave-one-out stability, control correlations, and 1000 matched random modules in each technically eligible cohort.", "",
  "GSE39582 is a descriptive anchor because its Stage-08 structure is already known. It cannot serve as the sole confirmation dataset. GSE17536/GSE17537 study-family dependence must be handled explicitly.", "",
  "## Interpretation boundary", "",
  "Allowed wording: platelet-related transcriptional state, platelet-associated signal, identity/adhesion axis, and granule/effector axis. Source attribution requires single-cell evidence; spatial localization or abundance claims require spatial/IHC evidence.", "",
  "## Later analyses", "",
  "Single-cell source attribution is primary source validation. TCGA microenvironment associations and clinical variables are secondary. CMS, MSI, stage, and survival must not be opened until the outcome-blind structural outputs and code version are locked.", "",
  "## Version control", "",
  "Any change to genes, weights, scoring, eligibility, controls, hierarchy, or thresholds requires a new semantic protocol version, a written reason, new checksums, and independent validation. The current version must remain archived and reported."
)
writeLines(protocol_md, file.path(out_dir, "08_FROZEN_PROTOCOL.md"), useBytes = TRUE)

freeze_manifest <- data.frame(
  field = c("protocol_id", "protocol_version", "freeze_date", "status", "primary_state",
            "primary_gene_count", "prespecified_axis_1", "axis_1_gene_count", "prespecified_axis_2",
            "axis_2_gene_count", "primary_scoring", "stage10_mode", "source_module_sha256",
            "stage08_result_acknowledged", "clinical_outcome_access_stage10", "amendment_rule"),
  value = c("CRC_platelet_related_transcriptional_states", protocol_version, freeze_date,
            "FROZEN_BEFORE_MULTICOHORT_STRUCTURAL_ANALYSIS", "platelet_total_state_13", "13",
            "platelet_identity_adhesion_10", "10", "platelet_granule_effector_3", "3",
            "equal-weight within-sample percentile-rank mean", "OUTCOME_BLIND", module_source_sha256,
            "Yes; GSE39582 is descriptive anchor, not independent confirmation", "PROHIBITED",
            "New semantic version plus rationale, checksums, archive, and independent validation"))
write_tsv(freeze_manifest, "09_freeze_manifest.tsv")

bundle <- list(
  protocol_version = protocol_version, freeze_date = freeze_date, state_info = state_info,
  controls = controls, scoring = scoring, analysis_hierarchy = analysis_hierarchy,
  qc_rules = qc, cohort_register = cohorts, prohibited_actions = prohibited,
  source_module_sha256 = module_source_sha256
)
saveRDS(bundle, file.path(out_dir, "frozen_protocol_bundle_PTS-CRC-1.0.0.rds"))

files_to_hash <- c(
  "freeze_platelet_transcriptional_state_protocol.R", "01_frozen_state_gene_sets.tsv",
  "02_frozen_control_gene_sets.tsv", "03_frozen_scoring_specification.tsv",
  "04_frozen_analysis_hierarchy.tsv", "05_frozen_QC_and_decision_rules.tsv",
  "06_frozen_cohort_register.tsv", "07_frozen_prohibited_adaptive_actions.tsv",
  "08_FROZEN_PROTOCOL.md", "09_freeze_manifest.tsv", "frozen_protocol_bundle_PTS-CRC-1.0.0.rds"
)
checksums <- data.frame(file = files_to_hash,
                        sha256 = vapply(file.path(out_dir, files_to_hash), sha256, character(1)),
                        protocol_version = protocol_version)
write_tsv(checksums, "10_checksums_sha256.tsv")

readme <- c(
  "CRC PLATELET-RELATED TRANSCRIPTIONAL STATE PROTOCOL FREEZE", "",
  paste0("Version: ", protocol_version), paste0("Freeze date: ", freeze_date),
  "Status: FROZEN_BEFORE_MULTICOHORT_STRUCTURAL_ANALYSIS", "",
  "This directory freezes the analysis definitions before Stage-10 multicohort structural analysis.",
  "It does not contain or inspect survival, recurrence, response, stage, CMS, MSI, or association results.", "",
  "Primary candidate: original 13-gene total state.",
  "Prespecified axis: 10-gene identity/adhesion state.",
  "Exploratory prespecified axis: PF4/PPBP/PLEK granule/effector state.", "",
  "Start with 08_FROZEN_PROTOCOL.md, 01_frozen_state_gene_sets.tsv, 05_frozen_QC_and_decision_rules.tsv, and 07_frozen_prohibited_adaptive_actions.tsv.",
  "Machine-readable definitions are stored in frozen_protocol_bundle_PTS-CRC-1.0.0.rds.",
  "Verify every file against 10_checksums_sha256.tsv before downstream use.", "",
  paste0("Reproduce: D:/R-project/R-4.5.3/R-4.5.3/bin/Rscript.exe \"", file.path(out_dir, "freeze_platelet_transcriptional_state_protocol.R"), "\"")
)
writeLines(readme, file.path(out_dir, "README.txt"), useBytes = TRUE)
writeLines(capture.output(sessionInfo()), file.path(out_dir, "11_sessionInfo.txt"), useBytes = TRUE)

cat("Frozen protocol created:", protocol_version, "\n")
