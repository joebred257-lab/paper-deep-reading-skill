# paper-deep-reading-skill

中文：`paper-deep-reading` 是一个用于深度阅读本地学术 PDF 的 Codex skill，目标是输出带截图证据的 Markdown 报告，而不是只给一段普通摘要。  
English: `paper-deep-reading` is a Codex skill for deeply reading local academic PDFs and exporting screenshot-backed Markdown reports instead of plain summaries.

## Status / 当前状态

中文：本仓库当前**只面向 Windows 用户**维护和发布。所有主要脚本、安装说明和验证流程都按 `PowerShell + Python` 的 Windows 工作流编写与测试。  
English: This repository is currently maintained and published for **Windows users only**. The main scripts, installation guide, and validation flow are written and tested for a `PowerShell + Python` workflow on Windows.

## What This Skill Does / 这个 Skill 能做什么

中文：安装后，Codex 可以通过 `$paper-deep-reading` 来：

- 逐页阅读本地学术 PDF
- 从 PDF 原文核对标题、作者和单位信息
- 截取标题抬头、定理链、算法块、系统模型、图和表
- 生成结构化中文 `report.md`
- 保留本地 `images/` 文件夹
- 把 `report.md` 中的图片链接改写成公网 URL
- 在交付前执行最终自我审查

English: After installation, Codex can use `$paper-deep-reading` to:

- read a local academic PDF end to end
- verify title, authors, and affiliations against the source PDF
- capture title-header, theorem-chain, algorithm, system-model, figure, and table screenshots
- generate a structured Chinese `report.md`
- keep a local `images/` folder
- rewrite image links in `report.md` into hosted public URLs
- perform a final self-review before handoff

## Best-Fit Paper Types / 最适合的论文类型

中文：这个 skill 特别适合：

- 控制理论论文
- 状态估计、滤波与 observer 设计论文
- 有 theorem / lemma / assumption / property 链条的论文
- 既重视技术推导，也重视仿真对比图的论文

English: This skill is especially suitable for:

- control-theory papers
- estimation, filtering, and observer-design papers
- papers with theorem / lemma / assumption / property chains
- papers where technical derivation and simulation evidence are both important

## Repository Layout / 仓库结构

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

中文：真正的 skill 内容在 [paper-deep-reading](./paper-deep-reading/) 目录下。  
English: The actual skill payload lives under [paper-deep-reading](./paper-deep-reading/).

## Windows Support Statement / Windows 支持说明

中文：当前发布版本面向 `Windows 10 / Windows 11`。默认假设如下：

- Shell 为 `PowerShell 5.1+` 或 `PowerShell 7+`
- Python 启动方式为 `python` 或 `py -3`
- Codex skill 安装目录为 `%USERPROFILE%\.codex\skills` 或 `%CODEX_HOME%\skills`

如果你使用 macOS 或 Linux，这个仓库未来可以继续扩展，但当前 README 中的安装说明是**明确按 Windows 写的**。

English: The current published version targets `Windows 10 / Windows 11`. The default assumptions are:

- shell: `PowerShell 5.1+` or `PowerShell 7+`
- Python entrypoint: `python` or `py -3`
- Codex skills directory: `%USERPROFILE%\.codex\skills` or `%CODEX_HOME%\skills`

If you are on macOS or Linux, the repository may still be extensible later, but the installation guide in this README is **intentionally Windows-specific**.

## Environment Requirements / 环境要求

### 1. Node.js and npm / 先安装 Node.js 和 npm

中文：Codex CLI 通过 npm 分发，所以先安装一个较新的 Node.js LTS。  
English: Codex CLI is distributed via npm, so install a recent Node.js LTS first.

Recommended / 建议版本：

- Node.js `18+`
- npm bundled with Node.js / 随 Node.js 自带的 npm

Check / 检查命令：

```powershell
node --version
npm --version
```

### 2. Install Codex CLI / 安装 Codex CLI

Official install command / 官方安装命令：

```powershell
npm install -g @openai/codex
```

Login / 登录：

```powershell
codex --login
```

Check / 检查：

```powershell
codex --version
```

### 3. Install Python / 安装 Python

中文：请安装 `Python 3.10+`，并确保下面两种方式至少有一种可用。  
English: Install `Python 3.10+` and make sure at least one of the following works.

```powershell
python --version
```

or

```powershell
py -3 --version
```

### 4. Python Dependencies / Python 依赖

Required / 必需依赖：

- `pymupdf`
- `pillow`

Optional but recommended for scanned PDFs / 扫描版 PDF 可选但推荐：

- `pytesseract`
- Windows 上单独安装的 `Tesseract OCR` 可执行程序

中文：仓库自带的安装脚本会自动安装必需 Python 包。  
English: The included installer script will install the required Python packages for you.

## One-Click Install on Windows / Windows 一键安装

中文：如果你已经安装好了：

- Node.js + npm
- Codex CLI
- Python 3.10+

那么直接执行：

English: If you already have:

- Node.js + npm
- Codex CLI
- Python 3.10+

then run:

```powershell
git clone https://github.com/Eroticoo/paper-deep-reading-skill.git
cd paper-deep-reading-skill
powershell -ExecutionPolicy Bypass -File .\install-windows.ps1
```

中文：安装脚本会：

- 自动找到你的 Codex skills 目录
- 把 `paper-deep-reading/` 复制到正确位置
- 安装 `pymupdf` 和 `pillow`
- 如果你显式要求，也可以安装 `pytesseract`
- 输出最终安装路径

