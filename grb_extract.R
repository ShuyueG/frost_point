# read grib1 data file and extract one band data to be a matrix
# input: grib1 file, band number
# output: a certain band data by matrix
# "wgrib.exe" and "cygwin1.dll" file need
grb_extr <- function(fname, band_num) {
  # extract data by wgrib.exe and store in TEMP.txt
  system(paste("wgrib", fname, "-d", band_num, "-text -nh -o TEMP.txt"))
  x <- read.table("TEMP.txt") # read the TEMP.txt
  # convert list to matrix
  band <- matrix(unlist(x),
                 nrow = 1440,
                 ncol = 600,
                 byrow = FALSE)
  band[band > 999999] <- NA # mark NA data
  file.remove("TEMP.txt")
  return(band)
}
