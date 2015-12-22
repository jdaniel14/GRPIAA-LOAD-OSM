import csv
import sys
from bs4 import BeautifulSoup
import urllib2
from itertools import izip 

path_file_job1	= "3_scripts/input/i7_zonatransito.csv" 
path_file_out 	= "3_scripts/output/o7_minizona.csv" 

file_out 		= open(path_file_out, "wb")
file_out.write("codigo|area|idzonatransito|iddistrito|geom\n")
with open(path_file_job1, "r") as file1:     
	flag = True
	for row in file1:
		if flag == True :
			flag = False
			continue 

		data_insert	= row.split(";")

		cad = data_insert[6] + "|" + data_insert[3] + "|" + data_insert[2] + "|" + data_insert[9] + "|SRID=4326;" + data_insert[0]
		file_out.write(cad+'\n')
file_out.close()
