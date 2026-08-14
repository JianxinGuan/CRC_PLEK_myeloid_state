from docx import Document
from pathlib import Path

path = Path(r"G:\New_CRC_Platelet\24_制作投稿文件包\manuscript\CRC_PLEK_myeloid_state_Main_Manuscript.docx")
doc = Document(path)
replacements = {
    "Int J Mol Sci. 2022;23(7). doi:10.3390/ijms23073868.": "Int J Mol Sci. 2022;23(7):3868. doi:10.3390/ijms23073868.",
    "J Exp Med. 2022;219(6). doi:10.1084/jem.20220011.": "J Exp Med. 2022;219(6):e20220011. doi:10.1084/jem.20220011.",
    "Cancers (Basel). 2022;14(19). doi:10.3390/cancers14194755.": "Cancers (Basel). 2022;14(19):4755. doi:10.3390/cancers14194755.",
    "Int J Mol Sci. 2024;26(1). doi:10.3390/ijms26010006.": "Int J Mol Sci. 2024;26(1):6. doi:10.3390/ijms26010006.",
    "Cancers (Basel). 2023;15(19). doi:10.3390/cancers15194851.": "Cancers (Basel). 2023;15(19):4851. doi:10.3390/cancers15194851.",
    "Gigascience. 2020;9(12). doi:10.1093/gigascience/giaa151.": "Gigascience. 2020;9(12):giaa151. doi:10.1093/gigascience/giaa151.",
}
changed = 0
for p in doc.paragraphs:
    original = p.text
    updated = original
    for old, new in replacements.items():
        updated = updated.replace(old, new)
    if updated != original:
        p.text = updated
        changed += 1
doc.save(path)
print(f"updated references: {changed}")
print(path)
