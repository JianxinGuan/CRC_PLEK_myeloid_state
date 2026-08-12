options(stringsAsFactors = FALSE)

out_dir <- "G:/New_CRC_Platelet/22_补充数据/06_小样本meta与分析锁审计"
dir.create(out_dir, recursive = TRUE, showWarnings = FALSE)

stage15 <- read.csv("G:/New_CRC_Platelet/15_4–6个GEO队列中10基因内皮关联和3基因中性粒细胞关联的跨队列复现及meta-analysis/results/04_cohort_spearman_effects.csv")
stage16 <- read.csv("G:/New_CRC_Platelet/16_3基因轴稳健性和驱动基因分析/results/04_cohort_robustness_effects.csv")
stage13 <- read.csv("G:/New_CRC_Platelet/13_冻结13基因血小板相关转录状态的4–6个GEO队列正式meta-analysis及阴性对照分析/results/04_cohort_cox_effects.csv")
adjusted <- read.csv("G:/New_CRC_Platelet/15_4–6个GEO队列中10基因内皮关联和3基因中性粒细胞关联的跨队列复现及meta-analysis/results/06_cohort_adjusted_source_models.csv")
mnda <- read.csv("G:/New_CRC_Platelet/22_补充数据/01_M2_PLEK异质性与留一法/mnda_results/PLEK_7_vs_8_gene_MNDA_sensitivity.csv")

meta_mkh <- function(y, se, label, scale) {
  vi <- se^2; k <- length(y)
  reml_obj <- function(tau2) {
    w <- 1/(vi + tau2); mu <- sum(w*y)/sum(w)
    0.5 * (sum(log(vi + tau2)) + log(sum(w)) + sum(w*(y-mu)^2))
  }
  upper <- max(2, var(y)*20, max(y^2)*5)
  tau2 <- optimize(reml_obj, c(0, upper), tol=1e-12)$minimum
  w <- 1/(vi + tau2); mu <- sum(w*y)/sum(w)
  q <- sum(w*(y-mu)^2)/(k-1)
  var_mkh <- max(1, q)/sum(w)
  se_mkh <- sqrt(var_mkh); crit <- qt(0.975, df=k-1)
  ci <- mu + c(-1,1)*crit*se_mkh
  pred <- mu + c(-1,1)*crit*sqrt(tau2 + var_mkh)
  wf <- 1/vi; muf <- sum(wf*y)/sum(wf); Q <- sum(wf*(y-muf)^2)
  I2 <- max(0, (Q-(k-1))/Q)
  p <- 2*pt(-abs(mu/se_mkh), df=k-1)
  transform <- if (scale == "correlation") tanh else if (scale == "hazard_ratio") exp else identity
  data.frame(
    analysis=label, scale=scale, k=k, estimate=transform(mu), ci_low=transform(ci[1]),
    ci_high=transform(ci[2]), p_mkh=p, tau2=tau2, I2=I2,
    prediction_low=transform(pred[1]), prediction_high=transform(pred[2]),
    df=k-1, variance_multiplier=max(1,q), stringsAsFactors=FALSE
  )
}

rows <- list()
add_cor <- function(d, label) meta_mkh(d$fisher_z, d$se_z, label, "correlation")

d <- subset(stage15, state=="platelet_granule_effector_3" & source=="neutrophil")
rows[[length(rows)+1]] <- add_cor(d, "three_gene_axis__8_gene_myeloid_neutrophil_module")
d <- subset(stage15, state=="platelet_identity_adhesion_10" & source=="endothelial")
rows[[length(rows)+1]] <- add_cor(d, "identity_adhesion_10__endothelial_module")
for (score in c("PLEK", "PPBP", "PF4", "without_PF4", "without_PLEK", "without_PPBP")) {
  d <- subset(stage16, score_id==score)
  rows[[length(rows)+1]] <- add_cor(d, paste0(score, "__8_gene_myeloid_neutrophil_module"))
}
for (version in c("8_gene", "7_gene")) {
  d <- subset(mnda, module_version==version)
  d$fisher_z <- atanh(d$rho); d$se_z <- 1/sqrt(d$n-3)
  rows[[length(rows)+1]] <- add_cor(d, paste0("PLEK__", version, "_MNDA_sensitivity"))
}
for (model_name in c("univariable", "stage_adjusted")) {
  d <- stage13[stage13$module=="platelet_total_state_13" & stage13$model==model_name, ]
  rows[[length(rows)+1]] <- meta_mkh(d$log_hr, d$se, paste0("platelet_total_state_13__OS_", model_name), "hazard_ratio")
}
d <- stage13[stage13$module=="endothelial_control" & stage13$model=="univariable", ]
rows[[length(rows)+1]] <- meta_mkh(d$log_hr, d$se, "endothelial_control__OS_univariable", "hazard_ratio")
d <- adjusted[adjusted$state=="platelet_granule_effector_3" & adjusted$source=="neutrophil", ]
rows[[length(rows)+1]] <- meta_mkh(d$beta, d$se, "three_gene_axis__jointly_adjusted_myeloid_neutrophil_beta", "identity")
d <- adjusted[adjusted$state=="platelet_identity_adhesion_10" & adjusted$source=="endothelial", ]
rows[[length(rows)+1]] <- meta_mkh(d$beta, d$se, "identity_adhesion_10__jointly_adjusted_endothelial_beta", "identity")
for (model_name in c("univariable", "stage_adjusted")) {
  d <- stage13[stage13$module=="platelet_total_state_13" & stage13$model==model_name & stage13$cohort!="GSE41258", ]
  rows[[length(rows)+1]] <- meta_mkh(d$log_hr, d$se, paste0("platelet_total_state_13__OS_", model_name, "__exclude_GSE41258"), "hazard_ratio")
}

results <- do.call(rbind, rows)
primary <- results$analysis %in% c("three_gene_axis__8_gene_myeloid_neutrophil_module", "identity_adhesion_10__endothelial_module")
results$primary_fdr_mkh <- NA_real_
results$primary_fdr_mkh[primary] <- p.adjust(results$p_mkh[primary], method="BH")
write.csv(results, file.path(out_dir, "01_modified_Hartung_Knapp_primary_and_supporting_meta.csv"), row.names=FALSE)
writeLines(capture.output(sessionInfo()), file.path(out_dir, "02_R_sessionInfo.txt"))
message("MODIFIED_HARTUNG_KNAPP_COMPLETE")
