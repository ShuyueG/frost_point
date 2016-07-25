# the parallel computation version of code to complement the missing Rdata files for one year
# Many reasons could cause data missing, such the web connection problem, disk problem,
# unforeseen parallel computation problem, etc.
# Hence, we need to check data files' completeness and complement the missing ones
# using the "foreach" and "doParallel" packages
# input & output: same as the complement_data function, see in complement_data.R

# initialize
  year<-2010
  st_day<-1
  ed_day<-365
  folder<-"c:/data/2010/"

  source("Get_missing.R")
  source("Extract_GRIB.R")
  # check the missing files
  miss_dates <- Get_missing(folder, year, st_day, ed_day)
  
  if (is.null(miss_dates)) {
    return("The dataset is already complete.") # no missing file
  }
  
  # to get the real number of CPU's cores
  # the performance is based on the real number of CPU's cores
  library(parallel)
  core_num <- detectCores(logical = F)
  
  library(foreach)
  library(doParallel)
  
  num_missing<-length(miss_dates)
  
  func<-function(i){
     # get the year, day and time for downloading and extracting data
    year <- substr(miss_dates[i], 1, 4)
    day <- substr(miss_dates[i], 6, 8)
    time <- substr(miss_dates[i], 10, 11)
    Extract_GRIB(year, day, time, folder)
  }
  
  # initialize the parallel computation
  cl <- makeCluster(core_num)
  registerDoParallel(cl)
  # start parallel computation
  foreach(i = 1:num_missing) %dopar% func(i)
  stopCluster(cl) # ending
  
  # double check after doing supplement
  miss_dates <- Get_missing(folder, year, st_day, ed_day)
  
  if (is.null(miss_dates)) {
    return("The dataset is now complete.")
  } else{
    return("The dataset is still incomplete, please check or run it again.")
  }
