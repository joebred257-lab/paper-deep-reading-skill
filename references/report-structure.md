# Report Structure

Write the final output as a single Markdown file named `report.md` inside the dedicated report folder.

## Required section order

```markdown
# <论文标题的标准学术中文翻译>

![论文抬头：标题与作者](./images/header_title_authors.png)

- 作者：
- 单位：
- 关键词：
- DOI / 论文链接：

## 1. 研究背景、问题定义与核心思路
### 1.1 研究动机与关键挑战
### 1.2 方法框架与核心思路
### 1.3 主要创新点

## 2. 核心方法与技术主线解析
### 2.1 整体技术路线
### 2.2 关键技术块解析

## 3. 仿真结果与对比分析
### 3.1 仿真设置与对比对象
### 3.2 主要结果与对比说明

## 4. 面向不同对象的后续建议
1. 面向入门者
   标题：
   *核心建议：*
   数学推导难度：
2. 面向硕博学生
   标题：
   *核心建议：*
   数学推导难度：
3. 面向教授
   标题：
   *核心建议：*
   数学推导难度：

## 5. 总结与评价
```

## Writing rules

- The top `#` title should be the paper title written as a standard academic Chinese translation.
- Place one tight header snapshot immediately below the top title.
- Fill `作者` using verified English names from the PDF.
- Fill `单位` using verified institution names.
- Prefer `DOI / 论文链接` as a DOI URL.
- Keep formulas in LaTeX form.
- Put image links directly under related explanation paragraphs.
- Default image links in `report.md` should use local relative paths, e.g. `./images/figure_1.png`, for direct local preview.
- If and only if user explicitly requests publishing/public hosting, you may rewrite links to hosted URLs.

## Minimum screenshot coverage

- Section `2`: at least one technical-core image.
- Section `3`: at least one evidence image.
- Whole report: at least three images in total, including header snapshot.
