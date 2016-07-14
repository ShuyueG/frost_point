# This function is to check if the downloaded files are complete for one year
# if they're incomplete, it returns the missing items named as YYYY_DDD_TT
# input: the folder location such as "N:/data/2003 001-218/"
#        year for checking and start day & end day in this year (usually 1 to 365 or 366)
# output: if no missing, return NULL; otherwise returns the missing items
#          named as YYYY_DDD_TT, e.g. "2003_106_12"
Get_missing <- function(folder, year, st_day, ed_day) {
  # check folder, only concern Rdata files
  file_list <-
    list.files(folder, pattern = 'GLDAS_NOAH025SUBP_3H_\\d{4}_\\d{3}_\\d{2}.Rdata')
  dates <- substr(file_list, 22, 32) # real data list in folder
  
  # function for getting ideal data list (complete list)
  Get_norm <- function(year, st_day, ed_day) {
    time <- c("00", "03", "06", "09", "12", "15", "18", "21")
    year <- as.character(year)
    
    norm_list <- character(0)
    for (d in st_day:ed_day) {
      d <- formatC(as.numeric(d), width = 3, flag = "0") # 66 to 066
      for (t in time) {
        norm_list <- c(norm_list, paste(year, "_", d, "_", t, sep = ""))
      }
    }
    return(norm_list)
  }
  # get ideal data list
  norm_dates <- Get_norm(year, st_day, ed_day)
  
  # find the difference
  miss_dates <- setdiff(norm_dates, dates)
  
  # miss files or not
  if (length(miss_dates) == 0) {
    return() # No missing.
  } else{
    return(miss_dates)
  }
  
}
