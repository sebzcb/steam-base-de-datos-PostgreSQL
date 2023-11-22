create table traspaso(
	id_app integer primary key,
	nombre varchar(300) ,
	descripcion varchar(1000),
	desarrollador varchar(300),
	publicador varchar(300),
	genero varchar(300),
	tags varchar(600),
	tipo varchar(200),
	categorias varchar (600),
	descargas_rango varchar(300),
	reviews_positivas integer,
	reviews_negativas integer,
	precio_final integer,
	precio_inicial integer,
	descuento integer,
	ccu integer,
	lenguajes varchar(700),
	plataformas varchar(300),
	fecha_salida varchar(100),
	edad_minima varchar(100),
	website varchar(1000),
	header_img varchar(1000)
);
drop table traspaso;
copy traspaso from 'E:\steam_games.csv' delimiter ';' csv header encoding 'Latin1'


-- Eliminar columnas innecesarias
ALTER TABLE traspaso
DROP COLUMN website,
DROP COLUMN header_img;


/*casos aislados de fecha*/
UPDATE traspaso
SET fecha_salida = CASE 
    WHEN CHAR_LENGTH(fecha_salida) = 7 THEN CONCAT(fecha_salida, '/01')
    ELSE fecha_salida
END
WHERE fecha_salida LIKE '____/_%';

/*cambia formato fecha_salida */
ALTER TABLE traspaso
ALTER COLUMN fecha_salida TYPE Date USING fecha_salida::date;

UPDATE traspaso
SET edad_minima = REGEXP_REPLACE(edad_minima, '[^0-9]', '', 'g')::integer
WHERE edad_minima SIMILAR TO '%[^0-9]%';

/*cambia formato integer edad_minima */
ALTER TABLE traspaso
ALTER COLUMN edad_minima TYPE integer USING edad_minima::integer;


/*creacion de secuencias */
/*descargas_rangos*/
CREATE SEQUENCE IF NOT EXISTS public.descargas_rangos_id_descargasrangos_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 2147483647
    CACHE 1;
/*edades_minimas*/
CREATE SEQUENCE IF NOT EXISTS public.edades_minimas_id_edadminima_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 2147483647
    CACHE 1;
/*descuentos*/
CREATE SEQUENCE IF NOT EXISTS public.descuentos_id_descuento_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 2147483647
    CACHE 1;
/*publicadores*/
CREATE SEQUENCE IF NOT EXISTS public.publicadores_id_publicador_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 2147483647
    CACHE 1;
/*desarrolladores*/
CREATE SEQUENCE IF NOT EXISTS public.desarrolladores_id_desarrollador_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 2147483647
    CACHE 1;
/*categorias*/
CREATE SEQUENCE IF NOT EXISTS public.categorias_id_categoria_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 2147483647
    CACHE 1;
/*tipos*/
CREATE SEQUENCE IF NOT EXISTS public.tipos_id_tipo_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 2147483647
    CACHE 1;
/*lenguajes*/
CREATE SEQUENCE IF NOT EXISTS public.lenguajes_id_lenguaje_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 2147483647
    CACHE 1;
/*generos*/
CREATE SEQUENCE IF NOT EXISTS public.generos_id_genero_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 2147483647
    CACHE 1;
/*plataformas*/
CREATE SEQUENCE IF NOT EXISTS public.plataformas_id_plataforma_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 2147483647
    CACHE 1;
/*tags*/
CREATE SEQUENCE IF NOT EXISTS public.tags_id_tag_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 2147483647
    CACHE 1;

/*tabla juegos sin FK's de momento*/
CREATE TABLE IF NOT EXISTS public.juegos
(
    id_app integer NOT NULL,	
    juego character varying(300) COLLATE pg_catalog."default" NOT NULL,
    descripcion character varying(1000) COLLATE pg_catalog."default" ,
    reviews_positivas integer NOT NULL,
    reviews_negativas integer NOT NULL,
    ccu integer NOT NULL,
    feceha_salida date,
    precio_inicial integer NOT NULL,
    precio_final integer NOT NULL,
    CONSTRAINT juegos_pkey PRIMARY KEY (id_app)
);

