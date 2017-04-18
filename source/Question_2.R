##Question 2 R Code

#Using the built-in data set, Orange, this code is to calculate the mean and median of each type of Tree in the data set.
#First Install doBy package if you do not already have available
install.packages("doBy")

#Load the doBy library
library(doBy)

#Run the summaryBy function with mean and median as arguments in the list function to return the mean and median by Tree
summaryBy(circumference ~ Tree, data = Orange, FUN = list(mean, median))

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

#Comparitive Boxplots of Circumferences by Tree, sorted in increasing order of maximum diameter 
boxplot(circumference~Tree,data=Orange, main="Boxplot Circumference by Tree", xlab="Tree", ylab="Circumference")