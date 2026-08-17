$ErrorActionPreference = "Stop"

$repoRoot = $PSScriptRoot
$required = @(
    "STAGE15_SPEARMAN", "STAGE16_ROBUSTNESS", "STAGE13_COX",
    "STAGE15_ADJUSTED", "MNDA_SENSITIVITY", "PSEUDOBULK_SOURCE"
)

foreach ($name in $required) {
    $value = [Environment]::GetEnvironmentVariable($name, "Process")
    if ([string]::IsNullOrWhiteSpace($value) -or -not (Test-Path -LiteralPath $value -PathType Leaf)) {
        throw "Set $name to an existing input file. See INPUT_DATA_DICTIONARY.md."
    }
}

$env:PROJECT_ROOT = $repoRoot
$rscript = if ($env:RSCRIPT) { $env:RSCRIPT } else { "Rscript" }
$python = if ($env:PYTHON) { $env:PYTHON } else { "python" }

$env:OUTPUT_ROOT = Join-Path $repoRoot "results\modified_hartung_knapp"
& $rscript (Join-Path $repoRoot "scripts\run_modified_hartung_knapp.R")
if (-not $?) { throw "Modified Hartung-Knapp audit failed." }

$env:OUTPUT_ROOT = Join-Path $repoRoot "results\study_level_robustness"
& $python (Join-Path $repoRoot "scripts\run_study_level_robustness.py")
if (-not $?) { throw "Study-level robustness audit failed." }

Write-Host "KEY_AUDITS_COMPLETE"
