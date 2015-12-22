CREATE TABLE redvial (
    ID 		integer,
    NAME 	text,
    TIPO 	integer,
    geom 	geometry(LineString,4326),
    idzona 	integer null
); --FALTA QUE ESTE EN PUBLIC.REDVIAL


ALTER TABLE arista ADD COLUMN iddistrito integer; 	--FALTA EN ARISTA
ALTER TABLE arista ADD COLUMN redvial integer;		--FALTA EN ARISTA
ALTER TABLE nodo ADD COLUMN grafo integer;

CREATE TABLE zonacensal (
    id 		integer,
    dpto	integer,
    prov	integer,
    dist 	integer,
    nombre	text,
    length	float,
    area	float,
    geom 	geometry(Geometry,4326)
);

CREATE TABLE censalxtransito (
	idzoncensal		integer,
	idzonatransito 	integer
);

--PARA LAS LOS SHPS QUE QUERIA BRENDA
CREATE TABLE censalxtransitoxgeom (
	id 		serial primary key,
	idzonacensal		integer,
	idzonatransito 	integer,
	geom 	geometry(Geometry,4326)
);

CREATE TABLE GRAFOXDISTRITO (
	iddistrito	integer,
	idgrafo 	integer
);

CREATE TABLE GRAFOXDISTRITO (
	iddistrito	integer,
	idgrafo 	integer
);
