# Quality Checklist

Treat the report as acceptable only if all items below pass.

## Structural checks

- The report lives in its own folder.
- The folder contains `report.md`.
- The folder contains `images/`.
- The report includes a header snapshot and `关键词`.
- The report does not expose a local filesystem PDF path; it prefers DOI/official paper URL when available.
- Section `1` explains problem, idea origin, and innovation points.
- Section `2` contains technical-core screenshots and explanations.
- Section `3` contains evidence screenshots and explanations.
- Section `4` contains exactly three numbered audience-specific items.
- Section `5` provides a final summary.

## Screenshot checks

- At least one section-2 technical-core image is present.
- At least one section-3 evidence image is present.
- One title-author header image is directly below the top `#` title.
- By default, each image link in `report.md` is a valid local relative path (recommended: `./images/<file>`).
- If user explicitly requested publishing, hosted image URLs are acceptable.
- Screenshots are readable and tightly cropped to target evidence.

## Content checks

- Innovation points are separated from generic background.
- Headings read like a formal academic report.
- Section-2 explanations clarify role/assumption/guarantee/importance of technical blocks.
- Section-3 explanations state metric, baseline/comparison object, and justified conclusion.
- Section-4 follows fixed audience order: `入门者` -> `硕博学生` -> `教授`.
- Each section-4 item includes a mathematical derivation difficulty label.

## Final self-review

- Re-run checklist after final edits.
- Confirm `report.md` and `images/` remain in output folder.
- Remove transient helper artifacts unless user asked to keep them.
- Briefly summarize validation result in final user-facing response.
