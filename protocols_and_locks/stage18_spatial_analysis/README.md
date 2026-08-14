# 18_空间分析

本目录保存CRC Visium空间验证的锁定方案、原始H5AD、可复现脚本、患者级统计结果和论文用图。

运行顺序：

1. `scripts/01_download_spatial_h5ad.py`：下载并校验14个H5AD。
2. `scripts/02_run_spatial_analysis.py`：切片内评分、空间相关、置换检验、患者内合并及患者级随机效应meta-analysis。
3. `scripts/03_finalize_spatial_analysis.py`：中性粒细胞-内皮配对审计、结论表、报告及校验清单。

核心结果见 `results/07_donor_random_effects_spatial_meta.csv`、`results/09_neutrophil_vs_endothelial_paired_audit.csv` 和 `results/10_final_spatial_conclusion_table.csv`。最终解释见 `空间分析_验证报告.md`。

注意：`results/04_spot_level_scores.csv` 是探索和绘图用spot级文件，推断单位始终是患者，不可将spot作为独立重复。
