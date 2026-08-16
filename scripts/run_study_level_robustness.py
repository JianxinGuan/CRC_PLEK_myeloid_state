from pathlib import Path
import os
import warnings

import numpy as np
import pandas as pd
import statsmodels.formula.api as smf

SOURCE = Path(os.environ.get("PSEUDOBULK_SOURCE", Path(__file__).resolve().parents[1] / "data" / "intermediate" / "whole_tumor_donor_pseudobulk_and_neutrophil_fraction.csv"))
OUT = Path(os.environ.get("OUTPUT_ROOT", Path(__file__).resolve().parents[1] / "results" / "study_level_robustness"))
if not SOURCE.exists():
    raise FileNotFoundError(f"Missing pseudobulk input: {SOURCE}. Set PSEUDOBULK_SOURCE.")
OUT.mkdir(parents=True, exist_ok=True)
SCORES = ["PLEK", "PPBP", "PF4", "granule3_axis", "PLEK_PPBP_sensitivity"]

data = pd.read_csv(SOURCE)
audit = pd.DataFrame([{
    "rows": len(data),
    "unique_donors": data.donor_id.nunique(),
    "duplicate_donor_rows": int(data.donor_id.duplicated().sum()),
    "study_sources": data.study_id.nunique(),
    "min_donors_per_study": int(data.groupby("study_id").size().min()),
    "median_donors_per_study": float(data.groupby("study_id").size().median()),
    "max_donors_per_study": int(data.groupby("study_id").size().max()),
}])
audit.to_csv(OUT / "01_donor_study_audit.csv", index=False)
data.groupby("study_id").size().rename("donors").reset_index().to_csv(OUT / "02_study_donor_counts.csv", index=False)

model_rows = []
loo_rows = []
for score in SCORES:
    x = data[["donor_id", "study_id", "cells", "neutrophil_fraction", score]].dropna().rename(columns={score: "score"}).copy()
    x["score_z"] = (x.score - x.score.mean()) / x.score.std(ddof=1)
    x["neut_z"] = (x.neutrophil_fraction - x.neutrophil_fraction.mean()) / x.neutrophil_fraction.std(ddof=1)

    fixed = smf.ols("score_z ~ neut_z + C(study_id)", data=x).fit()
    clustered = fixed.get_robustcov_results(cov_type="cluster", groups=x.study_id, use_correction=True)
    idx = list(fixed.params.index).index("neut_z")
    model_rows.append({
        "score": score, "model": "study_fixed_effect_cluster_robust", "donors": len(x),
        "studies": x.study_id.nunique(), "beta": clustered.params[idx], "se": clustered.bse[idx],
        "ci_low": clustered.conf_int()[idx, 0], "ci_high": clustered.conf_int()[idx, 1],
        "p": clustered.pvalues[idx],
    })

    with warnings.catch_warnings():
        warnings.simplefilter("ignore")
        mixed = smf.mixedlm("score_z ~ neut_z", data=x, groups=x["study_id"], re_formula="1").fit()
    model_rows.append({
        "score": score, "model": "study_random_intercept", "donors": len(x),
        "studies": x.study_id.nunique(), "beta": mixed.params["neut_z"], "se": mixed.bse["neut_z"],
        "ci_low": mixed.conf_int().loc["neut_z", 0], "ci_high": mixed.conf_int().loc["neut_z", 1],
        "p": mixed.pvalues["neut_z"],
    })

    for dropped in sorted(x.study_id.unique()):
        y = x[x.study_id != dropped].copy()
        fit = smf.ols("score_z ~ neut_z + C(study_id)", data=y).fit()
        robust = fit.get_robustcov_results(cov_type="cluster", groups=y.study_id, use_correction=True)
        j = list(fit.params.index).index("neut_z")
        loo_rows.append({
            "score": score, "dropped_study": dropped, "donors": len(y), "studies": y.study_id.nunique(),
            "beta": robust.params[j], "se": robust.bse[j], "ci_low": robust.conf_int()[j, 0],
            "ci_high": robust.conf_int()[j, 1], "p": robust.pvalues[j],
        })

models = pd.DataFrame(model_rows)
models["fdr_within_model"] = models.groupby("model")["p"].transform(lambda s: __import__("statsmodels.stats.multitest", fromlist=["multipletests"]).multipletests(s, method="fdr_bh")[1])
models.to_csv(OUT / "03_cluster_robust_and_mixed_models.csv", index=False)
loo = pd.DataFrame(loo_rows)
loo.to_csv(OUT / "04_leave_one_study_out.csv", index=False)
summary = loo.groupby("score").agg(
    analyses=("beta", "size"), beta_min=("beta", "min"), beta_max=("beta", "max"),
    ci_low_min=("ci_low", "min"), ci_high_max=("ci_high", "max"),
    positive_beta_fraction=("beta", lambda s: float((s > 0).mean())),
    nominal_p_lt_005_fraction=("p", lambda s: float((s < 0.05).mean())),
).reset_index()
summary.to_csv(OUT / "05_leave_one_study_out_summary.csv", index=False)

print(json.dumps({"status": "complete", "donors": int(data.donor_id.nunique()), "studies": int(data.study_id.nunique())}))
