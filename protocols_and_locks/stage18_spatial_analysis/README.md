# Stage 18: spatial analysis

This lock records the CRC Visium spatial-context analysis used in the manuscript. The released repository contains the lock specification and the final figure/data summaries, but not the large H5AD objects or the original download cache.

The analysis sequence was: download and verify the 14 sections; compute within-section module scores and same-spot/nearest-neighbor associations; combine paired sections within patients; and perform patient-level random-effects inference with the prespecified paired neutrophil-versus-endothelial audit.

The inferential unit was the patient, not the spot. Spot-level values were used for exploration and plotting only and must not be treated as independent biological replicates. The final manuscript and Supplementary Figure S3 report the retained patient-level results and their interpretation limits.

To reproduce the full spatial computation, retrieve the specified CELLxGENE collection and the corresponding scripts from the complete analysis workspace; those large inputs are intentionally excluded from this lightweight release.
