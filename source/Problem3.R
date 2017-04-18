######################################
# Case Study 2 Question 3
# MSDS 6306-Monday 6:30 CT
# Group Members: Johnson Ekedum, Emmanuel Farrugia, John Heinen, Lauren Darr

## Introduction: The average monthly temperature was recorded along with the standard deviation, for a host of countries (and continents) starting in the 1800s up until the 2000s.
## Furthermore, a second set of data contains the recorded temperatures for cities. The goal of this analysis is to explore differences in temperature between counries and cities.
## Also, we will explore the trends in average temperature for the U.S. from 1990. 

#Part 3.1
# Goal: Find the range of monthly average temperatures for each country and visualize the output.

#Install and load required Packages
install.packages("lubridate")
library(lubridate)
install.packages("tibble")
library(tibble)
install.packages("ggplot2")
library(ggplot2)

#Import data into R and take closer look at what data is present/summarize data/help make decisions about how to tidy data
setwd("C:/Users/Lauren/Desktop/caseStudy2/Data")
temp<- read.csv("TEMP.csv")
head(temp)
str(temp)

#Determine how many missing variables are in the data frame overall 
table(is.na(temp))

#There are many missing values in the data frame. It will be useless to have a date and country recorded where no average monthly temperature has been recorded so all rows with missing data will be removed.
temp2<- na.omit(temp)
str(temp2)

#The variable date is currently a factor variable with multiple date formats. We will reformat these multiple formats into a 'data' type variable.
ymd<- ymd(temp2$Date)
mdy<- dmy(temp2$Date)
ymd[is.na(ymd)]<-mdy[is.na(ymd)]
temp2$Date<-ymd
temp2$Date

#We are only interested in the average monthly temperatures for the years 1990 and on. Subset the data to omit years before 1990.
Date2<-as.Date(temp2$Date)
temp3<- subset(temp2, Date2>="1900-01-01")

#In order to find the range, we must first find the minimum and maximum avg. monthly temperatures for each country.
max<-tapply(temp3$Monthly.AverageTemp, temp3$Country, max)
min<-tapply(temp3$Monthly.AverageTemp, temp3$Country, min)

#Convert to data frames
max2<-data.frame(max)
min2<-data.frame(min)

#Convert rownames to column one for both
max3<-rownames_to_column(max2, "Country")
min3<-rownames_to_column(min2, "Country")


#Merge max and min data frames
Since1900<-merge(max3, min3, by="Country")

#Find the range of average monthly temperatures for each country since 1900.
Since1900$range<- Since1900$max-Since1900$min

#Subset the top 20 ranges
Top20<-Since1900[order(Since1900$range,decreasing=T),]
Top20<-Top20[1:20,]

#Visualize the countries with the top 20 differences in average monthly temperatures since 1900.
ggplot(Top20, aes(Country,range)) + geom_col()



#Part 3.2
#Goal: Explore temperature data for only the U.S. since 1990.

#Subset the dataframe temp3 by dates that are greater than or equal to 1990.
date3<-as.Date(temp3$Date)
temp1990<-subset(temp3, date3>="1990-01-01")

#Subset the dataframe to only include U.S. data
UStemp<-subset(temp1990, temp1990$Country== "United States")

#Create a new column to display the monthly average temperature in Fahrnheit.
UStemp$tempFahrenheit<-UStemp$Monthly.AverageTemp*1.8 + 32

#Find the average yearly temperatures in the U.S. since 1990.
UStemp$Year<-format(UStemp$Date, format="%y")
yearmean<-aggregate(tempFahrenheit~Year, UStemp, mean)

#Plot the average yearly temperatures in the U.S. since 1990.

#