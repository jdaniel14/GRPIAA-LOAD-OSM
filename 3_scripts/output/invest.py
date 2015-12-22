import powerlaw
import numpy
import numpy as np

#f_in	= open('lima_degree.txt', 'r')
f_in	= open('output.txt', 'r')

data	= []

with f_in as f:
	i	= 1
	for line in f.readlines():
		line	= line.strip()
		#data.append((int(line),i))
		data.append(int(line))
		#data[int(line)]	= i
		i		= i + 1

'''
lista_sort	= sorted(data, key = lambda dato : dato[0])

#for key in lista_sort:
#		print key
print lista_sort

'''
print len(data)

data	= np.array(data)

results = powerlaw.Fit(data)
print '--------------'
print results.power_law.alpha
print results.power_law.xmin

R, p = results.distribution_compare('power_law', 'lognormal') #http://pythonhosted.org/powerlaw/
print '-------------'
print R
print p
