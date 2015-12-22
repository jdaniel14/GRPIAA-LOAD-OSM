--
-- PostgreSQL database dump
--

-- Dumped from database version 9.3.4
-- Dumped by pg_dump version 9.3.4
-- Started on 2014-10-23 17:20:52 PET


DROP DATABASE IF EXISTS rutas;
CREATE DATABASE rutas  ;
\connect rutas



SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 284 (class 3079 OID 11829)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 3593 (class 0 OID 0)
-- Dependencies: 284
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- TOC entry 283 (class 3079 OID 103017)
-- Name: adminpack; Type: EXTENSION; Schema: -; Owner: 
--



--
-- TOC entry 3594 (class 0 OID 0)
-- Dependencies: 283
-- Name: EXTENSION adminpack; Type: COMMENT; Schema: -; Owner: 
--

--COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';


--
-- TOC entry 285 (class 3079 OID 103026)
-- Name: postgis; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;


--
-- TOC entry 3595 (class 0 OID 0)
-- Dependencies: 285
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis IS 'PostGIS geometry, geography, and raster spatial types and functions';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 183 (class 1259 OID 104312)
-- Name: algoritmo; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE algoritmo (
    idalgoritmo integer NOT NULL,
    nombre character varying(45) NOT NULL
);


ALTER TABLE public.algoritmo OWNER TO postgres;

--
-- TOC entry 184 (class 1259 OID 104315)
-- Name: algoritmo_idalgoritmo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE algoritmo_idalgoritmo_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.algoritmo_idalgoritmo_seq OWNER TO postgres;

--
-- TOC entry 185 (class 1259 OID 104317)
-- Name: algoritmo_idalgoritmo_seq1; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE algoritmo_idalgoritmo_seq1
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.algoritmo_idalgoritmo_seq1 OWNER TO postgres;

--
-- TOC entry 3596 (class 0 OID 0)
-- Dependencies: 185
-- Name: algoritmo_idalgoritmo_seq1; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE algoritmo_idalgoritmo_seq1 OWNED BY algoritmo.idalgoritmo;


--
-- TOC entry 186 (class 1259 OID 104319)
-- Name: arista; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE arista (
    idarista bigint NOT NULL,
    idnodoorigen bigint NOT NULL,
    idnododestino bigint NOT NULL,
    iddistrito bigint,
    idvia bigint NOT NULL,
    distancia double precision,
    numcarriles integer,
    accesible boolean NOT NULL,
    direccion integer,
    redvial integer,
    geom geometry(LineString,4326),
    grafo bigint
);


ALTER TABLE public.arista OWNER TO postgres;

--
-- TOC entry 3597 (class 0 OID 0)
-- Dependencies: 186
-- Name: TABLE arista; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE arista IS 'Almacena las aristas (calles) que conforman la red vial';


--
-- TOC entry 3598 (class 0 OID 0)
-- Dependencies: 186
-- Name: COLUMN arista.idarista; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN arista.idarista IS 'identificador del registro';


--
-- TOC entry 3599 (class 0 OID 0)
-- Dependencies: 186
-- Name: COLUMN arista.idnodoorigen; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN arista.idnodoorigen IS 'nodo(esquina) origen';


--
-- TOC entry 3600 (class 0 OID 0)
-- Dependencies: 186
-- Name: COLUMN arista.idnododestino; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN arista.idnododestino IS 'nodo(esquina) destino';


--
-- TOC entry 3601 (class 0 OID 0)
-- Dependencies: 186
-- Name: COLUMN arista.idvia; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN arista.idvia IS 'via a la cual pertenece la arista';


--
-- TOC entry 3602 (class 0 OID 0)
-- Dependencies: 186
-- Name: COLUMN arista.distancia; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN arista.distancia IS 'Distancia o longitd de la arista en kilometros';


--
-- TOC entry 3603 (class 0 OID 0)
-- Dependencies: 186
-- Name: COLUMN arista.numcarriles; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN arista.numcarriles IS 'numero de carriles de la arista';


--
-- TOC entry 3604 (class 0 OID 0)
-- Dependencies: 186
-- Name: COLUMN arista.accesible; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN arista.accesible IS 'indica si la arista se encuentra accesible (1) o no(0)';


--
-- TOC entry 3605 (class 0 OID 0)
-- Dependencies: 186
-- Name: COLUMN arista.direccion; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN arista.direccion IS 'direccion(sentido) de la arista';


--
-- TOC entry 3606 (class 0 OID 0)
-- Dependencies: 186
-- Name: COLUMN arista.redvial; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN arista.redvial IS 'Indica si la arista es parte de la red vial';


--
-- TOC entry 3607 (class 0 OID 0)
-- Dependencies: 186
-- Name: COLUMN arista.geom; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN arista.geom IS 'lineString de la arista';


--
-- TOC entry 187 (class 1259 OID 104325)
-- Name: arista_idarista_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE arista_idarista_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.arista_idarista_seq OWNER TO postgres;

--
-- TOC entry 188 (class 1259 OID 104327)
-- Name: arista_minizona; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE arista_minizona (
    idaristaminizona bigint NOT NULL,
    distancia double precision NOT NULL,
    idminizonaorigen bigint NOT NULL,
    idminizonadestino bigint NOT NULL
);


ALTER TABLE public.arista_minizona OWNER TO postgres;

--
-- TOC entry 3608 (class 0 OID 0)
-- Dependencies: 188
-- Name: TABLE arista_minizona; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE arista_minizona IS 'Almacena las arista_zonas que componen el grafo de la red de zonas';


--
-- TOC entry 3609 (class 0 OID 0)
-- Dependencies: 188
-- Name: COLUMN arista_minizona.idaristaminizona; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN arista_minizona.idaristaminizona IS 'identificador del registro';


--
-- TOC entry 3610 (class 0 OID 0)
-- Dependencies: 188
-- Name: COLUMN arista_minizona.distancia; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN arista_minizona.distancia IS 'distancia o longitud de la arista_minizona en kilometros';


--
-- TOC entry 3611 (class 0 OID 0)
-- Dependencies: 188
-- Name: COLUMN arista_minizona.idminizonaorigen; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN arista_minizona.idminizonaorigen IS 'minizona origen';


--
-- TOC entry 3612 (class 0 OID 0)
-- Dependencies: 188
-- Name: COLUMN arista_minizona.idminizonadestino; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN arista_minizona.idminizonadestino IS 'minizona destino';


--
-- TOC entry 189 (class 1259 OID 104330)
-- Name: arista_minizona_idaristaminizona_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE arista_minizona_idaristaminizona_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.arista_minizona_idaristaminizona_seq OWNER TO postgres;

--
-- TOC entry 190 (class 1259 OID 104332)
-- Name: arista_minizona_idaristaminizona_seq1; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE arista_minizona_idaristaminizona_seq1
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.arista_minizona_idaristaminizona_seq1 OWNER TO postgres;

--
-- TOC entry 191 (class 1259 OID 104334)
-- Name: arista_minizona_idaristaminizona_seq2; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE arista_minizona_idaristaminizona_seq2
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.arista_minizona_idaristaminizona_seq2 OWNER TO postgres;

--
-- TOC entry 192 (class 1259 OID 104336)
-- Name: arista_minizona_idaristaminizona_seq3; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE arista_minizona_idaristaminizona_seq3
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.arista_minizona_idaristaminizona_seq3 OWNER TO postgres;

--
-- TOC entry 193 (class 1259 OID 104338)
-- Name: arista_minizona_idaristaminizona_seq4; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE arista_minizona_idaristaminizona_seq4
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.arista_minizona_idaristaminizona_seq4 OWNER TO postgres;

--
-- TOC entry 3613 (class 0 OID 0)
-- Dependencies: 193
-- Name: arista_minizona_idaristaminizona_seq4; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE arista_minizona_idaristaminizona_seq4 OWNED BY arista_minizona.idaristaminizona;


