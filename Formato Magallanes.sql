CREATE DEFINER=`root`@`localhost` FUNCTION `obtener_descripcion_procedimiento`(nr_item INT) RETURNS varchar(255) CHARSET utf8mb4
    NO SQL
BEGIN
    DECLARE descripcion VARCHAR(255);
	SELECT  p.ds_proc 
    into descripcion
    from items_adm i,
    procedimientos p
    where i.nr_item=nr_item
    and i.nr_item=p.nr_procedimientos;
RETURN descripcion;
END;

CREATE DEFINER=`root`@`localhost` FUNCTION `obtener_nombre`(nr_persona INT) RETURNS varchar(255) CHARSET utf8mb4
    NO SQL
BEGIN
	DECLARE nombre VARCHAR(255);
	SELECT concat(ds_apellido,', ',ds_nombre,' ',ifnull(ds_segundo_nombre,''))
    into nombre
    from personas 
    where nr_secuencia=nr_persona;
RETURN nombre;
END;