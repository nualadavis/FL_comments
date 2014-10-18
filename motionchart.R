# Author:   Nuala Davis, Newcastle University
# Purpose:  read in comments file and produce a google Motion chart
#           to show activity over the duration of the course.

## Set up constants and libraries
setwd("c:/users/Nuala/skydrive/r/nmd")
commentsFile = "data/hadrians-wall_comments.csv"
library(reshape)
library(googleVis)
library(plyr)

## read in the comments file, forcing input of steps in particular to character
## due to abject hatred of all things factor
cols<-c("integer", "character", "character", "character", "character","character","character", "integer")
comments<-read.csv(commentsFile, header=TRUE, sep=",", colClasses=cols)
comments<-data.frame(comments$step,comments$timestamp)
colnames(comments)<-c("step","date")
## replace . with _ in step so that we don't accidentally convert it to number
comments$step<-sub("\\.","\\_", comments$step)

## this would be a sensible place to subset if it needed eg last 7 days, set of steps

## pad out step element after the _ so that it sorts alphabetically
## otherwise 2_10 comes after 2_1  GRRR
tempStep<-matrix(unlist(strsplit(comments$step,"_")), ncol=2, byrow=TRUE)
tempStep[,2]<-formatC(tempStep[,2], width=2, flag="0")
comments$step<-paste(tempStep[,1],tempStep[,2],sep="_")

## table comments by day and convert timestamps to dates
## truncate the timestamp removing the hh:mm
comments$date<-substr(comments$date, 1,10)
commentsCounts <- count(comments, c("step", "date"))
commentsCounts$date<-as.Date(strptime(commentsCounts$date,"%Y-%m-%d"))

## run the chart without many settings first of all by uncommenting the next two lines
## z<-gvisMotionChart(commentsCounts, idvar="step", timevar="date")
## plot(z)
## fiddle with it on screen then paste the options here into myStateSettings
myStateSettings <-'
{"xAxisOption":"_ALPHABETICAL","xZoomedDataMin":0,"colorOption":"_UNICOLOR","playDuration":15000,"orderedByX":true,"xZoomedIn":false,"sizeOption":"_UNISIZE","yZoomedIn":false,"time":"2014-09-22","iconKeySettings":[{"key":{"dim0":"6_ 1"}},{"key":{"dim0":"3_ 1"}},{"key":{"dim0":"2_ 1"}},{"key":{"dim0":"5_ 1"}},{"key":{"dim0":"1_ 1"}},{"key":{"dim0":"4_ 1"}}],"yZoomedDataMax":2013,"yLambda":0,"iconType":"VBAR","xLambda":1,"uniColorForNonSelected":false,"yZoomedDataMin":0,"dimensions":{"iconDimensions":["dim0"]},"xZoomedDataMax":109,"orderedByY":false,"yAxisOption":"2","nonSelectedAlpha":0.4,"duration":{"multiplier":1,"timeUnit":"D"},"showTrails":false}
'

z<-gvisMotionChart(commentsCounts, idvar="step", timevar="date",
        options=list(
            state=myStateSettings, 
            width=1000
           )
          )
plot(z)

## you can save the output to plot this via a webbrowser with 
## print(z,'chart')




