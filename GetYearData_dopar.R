# the parallel computation version of code to download data for one year
# using the "foreach" and "doParallel" packages
# input & output: same as the GetYearData function, see in GetYearData.R

# initialize
  year<-2010
  st_day<-1
  ed_day<-365
  folder<-"c:/data/2010/"
  
  # need to run in the first time
  install.packages("foreach")
  install.packages("doParallel")
  install.packages("RCurl")
  
  source("Extract_GRIB.R")
  # time list for one day
  time <- c("00", "03", "06", "09", "12", "15", "18", "21")
  # to get the real number of CPU's cores
  # the performance is based on the real number of CPU's cores
  library(parallel)
  core_num <- detectCores(logical = F)
  
  library(foreach)
  library(doParallel)
  # function for doing parallel computation
  # download and extract data for a certain day in each process
  func <- function(d) {
    for (t in time) {
      Extract_GRIB(as.character(year), d, t, folder)
    }
  }
  # initialize the parallel computation
  cl <- makeCluster(core_num)
  registerDoParallel(cl)
  # start parallel computation
  foreach(d = st_day:ed_day) %dopar% func(d)
  stopCluster(cl) # ending
  return("Done.")
