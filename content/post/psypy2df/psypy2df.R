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