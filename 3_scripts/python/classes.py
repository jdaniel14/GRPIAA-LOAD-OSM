class Shapefile :
	wkt		= ""
	refname = ""
	id		= ""
	area	= ""
	id_orig = ""
	area_1_ = ""
	zoneseg	= ""
	trafficzon  = ""
	landuse		= ""
	distrito	= ""
	zconbine15	= ""
	zconbine14	= ""
	region		= ""
	zona553		= ""
	zona553com 	= ""
	zona638emu	= ""
	dist		= ""
	centroide	= ""
	destautohp	= ""
	destpubhpm	= ""

	def __init__(self, row) :
		self.wkt		= row[0]
		self.refname 	= row[1]
		self.id			= row[2]
		self.area		= row[3]
		self.id_orig 	= row[4]
		self.area_1_ 	= row[5]
		self.zoneseg	= row[6]
		self.trafficzon = row[7]
		self.landuse	= row[8]
		self.distrito	= row[9]
		self.zconbine15	= row[10]
		self.zconbine14	= row[11]
		self.region		= row[12]
		self.zona553	= row[13]
		self.zona553com = row[14]
		self.zona638emu	= row[15]
		self.dist		= row[16]
		self.centroide	= row[17]
		self.destautohp	= row[18]
		self.destpubhpm	= row[19]

class Nodo :
	idnodo	 	= ""
	latitud		= ""
	longitud	= ""
	
	def __init__(self, row = None) :
		if row is not None :
			self.idnodo 	= str(row[0])
			self.longitud 	= str(row[1])
			self.latitud 	= str(row[2])

	def guardar(self, file) :
		cad     = "%s|%s|%s\n"%(self.idnodo, self.longitud, self.latitud)
		file.write(cad)

class Tipo_Via :
	idtipovia 	= ""
	nombretipo	= ""
	rutasmax	= ""

	def __init__(self, row) :
		self.idtipovia 	= str(row[0])
		self.nombretipo = str(row[1])
		self.rutasmax 	= str(row[2])

	def guardar(self, file) :
		cad	= "%s|%s|%s\n"%(self.idtipovia, self.nombretipo, self.rutasmax)
		file.write(cad)

class Via :
	idvia			= ""
	nombre			= ""
	velocidadprom	= ""
	accesible		= ""
	idtipovia		= ""

	def __init__(self, row) :
		self.idvia 			= str(row[0])
		self.nombre 		= str(row[1]).strip()
		self.velocidadprom 	= str(row[2])
		self.accesible 		= str(row[3])
		self.idtipovia		= str(row[4])

	def guardar(self, file) :
		cad = "%s|%s|%s|%s|%s\n"%(self.idvia, self.nombre, self.velocidadprom, self.accesible, self.idtipovia)
		file.write(cad)

class Arista :
	idarista		= ""
	idnodoorigen	= ""
	idnododestino	= ""
	idvia			= ""
	distancia		= ""
	numcarriles		= ""
	accesible		= ""
	direccion		= ""
	geom			= ""

	def __init__(self, row = None) :
		if row is not None :
			self.idarista 		= str(row[0])
			self.idnodoorigen 	= str(row[1])
			self.idnododestino 	= str(row[2])
			self.idvia	 		= str(row[3])
			self.distancia 		= str(row[4])
			self.numcarriles 	= str(row[5])
			self.accesible 		= str(row[6])
			self.direccion 		= str(row[7])
			self.geom 			= str(row[8])

	def guardar(self, file) :
		cad = "%s|%s|%s|%s|%s|%s|%s|%s|%s\n"%(self.idarista, self.idnodoorigen, self.idnododestino, self.idvia, self.distancia, self.numcarriles, self.accesible, self.direccion, self.geom)
		file.write(cad)

class Minizona :
	codigo			= ""
	area			= ""
	idzonatransito	= ""
	iddistrito		= ""
	geom			= ""

	def __init__(self, row) :
		self.codigo 		= str(row[0])
		self.area 			= str(row[1])
		self.idzonatransito = str(row[2])
		self.iddistrito 	= str(row[3])
		self.geom 			= str(row[4])


