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

Simple script that extracts the framewise displacement variable from fMRIPrep v20.0.1 confounds file which can be used with any BIDS compliant directory. Will take all subjects and all functional run types if fMRIPrep has produced a confound_timeseries.tsv file for. There isn't an agreement on the limit of framewise displacement which should determine exclusion so currently script determines which subject runs exceeds the following framewise displacement values: 1mm, 1.1mm, 1.2mm, 1.5mm, 2mm, and max value but will only output excess of 1mm if save option is not enabled.
Can be modified to extract any column of fMRIPrep confounds and used as a general value checker.
