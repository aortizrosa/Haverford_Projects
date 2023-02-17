/*
This is the data.appendix do file, it generates the figures and information on the data appendix.

WHEN YOU RUN THIS DO-FILE, MAKE SURE THAT
STATA'S WORKING DIRECTORY IS SET TO THE
Ex3ZhengOrtiz/ FOLDER

Note: As per the instructions, only generates tables/graphs for varibles exculding health. However I generate health as sanity check to compare with the example Data Appendix Addendum 
*/


*Settings
clear
set more off

*use analysis.dta generated from Processing file
use Data/AnalysisData/analysis.dta



//Finds the number of missing observations and the total (missing plus nonmissing) number of observations.
//first count gets missing 
capture log using Output/DataAppendixOutput/MissingObs.log, replace

count if drunk == .
count if hsdrunk == .
count if free == .
count if volfree == .
count if housing == .

	//second count gets total 	
count 

log close


// sanity check count
count if health == .
count if health 

//--The frequency distribution and the percent frequency distribution.

table drunk, statistic(frequency) statistic(percent)
collect export Output/DataAppendixOutput/FrequencyD.docx, replace

table hsdrunk, statistic(frequency) statistic(percent)
collect export Output/DataAppendixOutput/FrequencyHS.docx, replace

table free, statistic(frequency) statistic(percent)
collect export Output/DataAppendixOutput/FrequencyF.docx, replace

table volfree, statistic(frequency) statistic(percent)
collect export Output/DataAppendixOutput/FrequencyV.docx, replace

table housing, statistic(frequency) statistic(percent)
collect export Output/DataAppendixOutput/FrequencyH.docx, replace

//sanity check frequency distribution
table health, statistic(frequency) statistic(percent)



//--A bar graph showing the percent frequency distribution. When each bar graph is created, a copy should be saved (as a Stata .gph graphics file) in the DataAppendixGraphs/ subfolder of the Output/ folder. (In the commands that save these graph files, use relative directory paths to specify the location of the DataAppendixGraphs/ sub-folder.) Save each graph with the name `var'.gph, where `var' is replaced by the name of the variable. 


graph bar (percent), over(drunk) saving(Output/DataAppendixOutput/drunk.gph, replace)
graph bar (percent), over(hsdrunk) saving(Output/DataAppendixOutput/drunk.gph, replace)
graph bar (percent), over(free) saving(Output/DataAppendixOutput/drunk.gph, replace)
graph bar (percent), over(volfree) saving(Output/DataAppendixOutput/drunk.gph, replace)
graph hbar (percent), over(housing) saving(Output/DataAppendixOutput/drunk.gph, replace)

//sanity check frequency distribution
graph bar (percent), over(health)
























