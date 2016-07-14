# To download data for one year
# input: the year [2000-2016], start day & end day in this year (usually 1 to 365 or 366)
#        the folder location such as "N:/data/2003 001-218/"
# output: if downloading is finish, state words "done"
GetYearData <- function(year, st_day, ed_day, folder) {
  # install.packages("RCurl") # need to run in the first time
  source("Extract_GRIB.R")
  # time list for one day
  time <- c("00", "03", "06", "09", "12", "15", "18", "21")
  
  for (day in st_day:ed_day) {
    for (t in time) {
      # download and extract data for a certain day & time
      Extract_GRIB(as.character(year), day, t, folder)
    }
  }
  return("Done.")
}