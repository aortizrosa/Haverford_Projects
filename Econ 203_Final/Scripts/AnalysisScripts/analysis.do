/*
NOTE: This is the analysis.do file, it generates 6 bar graphs that constitute the main analysis. This script uses the analysis.dta file that was generated by the processing.do file. 

ALL FIGURES ARE SAVED TO THE ReportOutput FOLDER

-------------------------
Note: Please make sure the ExcersiseZhengOrtiz Folder is up to date according to the latest OSF version and that the, and ensure that the wd is set to this folder.

*/

*Settings
clear
set more off

*use analysis.dta generated from Processing file
use Data/AnalysisData/analysis.dta

/*
The following command generates Figure1.
*/


//changes: I added the caption and titles from the solution
graph bar drunk, over(free, relabel(  1 "Not in Alcohol-Free Housing" 2 "Lives in Alcohol-Free Housing" )) ///
ytitle("Proportion drunk 3 or more times in past 30 days") ///
blabel(bar) ///
caption("Figure 1: Rates of Heavy Drinking in Alcohol-Free"  ///
"Versus Not Alcohol-Free Housing") ///
saving(Output/ReportOutput/Figure1.gph, replace) 


/*
The following command generates Figure 2.
*/


//changes: I added the caption and titles from the solution
graph bar drunk, ///
	over(volfree, ///
		relabel(  ///
			1 "Not Voluntarily"  ///
			2 "Voluntarily"  ///
		)) ///
	ytitle("Proportion drunk 3 or more times in past 30 days") ///
	caption("Figure 2: Students in Alcohol-Free Housing By Choice versus Assignment") ///
	saving(Output/ReportOutput/Figure2.gph, replace) 
	
*graph bar drunk, over(volfree) blabel(bar)
*saving(Output/ReportOutput/Figure2.gph, replace


/*
The following command will generate Figure3
*/

//changes: I added the caption and titles from the solution

graph bar drunk, ///
	over(housing, ///
		relabel(  ///
			1 `""Not" "Alcohol-Free""'   ///
			2 "Assigned" ///
			3 `""All Housing" "Alcohol-Free""'  ///
			4 "Requested"  ///
		)) ///
	ytitle("Proportion drunk 3 or more times in past 30 days") ///
	caption("Figure 3: Drinking by Students in All Housing Types") ///
	saving(Output/ReportOutput/Figure3.gph, replace) 


/*
This command will generate Figure 4.
*/

//changes: I added the caption and titles from the solution

graph bar drunk, ///
	over(free, ///
		relabel( ///
			1 `""Not in Alcohol-" "Free Housing""' ///
			2 `""    Lives in Alcohol-" "    Free Housing""'  ///
		)) ///
	over(hsdrunk, ///
		relabel( ///
				1 "Low HS Drinking" ///
				2 "High HS Drinking"  ///
			)) ///
	ytitle("Proportion drunk 3 or more times in past 30 days") ///
	caption("Figure 4: Students in Alcohol-Free versus not Alcohol-Free Housing" ///
	"               Controlling for HS Drinking") ///
	saving(Output/ReportOutput/Figure4.gph, replace) 


/*
This command will generate Figure 5.
*/

//changes: I added the caption and titles from the solution

graph bar drunk, ///
	over(volfree, ///
		relabel( ///
			1 "Assigned" ///
			2 "Choice" ///
		)) ///
	over(hsdrunk, ///
		relabel( ///
			1 "Low HS Drinking" ///
			2 "High HS Drinking"  ///
			)) ///
	ytitle("Proportion drunk 3 or more times in past 30 days") ///
	caption("Figure 5: Students in Alcohol-Free Housing By Choice versus Assignment") ///
	saving(Output/ReportOutput/Figure5.gph, replace) 
	

/*
This command will generate Figure 6.
*/


graph bar drunk, ///
	over(housing, ///
		relabel(  ///
			1 `""Not" "Alc.-Free""' ///
			2 "Assigned" ///
			3 `""All" "Alc.-Free""'  ///
			4 "Requested"  ///
		)) ///
	over(hsdrunk, /// 
		relabel(  ///
			1 "Low HS Drinking" ///
			2 "High HS Drinking"  ///
		)) ///
	ytitle("Proportion drunk 3 or more times in past 30 days") ///
	caption("Figure 6: Students in All Housing Types" ///
	"               Controlling for HS Drinking") ///
	saving(Output/ReportOutput/Figure6.gph, replace) 


graph bar drunk, over(housing) by(hsdrunk) ///
saving(Output/ReportOutput/Figure6.gph, replace)


//Make sure to save this script to AnalysisScripts/ 
**





