###Makefile - Case Study2
###Lauren Darr, Emmanuel Farrugia, Johnson Ekedum, John Heinen
###Please make sure to change your directory in the shell to point to ~CaseStudy2_Final/paper


#Rule to run all necessary steps to produce Markdown file of analysis output
all: report.html

#Cleans project of files produced throughout process of cleaning and analyzing data
clean: 	
	rm -f Rplots.pdf CaseStudy2.html

#Installs packages needed to complete data cleaning and analyzing of data
load_libraries: Load_Libraries.R
	Rscript $<

#Runs R code to analyze Orange data in Question 2
question_2: Question_2.R load_libraries
	Rscript $<
	
#Runs R code to analyze Country and City data in Question 3
question_3: Question_3.R question_2
	Rscript $<

#Rule to produce RMarkdown file for reporting	
report.html: CaseStudy2.Rmd question_3
	Rscript -e 'rmarkdown::render("$<")'	