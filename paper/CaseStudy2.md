# Case Study 2 Project
Lauren Darr, Emmanuel Farrugia, Johnson Ekedum, John Heinen


# Introduction
There are two parts to this project.  The first part entails looking at the native data set Orange to analyze three tree types and their age and circumference.  First, we will find the circumference median and mean of each tree type, then we will plot the data of the tree's age versus circumference.  Finally, we will compare the circumferences of each tree type visually using boxplots.

In Question 3, we will be analyzing the minimum and maximum monthly average temperatures for a set of countries and cities since the year 1900.  We will identify the top 20 countries and cities with the largest range in minimum and maximum temperatures in celcius.  Next, we will dive deeper into the US temperatures from 1990. Finally, we will include a comparison analysis of the two graphs, top 20 countries versus top 20 cities.

This document will go through any data downloads, cleaning of data, visualization, and analysis conclusion.

Before getting started, load the doBy, ggplot2, lubridate, and dyplr packages into your R workspace. We will use functions from these packages through the project.


```r
#Following code checks if you have the packages doby, ggplot2, lubridate, and dyplr.  If you do not have, it will
#install the packages, if you do have, then it will not reinstall, it will just load the libraries.
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
if (!require("dplyr")) {
  install.packages("dyplr", repos="http://cran.rstudio.com/") 
}
library(dplyr)
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
#Run the summaryBy function with mean and median as arguments in the list function to return the mean and median
#by Tree
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
legend("topleft", pch = c(16, 17, 18, 19, 20), col = c("red", "green","blue", "yellow", "orange"), 
  legend = c("1","2","3","4","5"), title = "Trees")
```
![](https://github.com/jheinen001/CaseStudy2_Final/blob/master/paper/Orange1.PNG)<!-- -->


Finally, we will look at comparitive boxplots of circumferences by tree, sorted in increasing order of maximum diameter.
```r
#Comparitive Boxplots of Circumferences by Tree, sorted in increasing order of maximum diameter 
boxplot(circumference~Tree,data=Orange, main="Boxplot Circumference by Tree", xlab="Tree", ylab="Circumference")

```
![](https://github.com/jheinen001/CaseStudy2_Final/blob/master/paper/Orange2.PNG)<!-- -->

## Question 3 Country and City Temperatures
In Question 3, we will be analyzing the minimum and maximum monthly average temperatures for a set of countries since the year 1900.  We will first identify the top 20 countries with the largest range in minimum and maximum temperatures in celcius.  Next, we will dive deeper into the US temperatures from 1990, converting the temperatures to Farenheit, calculating yearly average land temperature as opposed to monthly average temperature in the first part of the question.  Finally for this part of Question 3, we will calculate the one year difference of average land temperature by year and provide the maximum difference with the corresponding two years.

Next, we will take a look at a dataset of City temperatures since 1900.  Like in the first graph, we will repor the top 20 cities with the largest range in minimum and maximum temperatures, but at the city level.

Finally, we will include a comparison analysis of the two graphs, top 20 countries versus top 20 cities.

## Country Temperature Data

First, we must read in the data to begin our analysis.
```r
#Read in external data set "Temp.csv".
#Make sure to set your working directory accordingly for this project.
#This sets the data to a variable called Temp.data
#setwd("C:/Users/Lauren/Desktop/caseStudy2/Data")
Temp.data <- read.csv("TEMP.csv", stringsAsFactors = FALSE )
```
Next, we must clean our data to make sure that it is ready for analysis.  We will start by taking a look at the structure, view the data file, and look at the column headers.

```r
#first lets look at the structure of the Data
str(Temp.data)
#second view the data file
View(Temp.data)
#third look at the column headers
colnames(Temp.data)
```
The structure of the data:
```
##'data.frame':	574223 obs. of  4 variables:
## $ Date                           : chr  "1838-04-01" "1838-05-01" "1838-06-01" "1838-07-01" ...
## $ Monthly.AverageTemp            : num  13 NA 23.9 26.9 24.9 ...
## $ Monthly.AverageTemp.Uncertainty: num  2.59 NA 2.51 2.88 2.99 ...
## $ Country                        : chr  "Afghanistan" "Afghanistan" "Afghanis
```
The column headers:
```
##[1] "Date"                            "Monthly.AverageTemp"             "Monthly.AverageTemp.Uncertainty"
##[4] "Country"      
```
Now, we will check for NA's in our dataset:
```r
#Let's also see if there are NA's within our dataset columns
sapply(Temp.data, function(x)  sum(is.na(x)) )
```
```
##                           Date             Monthly.AverageTemp Monthly.AverageTemp.Uncertainty 
##                              0                           32578                           31839 
##                        Country 
##                              0 
```
Finally, we will clean up our date values so that they all match and will make analysis by date possible.

```r
#Date cleanup: convert dates to "date" variables of matching format.
ymd<- ymd(Temp.data$Date)
mdy<- dmy(Temp.data$Date)
ymd[is.na(ymd)]<-mdy[is.na(ymd)]
Temp.data$Date<-ymd
Temp.data$year <- substr(Temp.data$Date,1,4)
Temp.data$year <- as.numeric(Temp.data$year)
```

Now we are ready to begin working with our data for analysis.  We will have to calculate the range in maximum and minimum monthly average temperature for each country. We will then take a look at the data.

```r
#find the difference between the maximum and the minimum monthly average temperature for each country.
Temp.one <- Temp.data %>% 
    select (Date,year, Country,Monthly.AverageTemp) %>% 
    na.omit() %>% 
    filter(year >= 1900) %>% 
    group_by(Country)  %>% 
  summarise(temp_diff = max(Monthly.AverageTemp) -
              min(Monthly.AverageTemp)) %>% 
    arrange(desc(temp_diff))
Temp.one
```    
```
### A tibble: 241 × 2
##        Country temp_diff
##          <chr>     <dbl>
##1    Kazakhstan    49.163
##2      Mongolia    48.010
##3        Russia    46.682
##4        Canada    43.532
##5    Uzbekistan    42.698
##6  Turkmenistan    40.579
##7       Belarus    39.338
##8       Finland    39.068
##9       Estonia    38.815
##10      Ukraine    38.660
### ... with 231 more rows
```

We are able to plot our first graph to answer the question of interest in Question 3.i.
```r
#report/visualize top 20 countries with the maximum differences for the period since 1900.
ggplot(Temp.one[1:20,], aes(Country,temp_diff)) + geom_col() + theme(axis.text.x=element_text(angle=90, hjust=1)) +
  xlab("Country") + ylab ("Range (Celcius)") + ggtitle("Top 20 temperature ranges by country") +
  theme(plot.title=element_text(hjust=0.5))
```
![](https://github.com/jheinen001/CaseStudy2_Final/blob/master/paper/Top20.PNG)<!-- -->
    
For Question 3.ii we will now look at a subset of the data and focus on US temperatures.  Our first task is to create a new column in the data and convert the degrees in celcius to farenheit.

```r
#Create a new column to display the monthly average land temperatures in Fahrenheit (?F).
Temp.two <- Temp.data %>% na.omit %>% 
  select (year, Monthly.AverageTemp,Country) %>% 
  filter ( Country=='United States', year >= 1900 ) %>% 
  mutate(Temp_Fahrenheit= Monthly.AverageTemp  * 9/5 + 32 ) %>% 
  select (year, Temp_Fahrenheit)%>%
  group_by(year) %>% 
  summarise(Avg_land_temp=mean(Temp_Fahrenheit) )
#Display new column
Temp.two
```
Display of new converted farenheit column for 3.ii.a:
```
### A tibble: 114 × 2
##    year Avg_land_temp
##   <dbl>         <dbl>
##1   1900      48.23885
##2   1901      47.29085
##3   1902      47.21720
##4   1903      46.35905
##5   1904      46.76120
##6   1905      47.12420
##7   1906      47.40815
##8   1907      47.10920
##9   1908      47.76005
##10  1909      46.79930
### ... with 104 more rows
```
We will now plot the average land temperature by year for 3.ii.b:
```r
ggplot(Temp.two,aes(year,Avg_land_temp)) + geom_line() + xlab("Year") + ylab ("Avg. Yearly Temp (Fahrenheit)") +
  ggtitle("Average Yearly Temperatures in the U.S. 1990-2013") + theme(plot.title=element_text(hjust=0.5))

```
![](https://github.com/jheinen001/CaseStudy2_Final/blob/master/paper/YearlyTemp.PNG)<!-- -->

Finally for question 3.ii.c, we will calculate the one year difference of average land temperature by year and provide the maximum difference with the corresponding two years.
```r
#Calculate the one year difference of average land temperature by year and 
#provide the maximum difference (value) with corresponding two years.
difference_in_temp <- diff(Temp.two$Avg_land_temp)
temp3 <- cbind(Temp.two[1:113,],difference_in_temp)
#Display maximum difference in temp
which.max(temp3$difference_in_temp)
```
Display maximum difference in temp of 21.
```
##[1] 21
```
```r
#Display temp difference for next two years
temp3[c(21,22),]
```
Display temperature difference for the following two years of 2.54 and -1.49 respectively.
```
##   year Avg_land_temp difference_in_temp
##21 1920       46.7321             2.5401
##22 1921       49.2722            -1.4895
```

We will now move to question 3.iii, in which we will work with a new data set of city temperatures.  We will first have to bring in the new data set to our workspace.
```r
#Read in data set.
City.data <- read.csv("CityTemp.csv", stringsAsFactors = FALSE )
```
Again, we will have to clean up the data in order to make sure it is ready to use.  We will first look at the first few rows of the data, and then the structure of the data.
```r
# Check first rows of dataset
head(City.data)
```
```
##        Date Monthly.AverageTemp Monthly.AverageTemp.Uncertainty        City  Country Latitude Longitude
##1 1850-01-01              15.986                           1.537 Addis Abeba Ethiopia    8.84N    38.11E
##2 1850-02-01              18.345                           1.527 Addis Abeba Ethiopia    8.84N    38.11E
##3 1850-03-01              18.632                           2.162 Addis Abeba Ethiopia    8.84N    38.11E
##4 1850-04-01              18.154                           1.693 Addis Abeba Ethiopia    8.84N    38.11E
##5 1850-05-01              17.480                           1.237 Addis Abeba Ethiopia    8.84N    38.11E
##6 1850-06-01              17.183                           1.252 Addis Abeba Ethiopia    8.84N    38.11E
```
```r
# Check structure of dataset
str(City.data)
```
```
##'data.frame':	237200 obs. of  7 variables:
## $ Date                           : chr  "1850-01-01" "1850-02-01" "1850-03-01" "1850-04-01" ...
## $ Monthly.AverageTemp            : num  16 18.3 18.6 18.2 17.5 ...
## $ Monthly.AverageTemp.Uncertainty: num  1.54 1.53 2.16 1.69 1.24 ...
## $ City                           : chr  "Addis Abeba" "Addis Abeba" "Addis Abeba" "Addis Abeba" ...
## $ Country                        : chr  "Ethiopia" "Ethiopia" "Ethiopia" "Ethiopia" ...
## $ Latitude                       : chr  "8.84N" "8.84N" "8.84N" "8.84N" ...
## $ Longitude                      : chr  "38.11E" "38.11E" "38.11E" "38.11E" ...
```
We need to clean up the date field in this data set.
```r
#Date Cleaning
ymd<- ymd(City.data$Date)
mdy<- dmy(City.data$Date)
ymd[is.na(ymd)]<-mdy[is.na(ymd)]
City.data$Date<-ymd

City.data$year<- substr(City.data$Date,1,4)
City.data$year <- as.numeric(City.data$year)
```
Now we can calculate the difference between the maximum and minimum temperatures for each major city and then display a graph of the top 20 cities with maximum differences for the period since 1900.
```r
#Find the difference between the maximum and the minimum temperatures 
#for each major city 
City.one<- City.data %>% 
  select (year,City,Monthly.AverageTemp) %>% 
  na.omit() %>% 
  filter(year >= 1900) %>% 
  group_by(City)  %>% 
  summarise(temp_diff = max(Monthly.AverageTemp) -
              min(Monthly.AverageTemp)) %>% 
  arrange(desc(temp_diff))
City.one
```
```
### A tibble: 99 × 2
##               City temp_diff
##              <chr>     <dbl>
##1            Harbin    53.281
##2         Changchun    49.844
##3            Moscow    43.956
##4          Shenyang    43.045
##5          Montreal    41.422
##6              Kiev    40.784
##7  Saint Petersburg    40.510
##8           Toronto    38.683
##9           Taiyuan    37.834
##10           Peking    36.953
### ... with 89 more rows
```

We will now display the graph and provide a written comparison analysis of this graph and the graph from 3.i.
```r
#visualize top 20 cities with maximum differences for the period since 1900.
ggplot(City.one[1:20,], aes(City,temp_diff)) + geom_col() + theme(axis.text.x=element_text(angle=90, hjust=1)) +
  xlab("City") + ylab ("Range (Celcius)") + ggtitle("Top 20 temperature ranges by city") +
  theme(plot.title=element_text(hjust=0.5))
```
![](https://github.com/jheinen001/CaseStudy2_Final/blob/master/paper/zTop20City.PNG)<!-- -->

Comparison Analysis Question 3.iv: The bar graphs depicting the top 20 countries and cities, respectively, with the greatest range in temperatures recorded since 1900 are similar. 
Of the top 20 countries, 6 recorded maximum differences above 40?C. Of the top 20 cities, 7 recorded maximum differences above 40 degrees celcius. 
Furthermore, no maximum difference was recorded below 30?C nor above 50?C for both cities and countries.
However, the top 20 ranges recorded for cities cannot be used to determine the top 20 ranges recorded for countries.
For example, the two highest maximum differences recorded for cities belong to Harbin and Changchun.
Both of these cities reside in China, but China is not in the top 20 list of country temperature ranges.
This discrepancy suggests that the temperatures recorded for "Countries" may not have necessarily been recorded in the "cities" that are connected to them from the other data set.
Also, without an understanding of how the temperatures were recorded for each country we do not even know how representative the recorded temperatures are of the entire countries. 
Overall, the maximum difference data for both countries and cities paints a picture of world temperatures as generally having ranges no larger than 50?C in any given geographical loaction.

## Conclusion
For the questions of interest in this project, we were able to utilize the skills in R that we have acquired over the semester.  We were able to pull in data, clean it, conduct analysis, and then provide various visuals.  In this particular project we worked with Orange Tree data and saw a linear correlation between age of a tree and circumference.  We also worked with Country and City temperature data and were able to analyze that data for a large period of time.