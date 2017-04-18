###Makefile - Case Study2
###Lauren Darr, Emmanuel Farrugia, Johnson Ekedum, John Heinen

#Rule to run all necessary steps to produce Markdown file of analysis output
all: report.html

#Cleans project of files produced throughout process of cleaning and analyzing data
clean: 	
	rm -f report.html

#Installs packages needed to complete data cleaning and analyzing of data
load_libraries: Load_Libraries.R
	Rscript $<

#Runs R code to analyze Orange data in Question 2
question_2: Question_2.R
	Rscript $<

#Rule to produce RMarkdown file for reporting	
report.html: CaseStudy2.Rmd
	Rscript -e 'rmarkdown::render("$<")'	