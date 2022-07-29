USE base_rocio;
CREATE TABLE  personas(
nr_documento INT NOT NULL,
nr_secuencia INT NOT NULL AUTO_INCREMENT,
ds_nombre VARCHAR(50) NOT NULL,
ds_segundo_nombre VARCHAR (90),
ds_apellido VARCHAR(90) NOT NULL,
ds_calle VARCHAR(90),
nr_calle INT,
ds_barrio VARCHAR(90),
nr_codigo_postal VARCHAR(10),
ds_ciudad VARCHAR(90),
ds_pais VARCHAR(90),
nr_telefono INT, 
ds_email VARCHAR(90),
dt_nacimiento DATETIME (6) NOT NULL,
nr_edad INT,
PRIMARY KEY (nr_secuencia)
);
CREATE TABLE  enfermeros(
nr_secuencia INT NOT NULL,
nr_enfermero INT NOT NULL AUTO_INCREMENT,
ds_profesion VARCHAR(255) NOT NULL,
nr_matricula_p INT NOT NULL,
ds_provincia VARCHAR(90),
dt_matricula DATETIME (6) NOT NULL,
PRIMARY KEY (nr_enfermero),
FOREIGN KEY (nr_secuencia) references personas(nr_secuencia)
);
CREATE TABLE  medicos(
nr_secuencia INT NOT NULL,
nr_medico INT NOT NULL AUTO_INCREMENT,
ds_profesion VARCHAR(255) NOT NULL,
nr_matricula_p INT NOT NULL,
ds_provincia VARCHAR(90),
dt_matricula DATETIME (6) NOT NULL,
ds_especialidad VARCHAR(90),
nr_reg_esp VARCHAR(90),
PRIMARY KEY (nr_medico),
FOREIGN KEY (nr_secuencia) references personas(nr_secuencia)
);
CREATE TABLE  prescr_medicas(
nr_secuencia_prescr INT NOT NULL AUTO_INCREMENT,
nr_medico_prescr INT NOT NULL ,
nr_sec_paciente INT NOT NULL ,
nr_med_mat INT NOT NULL,
nr_procedimiento INT NOT NULL,
dt_prescr DATETIME (6) NOT NULL,
PRIMARY KEY (nr_secuencia_prescr),
FOREIGN KEY (nr_sec_paciente) references personas(nr_secuencia),
FOREIGN KEY (nr_medico_prescr) references medicos(nr_medico)
);
CREATE TABLE  items_adm (
nr_sec_adm INT NOT NULL AUTO_INCREMENT,
nr_sec_prescr INT NOT NULL ,
nr_enfer_ejecutor INT NOT NULL ,
tp_item INT NOT NULL,
dt_administracion DATETIME (6) NOT NULL,
ie_adm BOOLEAN, 
nr_item INT,
PRIMARY KEY (nr_sec_adm),
FOREIGN KEY (nr_sec_prescr) references prescr_medicas(nr_secuencia_prescr),
FOREIGN KEY (nr_enfer_ejecutor) references enfermeros(nr_enfermero)
);
CREATE TABLE  mat_medic (
nr_med_mat INT NOT NULL AUTO_INCREMENT,
ds_med_mat VARCHAR(255) NOT NULL, 
tp_item INT NOT NULL,
ie_situacion BOOLEAN, 
PRIMARY KEY (nr_med_mat)
);
CREATE TABLE  procedimientos (
nr_procedimientos INT NOT NULL AUTO_INCREMENT,
ds_proc VARCHAR(255) NOT NULL, 
tp_item INT NOT NULL,
ie_situacion BOOLEAN, 
PRIMARY KEY (nr_procedimientos)
);
