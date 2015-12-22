COPY (SELECT COUNT(*) FROM nodo) TO '/tmp/cont_nodo.csv';
COPY (SELECT idnodo FROM nodo) TO '/tmp/nodo.csv';
COPY (SELECT COUNT(*) FROM arista) TO '/tmp/cont_arista.csv';
COPY (SELECT idarista, idnodoorigen, idnododestino FROM arista) TO '/tmp/arista.csv';