English: The installer script will:

- find your Codex skills directory automatically
- copy `paper-deep-reading/` into the correct location
- install `pymupdf` and `pillow`
- optionally install `pytesseract` if requested
- print the final installed path

Install optional OCR Python dependency / 安装可选 OCR Python 依赖：

```powershell
powershell -ExecutionPolicy Bypass -File .\install-windows.ps1 -InstallOptionalOcrDeps
```

Force overwrite without keeping the existing copy / 强制覆盖已安装版本：

```powershell
powershell -ExecutionPolicy Bypass -File .\install-windows.ps1 -Force
```

中文：默认情况下，如果系统里已经存在旧版本 skill，脚本会先做一个带时间戳的备份，再安装新版。  
English: By default, if an older installed copy already exists, the script first creates a timestamped backup and then installs the new one.

## Manual Install on Windows / Windows 手动安装

中文：如果你不想走脚本，也可以手动安装。

1. 把 [paper-deep-reading](./paper-deep-reading/) 复制到：

```text
%USERPROFILE%\.codex\skills\
```

或者如果你使用 `CODEX_HOME`：

```text
%CODEX_HOME%\skills\
```

2. 安装 Python 依赖：

```powershell
python -m pip install --upgrade pymupdf pillow
```

可选 OCR Python 包：

```powershell
python -m pip install --upgrade pytesseract
```

3. 检查最终目录结构：

```text
%USERPROFILE%\.codex\skills\paper-deep-reading\
+-- SKILL.md
+-- openai.yaml
+-- agents/openai.yaml
+-- references\
\-- scripts\
```

English: If you do not want to use the installer script, you can install manually:

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

3. Verify the final folder layout:

```text
%USERPROFILE%\.codex\skills\paper-deep-reading\
+-- SKILL.md
+-- openai.yaml
+-- agents/openai.yaml
+-- references\
\-- scripts\
```

## Optional OCR Setup / 可选 OCR 配置

中文：对于自带文本层的 PDF，`PyMuPDF` 通常已经足够。对于扫描版 PDF，建议额外安装：

1. Windows 版 Tesseract OCR 程序
2. Python 包 `pytesseract`

English: For machine-readable PDFs, `PyMuPDF` is usually enough. For scanned PDFs, install both:

1. the Windows Tesseract OCR binary
2. the Python package `pytesseract`

中文：这个 skill 把 OCR 当作兜底路径，而不是主路径。  
English: This skill treats OCR as a fallback path, not the default path.

## Smoke Test / 冒烟测试

中文：安装完成后，你可以这样做一次最小检查：

```powershell
cd %USERPROFILE%\.codex\skills\paper-deep-reading
.\scripts\pdf_tool.ps1
```

如果看到 usage 输出，而不是缺依赖报错，就说明基础安装基本成功。

English: After installation, run this lightweight smoke test:

```powershell
cd %USERPROFILE%\.codex\skills\paper-deep-reading
.\scripts\pdf_tool.ps1
```

If it prints the usage text instead of a missing-dependency error, the core installation is working.

## How To Call the Skill in Codex / 在 Codex 中如何调用

Minimal request / 最小调用：

```text
Use $paper-deep-reading to read this local PDF and write a Chinese report.
```

More explicit request / 更完整的调用：

```text
Use $paper-deep-reading to read this local PDF, capture the title-author header image,
explain the technical core with source-grounded screenshots, emphasize the simulation
figures, and save the result as report.md plus images/.
```

If you already know the public image prefix / 如果你已经知道公网图片前缀：

```text
Use $paper-deep-reading to read this PDF and rewrite all images in report.md with:
https://cdn.jsdelivr.net/gh/<owner>/<repo>@<commit>/<slug>/images
```

## Output Shape / 输出形式

中文：最终交付默认围绕下面两部分展开：

- `report.md`
- `images/`

生成出的报告会尽量满足：

- 标题使用标准学术中文翻译
- 在 `#` 标题下紧接标题-作者抬头截图
- 在 section `2` 解释 theorem / lemma / assumption 之间的关系
- 对控制类论文把核心系统模型公式转成 LaTeX
- 在论文支持时使用多张仿真 / 实验图形成证据链
- 最终把图片链接改为公网 URL
- 在交付前进行最终自我审查

English: The final deliverable is centered around:

- `report.md`
- `images/`

The generated report is designed to:

- use a standard academic Chinese translation for the title
- place a title-author header screenshot directly under the `#` heading
- explain theorem / lemma / assumption dependencies in section `2`
- transcribe core system equations into LaTeX for control-oriented papers
- include multiple simulation / experiment screenshots when the paper supports them
- rewrite image links into hosted URLs
- perform a final self-review before handoff

## Notes for Repository Users / 给仓库访问者的说明

中文：

- 这是一个 **skill 仓库**，不是单一 prompt 文件
- `paper-deep-reading/scripts/` 下的辅助脚本属于安装内容的一部分
- 当前 README 明确按 Windows-first 发布

English:

- This is a **skill repository**, not just a single prompt file
- the helper scripts under `paper-deep-reading/scripts/` are part of the installation payload
- the current README is intentionally published with a Windows-first setup path

## References / 参考链接

- Official Codex CLI repository / Codex CLI 官方仓库: https://github.com/openai/codex
- Skill payload in this repo / 本仓库中的 skill 主体: [paper-deep-reading](./paper-deep-reading/)
