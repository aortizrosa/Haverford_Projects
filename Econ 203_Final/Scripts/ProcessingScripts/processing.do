*Note: This is the processing.do file. It's purpose is to read the data from the Harvard Alcohol Study and extract the variables we are interested in working with. This script will save the processed data in the analysis.dta file. 


*Please ensure that Exercise3ZhengOrtiz/FOLDER the most recent folder version from OSF. Also ensure that 04291-0001-Data.dta is in the InputData folder, the working directory depends on it. 

*Settings
clear
set more off

*We are calling the 04291-0001-Data.dta file which should be stored in the file path shown below.
use Data/InputData/04291-0001-Data.dta



/*First drop all cases for which the student's residence at college is "Off campus house/apt" or "other." Also, drop all cases for which the variable representing the student's residence at college has a missing value.*/

//There is a couple of ways to do this. I choose inlist() since it is similar to other coding langs. //drop if A6==5 | A6==6 | A6==.

drop if inlist(A6,5,6) 




/*
Generate a variable called drunk, which is: equal to 0 if the student drank enough to get drunk fewer than three times in the last thirty days equal to 1 if the student drank enough to get drunk three or more times in the last thirty days equal to missing (".") if the variable indicating how many times the student drank enough to get drunk in the last thirty days is missing*/

generate drunk=0 if C13==1 | C13 == 2
replace drunk= 1 if C13 >=3 & C13<.

//updated the labels to match labels from solutions
*Label the variable "drunk"
label variable drunk "Times drunk past 30 days"
*Label the values of "drunk"
label define drunk_labels 0 "2 or fewer" 1 "3 or more" 
label values drunk drunk_labels


/*-Generate a variable called hsdrunk, which is:
equal to 0 if the student had five or more drinks in a row on two or fewer
occasions during her/his last year of high school

equal to 1 if the student had five or more drinks in a row on three or more
occasions during her/his last year of high school

equal to missing (".") if the variable indicating how many times the student
had five or more drinks in a row during her/his last year of high school is
missing
*/


// I am assumed that the never (1) case falls into first category- While this works and returns the correct variable, it is more straightforward to employ this solution method
//generate hsdrunk = 0 if G11 <= 2 
//replace hsdrunk = 1 if G11 >=3 & G11 <.

gen hsdrunk=1 if G11>=3 & G11<.
replace hsdrunk=0 if G11==1 | G11==2


*labels
label variable hsdrunk "Occassions of 5 or more drinks in a row as a highschool senior"
label define hsdrunk_label 1 "2 or less occassions" 2 "3 or more occassions" 
label values hsdrunk hsdrunk_label



/*
--Generate a variable called free, which is:
equal to 0 if the student does not live in alcohol-free housing
equal to 1 if the student lives in alcohol-free housing
equal to missing (".") if the variable indicating whether or not the student lives
in alcohol-free housing is missing*/

//no changes
generate free = B8

*labels
label variable free "Lives in an alcohol-free housing"

label define free_label 0 "No" 1 "Yes" 
label values free free_label


/*
--Generate a variable called volfree, which is:
equal to 1 if free=1 (the student lives in alcohol-free housing) and the student
requested to live in alcohol-free housing
equal to 0 if free=1 (the student lives in alcohol-free housing) and the student
was assigned to live in alcohol-free housing
equal to missing (".") in all other cases */

//no changes 
generate volfree = 1 if B9 == 1 & free==1
replace volfree = 0 if B9 ==2 & free==1

//changed the labels to sol labels because it was more clear
*Label the variable "volfree"
label variable volfree "Requested alcohol-free housing"
*Label the values of "volfree"
label define volfree_labels 0 "No" 1 "Yes" 
label values volfree volfree_labels

/*Generate a variable called housing, which is:
equal to 1 if free=0 (the student does not live in alcohol-free housing)
equal to 2 if free=1 (the student lives in alcohol-free housing) and the student
was assigned to live in alcohol-free housing
equal to 3 if free=1 (the student lives in alcohol-free housing) and all oncampus housing is alcohol-free
equal to 4 if free=1 (the student lives in alcohol-free housing) and the student
requested to live in alcohol-free housing
equal to missing (".") in all other cases
*/

//no changes
 generate housing = 1 if free == 0 
 replace housing = 2 if free == 1 & B9 == 2
 replace housing = 3 if free == 1 & B9 == 3
 replace housing = 4 if free == 1 & B9 == 1

 
 
 
label variable housing "Student Housing"

// changed labels for clarity 
label variable housing "Housing type"

label define housing_labels 1 "Not alchohol free" 2 "Assigned to alcohol-free housing" 3 "All campus housing alcohol-free" 4 "Requested alcohol-free housing"
label values housing housing_labels


*Generate a new variable that is simply an exact copy of G6, and give it the name health. 

//no changes
generate health = G6

label variable health "Health"

label define health_label 1 "Excellent" 2 "Very Good" 3 "Good" 4 "Fair" 5 "Poor"
label values health health_label


*Drop all variables other than the six that were just created. 
//no changes

keep drunk hsdrunk free volfree housing health

*Assign appropriate labels to each of the six variables. 
*Each label is assigned after each variable is generated


*Drop all cases for which the value of drunk is missing.
drop if drunk == .

*Drop all cases for which the value of hsdrunk is missing.
drop if hsdrunk == .

*Drop all cases for which the value of housing is missing.
drop if housing == .

*Save the new data file you have created. This will be the analysis data file
//fixed the working path

save Data/AnalysisData/analysis.dta, replace	

