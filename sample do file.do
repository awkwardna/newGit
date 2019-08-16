use "/Users/linnansol/Downloads/Data-Finished-本科计量/grilic.dta
rename s sch
describe
list sch lnw in 1/10
twoway scatter lnw sch || lfit lnw sch 
reg lnw sch 
reg lnw sch expr tenure smsa mrt 
reg lnw sch expr tenure smsa if rns //subsample regression
reg lnw sch expr tenure smsa if sch>=12 & rns //high school graduates and from south
quietly reg lnw sch expr tenure smsa mrt //return back to the original sample
predict lnw1
predict e, residual
//hypothesis test
test sch=0.1 
test expr = tenure 


