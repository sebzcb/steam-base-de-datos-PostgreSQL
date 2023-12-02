CREATE DATABASE steam;

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


/*AGREGAR ATRIBUTOS QUE DESPUES SERAN FKS EN LAS TABLAS */

ALTER TABLE juegos ADD COLUMN id_descargas_rangos INTEGER NOT NULL;
ALTER TABLE juegos ADD COLUMN id_edad_minima INTEGER NOT NULL;
ALTER TABLE juegos ADD COLUMN id_descuento INTEGER NOT NULL;

ALTER TABLE juegopublicador ADD COLUMN id_app INTEGER NOT NULL;
ALTER TABLE juegopublicador ADD COLUMN id_publicador INTEGER NOT NULL;

ALTER TABLE juegodesarrollador ADD COLUMN id_app INTEGER NOT NULL;
ALTER TABLE juegodesarrollador ADD COLUMN id_desarrollador INTEGER NOT NULL;

ALTER TABLE juegotag ADD COLUMN id_app INTEGER NOT NULL;
ALTER TABLE juegotag ADD COLUMN id_tag INTEGER NOT NULL;

ALTER TABLE juegoplataforma ADD COLUMN id_app INTEGER NOT NULL;
ALTER TABLE juegoplataforma ADD COLUMN id_plataforma INTEGER NOT NULL;

ALTER TABLE juegogenero ADD COLUMN id_app INTEGER NOT NULL;
ALTER TABLE juegogenero ADD COLUMN id_genero INTEGER NOT NULL;

ALTER TABLE juegolenguaje ADD COLUMN id_app INTEGER NOT NULL;
ALTER TABLE juegolenguaje ADD COLUMN id_lenguaje INTEGER NOT NULL;

ALTER TABLE juegotipo ADD COLUMN id_app INTEGER NOT NULL;
ALTER TABLE juegotipo ADD COLUMN id_tipo INTEGER NOT NULL;

ALTER TABLE juegocategoria ADD COLUMN id_app INTEGER NOT NULL;
ALTER TABLE juegocategoria ADD COLUMN id_categoria INTEGER NOT NULL;


/*AHORA ASIGNAR LOS FKS CORRESPONDIENTES A CADA TABLA*/

/*TABLA JUEGOS*/
/*id_descargas_rangos*/
ALTER TABLE IF EXISTS public.juegos
    ADD CONSTRAINT fk_descargas_rangos FOREIGN KEY (id_descargas_rangos)
    REFERENCES public.descargas_rangos (id_descargas_rangos) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;
	
/*id_edad_minima*/
ALTER TABLE IF EXISTS public.juegos
    ADD CONSTRAINT fk_edad_minima FOREIGN KEY (id_edad_minima)
    REFERENCES public.edades_minimas (id_edades_minimas) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;
	
/*id_descuento*/
ALTER TABLE IF EXISTS public.juegos
    ADD CONSTRAINT fk_id_descuento FOREIGN KEY (id_descuento)
    REFERENCES public.descuentos (id_descuentos) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

    	
/*tabla juegopublicador*/
ALTER TABLE IF EXISTS public.juegopublicador
    ADD CONSTRAINT fk_id_app FOREIGN KEY (id_app)
    REFERENCES public.juegos (id_app) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

ALTER TABLE IF EXISTS public.juegopublicador
    ADD CONSTRAINT fk_id_publicador FOREIGN KEY (id_publicador)
    REFERENCES public.publicadores (id_publicadores) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


/*tabla juegodesarrollador*/
ALTER TABLE IF EXISTS public.juegodesarrollador
    ADD CONSTRAINT fk_id_app FOREIGN KEY (id_app)
    REFERENCES public.juegos (id_app) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

ALTER TABLE IF EXISTS public.juegodesarrollador
    ADD CONSTRAINT fk_id_desarrollador FOREIGN KEY (id_desarrollador)
    REFERENCES public.desarrolladores (id_desarrolladores) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


    	/*tabla juegotag*/
ALTER TABLE IF EXISTS public.juegotag
    ADD CONSTRAINT fk_id_app FOREIGN KEY (id_app)
    REFERENCES public.juegos (id_app) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

ALTER TABLE IF EXISTS public.juegotag
    ADD CONSTRAINT fk_id_tag FOREIGN KEY (id_tag)
    REFERENCES public.tags (id_tag) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


    	
		/*tabla juegoplataforma*/
ALTER TABLE IF EXISTS public.juegoplataforma
    ADD CONSTRAINT fk_id_app FOREIGN KEY (id_app)
    REFERENCES public.juegos (id_app) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

ALTER TABLE IF EXISTS public.juegoplataforma
    ADD CONSTRAINT fk_id_plataforma FOREIGN KEY (id_plataforma)
    REFERENCES public.plataformas (id_plataforma) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;
		
		/*tabla juegogenero*/
