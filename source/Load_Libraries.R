##Load necessary library packages for this project, includes doBy, ggplot2,....

if (!require("doBy")) {
  install.packages("doBy", repos="http://cran.rstudio.com/") 
}
library(doBy)
if (!require("ggplot2")) {
  install.packages("ggplot2", repos="http://cran.rstudio.com/") 
}