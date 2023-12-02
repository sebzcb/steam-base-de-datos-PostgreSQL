
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