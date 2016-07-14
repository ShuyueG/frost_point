# download one file from "GLDAS_NOAH025SUBP_3H" dataset
# input: year(YYYY [2000-2016]); day(DDD [001-366]);time(TT [00,03,06,09,12,15,18,21])
#        folder: the location for saving data, such as "c:/data/"
# output: download the file: "GLDAS_NOAH025SUBP_3H.AYYYYDDD.TT00.***.*************.grb"
library(RCurl)
Download_GRIB <- function(year, day, time, folder) {
  # -----time check--------
  legal_time <- c("00", "03", "06", "09", "12", "15", "18", "21")
  if (is.na(match(time, legal_time))) {
    # time is legal or not
    return(paste(
      time,
      "is not a legal time. Legal time must be in [00,03,06,09,12,15,18,21]"
    )) # not legal
  }
  # ------- Url check---------
  web <-
    "ftp://hydro1.sci.gsfc.nasa.gov/data/s4pa/GLDAS_V1/GLDAS_NOAH025SUBP_3H"
  Url <- paste(web, "/", year, "/", day, "/", sep = "")
  if (!url.exists(Url)) {
    # url is real or not
    return(paste(Url, "does not exist.")) # not real, end function
  }
  # --------- get the list of files' names--------
  fnames <- getURL(Url, ftp.use.epsv = F, dirlistonly = T)
  x <- strsplit(fnames, "\r\n")[[1]]
  fname_list <- character(0) # initialze empty file name list
  # reject ".xml" or other files
  for (i in 1:length(x)) {
    fileformat <- substr(x[i], nchar(x[i]) - 2, nchar(x[i]))
    if (fileformat == "grb") {
      fname_list <- c(fname_list, x[i])
    }
  }
  # --------- get the file's name for downloading-------
  down_name <- NA # file for downloading
  for (i in 1:length(fname_list)) {
    T <- substr(fname_list[i], 31, 32) # get the time in files' name
    if (T == time) {
      # matched
      down_name <- fname_list[i]
      break
    }
  }
  if (is.na(down_name)) {
    return("file not found.")
  }
  
  # -------- download the file----------
  dat <-
    getBinaryURL(paste(Url, down_name, sep = ""))
  writeBin(dat, paste(folder, down_name, sep = "")) # download file in folder
  
  return(paste(down_name, "has been downloaded."))
}
