import csv
import sys
from bs4 import BeautifulSoup
import urllib2
from itertools import izip 

path_file_job1	= "3_scripts/input/i4_distritos.txt" #Archivo Walter
path_file_job2	= "3_scripts/input/i5_distritos.csv" #Archivo Jose

path_file_out 	= "3_scripts/output/o4_distritos.csv" 

file_out 		= open(path_file_out, "wb")
file_out.write("iddistrito|nombre|ubigeo|zona_integrada|area_polo|geom\n")

with open(path_file_job1, "r") as file1, open(path_file_job2, "r") as file2:     
	flag = True
	for x, y in izip(file1, file2):
		if flag == True :
			flag = False
			continue 

		data_dist	= x.split(";")
		data_geom	= y.split("|")

		path_wkt 	= data_geom[2]
		contenido 	= BeautifulSoup(urllib2.urlopen(path_wkt).read())
		wkt = str(contenido.find_all("p")[0])
		ind1 = wkt.find(">") 
		ind2 = wkt.find("<", ind1+1)

		cad = data_dist[0] + "|" + data_dist[1] + "|" + data_dist[2] + "|" + data_dist[3] + "|" + data_dist[4].strip() + "|SRID=4326;" + wkt[ind1+1 : ind2]
		file_out.write(cad+'\n')
file_out.close()
