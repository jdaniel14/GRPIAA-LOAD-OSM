from sets import Set

f_in	= open('o8_matrizdemanda.csv', 'r')
f_out	= open('grafo.net', 'wb')

lines	= []
with f_in as f:
	lines	= f.readlines()

set_puntos	= Set()

f_out.write('*Vertices %d\n' % 427)
for punto in range(1, 428):
	f_out.write('%d \"Zona_%d\"\n' % (punto, punto) )

f_out.write('*Edges\n')
for line in lines[1:]:
	line	= line.strip()
	lista	= line.split('|')

	orig	= int(lista[0])
	dest	= int(lista[1])
	peso	= float(lista[2])
	
	if lista[2] != '0':
		continue

	f_out.write('%d %d\n' % (orig, dest))