ALTER TABLE IF EXISTS public.juegogenero
    ADD CONSTRAINT fk_id_app FOREIGN KEY (id_app)
    REFERENCES public.juegos (id_app) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

ALTER TABLE IF EXISTS public.juegogenero
    ADD CONSTRAINT fk_id_genero FOREIGN KEY (id_genero)
    REFERENCES public.generos (id_genero) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


    	/*tabla juegolenguaje*/
ALTER TABLE IF EXISTS public.juegolenguaje
    ADD CONSTRAINT fk_id_app FOREIGN KEY (id_app)
    REFERENCES public.juegos (id_app) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

ALTER TABLE IF EXISTS public.juegolenguaje
    ADD CONSTRAINT fk_id_lenguaje FOREIGN KEY (id_lenguaje)
    REFERENCES public.lenguajes (id_lenguaje) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


    		/*tabla juegotipo*/
ALTER TABLE IF EXISTS public.juegotipo
    ADD CONSTRAINT fk_id_app FOREIGN KEY (id_app)
    REFERENCES public.juegos (id_app) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


/*CREA TABLA TIPO*/
Create table tipos(
	id_tipo INTEGER primary key,
	tipo character varying (200) NOT NULL
)
ALTER TABLE IF EXISTS public.juegotipo
    ADD CONSTRAINT fk_id_tipo FOREIGN KEY (id_tipo)
    REFERENCES public.tipos (id_tipo) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


    		/*tabla juegocategorias*/
ALTER TABLE IF EXISTS public.juegocategoria
    ADD CONSTRAINT fk_id_app FOREIGN KEY (id_app)
    REFERENCES public.juegos (id_app) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.juegocategoria
    ADD CONSTRAINT fk_id_categoria FOREIGN KEY (id_categoria)
    REFERENCES public.categorias (id_categorias) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

/* INSERTA DATOS EN TABLA descargas_rangos*/
INSERT INTO descargas_rangos(descarga_rango)
SELECT DISTINCT descargas_rango
FROM traspaso;

/*inserta datos en tabla edades minimas*/
INSERT INTO edades_minimas(edad_minima)
select distinct edad_minima from traspaso;

/*inserta datos en tabla descuento*/
insert into descuentos(descuento)
select distinct descuento from traspaso;

/*PARAMETROS FUNCION: TEXTO A DIVIR, DELIMITADOR => retorna valores independientes, sin la coma.
*/
CREATE OR REPLACE FUNCTION public.split_text_to_rows(
    text_to_split text,
    delimiter text
)
RETURNS TABLE (split_value varchar(300)) AS
$BODY$
BEGIN
    RETURN QUERY SELECT CAST(trim(regexp_split_to_table(text_to_split, delimiter)) AS varchar(300));
END;
$BODY$
LANGUAGE plpgsql;

/*ACTUALIZA DESARROLLADOR EN DONDE SEA NULL SE CAMBIA POR NINGUNO*/
UPDATE traspaso
SET desarrollador = COALESCE(desarrollador, 'ninguno')
WHERE desarrollador IS NULL;

/*ACTUALIZA PUBLICADOR EN DONDE SEA NULL SE CAMBIA POR NINGUNO*/
UPDATE traspaso
SET publicador = COALESCE(publicador, 'ninguno')
WHERE publicador IS NULL;

/*ACTUALIZA TAG EN DONDE SEA NULL SE CAMBIA POR NINGUNO*/
UPDATE traspaso
SET tags = COALESCE(tags, 'ninguno')
WHERE tags IS NULL;

/*ACTUALIZA genero EN DONDE SEA NULL SE CAMBIA POR NINGUNO*/
UPDATE traspaso
SET genero = COALESCE(genero, 'ninguno')
WHERE genero IS NULL;

/*ACTUALIZA lenguajes EN DONDE SEA NULL SE CAMBIA POR NINGUNO*/
UPDATE traspaso
SET lenguajes = COALESCE(lenguajes, 'ninguno')
WHERE lenguajes IS NULL;
/*ACTUALIZA categorias EN DONDE SEA NULL SE CAMBIA POR NINGUNO*/
UPDATE traspaso
SET categorias = COALESCE(categorias, 'ninguno')
WHERE categorias IS NULL;

/*descripcion => Cambia valores null a "ninguno"*/
UPDATE traspaso
SET descripcion = COALESCE(descripcion, 'ninguno')
WHERE descripcion IS NULL;


/*inserto en tabla publicadores*/
INSERT INTO publicadores (publicador)
/*ejecuto funcion para separar por comas cada fila de publicador ya que existen casos donde hay mas de 2 publicadores en una misma fila*/
SELECT DISTINCT split_text_to_rows(publicador, ', ')  
FROM traspaso;

