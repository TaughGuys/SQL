# SQL
SQL SCRIPTS FUNCTIONS AND PROCEDURES
This is my algoritm which writes numbers up to 999,999,999,999 with armenian words 
It is writen with Transact-SQL 
The main function is dbo.num_to_words();
function dbo.mianish()  returns the name of single number 0-9;
function dbo.tasnavor() returns names 10,20,30..90
Function dbo.eranish() returns names 1-999 using functions mianush() and tasnavor()
and finaly dbo.num_to_words() uses dbo.eranish to return final result.
