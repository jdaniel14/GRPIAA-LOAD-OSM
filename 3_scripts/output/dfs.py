import csv

f_nodo		= open("o3_nodo.csv", "r")
f_arista	= open("o4_arista.csv", "r")

f_out		= open("in.txt", "wb")

f_out.write("95255\n");
with f_nodo as f:
	rows	= csv.reader(f, delimiter="|")

	flag	= True
	for r in rows:
		if flag :
			flag	= False
			continue
		f_out.write(r[0]+"\n")

f_out.write("144233\n");
with f_arista as f:
	rows	= csv.reader(f, delimiter="|")

	flag	= True
	for r in rows:
		if flag :
			flag	= False
			continue
		f_out.write(r[0] + " " + r[1]+" " + r[2] + "\n")

