import networkx as nx
import random
import ConfigParser

config = "./grafos.cfg"

cfg = ConfigParser.ConfigParser()

try:
    cfg.readfp(file(config))
except Exception, e:
    print "Error leyendo fichero de configuracion ", config
    sys.exit(1)

n		= int(cfg.get("global", "n"))
p		= float(cfg.get("global", "p"))
w_inf	= int(cfg.get("global", "w_inf"))
w_sup	= int(cfg.get("global", "w_sup"))

G			= nx.gnp_random_graph(n, p, directed = True)
erdos_renyi = nx.DiGraph([(u,v,{'weight':random.randint(w_inf, w_sup)}) for (u,v) in G.edges()])

G			= nx.scale_free_graph(n) #Return a scale free directed graph.
scale_free	= nx.DiGraph([(u,v,{'weight':random.randint(w_inf, w_sup)}) for (u,v) in G.edges()])

G			= nx.watts_strogatz_graph(n, n/10, p) #Return a scale free directed graph.
small_world	= nx.DiGraph([(u,v,{'weight':random.randint(w_inf, w_sup)}) for (u,v) in G.edges()])

nx.write_pajek(G			, 'g.net'			)
nx.write_pajek(erdos_renyi	, 'erdos-renyi.net'	)
nx.write_pajek(scale_free	, 'scale_free.net'	)
nx.write_pajek(small_world	, 'small_world.net'	)

