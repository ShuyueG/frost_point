# How it works?

# 1) download all R files and "wgrib.exe" & "cygwin1.dll" in a folder called "data" in c:/

# 2) then open R studio, set working directory as "c:/data" and import our functions

setwd("c:/data")
source("Extract_GRIB.R")

# 3) extract temperature, Specific humidity, pressure and compute the dew point at a certain year, day and time
#    from the "GLDAS_NOAH025SUBP_3H" dataset (GRIB) 
#    For example, after running

Extract_GRIB("2010",68,"09")

# A file named "GLDAS_NOAH025SUBP_3H_2010_068_09.Rdata" will be created in "c:/data"
# if we open this file by R studio, 4 matrices will be loaded in working environment, they are:
# "Tt","q","p",and "dew", meaning global temperature, Specific humidity, pressure and dew point data at 9:00Z in the 68th day of 2010.

# 4) if we want to extract the data for a whole year, we can run loops. For example, the 2006

time<-c("00","03","06","09","12","15","18","21") # all times for one-day
 for (day in 1:365){  # 365 days in 2016
   for (t in time){
     Extract_GRIB("2006",day,t)
   }
 }
 
 # After the program ending, (8*365=) 2920 Rdata files will be created in "c:/data"
 
 ### To be continued ###
