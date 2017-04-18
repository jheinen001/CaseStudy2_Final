# Case Study 2 Project
Lauren Darr, Emmanuel Farrugia, Johnson Ekedum, John Heinen


# Introduction
There are two parts to this project.  The first part entails looking at the native data set Orange to analyze three tree types and their age and circumference.  First, we will find the circumference median and mean of each tree type, then we will plot the data of the tree's age versus circumference.  Finally, we will compare the circumferences of each tree type visually using boxplots.

Add text for Question 3

This document will go through any data downloads, cleaning of data, visualization, and analysis conclusion.

Before getting started, load the doBy, ggplot2, and add text packages into your R workspace. We will use functions from both packages through the project.


```r
#Install Required libraries, doBy, ggplot2,...
if (!require("doBy")) {
  install.packages("doBy", repos="http://cran.rstudio.com/") 
}
library(doBy)
if (!require("ggplot2")) {
  install.packages("ggplot2", repos="http://cran.rstudio.com/") 
}
library(ggplot2)
```


## Question 2 Orange Trees
The Orange data is native to R, so we do not have to download from anywhere.  We can move right in to answering the questions of interest for this problem.  A little information on the data:

Tree: an ordered factor indicating the tree on which the measurement is made. The ordering is
according to increasing maximum diameter.
age: a numeric vector giving the age of the tree (days since 1968/12/31)
circumference: a numeric vector of trunk circumferences (mm). This is probably “circumference
at breast height”, a standard measurement in forestry.

First, we want to get the circumference mean and median for the trees.
```r
#Run the summaryBy function with mean and median as arguments in the list function to return the mean and median by Tree
summaryBy(circumference ~ Tree, data = Orange, FUN = list(mean, median))
```

```
##   Tree circumference.mean circumference.median
## 1    3           94.00000                  108
## 2    1           99.57143                  115
## 3    5          111.14286                  125
## 4    2          135.28571                  156
## 5    4          139.28571                  167
```
Next, we would like to plot the Age in days versus the Circumference of the trees, the plot will show different symbols and colors for each tree.
```r
##Plot of Age in Days versus Circumference (mm) of the trees in the data set, pch creates the different symbols
#used for each of the tree types plotted on the chart
plot(circumference ~ age,
           xlab = "Age (Days)",
           ylab = "Circumference (mm)",
           pch = c(16, 17, 18, 19, 20)[as.numeric(Tree)],  # different 'pch' types 
           main = "Age versus Circumference",
           col = c("red", "green","blue", "yellow", "orange")[as.numeric(Tree)],
           data = Orange)

#Adds legend to the scatter plot to identify which symbol belongs to which tree.           
legend("topleft", pch = c(16, 17, 18, 19, 20), col = c("red", "green","blue", "yellow", "orange"), legend = c("1","2","3","4","5"), title = "Trees")
```
![](https://github.com/jheinen001/CaseStudy2_Final/blob/master/paper/Orange1.PNG)<!-- -->


Finally, we will look at comparitive boxplots of circumferences by tree, sorted in increasing order of maximum diameter.
```r
#Comparitive Boxplots of Circumferences by Tree, sorted in increasing order of maximum diameter 
boxplot(circumference~Tree,data=Orange, main="Boxplot Circumference by Tree", xlab="Tree", ylab="Circumference")

```
![](https://github.com/jheinen001/CaseStudy2_Final/blob/master/paper/Orange2.PNG)<!-- -->

## Conclusion
Write Conclusion here