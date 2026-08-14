from docx import Document
from pathlib import Path

path = Path(r"G:\New_CRC_Platelet\24_制作投稿文件包\Cover_Letter.docx")
doc = Document(path)
old = 'We believe the manuscript is suitable for Scientific Reports because it addresses a common interpretive problem in bulk tumor transcriptomics: how an apparently platelet-related signal changes when its cellular context and component contributions are examined across independent data types. The study retains negative and non-informative findings, reports between-cohort heterogeneity and prediction intervals, and distinguishes reproducible association from biological source or mechanism. A supplementary "prohibited claims" table (nine rules) further prevents overinterpretation of the correlation evidence. This transparent, self-limiting approach aligns with Scientific Reports\' emphasis on technical soundness and reproducible methodology over exaggerated novelty claims.'
new = 'We believe the manuscript is suitable for Scientific Reports because it addresses a common interpretive problem in bulk tumor transcriptomics: how an apparently platelet-related signal changes when its cellular context and component contributions are examined across independent data types. The study retains negative and non-informative findings, reports between-cohort heterogeneity and prediction intervals, and distinguishes reproducible association from biological source or mechanism. The manuscript also specifies explicit boundaries for biological interpretation to avoid overstatement of correlation-based findings. This approach emphasizes transparent reporting, technical rigor, and reproducibility.'
for p in doc.paragraphs:
    if p.text.startswith('We believe the manuscript is suitable for Scientific Reports'):
        p.text = new
    if p.text == old:
        p.text = new
    if p.text == 'All authors have reviewed and approved the submitted manuscript.':
        p.text = 'All authors have reviewed and approved the submitted manuscript.'
doc.save(path)
print(path)
