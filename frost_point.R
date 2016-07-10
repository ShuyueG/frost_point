# find frost points by dew points and temperature
# input: dew point data (in C) and temperature (in K)
# output: frost distribution, frost area=(-1), others=(1)
frost_point <- function(dew, Tt) {
  frostp <-
    matrix(data = NA,
           nrow = 1440,
           ncol = 600) # new matrix of frost point
  CTt <- (Tt - 273.15) # convert K to deg-C for Temperature 
  for (lon in 1:1440) {
    for (lat in 1:600) {
      a_CTt <- CTt[lon, lat]
      a_dew <- dew[lon, lat]
      # both dew and CTt are not NA
      if ((!is.na(a_CTt)) &
          (!is.na(a_dew))) {
        # if temperature is below the dew point and colder than freezing (0C)
        # frost will form
        if ((a_CTt < a_dew)
            & (a_CTt < 0)) {
          frostp[lon, lat] <- (-1) # frost formed
        } else{
          frostp[lon, lat] <- (1) # not frost
        }
      }
    }
  }
  return(frostp)
}
