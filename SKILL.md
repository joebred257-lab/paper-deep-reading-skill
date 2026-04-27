---
name: paper-deep-reading
description: Read local academic PDFs in depth and produce a screenshot-backed Markdown report. Use when Codex receives a local paper PDF and must explain the paper's problem setting, idea origin, innovation points, technical core (such as a theorem, algorithm, objective, system model, or method block), experimental or simulation evidence, title, keywords, authors, institutions, and three audience-specific section-4 recommendations for beginners, master's/PhD students, and professors. Default output keeps report images as local relative paths for direct Markdown preview.
---

# Paper Deep Reading

## Goal

Read a local paper PDF end to end, capture source-grounded snapshots from the PDF itself, and write a report that stays anchored to the paper.

Default deliverable:
- keep `report.md`
- keep local `images/` folder
- keep image links in `report.md` as local relative paths like `./images/xxx.png` so VS Code/GitHub local preview works immediately.

Only rewrite image links to public URLs when the user explicitly asks for publishing/web hosting.

## Workflow

1. Create the output folder first
- Run `python scripts/init_output_folder.py "<pdf-path>" --output-root "<root-dir>"`.
- Write the final report into the generated `report.md`.
- Save every snapshot into the generated `images/` directory.

2. Extract and inspect the paper text
- Run `python scripts/pdf_tool.py probe "<pdf-path>"`.
- Run `python scripts/pdf_tool.py extract-text "<pdf-path>" "<output-dir>/source_text.txt"`.
- Prefer DOI URL in metadata when available.

3. Capture the report-header snapshot first
- Capture one compact snapshot from page 1 with paper title and authors.
- Place it immediately under the top `#` title in `report.md`.

4. Capture section-2 technical-core snapshots
- Use `python scripts/pdf_tool.py find` to locate anchors.
- Prefer theorem/lemma/assumption/property/remark when available.
- If not, capture algorithm/objective/problem/system model/equation group/framework.
- Use `snapshot-query` first; use `snapshot-rect --preset exact` for recrop.

5. Capture section-3 evidence snapshots
- Search `Fig.`, `Figure`, `Table`, `Tab.`.
- Prefer 2-4 evidence images when paper provides complementary evidence.
- Ensure each image includes full panel + caption and avoids unrelated spillover.

6. Write the report in required structure
- Load `references/report-structure.md`.
- Keep section order and evidence-grounded writing.
- Keep formulas in LaTeX.
- Keep `作者` in English names from PDF.
- Keep `学校` verified from PDF.

7. Image-link policy (updated)
- Default: keep local relative links in `report.md`, e.g. `./images/figure_1.png`.
- If user explicitly requests web publishing/public links, then run:
  - `python scripts/render_wechat_paste.py "<output-dir>/report.md" "<output-dir>/report.rendered.md" --image-url-prefix "<public-image-prefix>" --rewrite-report-images`
- Without explicit publishing requirement, do not rewrite report image links to remote URLs/placeholders.

8. Validate and iterate
- Run `python scripts/validate_report.py "<output-dir>/report.md"`.
- Fix structure/coverage/crop issues if needed.

9. Final self-review before handoff
- Manually inspect every image referenced in `report.md`.
- Confirm links are valid (local relative by default, remote only when requested).
- Confirm final output keeps `report.md` + `images/`.
- Remove transient helper artifacts unless user asked to keep them.

## Operating Rules

- Treat screenshots as mandatory.
- Prefer `python scripts/pdf_tool.py ...`.
- Keep one dedicated output folder per paper.
- Put title-author header image under top title.
- Keep keywords, authors, institutions, DOI metadata complete.
- Preserve formulas in LaTeX.
- Do not invent unsupported claims.
- Default `report.md` image links must be local relative paths.
- Only switch to hosted URLs if user explicitly requests publishing/distribution.

## Resources

- `scripts/init_output_folder.py`
- `scripts/pdf_tool.py`
- `scripts/pdf_tool.ps1`
- `scripts/pdf_tool.sh`
- `scripts/pdf_snapshot.swift`
- `scripts/render_wechat_paste.py`
- `scripts/validate_report.py`
- `references/report-structure.md`
- `references/snapshot-playbook.md`
- `references/quality-checklist.md`