--
-- TOC entry 194 (class 1259 OID 104340)
-- Name: arista_zona_idminizonaFinal_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "arista_zona_idminizonaFinal_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."arista_zona_idminizonaFinal_seq" OWNER TO postgres;

--
-- TOC entry 195 (class 1259 OID 104342)
-- Name: arista_zona_idminizonaFinal_seq1; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "arista_zona_idminizonaFinal_seq1"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."arista_zona_idminizonaFinal_seq1" OWNER TO postgres;

--
-- TOC entry 196 (class 1259 OID 104344)
-- Name: arista_zona_idminizonaInicial_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "arista_zona_idminizonaInicial_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."arista_zona_idminizonaInicial_seq" OWNER TO postgres;

--
-- TOC entry 197 (class 1259 OID 104346)
-- Name: arista_zona_idminizonaInicial_seq1; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "arista_zona_idminizonaInicial_seq1"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."arista_zona_idminizonaInicial_seq1" OWNER TO postgres;

--
-- TOC entry 198 (class 1259 OID 104348)
-- Name: censalxtransito; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE censalxtransito (
    idzoncensal integer,
    idzonatransito integer
);


ALTER TABLE public.censalxtransito OWNER TO postgres;

--
-- TOC entry 3614 (class 0 OID 0)
-- Dependencies: 198
-- Name: TABLE censalxtransito; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE censalxtransito IS 'Almacena la relacion entre zona censal y  zonas de transito';


--
-- TOC entry 3615 (class 0 OID 0)
-- Dependencies: 198
-- Name: COLUMN censalxtransito.idzoncensal; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN censalxtransito.idzoncensal IS 'identificador zona censal';


--
-- TOC entry 3616 (class 0 OID 0)
-- Dependencies: 198
-- Name: COLUMN censalxtransito.idzonatransito; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN censalxtransito.idzonatransito IS 'identificador zona de transito';


--
-- TOC entry 199 (class 1259 OID 104351)
-- Name: datos; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE datos (
    iddatos integer NOT NULL,
    lmin real,
    lmax real,
    p real,
    c2 real,
    c3 real,
    rmax integer,
    w1 real ,
    w2 real  ,
    w3 real  ,
    vprom real  ,
    vprompr real,
    capruta integer,
    bcap integer  ,
    cpasaje real,
    cpasahepr real,
    chh  real,
    chhpr real,
    fl integer,
    cap real  
);


ALTER TABLE public.datos OWNER TO postgres;

--
-- TOC entry 200 (class 1259 OID 104354)
-- Name: datos_iddatos_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE datos_iddatos_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.datos_iddatos_seq OWNER TO postgres;

--
-- TOC entry 201 (class 1259 OID 104356)
-- Name: datos_iddatos_seq1; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE datos_iddatos_seq1
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.datos_iddatos_seq1 OWNER TO postgres;

--
-- TOC entry 202 (class 1259 OID 104358)
-- Name: datos_iddatos_seq2; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE datos_iddatos_seq2
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.datos_iddatos_seq2 OWNER TO postgres;

--
-- TOC entry 203 (class 1259 OID 104360)
-- Name: datos_iddatos_seq3; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE datos_iddatos_seq3
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.datos_iddatos_seq3 OWNER TO postgres;

--
-- TOC entry 204 (class 1259 OID 104362)
-- Name: datos_iddatos_seq4; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE datos_iddatos_seq4
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.datos_iddatos_seq4 OWNER TO postgres;

--
-- TOC entry 3617 (class 0 OID 0)
-- Dependencies: 204
-- Name: datos_iddatos_seq4; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE datos_iddatos_seq4 OWNED BY datos.iddatos;


--
-- TOC entry 205 (class 1259 OID 104364)
-- Name: demanda; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE demanda (
    iddemanda bigint NOT NULL,
    idminizonaorigen bigint NOT NULL,
    idminizonadestino bigint NOT NULL,
    demanda real DEFAULT 0 NOT NULL
);


ALTER TABLE public.demanda OWNER TO postgres;

--
-- TOC entry 3618 (class 0 OID 0)
-- Dependencies: 205
-- Name: TABLE demanda; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE demanda IS 'Almacena la demanda de transporte de una minizona origen a una destino';


--
-- TOC entry 3619 (class 0 OID 0)
-- Dependencies: 205
-- Name: COLUMN demanda.iddemanda; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN demanda.iddemanda IS 'identificador del registro';


--
-- TOC entry 3620 (class 0 OID 0)
-- Dependencies: 205
-- Name: COLUMN demanda.idminizonaorigen; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN demanda.idminizonaorigen IS 'minizona origen';


--
-- TOC entry 3621 (class 0 OID 0)
-- Dependencies: 205
-- Name: COLUMN demanda.idminizonadestino; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN demanda.idminizonadestino IS 'minizona destino';


--
-- TOC entry 3622 (class 0 OID 0)
-- Dependencies: 205
-- Name: COLUMN demanda.demanda; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN demanda.demanda IS 'demanda de transporte de minizona origen a minizona destino';


--
-- TOC entry 206 (class 1259 OID 104368)
-- Name: demanda_iddemanda_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE demanda_iddemanda_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.demanda_iddemanda_seq OWNER TO postgres;

--
-- TOC entry 207 (class 1259 OID 104370)
-- Name: demanda_iddemanda_seq1; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE demanda_iddemanda_seq1
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.demanda_iddemanda_seq1 OWNER TO postgres;

--
-- TOC entry 208 (class 1259 OID 104372)
-- Name: demanda_iddemanda_seq2; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE demanda_iddemanda_seq2
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.demanda_iddemanda_seq2 OWNER TO postgres;

--
-- TOC entry 209 (class 1259 OID 104374)
-- Name: demanda_iddemanda_seq3; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE demanda_iddemanda_seq3
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.demanda_iddemanda_seq3 OWNER TO postgres;

--
-- TOC entry 210 (class 1259 OID 104376)
-- Name: demanda_iddemanda_seq4; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE demanda_iddemanda_seq4
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.demanda_iddemanda_seq4 OWNER TO postgres;

--
-- TOC entry 3623 (class 0 OID 0)
-- Dependencies: 210
-- Name: demanda_iddemanda_seq4; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE demanda_iddemanda_seq4 OWNED BY demanda.iddemanda;


--
-- TOC entry 211 (class 1259 OID 104378)
-- Name: demanda_idminizonaxminizona_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE demanda_idminizonaxminizona_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.demanda_idminizonaxminizona_seq OWNER TO postgres;

--
-- TOC entry 212 (class 1259 OID 104380)
-- Name: distrito; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE distrito (
    iddistrito bigint NOT NULL,
    nombre character varying(45) NOT NULL,
    zona_integrada integer,
    area_polo character varying(25),
    ubigeo character varying(45),
    geom geometry(Geometry,4326)
);


ALTER TABLE public.distrito OWNER TO postgres;

--
-- TOC entry 3624 (class 0 OID 0)
-- Dependencies: 212
-- Name: TABLE distrito; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE distrito IS 'tabla que almacena los distritos';


--
-- TOC entry 3625 (class 0 OID 0)
-- Dependencies: 212
-- Name: COLUMN distrito.iddistrito; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN distrito.iddistrito IS 'identificador del registro';


--
-- TOC entry 3626 (class 0 OID 0)
-- Dependencies: 212
-- Name: COLUMN distrito.nombre; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN distrito.nombre IS 'nombre del Distrito';


--
-- TOC entry 3627 (class 0 OID 0)
-- Dependencies: 212
-- Name: COLUMN distrito.ubigeo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN distrito.ubigeo IS 'codigo Ubigeo';


--
-- TOC entry 282 (class 1259 OID 104728)
-- Name: grafoxdistrito; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE grafoxdistrito (
    iddistrito integer,
    idgrafo integer
);


ALTER TABLE public.grafoxdistrito OWNER TO postgres;

