---
title: "psypy2df: Data importation"
subtitle: "For PsychoPy experiment(s)"

# Summary for listings and search engines
summary: "User-facing function to automate data importation from multiple excel spreadsheets (.csv file format) from an absolute or relative directory into a single dataframe object."

# Link this post with a project
projects: []

# Date published
date: "2021-11-263T00:00:00Z"

# Date updated
lastmod: "2021-11-26T00:00:00Z"

# Is this an unpublished draft? 
draft: false

# Show this page in the Featured widget?
featured: false

# Featured image
# Place an image named `featured.jpg/png` in this page's folder and customize its options here.
image:
  caption: ''
  focal_point: ""
  placement: 2
  preview_only: false

authors:
- admin

tags:
- R

categories:
- functions

links:
url_code: "/post/psypy2df/psypy2df.R"
url_pdf: "post/psypy2df/psypy2df.pdf"
---

# Purpose

For the automatation of data importation given an absolute or relative directory as a character vector. In particular, PsychoPy, a popular psychology experiment builder, allows the use of a graphical user interface (GUI) to build and program an experiment without the specific knowledge of coding. The organized data collected outputs per participant data in seperate files and formats (.csv, .log, and .psydat). This function may be used beyond this specific purpose with specific tweaks (commented in code) however it was written with this in mind. This function will read all comma seperated values (.csv) files in a given directory into R, clean up by removing rows and columns which belong to empty files, and output a single dataframe with all rows and columns with participant data.

NOTE: This function will retain all the columns and non-empty rows whether or not they may be useful to you. If a project was started with many variables or changes were made to variable names, it is important to check which columns are useful to you.

# Why use this function?

This function allows you to quickly import all the data from a given PsychoPy data directory to look at all the data at once. This is helpful to allow a user to check which files may or may not be useful in a single dataframe rather than opening multiple comma seperated value files one at a time. Whether your directory contains old data, partial data, or other issues with the PsychoPy output data, this function should retain all of the columns so that you can check the output dataframe to filter or select what is useful to you.

# Function

```r psypy2df
#install.packages("tidyverse")
#install.packages("readxl")

library(tidyverse)
library(readxl)

psypy2df <- function(directory) {
  #' @author Darren Liang
  #' @note Last updated: 01 DEC 2021
  #' @description Imports all *.csv files from a input directory as a single
  #' data frame object.
  #' @param directory (character) The absolute or relative path to a PsychoPy
  #' data directory.
  #' Usually ends with ../../data/ based on default Psychopy data structure.
  #' @usage psypy2df("directory")
  #' @return All the rows and columns from the .csv files from the directory as
  #' a single data frame object.
  #' @examples
  #' psypy2df("C:/Users/Admin/Documents/experiment/data")
  
  # preallocate dataframe for output object
  raw.list <- list()
  df <- data.frame()
  
  # obtain all the files and read in files in the data directory
  filelist <- list.files(path = directory, pattern = "*.csv", full.names = TRUE)
  for (index in 1:length(filelist)) {
    raw.list[[index]] <- read_csv(filelist[[index]])
  }
  
  # remove empty files from the list
  clean.list <- raw.list %>%
    compact()
  
  # remove all columns after framerate (framerate is usually the end of the
  # useful information for Psychopy)
  # if this function is being applied to another data structure, edit or remove
  # the select() line
  for (index in 1:length(clean.list)) {
    clean.list[[index]] <- as.data.frame(clean.list[[index]]) %>%
      select(1:frameRate)
    df <- merge(df, clean.list[[index]], all = TRUE)
  }
  
  # output object as data frame
  return(df)
}
```

## Usage
psypy2df('directory')

### Arguments
directory (char): An absolute or relative path to your directory containing all the .csv files which you wish to import into R in quotes (either " or ').

### Returns
df (dataframe): A single dataframe object containing all non-NA rows and columns from the imported .csv files.

#### Example
psypy2df('C:/Users/dliang55/Downloads/segmentation-timing-master/data')

See example output in knitted .Rmd to {{< staticref "post/psypy2df/psypy2df.pdf" "newtab" >}}PDF{{< /staticref >}}.