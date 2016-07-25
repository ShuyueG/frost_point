# This function compute frost points from dew points and temperature
# take dew points and temperature from Rdata files in one folder
# save computed frost points in Rdata files into another folder
# input: folder of input data files (dew points and temperature)
#        and folder of output data files (frost points)
# output: If all files in one folder (input data) have been computed, it stops.
Get_frost<-function(folder_in,folder_out){
  source("frost_point.R")
  # check input folder, only concern Rdata files
  file_list <-
    list.files(folder_in, pattern = 'GLDAS_NOAH025SUBP_3H_\\d{4}_\\d{3}_\\d{2}.Rdata')
  # all files in this folder
  for (i in 1:length(file_list)){
    load(paste(folder_in,file_list[i],sep="")) # open Rdata file
    frostp<-frost_point(dew,Tt) # compute frost points 
    # store data in Rdata file
    save(frostp,file=paste(folder_out,substr(file_list[i],1,32),"_FP.Rdata",sep=""))
  }
  
}