/*tabla descargas_rangos*/
CREATE TABLE IF NOT EXISTS public.descargas_rangos
(
    id_descargas_rangos integer NOT NULL DEFAULT nextval('descargas_rangos_id_descargasrangos_seq'::regclass),
    descarga_rango character varying(300) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT descargas_rangos_pkey PRIMARY KEY (id_descargas_rangos)
);
/*tabla edades_minimas*/
CREATE TABLE IF NOT EXISTS public.edades_minimas
(
    id_edades_minimas integer NOT NULL DEFAULT nextval('edades_minimas_id_edadminima_seq'::regclass),
    edad_minima character varying(50) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT edades_minimas_pkey PRIMARY KEY (id_edades_minimas)
);
/*tabla decuentos*/
CREATE TABLE IF NOT EXISTS public.descuentos
(
    id_descuentos integer NOT NULL DEFAULT nextval('descuentos_id_descuento_seq'::regclass),
    descuento integer NOT NULL,
    CONSTRAINT descuentos_pkey PRIMARY KEY (id_descuentos)
);
/*tabla intermedia juegopublicador*/
CREATE TABLE IF NOT EXISTS public.juegopublicador
(
    
);
/*tabla intermedia juegodesarrollador*/
CREATE TABLE IF NOT EXISTS public.juegodesarrollador
(
    
);
/*tabla decuentos*/
CREATE TABLE IF NOT EXISTS public.publicadores
(
    id_publicadores integer NOT NULL DEFAULT nextval('publicadores_id_publicador_seq'::regclass),
    publicador character varying(300) NOT NULL,
    CONSTRAINT publicadores_pkey PRIMARY KEY (id_publicadores)
);


/*tabla publicadores*/
CREATE TABLE IF NOT EXISTS public.desarrolladores
(
    id_desarrolladores integer NOT NULL DEFAULT nextval('desarrolladores_id_desarrollador_seq'::regclass),
    desarrollador character varying(300),
    CONSTRAINT desarrolladores_pkey PRIMARY KEY (id_desarrolladores)
);


/*tabla tipo categoria intermedia*/
CREATE TABLE IF NOT EXISTS public.juegocategoria
(
    
);
CREATE TABLE IF NOT EXISTS public.juegotipo
(
    
);
CREATE TABLE IF NOT EXISTS public.juegolenguaje
(
    
);CREATE TABLE IF NOT EXISTS public.juegogenero
(
    
);CREATE TABLE IF NOT EXISTS public.juegoplataforma
(
    
);
CREATE TABLE IF NOT EXISTS public.juegotag
(
    
);
CREATE TABLE IF NOT EXISTS public.categorias
(
    id_categorias integer NOT NULL DEFAULT nextval('categorias_id_categoria_seq'::regclass),
    categoria character varying(200),
    CONSTRAINT categorias_pkey PRIMARY KEY (id_categorias)
);

CREATE TABLE IF NOT EXISTS public.tipos
(
    id_tipo integer NOT NULL DEFAULT nextval('tipos_id_tipo_seq'::regclass),
    tipo character varying(200) NOT NULL,
    CONSTRAINT tipos_pkey PRIMARY KEY (id_tipo)
);

CREATE TABLE IF NOT EXISTS public.generos
(
    id_genero integer NOT NULL DEFAULT nextval('generos_id_genero_seq'::regclass),
    genero character varying(300),
    CONSTRAINT genero_pkey PRIMARY KEY (id_genero)
);

CREATE TABLE IF NOT EXISTS public.plataformas
(
    id_plataforma integer NOT NULL DEFAULT nextval('plataformas_id_plataforma_seq'::regclass),
    plataforma character varying(50) NOT NULL,
    CONSTRAINT plataforma_pkey PRIMARY KEY (id_plataforma)
);
CREATE TABLE IF NOT EXISTS public.tags
(
    id_tag integer NOT NULL DEFAULT nextval('tags_id_tag_seq'::regclass),
    tag character varying(50),
    CONSTRAINT tag_pkey PRIMARY KEY (id_tag)
);


