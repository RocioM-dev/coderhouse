CREATE DEFINER=`root`@`localhost` FUNCTION `obtener_nombre`(nr_persona INT) RETURNS varchar(255) CHARSET utf8mb4
    NO SQL
BEGIN
	DECLARE nombre VARCHAR(255);
	SELECT concat(ds_apellido,', ',ds_nombre,' ',ifnull(ds_segundo_nombre,''))
    into nombre
    from personas 
    where nr_secuencia=nr_persona;
RETURN nombre;
END