--
-- TOC entry 213 (class 1259 OID 104386)
-- Name: minizona; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE minizona (
    idminizona bigint NOT NULL,
    codigo character varying(45) NOT NULL,
    area real,
    longitud double precision,
    latitud double precision,
    idzonatransito bigint,
    iddistrito bigint,
    geom geometry(Polygon,4326)
);


ALTER TABLE public.minizona OWNER TO postgres;

--
-- TOC entry 3628 (class 0 OID 0)
-- Dependencies: 213
-- Name: TABLE minizona; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE minizona IS 'Almacena las zonas del area de estudio';


--
-- TOC entry 3629 (class 0 OID 0)
-- Dependencies: 213
-- Name: COLUMN minizona.idminizona; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN minizona.idminizona IS 'identificador del registro';


--
-- TOC entry 3630 (class 0 OID 0)
-- Dependencies: 213
-- Name: COLUMN minizona.codigo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN minizona.codigo IS 'codigo de la zona';


--
-- TOC entry 3631 (class 0 OID 0)
-- Dependencies: 213
-- Name: COLUMN minizona.area; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN minizona.area IS 'area total de la zona en kilometros ';


--
-- TOC entry 3632 (class 0 OID 0)
-- Dependencies: 213
-- Name: COLUMN minizona.longitud; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN minizona.longitud IS 'coordenada longitud de centroide de la zona';


--
-- TOC entry 3633 (class 0 OID 0)
-- Dependencies: 213
-- Name: COLUMN minizona.latitud; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN minizona.latitud IS 'coordenada latitud de centroide de la zona';


--
-- TOC entry 3634 (class 0 OID 0)
-- Dependencies: 213
-- Name: COLUMN minizona.idzonatransito; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN minizona.idzonatransito IS 'Identificador del registro';


--
-- TOC entry 3635 (class 0 OID 0)
-- Dependencies: 213
-- Name: COLUMN minizona.iddistrito; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN minizona.iddistrito IS 'identificador del registro';


--
-- TOC entry 3636 (class 0 OID 0)
-- Dependencies: 213
-- Name: COLUMN minizona.geom; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN minizona.geom IS 'Poligono de la zona';


--
-- TOC entry 214 (class 1259 OID 104392)
-- Name: minizona_idminizona_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE minizona_idminizona_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.minizona_idminizona_seq OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 104394)
-- Name: minizona_idminizona_seq1; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE minizona_idminizona_seq1
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.minizona_idminizona_seq1 OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 104396)
-- Name: minizona_idminizona_seq2; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE minizona_idminizona_seq2
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.minizona_idminizona_seq2 OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 104398)
-- Name: minizona_idminizona_seq3; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE minizona_idminizona_seq3
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.minizona_idminizona_seq3 OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 104400)
-- Name: minizona_idminizona_seq4; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE minizona_idminizona_seq4
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.minizona_idminizona_seq4 OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 104402)
-- Name: minizona_idminizona_seq5; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE minizona_idminizona_seq5
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.minizona_idminizona_seq5 OWNER TO postgres;

--
-- TOC entry 3637 (class 0 OID 0)
-- Dependencies: 219
-- Name: minizona_idminizona_seq5; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE minizona_idminizona_seq5 OWNED BY minizona.idminizona;


--
-- TOC entry 220 (class 1259 OID 104404)
-- Name: minizonaxarista; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE minizonaxarista (
    idminizonaxarista bigint NOT NULL,
    idarista bigint NOT NULL,
    idminizona bigint NOT NULL
);


ALTER TABLE public.minizonaxarista OWNER TO postgres;

--
-- TOC entry 3638 (class 0 OID 0)
-- Dependencies: 220
-- Name: TABLE minizonaxarista; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE minizonaxarista IS 'Almacena las aristas que cubre la minizona';


--
-- TOC entry 3639 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN minizonaxarista.idminizonaxarista; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN minizonaxarista.idminizonaxarista IS 'identificador del registro';


--
-- TOC entry 3640 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN minizonaxarista.idarista; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN minizonaxarista.idarista IS 'arista que esta cubierta por la minizona';


--
-- TOC entry 3641 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN minizonaxarista.idminizona; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN minizonaxarista.idminizona IS 'identificador de la minizona';


--
-- TOC entry 221 (class 1259 OID 104407)
-- Name: minizonaxarista_idminizonaxarista_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE minizonaxarista_idminizonaxarista_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.minizonaxarista_idminizonaxarista_seq OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 104409)
-- Name: minizonaxarista_idminizonaxarista_seq1; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE minizonaxarista_idminizonaxarista_seq1
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.minizonaxarista_idminizonaxarista_seq1 OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 104411)
-- Name: minizonaxarista_idminizonaxarista_seq2; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE minizonaxarista_idminizonaxarista_seq2
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.minizonaxarista_idminizonaxarista_seq2 OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 104413)
-- Name: minizonaxarista_idminizonaxarista_seq3; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE minizonaxarista_idminizonaxarista_seq3
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.minizonaxarista_idminizonaxarista_seq3 OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 104415)
-- Name: minizonaxarista_idminizonaxarista_seq4; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE minizonaxarista_idminizonaxarista_seq4
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.minizonaxarista_idminizonaxarista_seq4 OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 104417)
-- Name: minizonaxarista_idminizonaxarista_seq5; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE minizonaxarista_idminizonaxarista_seq5
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.minizonaxarista_idminizonaxarista_seq5 OWNER TO postgres;

--
-- TOC entry 3642 (class 0 OID 0)
-- Dependencies: 226
-- Name: minizonaxarista_idminizonaxarista_seq5; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE minizonaxarista_idminizonaxarista_seq5 OWNED BY minizonaxarista.idminizonaxarista;


--
-- TOC entry 227 (class 1259 OID 104419)
-- Name: minizonaxnodo; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE minizonaxnodo (
    idminizonaxnodo bigint NOT NULL,
    idnodo bigint NOT NULL,
    idminizona bigint NOT NULL
);


ALTER TABLE public.minizonaxnodo OWNER TO postgres;

--
-- TOC entry 3643 (class 0 OID 0)
-- Dependencies: 227
-- Name: TABLE minizonaxnodo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE minizonaxnodo IS 'Almacena los nodos que estan cubiertos por la minizona';


--
-- TOC entry 3644 (class 0 OID 0)
-- Dependencies: 227
-- Name: COLUMN minizonaxnodo.idminizonaxnodo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN minizonaxnodo.idminizonaxnodo IS 'identificador del registro';


--
-- TOC entry 3645 (class 0 OID 0)
-- Dependencies: 227
-- Name: COLUMN minizonaxnodo.idnodo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN minizonaxnodo.idnodo IS 'nodo que esta cubierto por la minizona';


--
-- TOC entry 3646 (class 0 OID 0)
-- Dependencies: 227
-- Name: COLUMN minizonaxnodo.idminizona; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN minizonaxnodo.idminizona IS 'identificador de la minizona';


--
-- TOC entry 228 (class 1259 OID 104422)
-- Name: minizonaxnodo_idminizonaxnodo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE minizonaxnodo_idminizonaxnodo_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.minizonaxnodo_idminizonaxnodo_seq OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 104424)
-- Name: minizonaxnodo_idminizonaxnodo_seq1; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE minizonaxnodo_idminizonaxnodo_seq1
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.minizonaxnodo_idminizonaxnodo_seq1 OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 104426)
-- Name: minizonaxnodo_idminizonaxnodo_seq2; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE minizonaxnodo_idminizonaxnodo_seq2
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.minizonaxnodo_idminizonaxnodo_seq2 OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 104428)
-- Name: minizonaxnodo_idminizonaxnodo_seq3; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE minizonaxnodo_idminizonaxnodo_seq3
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.minizonaxnodo_idminizonaxnodo_seq3 OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 104430)
-- Name: minizonaxnodo_idminizonaxnodo_seq4; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE minizonaxnodo_idminizonaxnodo_seq4
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.minizonaxnodo_idminizonaxnodo_seq4 OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 104432)
-- Name: minizonaxnodo_idminizonaxnodo_seq5; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE minizonaxnodo_idminizonaxnodo_seq5
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.minizonaxnodo_idminizonaxnodo_seq5 OWNER TO postgres;

