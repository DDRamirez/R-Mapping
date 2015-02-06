library(choroplethr)
library(choroplethrMaps)
library(dplyr)


#This file has 2 columns: The Regions pulled from census and the decimal values
#for the % working in the county.
mapData <- "C:\\Users\\dramirez\\Desktop\\Projects\\Blog Files\\Where Workers Live Vs. Where They Work\\where_work.csv"

countyData <- read.csv(mapData)

#The data read in as decimals representing the percentages.  I want the legend
#of the map to be factors instead.  So I have to convert them. I'll use the 
#cut function to convert them.
?cut
#The cut function needs breaks to use.  I'll get the quartiles using the 
#quantile function.
county_breaks <- quantile(countyData$value,probs=seq(0,1,0.2))

#Now a function to generate the breaks.
breaks <- function(x){
  paste(round(county_breaks[x]*100,digits = 1),"% - ",round(county_breaks[x+1]*100,digits = 1),"%",sep="")
  
}

#Create the labels.
category_labels <- sapply(c(1:5),breaks)

#Put the categories in the data. Make sure to "include.lowest=TRUE" or the lowest
#value with be "NA".
countyData$value <- cut(countyData$value,breaks=county_breaks,labels=category_labels,include.lowest=TRUE)

#And map
county_choropleth(countyData,zoom=c("north carolina"),buckets=5)
