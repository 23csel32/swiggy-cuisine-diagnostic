# Swiggy Cuisine Performance Diagnostic

## Overview
This project builds one deterministic Swiggy-style SQLite database, then proves that the same
cuisine-level monthly revenue numbers survive three tools untouched: raw SQL (Part A), a
spreadsheet pivot/lookup cross-check (Part B), and a Tableau Public dashboard with a written
data story (Part C). Every part consumes the exact same `monthly_cuisine_revenue.csv` exported
in Part A — nothing is re-derived or re-guessed downstream.

## Repository Structure
```
.
├── generate_data.py                  # Deterministic dataset generator (random.seed(42))
├── swiggy_capstone.db                # Generated SQLite database
├── verify.sql                        # Row-count / status-split verification queries
├── verify_output.txt                 # Actual output of running verify.sql
├── 01_foundations.sql                # WHERE, DISTINCT, ORDER BY+LIMIT, LIKE, IN, BETWEEN, IS NULL
├── 02_aggregation_joins.sql          # INNER JOIN + HAVING, LEFT JOIN zero-preserving count
├── 03_reporting.sql                  # CASE WHEN tiering, monthly-by-cuisine report, variance calc
├── monthly_cuisine_revenue.csv       # Fixed input for Parts B and C (34 rows + header)
├── Swiggy_Cuisine_Diagnostic.xlsx    # Part B spreadsheet workbook
├── ai_log.md                         # Two RCTCF-structured AI prompts + verification steps
├── DATA_STORY.md                     # Part C written data story and recommendations
└── README.md                         # This file
```

## Regenerating the Database
```bash
python3 generate_data.py
```
Do not change the `random.seed(42)` line or any fixed lists/weights — every acceptance number in
this brief (15 restaurants, 50 customers, 420 orders, 6 cuisine targets) depends on this exact
seed producing identical output.

## Where to Find Each SQL Task
| File | Contents |
|---|---|
| `01_foundations.sql` | WHERE, DISTINCT, ORDER BY+LIMIT, LIKE, IN, BETWEEN/NOT BETWEEN, IS NULL |
| `02_aggregation_joins.sql` | INNER JOIN + GROUP BY + HAVING; LEFT JOIN zero-match-preserving count |
| `03_reporting.sql` | CASE WHEN revenue tiering; monthly-by-cuisine report; variance/percentage_variance vs. `cuisine_targets` |

## Spreadsheet Workbook
`Swiggy_Cuisine_Diagnostic.xlsx` — contains the `Monthly Data` import, `Cuisine Targets` lookup
table, a `Pivot` sheet, and a `Cuisine Summary` sheet with VLOOKUP, variance/percentage_variance
formulas, nested-IF tiering, and the Part A reconciliation column.

## Live Tableau Public Dashboard
**[PASTE YOUR LIVE TABLEAU PUBLIC URL HERE]**

## Data Story
See [DATA_STORY.md](./DATA_STORY.md) for the full interpretation of which cuisines are above/below
target and the two concrete recommendations for the category team.

## AI-Assisted Prompting Log
See [ai_log.md](./ai_log.md) for both required RCTCF-structured prompts and the verification step
performed on each.
