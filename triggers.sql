/*CREA TABLA CONTADOR JUEGO DESARROLLADOS POR LOS DESARROLLADORES*/
CREATE TABLE IF NOT EXISTS contadorJuegosDesarrollados (
	id_desarrollador integer,
    desarrollador character varying (300),
    cantJuegosDesarrollados integer, 
	PRIMARY KEY(id_desarrollador)
);
/*LLENA TABLA DE CONTADOR*/
insert into contadorJuegosDesarrollados(id_desarrollador,
desarrollador,cantJuegosDesarrollados )
SELECT d.id_desarrolladores, d.desarrollador, COUNT(jd.id_desarrollador) as num_juegos_desarrollados
FROM juegodesarrollador jd inner join desarrolladores d
ON jd.id_desarrollador = d.id_desarrolladores
GROUP BY d.desarrollador,d.id_desarrolladores;


/*funcion actualizar contador juegos desarrollados*/
CREATE OR REPLACE FUNCTION update_contador_juegos_desarrollados()
RETURNS TRIGGER AS $$
BEGIN
    IF (TG_OP = 'INSERT') THEN
        UPDATE contadorJuegosDesarrollados
        SET cantJuegosDesarrollados = cantJuegosDesarrollados + 1
        WHERE id_desarrollador = NEW.id_desarrollador;
		
    ELSIF (TG_OP = 'DELETE') THEN
        UPDATE contadorJuegosDesarrollados
        SET cantJuegosDesarrollados = cantJuegosDesarrollados - 1
        WHERE id_desarrollador = OLD.id_desarrollador;
    END IF;
	/*EN CASO QUE TG_OP = 'UPDATE' NO PASA NADA PORQUE NO SE AGREGA NI RESTA CANTIDAD DE TITULADOS*/
    RETURN NEW;
END;
$$
 LANGUAGE plpgsql;

/*SE CREA TRIGGER QUE VE SI SE INSERTA/ACTUALIZA/ELIMINA DATOS DE juegodesarrollador
actualizando el contador de juegos hechos por desarolladores*/
CREATE TRIGGER update_contador_juegos_desarrollados_trigger
AFTER INSERT OR UPDATE OR DELETE ON juegodesarrollador
FOR EACH ROW
EXECUTE FUNCTION update_contador_juegos_desarrollados();

/*ejemplo funcionamiento de trigger*/
select * from contadorJuegosDesarrollados where id_desarrollador = 36694;
insert into juegodesarrollador(id_app,id_desarrollador)
select 919190, 36694;
DELETE FROM juegodesarrollador
WHERE id_app = 919190 AND id_desarrollador = 36694;



/*juego bpulicador triggers*/

CREATE TABLE IF NOT EXISTS contadorJuegosPublicados (
	id_publicador integer,
    publicador character varying (300),
    cantJuegosPublicados integer, 
	PRIMARY KEY(id_publicador)
);

insert into contadorJuegosPublicados(id_publicador,
publicador,cantJuegosPublicados )
SELECT p.id_publicadores, p.publicador, COUNT(jp.id_publicador) as num_juegos_publicados
FROM juegopublicador jp inner join publicadores p
ON jp.id_publicador = p.id_publicadores
GROUP BY p.publicador,p.id_publicadores;



/*funcion actualizar contador juegos publicados*/
CREATE OR REPLACE FUNCTION update_contador_juegos_publicados()
RETURNS TRIGGER AS $$
BEGIN
    IF (TG_OP = 'INSERT') THEN
        UPDATE contadorJuegosPublicados
        SET cantJuegosPublicados = cantJuegosPublicados + 1
        WHERE id_publicador = NEW.id_publicador;
		
    ELSIF (TG_OP = 'DELETE') THEN
        UPDATE contadorJuegosPublicados
        SET cantJuegosPublicados = cantJuegosPublicados - 1
        WHERE id_publicador = OLD.id_publicador;
    END IF;
    RETURN NEW;
END;
$$
 LANGUAGE plpgsql;
 
/*SE CREA TRIGGER QUE VE SI SE INSERTA/ACTUALIZA/ELIMINA DATOS DE juegopublicador
actualizando el contador de juegos hechos por publicadores*/
CREATE TRIGGER update_contador_juegos_publicados_trigger
AFTER INSERT OR UPDATE OR DELETE ON juegopublicador
FOR EACH ROW
EXECUTE FUNCTION update_contador_juegos_publicados();




/*ejemplo funcional*/
select * from contadorJuegosPublicados where id_publicador = 44127;

insert into juegopublicador(id_app,id_publicador)
select 919190, 44127;

DELETE FROM juegodesarrollador
WHERE id_app = 919190 AND id_desarrollador = 44127;