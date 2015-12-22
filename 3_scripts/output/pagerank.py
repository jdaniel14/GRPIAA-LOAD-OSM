import networkx as nx

f_in	= open('o8_matrizdemanda.csv', 'rb')
f_zonas	= open('../input/i8_zonatransito.csv', 'rb')

def sorted_map(map):
    ms  = sorted(map.iteritems(), key = lambda (k, v): (-v, k)) 
    return ms

lines	= []
with f_in as f:
	lines	= f.readlines()

D		= nx.DiGraph()
lista	= []

for line in lines[1:]:
	
	line	= line.strip()
	l		= line.split('|')
	
	#D.add_weighted_edges_from((l[0], l[1], float(l[2])))
	lista.append((l[0], l[1], float(l[2])))
	#print 'aqui'

D.add_weighted_edges_from(lista)

p	= nx.pagerank(D)
ps	= sorted_map(p)

lines	= []
with f_zonas as f:
	lines	= f.readlines()

d_zonas	= {}
for line in lines[1:]:
	line	= line.strip()
	l		= line.split(';')
	#print '%s -> %s' % (l[5], l[15])
	d_zonas[str(l[5])]	= l[15]

for val in ps[:10]:
	print '%s\t(%s)\t\t\t%f' % (val[0], d_zonas[val[0]], val[1])