--
-- TOC entry 3647 (class 0 OID 0)
-- Dependencies: 233
-- Name: minizonaxnodo_idminizonaxnodo_seq5; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE minizonaxnodo_idminizonaxnodo_seq5 OWNED BY minizonaxnodo.idminizonaxnodo;


--
-- TOC entry 234 (class 1259 OID 104434)
-- Name: nodo; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE nodo (
    idnodo bigint NOT NULL,
    idminizona bigint,
    longitud double precision,
    latitud double precision
);


ALTER TABLE public.nodo OWNER TO postgres;

--
-- TOC entry 3648 (class 0 OID 0)
-- Dependencies: 234
-- Name: TABLE nodo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE nodo IS 'Almacena los nodos(vertices) que conforman la red vial';


--
-- TOC entry 3649 (class 0 OID 0)
-- Dependencies: 234
-- Name: COLUMN nodo.idnodo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN nodo.idnodo IS 'identificador del registro';


--
-- TOC entry 3650 (class 0 OID 0)
-- Dependencies: 234
-- Name: COLUMN nodo.longitud; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN nodo.longitud IS 'coordenada longitud del nodo';


--
-- TOC entry 3651 (class 0 OID 0)
-- Dependencies: 234
-- Name: COLUMN nodo.latitud; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN nodo.latitud IS 'coordenada latitud del nodo';


--
-- TOC entry 235 (class 1259 OID 104437)
-- Name: nodo_idnodo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE nodo_idnodo_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.nodo_idnodo_seq OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 104439)
-- Name: parametros; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE parametros (
    idparametros integer NOT NULL,
    poblacion_genetico integer,
    generacion_genetico integer,
    probabilidadmutacion_genetico real,
    probabilidadcruzamiento_genetico real,
    metodocreacionrutas_genetico integer,
    cantidadmaximarutascreadas_genetico integer,
    formametodomutacion_genetico integer,
    formametodocruzamiento_genetico integer,
    alpha_simulated real,
    beta_simulated real,
    temperatura_simulated bigint,
    generacion_simulated integer,
    maxnocambios_simulated integer,
    numcambios_simulated integer,
    nrutaspia integer,
    plista real,
    nrutassimm integer
);


ALTER TABLE public.parametros OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 104442)
-- Name: parametros_idparametros_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE parametros_idparametros_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.parametros_idparametros_seq OWNER TO postgres;

--
-- TOC entry 3652 (class 0 OID 0)
-- Dependencies: 237
-- Name: parametros_idparametros_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE parametros_idparametros_seq OWNED BY parametros.idparametros;


--
-- TOC entry 238 (class 1259 OID 104444)
-- Name: redvial; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE redvial (
    id integer,
    name text,
    tipo integer,
    idzona integer,
    geom geometry(Geometry,4326)
);


ALTER TABLE public.redvial OWNER TO postgres;

--
-- TOC entry 239 (class 1259 OID 104450)
-- Name: ruta; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE ruta (
    idruta bigint NOT NULL,
    idsolucion bigint NOT NULL,
    tiempo time without time zone,
    actual boolean,
    frecuencia real NOT NULL,
    flota integer NOT NULL,
    longitudvial real,
    longitudzona real,
	osm_id integer,
	osm_nombre text,
    geom_ida geometry(LineString,4326),
    geom_vuelta geometry(LineString,4326)
);


ALTER TABLE public.ruta OWNER TO postgres;

--
-- TOC entry 3653 (class 0 OID 0)
-- Dependencies: 239
-- Name: TABLE ruta; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE ruta IS 'Almacena una ruta de trasnporte.';


--
-- TOC entry 3654 (class 0 OID 0)
-- Dependencies: 239
-- Name: COLUMN ruta.idruta; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN ruta.idruta IS 'identificador del registro';


--
-- TOC entry 3655 (class 0 OID 0)
-- Dependencies: 239
-- Name: COLUMN ruta.idsolucion; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN ruta.idsolucion IS 'solucion a la cual pertenece la ruta';


--
-- TOC entry 3656 (class 0 OID 0)
-- Dependencies: 239
-- Name: COLUMN ruta.tiempo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN ruta.tiempo IS 'tiempo que demora recorrer la ruta de un extremo a otro';


--
-- TOC entry 3657 (class 0 OID 0)
-- Dependencies: 239
-- Name: COLUMN ruta.actual; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN ruta.actual IS 'indica si la ruta es una ruta del acutal sistema de transporte(1) o no (0)';


--
-- TOC entry 3658 (class 0 OID 0)
-- Dependencies: 239
-- Name: COLUMN ruta.frecuencia; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN ruta.frecuencia IS 'frecuencia de salida de los buses en la ruta';


--
-- TOC entry 3659 (class 0 OID 0)
-- Dependencies: 239
-- Name: COLUMN ruta.flota; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN ruta.flota IS 'tamaño de la flota de buses que requiere la ruta';


--
-- TOC entry 3660 (class 0 OID 0)
-- Dependencies: 239
-- Name: COLUMN ruta.geom_ida; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN ruta.geom_ida IS 'LineString de la ruta de vuelta';


--
-- TOC entry 240 (class 1259 OID 104456)
-- Name: ruta_idruta_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE ruta_idruta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ruta_idruta_seq OWNER TO postgres;

--
-- TOC entry 241 (class 1259 OID 104458)
-- Name: ruta_idruta_seq1; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE ruta_idruta_seq1
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ruta_idruta_seq1 OWNER TO postgres;

--
-- TOC entry 242 (class 1259 OID 104460)
-- Name: ruta_idruta_seq2; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE ruta_idruta_seq2
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ruta_idruta_seq2 OWNER TO postgres;

--
-- TOC entry 243 (class 1259 OID 104462)
-- Name: ruta_idruta_seq3; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE ruta_idruta_seq3
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ruta_idruta_seq3 OWNER TO postgres;

--
-- TOC entry 244 (class 1259 OID 104464)
-- Name: ruta_idruta_seq4; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE ruta_idruta_seq4
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ruta_idruta_seq4 OWNER TO postgres;

--
-- TOC entry 245 (class 1259 OID 104466)
-- Name: ruta_idruta_seq5; Type: SEQUENCE; Schema: public; Owner: postgres
--

--CREATE SEQUENCE ruta_idruta_seq5
--    START WITH 1
--    INCREMENT BY 1
--    NO MINVALUE
--    NO MAXVALUE
--    CACHE 1;


--ALTER TABLE public.ruta_idruta_seq5 OWNER TO postgres;

--
-- TOC entry 3661 (class 0 OID 0)
-- Dependencies: 245
-- Name: ruta_idruta_seq5; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

--ALTER SEQUENCE ruta_idruta_seq5 OWNED BY ruta.idruta;


--
-- TOC entry 246 (class 1259 OID 104468)
-- Name: rutaxarista; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE rutaxarista (
    idrutaxarista bigint NOT NULL,
    idruta bigint NOT NULL,
    idarista bigint NOT NULL,
    paradero boolean NOT NULL,
    orden integer
);


ALTER TABLE public.rutaxarista OWNER TO postgres;

--
-- TOC entry 3662 (class 0 OID 0)
-- Dependencies: 246
-- Name: TABLE rutaxarista; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE rutaxarista IS 'Almacena las aristas que componen la ruta';


--
-- TOC entry 3663 (class 0 OID 0)
-- Dependencies: 246
-- Name: COLUMN rutaxarista.idrutaxarista; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN rutaxarista.idrutaxarista IS 'identificador del registro';


--
-- TOC entry 3664 (class 0 OID 0)
-- Dependencies: 246
-- Name: COLUMN rutaxarista.idruta; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN rutaxarista.idruta IS 'identificador de la ruta';


