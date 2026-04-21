# paper-deep-reading-skill

`paper-deep-reading` is a Codex skill for reading local academic PDFs deeply and exporting screenshot-backed Markdown reports.

This repository currently targets **Windows only**. The workflow and helper scripts are written and tested for `PowerShell + Python` on Windows, and the documentation below is written for Windows users first.

## What this skill does

After installation, Codex can use `$paper-deep-reading` to:

- read a local academic PDF end to end
- extract title / author metadata from the source PDF
- capture source-grounded screenshots for header blocks, theorem chains, algorithms, system models, figures, and tables
- write a structured Chinese `report.md`
- keep a local `images/` folder
- rewrite image links in `report.md` into public CDN URLs
- run a final self-review so the deliverable is checked before handoff

It is especially useful for:

- control papers
- estimation and filtering papers
- observer-design papers
- papers with theorem / lemma / assumption / property chains
- papers where simulation figures matter as much as the derivation

## Repository layout

```text
paper-deep-reading-skill/
+-- README.md
+-- install-windows.ps1
\-- paper-deep-reading/
    +-- SKILL.md
    +-- openai.yaml
    +-- agents/openai.yaml
    +-- references/
    \-- scripts/
```

The actual skill lives in [paper-deep-reading](./paper-deep-reading/).

## Windows support statement

This repository is currently maintained for **Windows 10 / Windows 11**.

Supported workflow assumptions:

- shell: `PowerShell 5.1+` or `PowerShell 7+`
- Python entrypoint: `python` or `py -3`
- filesystem layout: standard Codex skills directory under `%USERPROFILE%\\.codex\\skills` or `%CODEX_HOME%\\skills`

If you are on macOS or Linux, this repository may still be adaptable, but the published installation path in this README is intentionally Windows-specific.

## Requirements for Windows users

### 1. Install Node.js and npm

Codex CLI is distributed through npm, so install a recent Node.js LTS release first.

Recommended baseline:

- Node.js `18+`
- npm bundled with Node.js

Check:

```powershell
node --version
npm --version
```

### 2. Install Codex CLI

Official CLI install command:

```powershell
npm install -g @openai/codex
```

Then log in:

```powershell
codex --login
```

Check:

```powershell
codex --version
```

### 3. Install Python

Install Python `3.10+` on Windows and make sure one of these works:

```powershell
python --version
```

or

```powershell
py -3 --version
```

### 4. Python packages required by this skill

Required:

- `pymupdf`
- `pillow`

Optional but recommended for scanned PDFs:

- `pytesseract`
- native `Tesseract OCR` executable installed on Windows

The included installer script will install the Python packages for you.

## One-click install on Windows

If you already have:

- Node.js + npm
- Codex CLI
- Python 3.10+

then installation is:

```powershell
git clone https://github.com/Eroticoo/paper-deep-reading-skill.git
cd paper-deep-reading-skill
powershell -ExecutionPolicy Bypass -File .\install-windows.ps1
```

What the script does:

- finds your Codex skills directory
- copies `paper-deep-reading/` into the correct place
- installs `pymupdf` and `pillow`
- optionally installs `pytesseract` if you ask for it
- prints the final installed path

If you also want the optional OCR Python package:

```powershell
powershell -ExecutionPolicy Bypass -File .\install-windows.ps1 -InstallOptionalOcrDeps
```

If you want to overwrite an existing installed copy without keeping it:

```powershell
powershell -ExecutionPolicy Bypass -File .\install-windows.ps1 -Force
```

By default, when an older installed copy exists, the script makes a timestamped backup before replacing it.

## Manual install on Windows

If you prefer to install manually:

1. Copy [paper-deep-reading](./paper-deep-reading/) into:

```text
%USERPROFILE%\.codex\skills\
```

or, if you use `CODEX_HOME`:

```text
%CODEX_HOME%\skills\
```

2. Install Python dependencies:

```powershell
python -m pip install --upgrade pymupdf pillow
```

Optional OCR support:

```powershell
python -m pip install --upgrade pytesseract
```

3. Verify the skill folder looks like:

```text
%USERPROFILE%\.codex\skills\paper-deep-reading\
+-- SKILL.md
+-- openai.yaml
+-- agents/openai.yaml
+-- references\
\-- scripts\
```

## Optional OCR setup for scanned PDFs

For machine-readable PDFs, `PyMuPDF` text extraction is usually enough.

For scanned PDFs, install both:

1. Windows Tesseract OCR binary
2. Python package `pytesseract`

This skill treats OCR as a fallback, not as the primary path.

## Smoke test

After installation, you can verify the helper wrapper is available:

```powershell
cd %USERPROFILE%\.codex\skills\paper-deep-reading
.\scripts\pdf_tool.ps1
```

It should print the tool usage instead of failing on missing imports.

## How to call the skill in Codex

Minimal usage:

```text
Use $paper-deep-reading to read this local PDF and write a Chinese report.
```

A stronger request:

```text
Use $paper-deep-reading to read this local PDF, capture the title-author header image,
explain the technical core with source-grounded screenshots, emphasize the simulation
figures, and save the result as report.md plus images/.
```

If you already know the public image prefix:

```text
Use $paper-deep-reading to read this PDF and rewrite all images in report.md with:
https://cdn.jsdelivr.net/gh/<owner>/<repo>@<commit>/<slug>/images
```

## Output shape

The final deliverable is centered around:

- `report.md`
- `images/`

The generated report is designed to:

- use a standard academic Chinese translation for the title
- place a title-author header screenshot directly under the `#` heading
- explain theorem / lemma / assumption dependencies in section `2`
- write core system equations in LaTeX for control-oriented papers
- emphasize simulation / experiment evidence with more than one screenshot when the paper supports it
- rewrite image links into hosted URLs
- perform a final self-review before handoff

## Notes for repository users

- This repository is a **skill repository**, not just a single Markdown prompt.
- The helper scripts under `paper-deep-reading/scripts/` are part of the installation.
- The current published setup path is intentionally Windows-first.

## References

- Official Codex CLI repository: https://github.com/openai/codex
- Skill payload in this repo: [paper-deep-reading](./paper-deep-reading/)
