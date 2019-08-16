//Stata in Impact Evaluation
clear all
use "/Users/linnansol/Downloads/hh_91_practice.dta"
describe
summarize
sum exptot, detail
tabulate sexhead
bysort sexhead: sum exptot

//graph: distribution of exptot 
kdensity exptot, title(1. distribution of household expenditure)

twoway (kdensity exptot if sexhead ==0)  			///
		(kdensity exptot if sexhead ==1),			///
		title("2. distribution of household expenditure" ///
		"by gender of the household")				///
		legend (label (1"female") (2"male"))
		
//graph: distribution of a new variable ln(exptot) 		
generate lnexptot = ln(exptot)
kdensity lnexptot, title(distribution of lnexptot)

twoway (kdensity lnexptot if sexhead ==0)  			///
		(kdensity lnexptot if sexhead ==1),			///
		title("2. distribution of ln household expenditure" ///
		"by gender of the household")				///
		legend (label (1"female") (2"male"))

//Random draws 300
set seed 20080808
generate random = runiform()
sort random
generate experiment = (_n<=300)
tabulate experiment

generate random_t = runiform()
generate treatment = (random_t<0.5) if experiment ==1
tabulate treatment, missing

//Seperate treatment and experiment by sexhead
sort sexhead random_t
bysort sexhead: generate random_t_sex = runiform()
bysort sexhead: generate treatment_sex = (random_t_sex<0.5) if experiment ==1
tabulate treatment_sex, missing

//higher level of randomization: village
sort vill random_t
bysort vill: egen random_vill = mean (random)
generate t_vill = (random_vill <0.5)
tabulate t_vill

egen tag = tag (vill)
tabulate t_vill if tag == 1

ttest sexhead, by(treatment)
reg treatment sexhead educhead famsize hhland hhasset, cluster(vill)



