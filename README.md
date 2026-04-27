# paper-deep-reading

`paper-deep-reading` 是一个用于深度阅读本地学术 PDF 的 Codex skill。

默认输出策略（已更新）：
- 保留 `report.md`
- 保留 `images/` 文件夹
- `report.md` 中图片链接默认使用本地相对路径（`./images/...`），可直接在 VS Code 预览

仅当你明确要求“发布到公网/图床”时，才改写成公网 URL。

---

## 快速安装

```powershell
git clone https://github.com/Eroticoo/paper-deep-reading-skill.git "%USERPROFILE%\.codex\skills\paper-deep-reading"
python -m pip install --upgrade pymupdf pillow
```

可选（扫描版 PDF）：

```powershell
python -m pip install --upgrade pytesseract
```

---

## 最小调用

```text
Use $paper-deep-reading to read this local PDF and write a Chinese report.
```

---

## 默认输出目录结构

```text
<output-dir>/
  report.md
  images/
```

报告中的图片应默认写成：

```md
![示例图](./images/example.png)
```

---

## 什么时候改成公网链接

当且仅当你明确要发布（如公众号、网页、远程渲染）时，再执行：

```powershell
python scripts/render_wechat_paste.py "<output-dir>/report.md" "<output-dir>/report.rendered.md" --image-url-prefix "<public-image-prefix>" --rewrite-report-images
```

---

## 核心能力

- 抽取 PDF 文本并核对题目、作者、机构、DOI
- 生成标题/作者抬头图
- 抓取技术核心证据图（定理、算法、模型、公式组等）
- 抓取结果证据图（Figure/Table）
- 输出结构化中文报告（含 3 类人群建议）

---

## 参考

- Codex CLI: https://github.com/openai/codex
