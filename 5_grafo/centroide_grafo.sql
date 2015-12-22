UPDATE minizona
SET longitud = ST_X(ST_CENTROID(geom)), latitud = ST_Y(ST_CENTROID(geom));

INSERT INTO ARISTA_MINIZONA ( IDMINIZONAORIGEN, IDMINIZONADESTINO, DISTANCIA )
SELECT a.idminizona, b.idminizona , ST_DISTANCE(ST_Transform(ST_CENTROID(a.geom), 26986), ST_Transform(ST_CENTROID(b.geom),26986))/1000.0 
FROM minizona as a JOIN minizona as b ON ST_TOUCHES(a.geom,b.geom);
