# This function is to complement the missing Rdata files for one year
# Many reasons could cause data missing, such the web connection problem, disk problem,
# unforeseen parallel computation problem, etc.
# Hence, we need to check data files' completeness and complement the missing ones
# input: the folder location such as "N:/data/2003 001-218/"
#        year for checking and # of days in this year (usually 365 or 366)
# output: state the running result by words
complement_data <- function(folder, year, st_day, ed_day) {
  source("Get_missing.R")
  source("Extract_GRIB.R")
  # check the missing files
  miss_dates <- Get_missing(folder, year, st_day, ed_day)
  
  if (is.null(miss_dates)) {
    return("The dataset is already complete.") # no missing file
  }
  
  for (missing in miss_dates) {
    # get the year, day and time for downloading and extracting data
    year <- substr(missing, 1, 4)
    day <- substr(missing, 6, 8)
    time <- substr(missing, 10, 11)
    Extract_GRIB(year, day, time, folder)
  }
  
  # double check after doing supplement
  miss_dates <- Get_missing(folder, year, st_day, ed_day)
  
  if (is.null(miss_dates)) {
    return("The dataset is now complete.")
  } else{
    return("The dataset is still incomplete, please check or run it again.")
  }
}