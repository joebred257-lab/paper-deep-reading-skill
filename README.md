# paper-deep-reading

![平台](https://img.shields.io/badge/平台-Windows%20正式支持-0078D4)
![mac](https://img.shields.io/badge/mac-试验性可用-999999)
![下载方式](https://img.shields.io/badge/下载方式-git%20clone-1F6FEB)
![Python](https://img.shields.io/badge/Python-3.10%2B-3776AB)
![输出](https://img.shields.io/badge/输出-report.md%20%2B%20images-FF8C00)
![类型](https://img.shields.io/badge/适合论文-控制%20%7C%20估计%20%7C%20观测器-2EA44F)

`paper-deep-reading` 是一个用于**深度阅读本地学术 PDF** 的 Codex skill。它的目标不是只输出一段普通摘要，而是生成**带截图证据、结构清晰、可继续加工和发布的 Markdown 报告**。

---

## 标签导航

- **下载方式**：如何最快安装到 Codex
- **Skill 介绍**：这个 skill 解决什么问题
- **完整流程**：从 PDF 到最终 `report.md` 的全链路
- **平台支持**：哪些脚本适合 Windows，哪些 mac 也能用
- **调用方式**：在 Codex 中怎么触发

---

## 下载方式

### 方式 1：如果你本身就在用 Codex

**最简单粗暴的方式，就是直接让 Codex 帮你安装这个 skill。**

你可以直接对 Codex 说：

```text
请帮我安装这个 skill：
https://github.com/Eroticoo/paper-deep-reading-skill
把它安装到我的 Codex skills 目录里，并把需要的 Python 依赖也一起装好。
```

如果你想说得更明确一点，可以这样写：

```text
请帮我把这个 skill 安装到我的 Codex skills 目录：
https://github.com/Eroticoo/paper-deep-reading-skill
这是一个以 Windows 为正式支持平台的 skill，请同时安装 pymupdf 和 pillow；
如果环境里需要处理扫描版 PDF，再补 pytesseract。
```

### 方式 2：最推荐的手动安装方式

**这是当前最推荐的公开安装方式。**

如果你是 Windows 用户，并且使用默认 Codex skills 目录，请直接执行：

```powershell
git clone https://github.com/Eroticoo/paper-deep-reading-skill.git "%USERPROFILE%\.codex\skills\paper-deep-reading"
```

如果你使用的是自定义 `CODEX_HOME`，请执行：

```powershell
git clone https://github.com/Eroticoo/paper-deep-reading-skill.git "%CODEX_HOME%\skills\paper-deep-reading"
```

**执行完这一步，skill 文件本体就已经安装到位了。**

然后安装 Python 依赖：

```powershell
python -m pip install --upgrade pymupdf pillow
```

如果你还要处理扫描版 PDF，再补：

```powershell
python -m pip install --upgrade pytesseract
```

### 方式 3：不用 git，也可以下载 zip

如果你不想用 `git clone`，也可以：

1. 从 GitHub 下载 zip
2. 解压后把整个仓库根目录重命名为 `paper-deep-reading`
3. 放到：

```text
%USERPROFILE%\.codex\skills\
```

或者：

```text
%CODEX_HOME%\skills\
```

4. 再执行上面的 `pip install` 依赖命令

---

## Skill 介绍

安装后，Codex 可以通过 `$paper-deep-reading` 来：

- 逐页阅读本地学术 PDF
- 从 PDF 原文核对标题、作者和单位信息
- 截取标题抬头、定理链、算法块、系统模型、图和表
- 生成结构化中文 `report.md`
- 保留本地 `images/` 文件夹
- 把 `report.md` 中的图片链接改写成公网 URL
- 在交付前执行最终自我审查

它特别适合：

- 控制理论论文
- 状态估计、滤波与 observer 设计论文
- 有 theorem / lemma / assumption / property 链条的论文
- 既重视技术推导，也重视仿真对比图的论文

最终交付默认围绕下面两部分展开：

- `report.md`
- `images/`

---

## 完整流程

这一节是这个 skill 的核心说明，也就是它到底怎么从一篇 PDF 走到最终报告。

### 第 1 步：创建报告目录

skill 会先为每篇论文创建一个独立输出目录，里面至少包含：

- `report.md`
- `images/`

这样做的好处是：

- 每篇论文的资源不会混在一起
- 后续截图、导出、改公网地址都更稳定

### 第 2 步：抽取全文文本并核对元数据

然后 skill 会先从 PDF 抽取文本层，优先确认：

- 论文标题
- 作者
- 单位
- DOI 或论文链接
- 关键词

这一阶段不是简单“读摘要”，而是为后续报告结构和截图定位打底。

### 第 3 步：先抓标题抬头截图

第一页里最先抓的是：

- 标题
- 作者列表

这张图会直接放在 `report.md` 顶部标题下方，作为整个报告的来源抬头。

### 第 4 步：抓 Section 2 的技术核心截图

skill 会优先找这些内容：

- `Theorem`
- `Lemma`
- `Assumption`
- `Property`
- `Proposition`
- `Remark`
- `Algorithm`
- 系统模型
- 关键公式组

如果论文是控制、估计、observer 这一类，skill 还会特别强调：

- 系统模型不能只截图
- 核心状态方程、输出方程、观测器方程要转写成 LaTeX

### 第 5 步：抓 Section 3 的仿真 / 实验证据

skill 会继续找：

- `Fig.`
- `Figure`
- `Table`
- `Tab.`

并优先收集：

- 主对比图
- 关键仿真图
- 结果表
- 如果有的话，再补鲁棒性、敏感性、消融或通信代价图

这里的原则不是“随便截几张图”，而是形成一条**证据链**。

### 第 6 步：写出结构化报告

最终的 `report.md` 会按固定结构组织：

1. 标题与抬头图
2. 背景、问题与创新点
3. 技术核心与截图解释
4. 仿真 / 实验结果与对比分析
5. 面向不同读者的建议
6. 总结与评价

也就是说，这个 skill 输出的不是松散笔记，而是一份可直接继续发公众号、发仓库、沉淀笔记的文档。

### 第 7 步：改写图片公网链接

如果你有公网图床前缀，skill 会把 `report.md` 里的图片改写成公网地址。  
如果你还没有准备好图床，它也可以先写成占位前缀，后续再统一替换。

### 第 8 步：校验并做最终自我审查

这一步现在已经是 skill 的固定流程，不需要你再额外提醒。

最终会检查：

- 结构是否完整
- 图片链接是否还是本地路径
- 技术截图是否完整
- 仿真图是否够干净
- 是否还残留临时文件
- 最终回复里是否给出自我审查结果

---

## 平台支持

### 当前正式支持平台

**Windows 是当前正式支持平台。**

默认工作环境：

- `Windows 10 / Windows 11`
- `Python 3.10+`
- `Codex CLI`

### mac 能不能用

**可以试验性使用，但目前不算正式支持平台。**

更准确地说：

- Windows：已经按公开说明验证过
- mac：装好 Python 依赖后，通常可以走核心 Python 路径
- 当前仓库还没有把 mac 写成完整验证平台

### 哪些脚本是 Windows 专用，哪些不是

当前仓库里：

- `scripts/pdf_tool.ps1` 是 **Windows / PowerShell 专用包装器**
- `scripts/pdf_snapshot.swift` 是 **Apple 平台 fallback**
- `scripts/pdf_tool.py`、`scripts/init_output_folder.py`、`scripts/render_wechat_paste.py`、`scripts/validate_report.py` 这些核心脚本本质上都是 **跨平台 Python 脚本**

所以更准确地说：

- **Windows 是当前正式支持平台**
- **mac 可以试验性使用核心 Python 路径**
- **仓库不是“只能在 Windows 上运行”，而是“当前只把 Windows 当作正式支持对象”**

如果你是 mac 用户，最值得优先尝试的就是：

```bash
python3 ./scripts/pdf_tool.py
```

如果能正常看到 usage 输出，而不是缺依赖报错，就说明核心 Python 路径可以工作。

---

## 环境要求

### 1. Node.js 和 npm

**Codex CLI 通过 npm 分发，所以必须先安装 Node.js。**

建议版本：

- `Node.js 18+`
- 随 Node.js 自带的 `npm`

检查命令：

```powershell
node --version
npm --version
```

### 2. Codex CLI

**这是使用本 skill 的前提。**

官方安装命令：

```powershell
npm install -g @openai/codex
```

登录命令：

```powershell
codex --login
```

检查命令：

```powershell
codex --version
```

### 3. Python

**必须安装 `Python 3.10+`。**

下面两种方式至少有一种可用：

```powershell
python --version
```

或者：

```powershell
py -3 --version
```

### 4. Python 依赖

**必需依赖：**

- `pymupdf`
- `pillow`

**扫描版 PDF 可选但推荐：**

- `pytesseract`
- Windows 上单独安装的 `Tesseract OCR`

对于 mac 用户，如果你走的是核心 Python 路径，依赖也是同一套：

- `pymupdf`
- `pillow`
- 可选：`pytesseract`

---

## 安装后检查

**安装完成后，建议立刻做一次最小检查：**

Windows：

```powershell
cd %USERPROFILE%\.codex\skills\paper-deep-reading
python .\scripts\pdf_tool.py
```

mac：

```bash
python3 ./scripts/pdf_tool.py
```

如果看到 usage 输出，而不是缺依赖报错，就说明基础安装基本成功。

---

## 在 Codex 中如何调用

最小调用：

```text
Use $paper-deep-reading to read this local PDF and write a Chinese report.
```

更完整的调用：

```text
Use $paper-deep-reading to read this local PDF, capture the title-author header image,
explain the technical core with source-grounded screenshots, emphasize the simulation
figures, and save the result as report.md plus images/.
```

如果你已经知道公网图片前缀，也可以这样指定：

```text
Use $paper-deep-reading to read this PDF and rewrite all images in report.md with:
https://cdn.jsdelivr.net/gh/<owner>/<repo>@<commit>/<slug>/images
```

---

## 给仓库访问者的说明

- 这是一个 **skill 仓库**，不是单一 prompt 文件
- `scripts/` 下的辅助脚本属于 skill 的一部分
- 当前 README 按 Windows-first 发布
- mac 用户可以优先尝试 `python3 ./scripts/pdf_tool.py` 这条核心 Python 路径

---

## 参考链接

- Codex CLI 官方仓库：https://github.com/openai/codex
