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

Simple script that points to the ASHS directory (containing bin and atlases), input directory (BIDS compliant), and output directory (usually derivatives folder), and submits ASHS_main.sh via. SLURM scheduler using regularInteractive provided by neuroglia-helpers (https://github.com/khanlab/neuroglia-helpers). 

Automatic Segmentation of Hippocampal Subfields (ASHS) is developed by members of the Penn Image Computing and Science Laboratory (PICSL) at the Department of Radiology at the University of Pennsylvania (https://sites.google.com/site/hipposubfields/). Atlas version used (ashs_atlas_upennpmc_20161128) and all other ASHS scripts and functions is supported by their group and can be found at https://www.nitrc.org/frs/?group_id=370.
