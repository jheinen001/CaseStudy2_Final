##Load necessary library packages for this project, includes doBy, ggplot2, lubridate, dyplr

if (!require("doBy")) {
  install.packages("doBy", repos="http://cran.rstudio.com/") 
}
library(doBy)
if (!require("ggplot2")) {
  install.packages("ggplot2", repos="http://cran.rstudio.com/") 
}
library(ggplot2)
if (!require("lubridate")) {
  install.packages("lubridate", repos="http://cran.rstudio.com/") 
}
library(lubridate)
if (!require("dyplr")) {
  install.packages("dyplr", repos="http://cran.rstudio.com/") 
}
library(dyplr)