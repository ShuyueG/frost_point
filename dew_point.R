# calculate dew point Td(in deg C)  by 
# surface pressure p(in mb) and specific humidity q(in kg/kg)
dew_point<-function(p,q){ 
  e=(p*q)/(0.622+0.378*q)
  Td = log(e/6.112)*243.5/(17.67-log(e/6.112))
  return(Td)
}
  