--
-- TOC entry 3665 (class 0 OID 0)
-- Dependencies: 246
-- Name: COLUMN rutaxarista.idarista; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN rutaxarista.idarista IS 'arista que compone parte de la ruta';


--
-- TOC entry 3666 (class 0 OID 0)
-- Dependencies: 246
-- Name: COLUMN rutaxarista.paradero; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN rutaxarista.paradero IS 'indica si en la arista se localiza un paradero';


--
-- TOC entry 247 (class 1259 OID 104471)
-- Name: rutaxarista_idrutaxarista_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE rutaxarista_idrutaxarista_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rutaxarista_idrutaxarista_seq OWNER TO postgres;

--
-- TOC entry 248 (class 1259 OID 104473)
-- Name: rutaxarista_idrutaxarista_seq1; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE rutaxarista_idrutaxarista_seq1
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rutaxarista_idrutaxarista_seq1 OWNER TO postgres;

--
-- TOC entry 249 (class 1259 OID 104475)
-- Name: rutaxarista_idrutaxarista_seq2; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE rutaxarista_idrutaxarista_seq2
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rutaxarista_idrutaxarista_seq2 OWNER TO postgres;

--
-- TOC entry 250 (class 1259 OID 104477)
-- Name: rutaxarista_idrutaxarista_seq3; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE rutaxarista_idrutaxarista_seq3
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rutaxarista_idrutaxarista_seq3 OWNER TO postgres;

--
-- TOC entry 251 (class 1259 OID 104479)
-- Name: rutaxarista_idrutaxarista_seq4; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE rutaxarista_idrutaxarista_seq4
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rutaxarista_idrutaxarista_seq4 OWNER TO postgres;

--
-- TOC entry 252 (class 1259 OID 104481)
-- Name: rutaxarista_idrutaxarista_seq5; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE rutaxarista_idrutaxarista_seq5
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rutaxarista_idrutaxarista_seq5 OWNER TO postgres;

--
-- TOC entry 3667 (class 0 OID 0)
-- Dependencies: 252
-- Name: rutaxarista_idrutaxarista_seq5; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE rutaxarista_idrutaxarista_seq5 OWNED BY rutaxarista.idrutaxarista;


--
-- TOC entry 253 (class 1259 OID 104483)
-- Name: rutaxminizona; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE rutaxminizona (
    idrutaxminizona serial primary key,
    idruta integer,
    idminizona integer,
    orden integer
);


ALTER TABLE public.rutaxminizona OWNER TO postgres;

--
-- TOC entry 254 (class 1259 OID 104486)
-- Name: solucion; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE solucion (
    idsolucion integer NOT NULL,
    idalgoritmo integer NOT NULL,
    iddatos integer NOT NULL,
    idparametros integer NOT NULL,
    fecha date,
    estado integer NOT NULL,
    descripcion character varying(100),
    valor double precision NOT NULL
);


ALTER TABLE public.solucion OWNER TO postgres;

--
-- TOC entry 3668 (class 0 OID 0)
-- Dependencies: 254
-- Name: TABLE solucion; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE solucion IS 'almacena la solucion devuelta por el algoritmo';


--
-- TOC entry 3669 (class 0 OID 0)
-- Dependencies: 254
-- Name: COLUMN solucion.idsolucion; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN solucion.idsolucion IS 'identificador del registro';


--
-- TOC entry 3670 (class 0 OID 0)
-- Dependencies: 254
-- Name: COLUMN solucion.fecha; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN solucion.fecha IS 'fecha en la que se obtuvo la solucion';


--
-- TOC entry 3671 (class 0 OID 0)
-- Dependencies: 254
-- Name: COLUMN solucion.estado; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN solucion.estado IS 'indica si la solucion es la actual(2), ha sido escogida (1) o no(0)';


--
-- TOC entry 3672 (class 0 OID 0)
-- Dependencies: 254
-- Name: COLUMN solucion.valor; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN solucion.valor IS 'valor de la funcion objetivo calculador por el algoritmo';


--
-- TOC entry 255 (class 1259 OID 104489)
-- Name: solucion_iddatos_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE solucion_iddatos_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.solucion_iddatos_seq OWNER TO postgres;

--
-- TOC entry 256 (class 1259 OID 104491)
-- Name: solucion_iddatos_seq1; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE solucion_iddatos_seq1
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.solucion_iddatos_seq1 OWNER TO postgres;

--
-- TOC entry 257 (class 1259 OID 104493)
-- Name: solucion_iddatos_seq2; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE solucion_iddatos_seq2
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.solucion_iddatos_seq2 OWNER TO postgres;

--
-- TOC entry 258 (class 1259 OID 104495)
-- Name: solucion_idsolucion_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE solucion_idsolucion_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.solucion_idsolucion_seq OWNER TO postgres;

--
-- TOC entry 259 (class 1259 OID 104497)
-- Name: solucion_idsolucion_seq1; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE solucion_idsolucion_seq1
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.solucion_idsolucion_seq1 OWNER TO postgres;

--
-- TOC entry 260 (class 1259 OID 104499)
-- Name: solucion_idsolucion_seq2; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE solucion_idsolucion_seq2
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.solucion_idsolucion_seq2 OWNER TO postgres;

--
-- TOC entry 261 (class 1259 OID 104501)
-- Name: solucion_idsolucion_seq3; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE solucion_idsolucion_seq3
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.solucion_idsolucion_seq3 OWNER TO postgres;

--
-- TOC entry 262 (class 1259 OID 104503)
-- Name: solucion_idsolucion_seq4; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE solucion_idsolucion_seq4
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.solucion_idsolucion_seq4 OWNER TO postgres;

--
-- TOC entry 3673 (class 0 OID 0)
-- Dependencies: 262
-- Name: solucion_idsolucion_seq4; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE solucion_idsolucion_seq4 OWNED BY solucion.idsolucion;


--
-- TOC entry 263 (class 1259 OID 104505)
-- Name: solucion_idsolucion_seq_1; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE solucion_idsolucion_seq_1
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.solucion_idsolucion_seq_1 OWNER TO postgres;

--
-- TOC entry 264 (class 1259 OID 104507)
-- Name: solucionxdemanda; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE solucionxdemanda (
    idsolucionxdemanda bigint NOT NULL,
    idsolucion bigint NOT NULL,
    iddemanda bigint NOT NULL,
    demcubdirecta integer DEFAULT 0 NOT NULL,
    demcubind integer DEFAULT 0 NOT NULL,
    demsincubrir integer NOT NULL
);


ALTER TABLE public.solucionxdemanda OWNER TO postgres;

--
-- TOC entry 3674 (class 0 OID 0)
-- Dependencies: 264
-- Name: TABLE solucionxdemanda; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE solucionxdemanda IS 'Almacene la demanda cubierta y sincubrir por una solucion';


--
-- TOC entry 3675 (class 0 OID 0)
-- Dependencies: 264
-- Name: COLUMN solucionxdemanda.idsolucionxdemanda; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN solucionxdemanda.idsolucionxdemanda IS 'identificador del registro';


--
-- TOC entry 3676 (class 0 OID 0)
-- Dependencies: 264
-- Name: COLUMN solucionxdemanda.idsolucion; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN solucionxdemanda.idsolucion IS 'identificador solucion';


--
-- TOC entry 3677 (class 0 OID 0)
-- Dependencies: 264
-- Name: COLUMN solucionxdemanda.iddemanda; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN solucionxdemanda.iddemanda IS 'identificador demanda';


--
-- TOC entry 3678 (class 0 OID 0)
-- Dependencies: 264
-- Name: COLUMN solucionxdemanda.demcubdirecta; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN solucionxdemanda.demcubdirecta IS 'demanda cubierta por rutas directas';


--
-- TOC entry 3679 (class 0 OID 0)
-- Dependencies: 264
-- Name: COLUMN solucionxdemanda.demcubind; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN solucionxdemanda.demcubind IS 'Demanda cubierta por rutas indirectas( transferencia)';


