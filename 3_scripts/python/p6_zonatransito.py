import csv
import sys
from bs4 import BeautifulSoup
import urllib2
from itertools import izip 

path_file_job1	= "3_scripts/input/i7_zonatransito.csv" #Archivo Walter
path_file_job2	= "3_scripts/input/i8_zonatransito.csv" #Archivo Walter

path_file_out 	= "3_scripts/output/o6_zonatransito.csv" 

file_out 		= open(path_file_out, "wb")
file_out.write("idzonatransito|iddistrito|area|codigo|flgtraspaso|flgperiferico|geom\n")

with open(path_file_job1, "r") as file1, open(path_file_job2, "r") as file2:     
	flag = True
	for x, y in izip(file1, file2):
		if flag == True :
			flag = False
			continue 

		data_insert	= x.split(";")
		data_update	= y.split(";")

		cad = data_insert[2] + "|" + data_insert[9] + "|" + data_insert[3] + "|" + data_insert[6] + "|" + data_update[19] + "|" + data_update[20].strip() + "|SRID=4326;" + data_insert[0]
		file_out.write(cad+'\n')
file_out.close()
