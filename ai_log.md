# AI-Assisted Prompting Log

This log records the two required AI-assisted prompts used while building this capstone,
structured against RCTCF (Role, Context, Task, Constraints, Format), plus the concrete
verification step actually performed on each AI suggestion before it was kept.

---

## Prompt 1 — Part A: debugging the percentage-variance SQL expression

**Role:** You are a senior data analyst who is an expert in SQLite syntax and common integer-division pitfalls.

**Context:** I have a `cuisine_targets` table with an INTEGER `target_revenue_inr` column and a derived `total_revenue` value (also an integer, from `SUM(amount_inr)`). I need to compute `percentage_variance = ((total_revenue - target_revenue_inr) / target_revenue_inr) * 100`, but when I run it in SQLite the result is always 0 or a truncated integer instead of a decimal like -8.69.

**Task:** Explain why my expression is returning truncated integers instead of decimals, and rewrite the expression so it returns the true floating-point percentage.

**Constraints:** Must work in plain SQLite (no external extensions), must not change the underlying column types (they should stay INTEGER), and the fix should be a single self-contained expression I can drop into a SELECT.

**Format:** A short explanation (2–3 sentences) followed by the corrected SQL expression only.

**Verification performed:** I ran both the original expression and the AI-suggested expression
(`((total_revenue - target_revenue_inr) * 100.0) / target_revenue_inr`) against `swiggy_capstone.db`
for the "Desserts" cuisine row. The original returned `0`. The corrected expression returned
`-21.224`. I manually cross-checked this by hand: total_revenue for Desserts = 19694,
target = 25000, so (19694-25000)/25000*100 = -21.224 — which matched the query output exactly,
confirming the fix was correct before I used it in `03_reporting.sql`.

---

## Prompt 2 — Part C: choosing the Tableau color-coding approach for Above/Below Target

**Role:** You are a Tableau Public dashboard design expert who follows standard BI best practices (e.g., profit-by-subcategory, loss-highlighted patterns).

**Context:** I have a bar chart of total revenue by cuisine, sorted descending, and I need to visually distinguish the 3 cuisines that are "Above Target" (North Indian, South Indian, Italian) from the 3 that are "Below Target" (Chinese, Fast Food, Desserts) using color, without hardcoding colors per bar.

**Task:** Recommend the cleanest way to build this in Tableau Public's free tier — specifically, whether to use a calculated field or a set, and how to bind it to color.

**Constraints:** Must work entirely in Tableau Public (no Tableau Desktop-only features), must update automatically if the underlying revenue numbers change (no manually re-coloring bars), and should use only two colors total.

**Format:** A short recommendation (3–4 sentences) plus the calculated-field formula to use.

**Verification performed:** I created the calculated field the AI suggested
(`IF SUM([total_revenue]) >= LOOKUP(...target...) THEN "Above Target" ELSE "Below Target" END`,
adapted to reference my joined target value), dropped it onto Color, and then manually
cross-checked which cuisines turned up in each color group against my own KPI card totals
and the tagging already computed in `03_reporting.sql` (North Indian, South Indian, Italian =
Above Target; Chinese, Fast Food, Desserts = Below Target) before keeping the calculated field
in the final dashboard.