--
-- TOC entry 3680 (class 0 OID 0)
-- Dependencies: 264
-- Name: COLUMN solucionxdemanda.demsincubrir; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN solucionxdemanda.demsincubrir IS 'demanda no cubierta';


--
-- TOC entry 265 (class 1259 OID 104512)
-- Name: solucionxdemanda_idsolucionxdemanda_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE solucionxdemanda_idsolucionxdemanda_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.solucionxdemanda_idsolucionxdemanda_seq OWNER TO postgres;

--
-- TOC entry 266 (class 1259 OID 104514)
-- Name: solucionxdemanda_idsolucionxdemanda_seq1; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE solucionxdemanda_idsolucionxdemanda_seq1
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.solucionxdemanda_idsolucionxdemanda_seq1 OWNER TO postgres;

--
-- TOC entry 267 (class 1259 OID 104516)
-- Name: solucionxdemanda_idsolucionxdemanda_seq2; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE solucionxdemanda_idsolucionxdemanda_seq2
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.solucionxdemanda_idsolucionxdemanda_seq2 OWNER TO postgres;

--
-- TOC entry 268 (class 1259 OID 104518)
-- Name: solucionxdemanda_idsolucionxdemanda_seq3; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE solucionxdemanda_idsolucionxdemanda_seq3
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.solucionxdemanda_idsolucionxdemanda_seq3 OWNER TO postgres;

--
-- TOC entry 269 (class 1259 OID 104520)
-- Name: solucionxdemanda_idsolucionxdemanda_seq4; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE solucionxdemanda_idsolucionxdemanda_seq4
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.solucionxdemanda_idsolucionxdemanda_seq4 OWNER TO postgres;

--
-- TOC entry 270 (class 1259 OID 104522)
-- Name: solucionxdemanda_idsolucionxdemanda_seq5; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE solucionxdemanda_idsolucionxdemanda_seq5
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.solucionxdemanda_idsolucionxdemanda_seq5 OWNER TO postgres;

--
-- TOC entry 3681 (class 0 OID 0)
-- Dependencies: 270
-- Name: solucionxdemanda_idsolucionxdemanda_seq5; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE solucionxdemanda_idsolucionxdemanda_seq5 OWNED BY solucionxdemanda.idsolucionxdemanda;


--
-- TOC entry 271 (class 1259 OID 104524)
-- Name: solucionxdemanda_idsolucionxminizonaxminizona_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE solucionxdemanda_idsolucionxminizonaxminizona_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.solucionxdemanda_idsolucionxminizonaxminizona_seq OWNER TO postgres;

--
-- TOC entry 272 (class 1259 OID 104526)
-- Name: tipo_via; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE tipo_via (
    idtipovia integer NOT NULL,
    nombretipo character varying(45) NOT NULL,
    rutasmax integer
);


ALTER TABLE public.tipo_via OWNER TO postgres;

--
-- TOC entry 3682 (class 0 OID 0)
-- Dependencies: 272
-- Name: TABLE tipo_via; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE tipo_via IS 'Almacena los tipos de via de transporte';


--
-- TOC entry 3683 (class 0 OID 0)
-- Dependencies: 272
-- Name: COLUMN tipo_via.idtipovia; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN tipo_via.idtipovia IS 'identificador del registro';


--
-- TOC entry 3684 (class 0 OID 0)
-- Dependencies: 272
-- Name: COLUMN tipo_via.nombretipo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN tipo_via.nombretipo IS 'nombre del tipo de via';


--
-- TOC entry 3685 (class 0 OID 0)
-- Dependencies: 272
-- Name: COLUMN tipo_via.rutasmax; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN tipo_via.rutasmax IS 'numero maximo de rutas que pueden recorrer por la via';


--
-- TOC entry 273 (class 1259 OID 104529)
-- Name: via; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE via (
    idvia bigint NOT NULL,
    nombre character varying(80) NOT NULL,
    velocidadprom real,
    accesible boolean NOT NULL,
    idtipovia integer NOT NULL
);


ALTER TABLE public.via OWNER TO postgres;

--
-- TOC entry 3686 (class 0 OID 0)
-- Dependencies: 273
-- Name: TABLE via; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE via IS 'Almacena las vias de transporte que conforman la red vial';


--
-- TOC entry 3687 (class 0 OID 0)
-- Dependencies: 273
-- Name: COLUMN via.idvia; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN via.idvia IS 'identificador de la ruta';


--
-- TOC entry 3688 (class 0 OID 0)
-- Dependencies: 273
-- Name: COLUMN via.nombre; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN via.nombre IS 'nombre de la via';


--
-- TOC entry 3689 (class 0 OID 0)
-- Dependencies: 273
-- Name: COLUMN via.velocidadprom; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN via.velocidadprom IS 'velocidad promedio con la cual se recorre la via';


--
-- TOC entry 3690 (class 0 OID 0)
-- Dependencies: 273
-- Name: COLUMN via.accesible; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN via.accesible IS 'indica si la via es accesible(1) o no(0)';


--
-- TOC entry 274 (class 1259 OID 104532)
-- Name: via_idvia_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE via_idvia_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.via_idvia_seq OWNER TO postgres;

--
-- TOC entry 275 (class 1259 OID 104534)
-- Name: via_idvia_seq1; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE via_idvia_seq1
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.via_idvia_seq1 OWNER TO postgres;

--
-- TOC entry 276 (class 1259 OID 104536)
-- Name: via_idvia_seq2; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE via_idvia_seq2
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.via_idvia_seq2 OWNER TO postgres;

--
-- TOC entry 277 (class 1259 OID 104538)
-- Name: via_idvia_seq3; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE via_idvia_seq3
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.via_idvia_seq3 OWNER TO postgres;

--
-- TOC entry 278 (class 1259 OID 104540)
-- Name: via_idvia_seq4; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE via_idvia_seq4
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.via_idvia_seq4 OWNER TO postgres;

--
-- TOC entry 279 (class 1259 OID 104542)
-- Name: via_idvia_seq5; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE via_idvia_seq5
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.via_idvia_seq5 OWNER TO postgres;

--
-- TOC entry 3691 (class 0 OID 0)
-- Dependencies: 279
-- Name: via_idvia_seq5; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE via_idvia_seq5 OWNED BY via.idvia;


--
-- TOC entry 280 (class 1259 OID 104544)
-- Name: zonacensal; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE zonacensal (
    id integer,
    dpto integer,
    prov integer,
    dist integer,
    nombre character varying(45),
    length double precision,
    area real,
    geom geometry(Geometry,4326)
);


ALTER TABLE public.zonacensal OWNER TO postgres;

--
-- TOC entry 3692 (class 0 OID 0)
-- Dependencies: 280
-- Name: TABLE zonacensal; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE zonacensal IS 'Almacena las zonas censales';


--
-- TOC entry 3693 (class 0 OID 0)
-- Dependencies: 280
-- Name: COLUMN zonacensal.id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN zonacensal.id IS 'identificador del registro';


--
-- TOC entry 3694 (class 0 OID 0)
-- Dependencies: 280
-- Name: COLUMN zonacensal.dpto; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN zonacensal.dpto IS 'identificador departamento';


--
-- TOC entry 3695 (class 0 OID 0)
-- Dependencies: 280
-- Name: COLUMN zonacensal.prov; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN zonacensal.prov IS 'identificador provincia';


--
-- TOC entry 3696 (class 0 OID 0)
-- Dependencies: 280
-- Name: COLUMN zonacensal.dist; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN zonacensal.dist IS 'identificador distrito';


--
-- TOC entry 3697 (class 0 OID 0)
-- Dependencies: 280
-- Name: COLUMN zonacensal.nombre; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN zonacensal.nombre IS 'nombre de la zona censal';


--
-- TOC entry 3698 (class 0 OID 0)
-- Dependencies: 280
-- Name: COLUMN zonacensal.area; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN zonacensal.area IS 'area de la zona censal';


