
** This is the master script it's purpose is to run the processing, analysis, and data-appendix do files. 
**Before running this script make sure that
*** The working directory is set to Exercise3ZhengOrtiz/ folder, please ensure it is the most recent version from ODF and on your computer.
*** Also verify the Harvard Alcohol data fram named 04291-0001-Data.dta is saved in the InputData/ Folder 



*Clear memory
clear

*Settings
set more off

*cd /Users/arortizrosa/Desktop/Ex3ZhengOrtiz

*Run the processing.do script
do Scripts/ProcessingScripts/processing.do

*Run the data-appendix.do script
do Scripts/DataAppendixScripts/data-appendix.do

*Run the analysis.do script
do Scripts/AnalysisScripts/analysis.do

