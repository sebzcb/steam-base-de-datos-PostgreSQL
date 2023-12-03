/*subquery 1*/
/* desarrolladores con los juegos desarrollados con mas reviews positivas en total
*/
SELECT d.desarrollador,
       (SELECT SUM(j.reviews_positivas) 
        FROM juegodesarrollador jd 
        INNER JOIN juegos j ON j.id_app = jd.id_app 
        WHERE jd.id_desarrollador = d.id_desarrolladores
) AS total_reviews_positivas
FROM desarrolladores d 
ORDER BY total_reviews_positivas DESC;







/*subquery 2*/

/* Calcula el promedio general de las reviews positivas de todos los juegos */
WITH avg_reviews AS (
    SELECT ROUND(AVG(reviews_positivas)) AS avg_positivas
    FROM juegos
),
/* Calcula el promedio de las reviews positivas de los juegos por cada desarrollador */
developer_avg_reviews AS (
    SELECT jd.id_desarrollador, ROUND(AVG(j.reviews_positivas)) AS avg_dev_positivas
    FROM juegodesarrollador jd 
    INNER JOIN juegos j ON j.id_app = jd.id_app 
    GROUP BY jd.id_desarrollador
)
/* Selecciona los desarrolladores cuyo promedio de reviews positivas es mayor que el promedio general */
SELECT d.desarrollador, dar.avg_dev_positivas, ar.avg_positivas
FROM developer_avg_reviews dar
INNER JOIN desarrolladores d ON dar.id_desarrollador = d.id_desarrolladores, avg_reviews ar
WHERE dar.avg_dev_positivas > ar.avg_positivas 
ORDER BY dar.avg_dev_positivas DESC;



/*COMPARACION DE CONSULTAS MISMOS RESULTADOS DISTINTAS SENTENCIAS*/



SELECT juego,reviews_negativas,fecha_salida
FROM juegos 
WHERE (reviews_negativas > 1000) 
AND EXTRACT(YEAR FROM fecha_salida) IN (2021, 2022)
ORDER BY reviews_negativas desc;


SELECT juego, reviews_negativas, fecha_salida
FROM (
    SELECT *
    FROM juegos
    WHERE reviews_negativas > 1000
) AS subquery
WHERE EXTRACT(YEAR FROM fecha_salida) > 2020 AND EXTRACT(YEAR FROM fecha_salida) < 2023
ORDER BY reviews_negativas DESC;
