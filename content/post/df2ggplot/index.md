---
title: "df2ggplot: Quick and dirty ggplot"
subtitle: "Without learning the idiosyncracies in R"

# Summary for listings and search engines
summary: "User-facing function to create a quick visualization of your data using the popular ggplot package in R."

# Link this post with a project
projects: []

# Date published
date: "2021-11-303T00:00:00Z"

# Date updated
lastmod: "2021-11-30T00:00:00Z"

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
url_code: "/post/df2ggplot/df2ggplot.R"
url_pdf: "post/df2ggplot/df2ggplot.pdf"
---

# Purpose

To quickly create a ggplot chart in R using any data object which has rows and columns. This function takes some typical defaults for creating a chart found in the ggplot cheatsheet (https://raw.githubusercontent.com/rstudio/cheatsheets/main/data-visualization.pdf) to create a quickly stylized chart. The purpose is to just create a quick graph to visualize your data without thinking too much about the how and why that is to cut down the data management and time it takes organize and create a graph. 

NOTE: This function doesn't directly pipe into the ggplot package so there are limited settings which can be adjusted in this function however additional layers can be added as the output object is a ggplot compatible list object. 

# Why use this function?

This function allows you to quickly create a graph using any data object with rows and columns. Since most data is organized in a way that columns are variables and rows are participants, this function allows data to be inputted as is without conforming to the ggplot specific format. There are some idiosyncracies in R and ggplot such is not typical in any other programming language (e.g. pivotting tables) so this function will extract only the specified variables, clean, and pivot the table in addition to creating the specified chart, if avalilable, in addition to providing basic titles, labels, and scales. This should make ggplot more accessible with other types of objects (e.g. list, tibble, dataframe) as well as users coming from different programming languages as a function specification may be more intuitive.

# Function

```r df2ggplot
#install.packages("tidyverse")

library(tidyverse)

df2ggplot <- function(data, x, y = NULL, group = NULL, type = NULL) {
  #' @author Darren Liang
  #' @note Last updated: 01 DEC 2021
  #' @description Quickly creates a type of chart using ggplot using the data
  #' and variables from a typically organized data frame (columns are variables
  #' and rows are participants). since it is not typical to pivot tables in
  #' other programs, this function will extract and pivot only the required
  #' variables for ease of use in addition to providing basic titles and labels.
  #' @param data (list/ tibble/ data frame) A data object which contains columns
  #' and rows. Will be coerced into a data frame anyways.
  #' @param x (char) A character string which contains the name of a column
  #' which can be found in the data object. Plotted on the x-axis.
  #' @param y (char) OPTIONAL. A character string which contains the name of a
  #' column which can be found in the data object. Plotted on the y-axis.
  #' @param group (char) OPTIONAL. A character string which contains the name of
  #' a column which can be found in the data object. Will be used to color
  #' separate the group.
  #' @param type (char) OPTIONAL. A character string which contains the name of
  #' the type of chart you which to create. Refer to the ggplot2 cheat sheet for
  #' the most popular usage types (only include the type past geom*). Not all
  #' graph types are included in this function.
  #' @usage df2ggplot(data = data, x = "var1", y = "var2", group = "var3",
  #' type = "chart")
  #' @return A list object which can be viewed as a plot.
  #' @examples
  #' df2ggplot(data = mtcars, x = "mpg", y = "hp", group = "gear",
  #' type = "jitter")
  
  # create a new data frame by extracting variables from the input data
  data <- as.data.frame(data) %>%
    
    # clean all empty cells in case there are any
    compact() %>%
    
    # selects non-NULL variables if they exists to keep
    select(all_of(x), all_of(y), all_of(group)) %>%
    pivot_longer(!c(all_of(y), all_of(group)),
                 names_to = "scores", values_to = "values")
  
  # group_by() if applicable
  for (index in seq_along(group)) {
    group_by(data, group[[index]])
  }
  
  # plot the object using the specified features
  plt <- data %>%
    ggplot(aes(x = values)) +
    theme_classic() +
    labs(x = x, title = paste(x))
  
  if (!is.null(y)) {
    plt <- plt +
      aes(y = get(y)) +
      labs(x = x, y = y, title = paste(x, "vs.", y))
  }
  
  if (!is.null(group)) {
    plt <- plt +
      aes(color = get(group)) +
      labs(color = group)
  }
  
  # select type of graph based on type of data
  # Some but not all popular geom* included from ggplot2 cheat sheet found at:
  # https://raw.githubusercontent.com/rstudio/cheatsheets/main/data-visualization.pdf
  if (is.null(type)) {
    message("Type not specified, default visualization selected.")
    if (is.null(y)) {
      plt <- plt +
        geom_histogram(binwidth = 5)
    } else {
      plt <- plt +
        geom_jitter()
    }
  } else if (type == "area") {plt <- plt + geom_area()
  } else if (type == "density") {plt <- plt + geom_density(kernel = "gaussian")
  } else if (type == "dotplot") {plt <- plt + geom_dotplot()
  } else if (type == "freqpoly") {plt <- plt + geom_freqpoly()
  } else if (type == "histogram") {plt <- plt + geom_histogram(binwidth = 5)
  } else if (type == "bar") {plt <- plt + geom_bar()
  } else if (type == "point") {plt <- plt + geom_point()
  } else if (type == "rug") {plt <- plt + geom_rug(sides = "bl")
  } else if (type == "smooth") {plt <- plt + geom_smooth(method = lm)
  } else if (type == "col") {plt <- plt + geom_col()
  } else if (type == "boxplot") {plt <- plt + geom_boxplot()
  } else if (type == "violin") {plt <- plt + geom_violin(scale = "area")
  } else if (type == "count") {plt <- plt + geom_count()
  } else if (type == "jitter") {plt <- plt + geom_jitter()
  } else if (type == "line") {plt <- plt + geom_line()
  } else {stop("Graph type not included. Try ggplot geom_* instead.")
  }
  
  return(plt)
}

```

## Usage
df2ggplot(data = data, x = "var1", y = "var2", group = "var3", type = "chart")

### Arguments
data (list/ tibble/ data frame): A data object which contains columns and rows. Will be coerced into a data frame anyways.

x (char): A character string in quotes (either " or ') which contains the name of a column which can be found in the data object. Plotted on the x-axis.

y (char): *OPTIONAL.* A character string in quotes (either " or ') which contains the name of a column which can be found in the data object. Plotted on the y-axis.

group (char): *OPTIONAL.* A character string in quotes (either " or ') which contains the name of a column which can be found in the data object. Will be used to color separate the group.

type (char): *OPTIONAL.* A character string in quotes (either " or ') which contains the name of the type of chart you which to create. Refer to the ggplot2 cheat sheet for the most popular usage types (only include the type past geom*). Not all graph types are included in this function.

### Returns
plt (list): A single list object containing a ggplot compatible plot.

#### Example
df2ggplot(data = mtcars, x = "mpg", y = "hp", group = "gear", type = "jitter")

See example output in knitted .Rmd to {{< staticref "post/df2ggplot/df2ggplot.pdf" "newtab" >}}PDF{{< /staticref >}}.