--
-- TOC entry 281 (class 1259 OID 104550)
-- Name: zonatransito; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE zonatransito (
    idzonatransito bigint NOT NULL,
    iddistrito bigint NOT NULL,
    codigo character varying(25),
    area double precision,
    numminizona integer,
    flgtraspaso integer,
    flgperiferico integer,
    geom geometry(Polygon,4326)
);


ALTER TABLE public.zonatransito OWNER TO postgres;

--
-- TOC entry 3699 (class 0 OID 0)
-- Dependencies: 281
-- Name: TABLE zonatransito; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE zonatransito IS 'Tabla que almacena las zonas de transito';


--
-- TOC entry 3700 (class 0 OID 0)
-- Dependencies: 281
-- Name: COLUMN zonatransito.idzonatransito; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN zonatransito.idzonatransito IS 'Identificador del registro';


--
-- TOC entry 3701 (class 0 OID 0)
-- Dependencies: 281
-- Name: COLUMN zonatransito.codigo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN zonatransito.codigo IS 'codigo identificador de la zona de transito';


--
-- TOC entry 3702 (class 0 OID 0)
-- Dependencies: 281
-- Name: COLUMN zonatransito.area; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN zonatransito.area IS 'area total de la zona de transito en kilometros';


--
-- TOC entry 3703 (class 0 OID 0)
-- Dependencies: 281
-- Name: COLUMN zonatransito.numminizona; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN zonatransito.numminizona IS 'Cantidad de minizonas que contiene';


--
-- TOC entry 3704 (class 0 OID 0)
-- Dependencies: 281
-- Name: COLUMN zonatransito.flgtraspaso; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN zonatransito.flgtraspaso IS 'Indica si la zona de transito es una zona de traspaso';


--
-- TOC entry 3705 (class 0 OID 0)
-- Dependencies: 281
-- Name: COLUMN zonatransito.flgperiferico; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN zonatransito.flgperiferico IS 'Indica si la zona de transito es una zona de la periferia';


--
-- TOC entry 3706 (class 0 OID 0)
-- Dependencies: 281
-- Name: COLUMN zonatransito.geom; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN zonatransito.geom IS 'Poligono de la zona de transito';


--
-- TOC entry 3391 (class 2604 OID 104556)
-- Name: idalgoritmo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY algoritmo ALTER COLUMN idalgoritmo SET DEFAULT nextval('algoritmo_idalgoritmo_seq1'::regclass);


--
-- TOC entry 3392 (class 2604 OID 104557)
-- Name: idaristaminizona; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY arista_minizona ALTER COLUMN idaristaminizona SET DEFAULT nextval('arista_minizona_idaristaminizona_seq4'::regclass);


--
-- TOC entry 3393 (class 2604 OID 104558)
-- Name: iddatos; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY datos ALTER COLUMN iddatos SET DEFAULT nextval('datos_iddatos_seq4'::regclass);


--
-- TOC entry 3395 (class 2604 OID 104559)
-- Name: iddemanda; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY demanda ALTER COLUMN iddemanda SET DEFAULT nextval('demanda_iddemanda_seq4'::regclass);


--
-- TOC entry 3396 (class 2604 OID 104560)
-- Name: idminizona; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY minizona ALTER COLUMN idminizona SET DEFAULT nextval('minizona_idminizona_seq5'::regclass);


--
-- TOC entry 3397 (class 2604 OID 104561)
-- Name: idminizonaxarista; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY minizonaxarista ALTER COLUMN idminizonaxarista SET DEFAULT nextval('minizonaxarista_idminizonaxarista_seq5'::regclass);


--
-- TOC entry 3398 (class 2604 OID 104562)
-- Name: idminizonaxnodo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY minizonaxnodo ALTER COLUMN idminizonaxnodo SET DEFAULT nextval('minizonaxnodo_idminizonaxnodo_seq5'::regclass);


--
-- TOC entry 3399 (class 2604 OID 104563)
-- Name: idparametros; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY parametros ALTER COLUMN idparametros SET DEFAULT nextval('parametros_idparametros_seq'::regclass);


--
-- TOC entry 3400 (class 2604 OID 104564)
-- Name: idruta; Type: DEFAULT; Schema: public; Owner: postgres
--

--ALTER TABLE ONLY ruta ALTER COLUMN idruta SET DEFAULT nextval('ruta_idruta_seq5'::regclass);


--
-- TOC entry 3401 (class 2604 OID 104565)
-- Name: idrutaxarista; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY rutaxarista ALTER COLUMN idrutaxarista SET DEFAULT nextval('rutaxarista_idrutaxarista_seq5'::regclass);


--
-- TOC entry 3402 (class 2604 OID 104566)
-- Name: idsolucion; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY solucion ALTER COLUMN idsolucion SET DEFAULT nextval('solucion_idsolucion_seq4'::regclass);


--
-- TOC entry 3405 (class 2604 OID 104567)
-- Name: idsolucionxdemanda; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY solucionxdemanda ALTER COLUMN idsolucionxdemanda SET DEFAULT nextval('solucionxdemanda_idsolucionxdemanda_seq5'::regclass);


--
-- TOC entry 3406 (class 2604 OID 104568)
-- Name: idvia; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY via ALTER COLUMN idvia SET DEFAULT nextval('via_idvia_seq5'::regclass);


--
-- TOC entry 3408 (class 2606 OID 104570)
-- Name: algoritmo_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY algoritmo
    ADD CONSTRAINT algoritmo_pk PRIMARY KEY (idalgoritmo);


--
-- TOC entry 3410 (class 2606 OID 104572)
-- Name: arista_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY arista
    ADD CONSTRAINT arista_pk PRIMARY KEY (idarista);


--
-- TOC entry 3419 (class 2606 OID 104574)
-- Name: demanda_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY demanda
    ADD CONSTRAINT demanda_pk PRIMARY KEY (iddemanda);


--
-- TOC entry 3425 (class 2606 OID 104576)
-- Name: minizona_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY minizona
    ADD CONSTRAINT minizona_pk PRIMARY KEY (idminizona);


--
-- TOC entry 3427 (class 2606 OID 104578)
-- Name: minizonaxarista_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY minizonaxarista
    ADD CONSTRAINT minizonaxarista_pk PRIMARY KEY (idminizonaxarista);


--
-- TOC entry 3429 (class 2606 OID 104580)
-- Name: minizonaxnodo_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY minizonaxnodo
    ADD CONSTRAINT minizonaxnodo_pk PRIMARY KEY (idminizonaxnodo);


--
-- TOC entry 3431 (class 2606 OID 104582)
-- Name: nodo_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY nodo
    ADD CONSTRAINT nodo_pk PRIMARY KEY (idnodo);


--
-- TOC entry 3433 (class 2606 OID 104584)
-- Name: parametros_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY parametros
    ADD CONSTRAINT parametros_pk PRIMARY KEY (idparametros);


--
-- TOC entry 3415 (class 2606 OID 104586)
-- Name: pk_arista_zona; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY arista_minizona
    ADD CONSTRAINT pk_arista_zona PRIMARY KEY (idaristaminizona);


--
-- TOC entry 3417 (class 2606 OID 104588)
-- Name: pk_datos; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY datos
    ADD CONSTRAINT pk_datos PRIMARY KEY (iddatos);


--
-- TOC entry 3421 (class 2606 OID 104590)
-- Name: pk_distrito; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY distrito
    ADD CONSTRAINT pk_distrito PRIMARY KEY (iddistrito);


--
-- TOC entry 3444 (class 2606 OID 104592)
-- Name: pk_tipo_via; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tipo_via
    ADD CONSTRAINT pk_tipo_via PRIMARY KEY (idtipovia);


--
-- TOC entry 3450 (class 2606 OID 104594)
-- Name: pk_zonatransito; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY zonatransito
    ADD CONSTRAINT pk_zonatransito PRIMARY KEY (idzonatransito);


