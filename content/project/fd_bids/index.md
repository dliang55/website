---
title: Framewise Displacement
summary: "Function to extract confound from fMRIPrep."
tags:
- matlab
date: "2022-05-09T00:00:00Z"

# Optional external URL for project (replaces project detail page).
# external_link: /project/AoC2020/week_10.py
links:
url_code: "/project/fd_bids/fd_bids.m"

# Slides (optional).
#   Associate this project with Markdown slides.
#   Simply enter your slide deck's filename without extension.
#   E.g. `slides = "example-slides"` references `content/slides/example-slides.md`.
#   Otherwise, set `slides = ""`.
# slides: example

---

Simple script that extracts the framewise displacement variable from fMRIPrep confounds file which can be used with any BIDS compliant directory. Can be modified to extract any column of fMRIPrep confounds.