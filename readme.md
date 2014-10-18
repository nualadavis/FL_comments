---
title: "READ_ME"
author: "Nuala Davis"
date: "Thursday, October 16, 2014"
output: html_document
---
This is a bit of fun - looking at the step activity through a Google Motion chart.

It takes as input a FutureLearn comments file, throws away everything but the step numbers and timestamps and then plots these.

A few things are hard coded eg filenames involved and working directory - should be easy to spot an replace.

The params held in myStateSettings are best derived by plotting the chart first, fiddling with the settings you need, then copying them out.

You can read about GoogleVis and R here:
http://cran.r-project.org/web/packages/googleVis/index.html  

I also found these helpful
https://code.google.com/p/google-motion-charts-with-r/
https://developers.google.com/chart/interactive/docs/gallery/motionchart#Motion_Chart_initial_state

You are welcome to reuse (especially if you can give me some hints on my dodgy R)