--
-- TOC entry 3436 (class 2606 OID 104596)
-- Name: ruta_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY ruta
    ADD CONSTRAINT ruta_pk PRIMARY KEY (idruta);


--
-- TOC entry 3438 (class 2606 OID 104598)
-- Name: rutaxarista_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY rutaxarista
    ADD CONSTRAINT rutaxarista_pk PRIMARY KEY (idrutaxarista);


--
-- TOC entry 3440 (class 2606 OID 104600)
-- Name: solucion_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY solucion
    ADD CONSTRAINT solucion_pk PRIMARY KEY (idsolucion);


--
-- TOC entry 3442 (class 2606 OID 104602)
-- Name: solucionxdemanda_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY solucionxdemanda
    ADD CONSTRAINT solucionxdemanda_pk PRIMARY KEY (idsolucionxdemanda);


--
-- TOC entry 3447 (class 2606 OID 104604)
-- Name: via_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY via
    ADD CONSTRAINT via_pk PRIMARY KEY (idvia);


--
-- TOC entry 3411 (class 1259 OID 104605)
-- Name: idx_arista; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_arista ON arista USING btree (iddistrito);


--
-- TOC entry 3412 (class 1259 OID 104606)
-- Name: idx_arista_zona; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_arista_zona ON arista_minizona USING btree (idminizonaorigen);


--
-- TOC entry 3413 (class 1259 OID 104607)
-- Name: idx_arista_zona_0; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_arista_zona_0 ON arista_minizona USING btree (idminizonadestino);


--
-- TOC entry 3422 (class 1259 OID 104608)
-- Name: idx_minizona; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_minizona ON minizona USING btree (idzonatransito);


--
-- TOC entry 3423 (class 1259 OID 104609)
-- Name: idx_minizona_0; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_minizona_0 ON minizona USING btree (iddistrito);


--
-- TOC entry 3434 (class 1259 OID 104610)
-- Name: idx_redvial; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_redvial ON redvial USING btree (id);


--
-- TOC entry 3445 (class 1259 OID 104611)
-- Name: idx_via; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_via ON via USING btree (idtipovia);


--
-- TOC entry 3448 (class 1259 OID 104612)
-- Name: idx_zonatransito; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_zonatransito ON zonatransito USING btree (iddistrito);


--
-- TOC entry 3461 (class 2606 OID 104613)
-- Name: arista_minizonaxarista_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY minizonaxarista
    ADD CONSTRAINT arista_minizonaxarista_fk FOREIGN KEY (idarista) REFERENCES arista(idarista);


--
-- TOC entry 3466 (class 2606 OID 104618)
-- Name: arista_rutaxarista_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY rutaxarista
    ADD CONSTRAINT arista_rutaxarista_fk FOREIGN KEY (idarista) REFERENCES arista(idarista);


--
-- TOC entry 3468 (class 2606 OID 104623)
-- Name: demanda_solucionxdemanda_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY solucionxdemanda
    ADD CONSTRAINT demanda_solucionxdemanda_fk FOREIGN KEY (iddemanda) REFERENCES demanda(iddemanda);


--
-- TOC entry 3451 (class 2606 OID 104628)
-- Name: fk_arista_distrito; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY arista
    ADD CONSTRAINT fk_arista_distrito FOREIGN KEY (iddistrito) REFERENCES distrito(iddistrito);


--
-- TOC entry 3455 (class 2606 OID 104633)
-- Name: fk_arista_zona; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY arista_minizona
    ADD CONSTRAINT fk_arista_zona FOREIGN KEY (idminizonaorigen) REFERENCES minizona(idminizona);


--
-- TOC entry 3456 (class 2606 OID 104638)
-- Name: fk_arista_zona_0; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY arista_minizona
    ADD CONSTRAINT fk_arista_zona_0 FOREIGN KEY (idminizonadestino) REFERENCES minizona(idminizona);


--
-- TOC entry 3459 (class 2606 OID 104643)
-- Name: fk_minizona; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY minizona
    ADD CONSTRAINT fk_minizona FOREIGN KEY (idzonatransito) REFERENCES zonatransito(idzonatransito);


--
-- TOC entry 3460 (class 2606 OID 104648)
-- Name: fk_minizona_0; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY minizona
    ADD CONSTRAINT fk_minizona_0 FOREIGN KEY (iddistrito) REFERENCES distrito(iddistrito);


--
-- TOC entry 3470 (class 2606 OID 104653)
-- Name: fk_via; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY via
    ADD CONSTRAINT fk_via FOREIGN KEY (idtipovia) REFERENCES tipo_via(idtipovia);


--
-- TOC entry 3471 (class 2606 OID 104658)
-- Name: fk_zonatransito_distrito; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY zonatransito
    ADD CONSTRAINT fk_zonatransito_distrito FOREIGN KEY (iddistrito) REFERENCES distrito(iddistrito);


--
-- TOC entry 3457 (class 2606 OID 104663)
-- Name: minizona_demanda_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY demanda
    ADD CONSTRAINT minizona_demanda_fk FOREIGN KEY (idminizonaorigen) REFERENCES minizona(idminizona);


--
-- TOC entry 3458 (class 2606 OID 104668)
-- Name: minizona_demanda_fk1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY demanda
    ADD CONSTRAINT minizona_demanda_fk1 FOREIGN KEY (idminizonadestino) REFERENCES minizona(idminizona);


--
-- TOC entry 3462 (class 2606 OID 104673)
-- Name: minizona_minizonaxarista_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY minizonaxarista
    ADD CONSTRAINT minizona_minizonaxarista_fk FOREIGN KEY (idminizona) REFERENCES minizona(idminizona);


--
-- TOC entry 3463 (class 2606 OID 104678)
-- Name: minizona_minizonaxnodo_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY minizonaxnodo
    ADD CONSTRAINT minizona_minizonaxnodo_fk FOREIGN KEY (idminizona) REFERENCES minizona(idminizona);


--
-- TOC entry 3452 (class 2606 OID 104683)
-- Name: nodo_arista_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY arista
    ADD CONSTRAINT nodo_arista_fk FOREIGN KEY (idnodoorigen) REFERENCES nodo(idnodo);


--
-- TOC entry 3453 (class 2606 OID 104688)
-- Name: nodo_arista_fk1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY arista
    ADD CONSTRAINT nodo_arista_fk1 FOREIGN KEY (idnododestino) REFERENCES nodo(idnodo);


--
-- TOC entry 3464 (class 2606 OID 104693)
-- Name: nodo_minizonaxnodo_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY minizonaxnodo
    ADD CONSTRAINT nodo_minizonaxnodo_fk FOREIGN KEY (idnodo) REFERENCES nodo(idnodo);


--
-- TOC entry 3467 (class 2606 OID 104698)
-- Name: ruta_rutaxarista_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY rutaxarista
    ADD CONSTRAINT ruta_rutaxarista_fk FOREIGN KEY (idruta) REFERENCES ruta(idruta);


--
-- TOC entry 3465 (class 2606 OID 104703)
-- Name: solucion_ruta_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ruta
    ADD CONSTRAINT solucion_ruta_fk FOREIGN KEY (idsolucion) REFERENCES solucion(idsolucion);


--
-- TOC entry 3469 (class 2606 OID 104708)
-- Name: solucion_solucionxdemanda_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY solucionxdemanda
    ADD CONSTRAINT solucion_solucionxdemanda_fk FOREIGN KEY (idsolucion) REFERENCES solucion(idsolucion);


--
-- TOC entry 3454 (class 2606 OID 104713)
-- Name: via_arista_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY arista
    ADD CONSTRAINT via_arista_fk FOREIGN KEY (idvia) REFERENCES via(idvia);


--
-- TOC entry 3592 (class 0 OID 0)
-- Dependencies: 5
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2014-10-23 17:20:52 PET

--
-- PostgreSQL database dump complete
--

