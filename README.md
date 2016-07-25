## How it works?

#### (1) Download R files
download all R files and `wgrib.exe` & `cygwin1.dll` in same one folder (e.g. called `data` in `c:/`)

#### (2) Initialize the environment
then open R studio, set working directory in this folder (e.g. `c:/data`), install packages and import functions

 	setwd("c:/data")
 	install.packages("foreach")
  	install.packages("doParallel")
  	install.packages("RCurl")
 	source("Extract_GRIB.R")

#### (3) Get one Rdata file for a certain year, day and time
extract temperature, Specific humidity, pressure and compute the dew point at a certain year, day and time from the `GLDAS_NOAH025SUBP_3H` dataset (GRIB) For example, after running

	Extract_GRIB("2010",68,"09","c:/data/2010/")


A file named `GLDAS_NOAH025SUBP_3H_2010_068_09.Rdata` will be created in `c:/data/2010/` if we open this file by R studio, 4 matrices will be loaded in working environment, they are: `Tt`,`q`,`p`,and `dew`, meaning global temperature, Specific humidity, pressure and dew point data at 9:00Z in the 68th day of 2010.

#### (4) Get Rdata files for one year
if we want to extract the data for a whole year, we can run the function `GetYearData`. For example, to 2006

	GetYearData(2006,1, 365,"c:/data/2006/")
 
After the program ending, (8*365=) 2920 Rdata files will be created in `c:/data/2006/`
 
##### (4.1) Get Rdata files for one year faster
to speed the program up by using parallel computation
we can run the codes in `GetYearData_dopar.R`. For example, to 2010

	# initialize
  	year<-2010
  	st_day<-1
  	ed_day<-365
  	folder<-"c:/data/2010/"
  	...

After the program ending, 2920 Rdata files will be created in `c:/data/2010/`
its performance is based on the real number of CPU’s cores. If the computer has only Mono-core, the performance is same as function `GetYearData`.
However, the stability of parallel computation `GetYearData_dopar` is worse than non-parallel `GetYearData`. Many reasons could cause data missing, such the unforeseen parallel computation problem, web connection problem, disk problem, etc. Therefore, we have a function to complement the missing Rdata files for one year.

#### (5) Complement the missing Rdata files
The function `complement_data` in `complement_data.R` is used to complement the missing Rdata files for one year. 
First, it runs the `Get_missing` function to check data files' completeness and find missing files' name; then it downloads these missing Rdata files by using `Extract_GRIB` function (non-parallel). For example, to 2006

	complement_data("c:/data/2006/", 2006,1, 365)

If there is no missing file for this year, it will return words: "The dataset is already complete."

##### (5.1) Complement the missing Rdata files faster
to speed the program up by using parallel computation
we can run the codes in `complement_data_dopar.R`. For example, to 2010

	# initialize
  	year<-2010
  	st_day<-1
  	ed_day<-365
  	folder<-"c:/data/2010/"
  	...

#### (6) Compute frost point
After getting data files containing `Tt`,`q`,`p`,and `dew`, finally, we can compute the frost points from `Tt` and `dew`.
The Get_frost function opens Rdata files with `Tt` and `dew` in one folder, calculates frost points and save results in Rdata files of another folder. `frost_point.R` is needed.
For example, we have 2920 Rdata files for 2010 in the folder `c:/data/2010/` and an empty folder `c:/data/2010FP/` for Rdata files of frost points (output).

	Get_frost("c:/data/2010/","c:/data/2010FP/")

When the program ends, we have 2920 Rdata files with frost points in folder `2010FP`.

##### (6.1) Compute frost point faster
Similarly, we can speed the program up by using parallel computation.
we can run the codes in `Get_frost_dopar.R`. For example, to 2010

	# initialize
	folder_in<-"c:/data/2010/"
	folder_out<-"c:/data/2010FP/"
	...

### More details please see comments in each code file. Thank you. ▋
