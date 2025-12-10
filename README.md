# PA 446 Final Project – Chicago Pothole Analysis

## Repo Structure
- `data/` – raw & cleaned data
- `scripts/` – reproducible R scripts (01-05 except 04)
- `reports/` – Quarto main report (04) + **parameterized template**

## Automation Demo
Run `source("scripts/render_reports.R")` to generate **one HTML per community** via parameterized Quarto.

## Usage
1. Clone repo
2. Open `pa446-final.Rproj` (or set working directory)
3. Run `01_download.R` → `02_clean.R` → `03_analysis.R` → `05_cluster.R`
4. Render `reports/04_report.qmd` for full report

## Outputs
- `report.html` – city-wide analysis (≥ 3 viz + clustering)
- `community_X.html` – individual neighborhood dashboard

GitHub Repository: https://github.com/Adren01ine/pa446-final
