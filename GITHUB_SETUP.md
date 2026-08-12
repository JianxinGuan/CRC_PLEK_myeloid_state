# GitHub setup

This directory is prepared as a personal, submission-version repository. The recommended sequence is:

1. Create a new **private** GitHub repository, for example `CRC_PLEK_myeloid_state`. Do not add a second README, licence, or `.gitignore` during creation.
2. From this directory run:

```powershell
git init
git add .
git commit -m "Initial submission-ready analysis repository"
git branch -M main
git remote add origin https://github.com/<YOUR_USERNAME>/CRC_PLEK_myeloid_state.git
git push -u origin main
```

3. Before submission, replace local-path placeholders in `README.md` and the manuscript's Data/Code Availability sections with the public repository URL, release commit, and (after archiving) DOI.
4. Keep the repository private during peer review unless the journal requests reviewer access. Create a read-only collaborator or reviewer link when needed. Make the repository public at acceptance/publication and archive the release with Zenodo.

The `.gitignore` excludes raw GEO/TCGA downloads and local R/Python objects. Derived compact tables and figure data remain included for auditability.
