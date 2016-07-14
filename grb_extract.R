# read grib1 data file and extract one band data to be a matrix
# input: grib1 file, band number,folder location
# output: a certain band data by matrix
# "wgrib.exe" and "cygwin1.dll" file need
grb_extr <- function(fname, band_num, folder) {
  # extract data by wgrib.exe and store in TEMP.txt
  system(paste(
    "wgrib",
    paste("\"", folder, fname, "\"", sep = ""),
    "-d",
    band_num,
    paste("-text -nh -o ", "\"", folder, fname, "_TEMP.txt", "\"", sep = "")
  ))
  x <-
    read.table(paste(folder, fname, "_TEMP.txt", sep = "")) # read the TEMP.txt
  # convert list to matrix
  band <- matrix(unlist(x),
                 nrow = 1440,
                 ncol = 600,
                 byrow = FALSE)
  band[band > 999999] <- NA # mark NA data
  file.remove(paste(folder, fname, "_TEMP.txt", sep = ""))
  return(band)
}
