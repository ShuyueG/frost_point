## How it works?

#### (1) Download R files
download all R files and `wgrib.exe` & `cygwin1.dll` in same one folder (e.g. called `data` in `c:/`)

#### (2) Initialize the environment
then open R studio, set working directory in this folder (e.g. `c:/data`) and import the functions

 	setwd("c:/data")
 	source("Extract_GRIB.R")

#### (3) Get one Rdata file for a certain year, day and time
extract temperature, Specific humidity, pressure and compute the dew point at a certain year, day and time from the `GLDAS_NOAH025SUBP_3H` dataset (GRIB) For example, after running

	Extract_GRIB("2010",68,"09","d:/data/2010/")


A file named `GLDAS_NOAH025SUBP_3H_2010_068_09.Rdata` will be created in `d:/data/2010/` if we open this file by R studio, 4 matrices will be loaded in working environment, they are: `Tt`,`q`,`p`,and `dew`, meaning global temperature, Specific humidity, pressure and dew point data at 9:00Z in the 68th day of 2010.

#### (4) Get Rdata files for one year
if we want to extract the data for a whole year, we can run the function `GetYearData`. For example, the 2006

	GetYearData(2006,1, 365,"d:/data/2006/")
 
After the program ending, (8*365=) 2920 Rdata files will be created in `d:/data/2006/`
 
#### (5) Get Rdata files for one year faster
to speed the program up by using parallel computation
we can run the function `GetYearData_dopar`. For example, the 2006

	GetYearData_dopar(2006,1, 365,"d:/data/2006/")
 
After the program ending, 2920 Rdata files will be created in `d:/data/2006/`
its performance is based on the real number of CPU's cores. If the computer has only Mono-core, the performance is same as function `GetYearData`.
However, the stability of parallel computation `GetYearData_dopar` is worse than non-parallel `GetYearData`. Many reasons could cause data missing, such the unforeseen parallel computation problem, web connection problem, disk problem, etc. Therefore, we have a function to complement the missing Rdata files for one year.

#### (6) Complement the missing Rdata files
The function `complement_data` in `complement_data.R` is used to complement the missing Rdata files for one year. 
First, it runs the `Get_missing` function to check data files' completeness and find missing files' name; then it downloads these missing Rdata files by using `Extract_GRIB` function (non-parallel). For example, the 2006

	complement_data("d:/data/2006/", 2006,1, 365)

If there is no missing file for this year, it will return words: 
	"The dataset is already complete."
	
	# To be continued...