/*inserto en tabla desarrolladores*/
INSERT INTO desarrolladores(desarrollador)
/*ejecuto funcion para separar por comas cada fila de publicador ya que existen casos donde hay mas de 2 desarrolladores en una misma fila*/
SELECT DISTINCT split_text_to_rows(desarrollador, ', ')  
FROM traspaso;
/*renombra atributo*/
ALTER TABLE juegos
RENAME COLUMN feceha_salida TO fecha_salida;

/*CAMBIA DE TIPO VARCHAR A INTEGER EN EDAD_MINIMA*/
ALTER TABLE edades_minimas
ALTER COLUMN edad_minima TYPE integer USING edad_minima::integer;


/*SE INSERTAN DATOS A TABLA JUEGOS*/
INSERT INTO juegos (id_app, juego, descripcion, reviews_positivas, reviews_negativas, ccu, fecha_salida, precio_inicial, precio_final,id_descargas_rangos,id_edad_minima,id_descuento)
SELECT id_app, nombre, descripcion, reviews_positivas, reviews_negativas, ccu, fecha_salida, precio_inicial, precio_final
,dr.id_descargas_rangos,em.id_edades_minimas,d.id_descuentos
FROM traspaso t inner join descargas_rangos dr
ON t.descargas_rango = dr.descarga_rango
inner join edades_minimas em 
ON t.edad_minima = em.edad_minima
inner join descuentos d
ON t.descuento = d.descuento;


/*AGREGA DATOS A TABLA juegopublicador*/
insert into juegopublicador (id_app,id_publicador)
/*para ver cuales son distintos*/
SELECT t.id_app,p.id_publicadores  FROM traspaso t 
inner JOIN publicadores p
ON p.publicador = ANY(STRING_TO_ARRAY(t.publicador, ','));


insert into juegodesarrollador (id_app,id_desarrollador)
/*para ver cuales son distintos*/
SELECT t.id_app,d.id_desarrolladores  FROM traspaso t 
inner JOIN desarrolladores d
ON d.desarrollador = ANY(STRING_TO_ARRAY(t.desarrollador, ','));

/*INSERTA DATOS A TABLA TAGS*/
insert into tags(tag)
select distinct split_text_to_rows(tags,',') from traspaso;
/*INSERTA DATOS A PLATAFORMAS*/
insert into plataformas(plataforma)
select distinct split_text_to_rows(plataformas,',') from traspaso;

/*INSERTA DATOS A PLATAFORMAS*/
insert into plataformas(plataforma)
select distinct split_text_to_rows(plataformas,',') from traspaso;

/*INSERTA DATOS A TABLA GENEROS*/
insert into generos(genero)
select distinct split_text_to_rows(genero,',') from traspaso;
/*cambio tipo de dato de lenguaje para no tener problemas*/
ALTER TABLE lenguajes
ALTER COLUMN lenguaje TYPE character varying(300);

/*INSERTA DATOS A TABLA LENGUAJES*/
insert into lenguajes(lenguaje)
select distinct split_text_to_rows(lenguajes,',') from traspaso;


/*inserta datos a tabla tipos , solo tiene 2 datos*/
insert into tipos(id_tipo,tipo)
SELECT  distinct 1, tipo from traspaso where tipo = 'game';

insert into tipos(id_tipo,tipo)
SELECT  distinct 2, tipo from traspaso where tipo = 'hardware';
/*inserta datos a tabla categorias*/
insert into categorias(categoria)
select distinct split_text_to_rows(categorias,',') from traspaso;


/*inserto datos a tabla juegocategoria*/
insert into juegocategoria(id_app,id_categoria)

SELECT t.id_app,c.id_categorias 
FROM traspaso t 
inner JOIN categorias c 
ON c.categoria = ANY(STRING_TO_ARRAY(t.categorias, ','));


/*inserto datos a tabla juegotipo*/
insert into juegotipo(id_app,id_tipo)

SELECT t.id_app,ti.id_tipo 
FROM traspaso t 
inner JOIN tipos ti 
ON ti.tipo = t.tipo;


/*inserto datos a tabla juegolenguaje*/
insert into juegolenguaje(id_app,id_lenguaje)

SELECT t.id_app,l.id_lenguaje 
FROM traspaso t 
inner JOIN lenguajes l
ON l.lenguaje = ANY(STRING_TO_ARRAY(t.lenguajes, ','));


/*inserto datos tabla juegogenero*/
insert into juegogenero(id_app,id_genero)
SELECT t.id_app,g.id_genero 
FROM traspaso t 
inner JOIN generos g
ON g.genero = ANY(STRING_TO_ARRAY(t.genero, ','));

/*inserto datos tabla juegoplataforma*/
insert into juegoplataforma(id_app,id_plataforma)

SELECT t.id_app,p.id_plataforma 
FROM traspaso t 
inner JOIN plataformas p
ON p.plataforma = ANY(STRING_TO_ARRAY(t.plataformas, ','));

