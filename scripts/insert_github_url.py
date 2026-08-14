from docx import Document
from pathlib import Path

root = Path(r"G:\New_CRC_Platelet\23_形成论文仓库\manuscript")
url = "https://github.com/JianxinGuan/CRC_PLEK_myeloid_state"
for path in root.glob("*.docx"):
    doc = Document(path)
    changed = False
    for p in doc.paragraphs:
        if "[PUBLIC REPOSITORY URL AND RELEASE DOI TO BE COMPLETED BEFORE SUBMISSION]" in p.text:
            p.text = p.text.replace("[PUBLIC REPOSITORY URL AND RELEASE DOI TO BE COMPLETED BEFORE SUBMISSION]", url + ". Release DOI will be added after archival publication.")
            changed = True
        if "[PUBLIC REPOSITORY URL, COMMIT HASH, AND ARCHIVAL DOI TO BE COMPLETED BEFORE SUBMISSION]" in p.text:
            p.text = p.text.replace("[PUBLIC REPOSITORY URL, COMMIT HASH, AND ARCHIVAL DOI TO BE COMPLETED BEFORE SUBMISSION]", url + ". The submission version is identified by the repository commit recorded in the accompanying SHA-256 manifest; an archival DOI will be added after publication.")
            changed = True
    if changed:
        doc.save(path)
        print(path)
