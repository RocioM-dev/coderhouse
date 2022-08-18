CREATE DEFINER=`root`@`localhost` PROCEDURE `selec_prescr`(IN tp_ordenamiento INT, IN asc_desc VARCHAR(250))
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
END