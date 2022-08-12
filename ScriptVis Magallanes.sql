USE base_rocio;
CREATE OR REPLACE VIEW MEDICOS_VIEW  AS 
select p.nr_secuencia,
m.nr_medico,
concat(p.ds_apellido,', ',p.ds_nombre,' ',ifnull(p.ds_segundo_nombre,'')) nombre_completo,
p.nr_documento,
m.ds_profesion,
m.ds_especialidad,
m.nr_matricula_p,
m.nr_reg_esp
from medicos m,
personas p
where p.nr_secuencia=m.nr_secuencia;

SELECT*FROM MEDICOS_VIEW;

CREATE OR REPLACE VIEW ENFERMEROS_VIEW  AS
SELECT p.nr_secuencia,
concat(p.ds_apellido,', ',p.ds_nombre,' ',ifnull(p.ds_segundo_nombre,'')) nombre_completo,
e.nr_enfermero,
p.nr_documento,
e.ds_profesion, 
e.nr_matricula_p
from personas p, 
enfermeros e
where p.nr_secuencia=e.nr_secuencia;

SELECT*FROM ENFERMEROS_VIEW;

CREATE OR REPLACE VIEW PRESCRIPCIONES_VIEW  AS 
select x.nr_secuencia_prescr,
x.dt_prescr,
p.nr_documento,
concat(p.ds_apellido,', ',p.ds_nombre,' ',ifnull(p.ds_segundo_nombre,'')) nm_paciente,
concat('Dr/a. ', mv.nombre_completo) nm_med_prescr,
concat('Mat. ',mv.nr_matricula_p) matricula,
x.nr_procedimientos,
x.ds_proc
FROM (SELECT* 
FROM prescr_medicas pm JOIN PROCEDIMIENTOS P on pm.nr_procedimiento=p.nr_procedimientos
union all
SELECT* 
FROM prescr_medicas pm JOIN mat_medic m on pm.nr_med_mat=m.nr_med_mat) x,
medicos_view mv, 
personas p
WHERE x.nr_medico_prescr=mv.nr_medico
and x.nr_sec_paciente=p.nr_secuencia
ORDER BY x.nr_secuencia_prescr, x.dt_prescr;

SELECT* FROM PRESCRIPCIONES_VIEW;

CREATE OR REPLACE VIEW ITEMS_ADM_VIEW AS
select x.nr_sec_prescr,
x.dt_administracion,
concat(p.ds_apellido,', ',p.ds_nombre,' ',ifnull(p.ds_segundo_nombre,'')) nm_paciente,
p.nr_documento dni,
x.ds_med_mat,
if(x.ie_adm=1, 'Administrado', 'Pendiente de administración') situacion,
concat('Enf. ', ev.nombre_completo) ejecutor,
concat('Mat. ', ev.nr_matricula_p) matricula
from adm_med_proc x,
personas p,
enfermeros_view ev,
prescr_medicas pm
where x.nr_enfer_ejecutor=ev.nr_enfermero
and x.nr_sec_prescr=pm.nr_secuencia_prescr
and pm.nr_sec_paciente=p.nr_secuencia;

SELECT* FROM ITEMS_ADM_VIEW;

CREATE OR REPLACE VIEW CANTIDADES_HISTORICAS_ADM AS
SELECT distinct count(ia.nr_item) cantidad_adm ,
ia.nr_item codigo,
iav.ds_med_mat item
FROM ITEMS_ADM_VIEW iav,
items_adm ia
where ia.nr_sec_prescr=iav.nr_sec_prescr
group by  ia.nr_item;

SELECT* FROM CANTIDADES_HISTORICAS_ADM;

CREATE OR REPLACE VIEW adm_med_proc as 
select ia.nr_sec_adm,
ia.nr_sec_prescr,
ia.nr_enfer_ejecutor,
ia.dt_administracion,
ia.ie_adm,
ia.nr_item,
mm.ds_med_mat
from items_adm ia,
mat_medic mm
where  ia.nr_item=mm.nr_med_mat
union all
select ia.nr_sec_adm,
ia.nr_sec_prescr,
ia.nr_enfer_ejecutor,
ia.dt_administracion,
ia.ie_adm,
ia.nr_item,
p.ds_proc
from items_adm ia,
procedimientos p
where ia.nr_item=p.nr_procedimientos;

select* from adm_med_proc;