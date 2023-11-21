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
