# the parallel computation version of code to compute frost points from dew points and temperature
# take dew points and temperature from Rdata files in one folder
# save computed frost points in Rdata files into another folder
# using the "foreach" and "doParallel" packages
# input & output: same as the Get_frost function, see in Get_frost.R

# initialize
folder_in<-"c:/data/2010/"
folder_out<-"c:/data/2010FP/"

# to get the real number of CPU's cores
# the performance is based on the real number of CPU's cores
library(parallel)
core_num <- detectCores(logical = F)

library(foreach)
library(doParallel)
source("frost_point.R")

# check input folder, only concern Rdata files
file_list <-
  list.files(folder_in, pattern = 'GLDAS_NOAH025SUBP_3H_\\d{4}_\\d{3}_\\d{2}.Rdata')

func <- function(i) {
  load(paste(folder_in,file_list[i],sep="")) # open Rdata file
  frostp<-frost_point(dew,Tt) # compute frost points 
  # store data in Rdata file
  save(frostp,file=paste(folder_out,substr(file_list[i],1,32),"_FP.Rdata",sep=""))
}
# initialize the parallel computation
cl <- makeCluster(core_num)
registerDoParallel(cl)
# start parallel computation
# all files in this folder
foreach(i = 1:length(file_list)) %dopar% func(i)
stopCluster(cl) # ending
return("Done.")