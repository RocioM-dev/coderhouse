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
END