#Este store procedure permite registrar la ejecución del procedimiento por la enfermera.
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
END