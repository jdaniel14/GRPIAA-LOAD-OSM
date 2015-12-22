import csv
import sys
from bs4 import BeautifulSoup
import urllib2
from itertools import izip 

path_file_job1	= "3_scripts/input/i9_zonascensales.csv" 
path_file_out 	= "3_scripts/output/o9_zonascensales.csv" 

file_out 		= open(path_file_out, "wb")
file_out.write("id|dpto|prov|dist|nombre|length|area|geom\n")
with open(path_file_job1, "r") as file1:     
	flag = True
	for row in file1:
		if flag == True :
			flag = False
			continue 

		data_insert	= str(row).strip().split(";")

		cad = data_insert[1] + "|" + data_insert[3] + "|" + data_insert[4] + "|" + data_insert[5] + "|" + data_insert[8] + "|" + data_insert[10] + "|" + data_insert[11] + "|SRID=4326;" + data_insert[0]
		file_out.write(cad+'\n')
file_out.close()
