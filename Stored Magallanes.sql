#Este store procedure permite registrar la ejecución del procedimiento por la enfermera.
#como parametros de entrada estan el numero de prescripcion, la fecha en la que se administro, el enfermero ejecutor y el codigo del item administrado
CREATE DEFINER=`root`@`localhost` PROCEDURE `administrar_proc`(IN nr_sec_prescr INT,
									IN dt_administracion DATETIME,
                                    IN nr_enf_ejecutor INT,
                                    IN nr_item INT)
BEGIN
insert into items_adm
                (nr_sec_prescr,
                nr_enfer_ejecutor,
                tp_item,
                dt_administracion,
                ie_adm,
                nr_item)
		VALUES (nr_sec_prescr,
                nr_enf_ejecutor,
                1,
                dt_administracion,
                1,
                nr_item);
		COMMIT;
END;

#este store procedure permite seleccionar todas las prescripciones y ordenarlas de 6 maneras dependiendo de los parametros de entrada, que son:
#1:Permite ordenar por numero de secuencia de la prescripcion
#2:Permite ordenar por fecha de prescripcion
#3: Permite ordenar por el numero de secuencia del medico prescriptor
#'asc': ordena de manera ascendente y se combina con el otro parametro
#'desc': ordena de manera descendente y se combina con el otro parametro
 DEFINER=`root`@`localhost` PROCEDURE `selec_prescr`(IN tp_ordenamiento INT, IN asc_desc VARCHAR(250))
BEGIN
	IF tp_ordenamiento=1 and asc_desc='ASC'then 
		select* from prescr_medicas
		order by nr_secuencia_prescr ASC ;
	ELSEIF tp_ordenamiento=1 and asc_desc='DESC'then 
		select* from prescr_medicas
		order by nr_secuencia_prescr DESC;
	ELSEIF tp_ordenamiento=2 and asc_desc='ASC'then  
		select* from prescr_medicas
		order by dt_prescr ASC;
	ELSEIF tp_ordenamiento=2 and asc_desc='DESC'then  
		select* from prescr_medicas
		order by dt_prescr DESC;
	ELSEIF tp_ordenamiento=3 and asc_desc='ASC'then
		select* from prescr_medicas
		order by nr_medico_prescr ASC; 
	ELSEIF tp_ordenamiento=3 and asc_desc='DESC'then
		select* from prescr_medicas
		order by nr_medico_prescr DESC; 
	else select* from prescr_medicas;
END IF;
END;