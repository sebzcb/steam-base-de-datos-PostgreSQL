SELECT juego,reviews_negativas,fecha_salida
FROM juegos 
WHERE (reviews_negativas > 1000) 
AND EXTRACT(YEAR FROM fecha_salida) IN (2021, 2022)
ORDER BY reviews_negativas desc;


CREATE INDEX dx_rev_neg on juegos(reviews_negativas);
CREATE INDEX dx_fec_salida on juegos(fecha_salida);