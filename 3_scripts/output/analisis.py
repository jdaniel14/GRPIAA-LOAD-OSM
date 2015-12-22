import networkx as nx
import matplotlib.pyplot as plt

f_out	= open('degree_results.csv', 'wb')
f_out.write('zona|degree|closeness|betweenness\n')

def sorted_map(map):
	ms	= sorted(map.iteritems(), key = lambda (k, v): (-v, k))
	return ms

G	= nx.read_pajek('pr.net')

'''
positions = nx.spring_layout( G )
nx.draw( G, positions )

xlim = plt.gca().get_xlim()
ylim = plt.gca().get_ylim()

plt.savefig( "g.png" )
plt.clf()
'''

#print G['Zona_2'] #['Zona_2']

p	= nx.pagerank(G)
ps	= sorted_map(p)

print ps[:]

'''
d	= nx.degree(G)
ds	= sorted_map(d)

#h	= plt.hist(deg.values(), 100)
#plt.loglog(h[1][1:], h[0])
#plt.savefig("degree.png")
#print ds[0:9]
c	= nx.closeness_centrality(G)
cs	= sorted_map(c)

b	= nx.betweenness_centrality(G)
bs	= sorted_map(b)

names1	= [x[0] for x in ds[:]]
names2	= [x[0] for x in cs[:]]
names3	= [x[0] for x in bs[:]]

names	= list(set(names1) | set(names2) | set(names3))

table	= [[name, d[name], c[name], b[name]] for name in names]

for row in table:
	f_out.write("%s|%s|%s|%s\n" % (row[0], row[1], row[2], row[3]))
'''
