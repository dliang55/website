---
title: ASHS for SLURM
summary: "Function to run ASHS on BIDS compliant directory."
tags:
- shell
date: "2022-05-09T00:00:00Z"

# Optional external URL for project (replaces project detail page).
# external_link: /project/AoC2020/week_10.py
links:
url_code: "/project/ashs_slurm/run_ASHS.sh"

# Slides (optional).
#   Associate this project with Markdown slides.
#   Simply enter your slide deck's filename without extension.
#   E.g. `slides = "example-slides"` references `content/slides/example-slides.md`.
#   Otherwise, set `slides = ""`.
# slides: example

---

Simple script that points to the ASHS directory (containing bin and atlas), input directory (BIDS compliant), and output directory (usually derivatives folder), and executes ASHS_main.sh via. SLURM scheduler as only SGE scheduler was included in ASHS distribution.