class ZonaTransito :
	idzonatransito	= ""
	area			= ""
	codigo			= ""
	geom			= ""

	def __init__(self, row) :
		self.idzonatransito = str(row[0])
		self.area 			= str(row[1])
		self.codigo 		= str(row[2])
		self.geom 			= str(row[3])

class RedVial :
	WKT			= ""
	ID			= ""
	LENGTH		= ""
	DIR			= ""
	LONGITUD	= ""
	TIPO		= ""
	MODE		= ""
	NAME		= ""
	AB_CARRIL	= ""
	BA_CARRIL	= ""
	AB_CAP		= ""
	BA_CAP		= ""
	AB_VEL		= ""
	BA_VEL		= ""
	AB_ALPHA	= ""
	BA_ALPHA	= ""
	AB_BETA		= ""
	BA_BETA		= ""
	AB_CAPAC	= ""
	BA_CAPAC	= ""
	AB_PRELOAD	= ""
	BA_PRELOAD	= ""
	AB_PRELOA1	= ""
	BA_PRELOA1	= ""
	AB_PRELOA2	= ""
	BA_PRELOA2	= ""
	AB_TMPPRV_	= ""
	BA_TMPPRV_	= ""
	AB_TMPPRVA	= ""
	BA_TMPPRVA	= ""
	AB_VELPRVA	= ""
	BA_VELPRVA	= ""
	AB_TMPPEAT	= ""
	BA_TMPPEAT	= ""
	AB_TMMETRO	= ""
	BA_TMMETRO	= ""
	AB_TMTREN	= ""
	BA_TMTREN	= ""
	AB_TMBUS	= ""
	BA_TMBUS	= ""
	MAXBUSSP	= ""
	Y12			= ""
	Y20			= ""
	Y30			= ""
	
	def __init__(self, row = None) :
		if row is not None :
			self.WKT		= str(row[0])
			self.ID			= str(row[1])
			self.LENGTH		= str(row[2])
			self.DIR		= str(row[3])
			self.LONGITUD	= str(row[4])
			self.TIPO		= str(row[5])
			self.MODE		= str(row[6])
			self.NAME		= str(row[7])
			self.AB_CARRIL	= str(row[8])
			self.BA_CARRIL	= str(row[9])
			self.AB_CAP		= str(row[10])
			self.BA_CAP		= str(row[11])
			self.AB_VEL		= str(row[12])
			self.BA_VEL		= str(row[13])
			self.AB_ALPHA	= str(row[14])
			self.BA_ALPHA	= str(row[15])
			self.AB_BETA	= str(row[16])
			self.BA_BETA	= str(row[17])
			self.AB_CAPAC	= str(row[18])
			self.BA_CAPAC	= str(row[19])
			self.AB_PRELOAD	= str(row[20])
			self.BA_PRELOAD	= str(row[21])
			self.AB_PRELOA1	= str(row[22])
			self.BA_PRELOA1	= str(row[23])
			self.AB_PRELOA2	= str(row[24])
			self.BA_PRELOA2	= str(row[25])
			self.AB_TMPPRV_	= str(row[26])
			self.BA_TMPPRV_	= str(row[27])
			self.AB_TMPPRVA	= str(row[28])
			self.BA_TMPPRVA	= str(row[29])
			self.AB_VELPRVA	= str(row[30])
			self.BA_VELPRVA	= str(row[31])
			self.AB_TMPPEAT	= str(row[32])
			self.BA_TMPPEAT	= str(row[33])
			self.AB_TMMETRO	= str(row[34])
			self.BA_TMMETRO	= str(row[35])
			self.AB_TMTREN	= str(row[36])
			self.BA_TMTREN	= str(row[37])
			self.AB_TMBUS	= str(row[38])
			self.BA_TMBUS	= str(row[39])
			self.MAXBUSSP	= str(row[40])
			self.Y12		= str(row[41])
			self.Y20		= str(row[42])
			self.Y30		= str(row[43])

	def guardar(self, file_out) : 
		cad = "%s|%s|%s|SRID=4326;%s|0\n"%(self.ID, self.NAME.encode("utf-8"), self.TIPO, self.WKT)
		file_out.write(cad)


