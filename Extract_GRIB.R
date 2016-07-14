# Extract the temperature, Specific humidity, pressure and compute the dew point
# from the "GLDAS_NOAH025SUBP_3H" dataset (GRIB) and store them in a "Rdata" file
# input: year(YYYY [2000-2016]); day(DDD [001-366]);time(TT [00,03,06,09,12,15,18,21])
#        folder: the location for saving data, such as "c:/data/"
# output: a "Rdata" file named "GLDAS_NOAH025SUBP_3H_YYYY_DDD_HH.Rdata"
#     includes temperature(Tt), Specific humidity(q), pressure(p) and dew point(dew)
# support R files: "grb_extract.R","dew_point.R","Download_GRIB.R"
Extract_GRIB <- function(year, day, time, folder) {
  # import function files
  source("Download_GRIB.R")
  source("grb_extract.R")
  source("dew_point.R")
  
  day <- formatC(as.numeric(day), width = 3, flag = "0") # 66 to 066
  # download the grib file
  result <- Download_GRIB(year, day, time, folder)
  fname <- substr(result, 1, 56) # get the file's name
  
  Tt <- grb_extr(fname, 24, folder) # get temperature (in K)
  q <- grb_extr(fname, 25, folder) # get Specific humidity (in kg/kg)
  p <- grb_extr(fname, 26, folder) # get surface air pressure (in Pa)
  # compute dew point
  dew <- matrix(data = NA,
                nrow = 1440,
                ncol = 600) # new matrix of dew point
  for (i in 1:1440) {
    for (j in 1:600) {
      a_p <- p[i, j]
      a_q <- q[i, j]
      if ((!is.na(a_p)) & (!is.na(a_q))) {
        # both p and q are not NA
        dew[i, j] <- dew_point(a_p * 0.01, a_q) # 1 Pa=0.01 mb
      }
    }
  }
  # store data in Rdata file
  save(Tt,q,p,dew,file=paste(folder,substr(fname,1,20),"_",year,"_",day,"_",time,".Rdata",sep=""))
  # delete the downloaded grib file
  file.remove(paste(folder, fname, sep = ""))
}
