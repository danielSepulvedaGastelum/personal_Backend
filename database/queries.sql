DROP TABLE IF EXISTS RESERVATIONS;
DROP TABLE IF EXISTS PETS;
DROP TABLE IF EXISTS USERS;
DROP TABLE IF EXISTS ROLES;

CREATE TABLE ROLES (
    RID VARCHAR(20) PRIMARY KEY,
    NOMBRE VARCHAR(50) NOT NULL UNIQUE,
    UNIDAD VARCHAR(20) NOT NULL CHECK (UNIDAD IN ('OOAD', 'UNIDAD'))
);

SELECT * FROM ROLES;

INSERT INTO ROLES (RID,NOMBRE,UNIDAD) VALUES ('ADMIN','ADMINISTRADOR DEL SSITEMA','OOAD');
INSERT INTO ROLES (RID,NOMBRE,UNIDAD) VALUES ('CONTROL','CONTROL DEL PROCESO ','OOAD');
INSERT INTO ROLES (RID,NOMBRE,UNIDAD) VALUES ('OPERATIVO','OPERADOR DEL SISTEMA EN OOAD ','OOAD');
INSERT INTO ROLES (RID,NOMBRE,UNIDAD) VALUES ('SECCION','JEFE DE SECCIÓN EN OOAD ','OOAD');
INSERT INTO ROLES (RID,NOMBRE,UNIDAD) VALUES ('OFICINA','JEFE DE OFICINA EN OOAD ','OOAD');
INSERT INTO ROLES (RID,NOMBRE,UNIDAD) VALUES ('DEPARTAMENTO','JEFE DE DEPARTAMENTO EN OOAD ','OOAD');
INSERT INTO ROLES (RID,NOMBRE,UNIDAD) VALUES ('SERVICIO','JEFE DE SERVICIO EN OOAD ','OOAD');
INSERT INTO ROLES (RID,NOMBRE,UNIDAD) VALUES ('OPERATIVO_UNIDAD','OPERADOR DEL SISTEMA EN UNIDAD','UNIDAD');
INSERT INTO ROLES (RID,NOMBRE,UNIDAD) VALUES ('OFICINA_UNIDAD','JEFE DE OFICINA EN UNIDAD','UNIDAD');
INSERT INTO ROLES (RID,NOMBRE,UNIDAD) VALUES ('DEPARTAMENTO_UNIDAD','JEFE DE DEPARTAMENTO EN UNIDAD','UNIDAD');
INSERT INTO ROLES (RID,NOMBRE,UNIDAD) VALUES ('ADMINISTRADOR_UNIDAD','ADMINISTRADOR EN UNIDAD','UNIDAD');
INSERT INTO ROLES (RID,NOMBRE,UNIDAD) VALUES ('DIRECTOR','DIRECTOR EN UNIDAD','UNIDAD');

SELECT * FROM ROLES;


CREATE TABLE USUARIOS (
	MATRICULA VARCHAR(20) PRIMARY KEY,
	PASSWORD VARCHAR(60) NOT NULL,
    NICKNAME VARCHAR(20) NOT NULL UNIQUE,
    NOMBRE VARCHAR(50) NOT NULL,
    APELLIDO1 VARCHAR(50) NOT NULL,
    APELLIDO2 VARCHAR(50) NOT NULL,
    EMAIL VARCHAR(60) NOT NULL UNIQUE,
    UNIDAD_TRABAJO VARCHAR(50) NOT NULL,
    SERVICIO VARCHAR(40) NULL,
    DEPARTAMENTO VARCHAR(40) NULL,
    OFICINA VARCHAR(40) NULL,
    SECCION VARCHAR(40) NULL,
    ROLE_ID VARCHAR(20) NOT NULL DEFAULT 'OPERATIVO',
    FOREIGN KEY (ROLE_ID) REFERENCES ROLES(RID)
);

SELECT * FROM USUARIOS;

INSERT INTO USUARIOS (MATRICULA,PASSWORD,NICKNAME,NOMBRE,APELLIDO1,APELLIDO2,EMAIL,UNIDAD_TRABAJO,SERVICIO,DEPARTAMENTO,OFICINA,SECCION,ROLE_ID)
    VALUES  ('311270027','123123','DANIEL','DANIEL','SEPULVEDA','GASTELUM','DANIEL.SEPULVEDA@IMSS.GOB.MX','OOAD','PERSONAL','PRESUPUESTO','CONTROL','PROCESOS','ADMIN'),
            ('99274577','123123','JULIAN','JULIAN','SANCHEZ','LOPEZ','JULIAN.SANCHEZ@IMSS.GOB.MX','OOAD','PERSONAL','PRESUPUESTO','CONTROL','PROCESOS','CONTROL'),
            ('99278356','123123','ISELA','ROSA ISELA','FUENTES','ACUÑA','ROSA.FUENTESA@IMSS.GOB.MX','OOAD','PERSONAL','PRESUPUESTO','CONTROL','PROCESOS','CONTROL'),
            ('99272594','123123','NITZA','NITZA NUBIA','FLORES','LASTRA','NITZA.FLORES@IMSS.GOB.MX','OOAD','PERSONAL',NULL,NULL, NULL,'SERVICIO'),
            ('10970088','123123','SELENE','OLGA SELENE','ENCINAS','MENDIVIL','OLGA.ENCINAS@IMSS.GOB.MX','OOAD','PERSONAL','PERSONAL',NULL, NULL,'DEPARTAMENTO'),
            ('99274742','123123','ANITA','ANA ROSA','ENRIQUEZ','CEDILLO','ANA.ENRIQUEZC@IMSS.GOB.MX','OOAD','PERSONAL','PERSONAL','FUERZA','PLANTILLAS','SECCION'),
            ('311270024','123123','CRISTINA','CLARA CRISTINA','CABADA','JACOBO','CLARA.CABADA@IMSS.GOB.MX','OOAD','PERSONAL','PERSONAL','FUERZA','PLANTILLAS','OPERATIVO'),
            ('99279914','123123','TERESITA','MARIA TERESA','NEVAREZ','ESQUER','MARIA.NEVAREZ@IMSS.GOB.MX','OOAD','PERSONAL','PERSONAL','FUERZA','APS','SECCION'),
            ('99270296','123123','MANUEL','MANUEL DE JESUS','RIVERA','ORTIZ','MANUEL.RIVERAO@IMSS.GOB.MX','OOAD','PERSONAL','PERSONAL','FUERZA','APS','OPERATIVO'),
            ('99273316','123123','JANETH','JANETH GABRIELA','REYES','MEZA','JANETH.REYES@IMSS.GOB.MX','OOAD','PERSONAL','PERSONAL','PRESTACIONES', NULL,'OFICINA'),
            ('11922621','123123','OMAR','OMAR','IBARRA','ANCIRA','OMAR.IBARRA@IMSS.GOB.MX','OOAD','PERSONAL','PERSONAL','PRESTACIONES','CREDITOS','SECCION'),
            ('11443529','123123','SERGIO','CARLOS SERGIO','SERVIN DE LA MORA','MURILLO','SERGIO.SERVIN@IMSS.GOB.MX','OOAD','PERSONAL','PERSONAL','PRESTACIONES','CREDITOS','OPERATIVO'),
            ('311270163','123123','ALEXIS','ALEXIS','VERDUGO','HERNANDEZ','ALEXIS.VERDUGO@IMSS.GOB.MX','OOAD','PERSONAL','PERSONAL','PRESTACIONES','RETIRO','SECCION'),
            ('99273348','123123','LULY','MARIA LOURDES','CEBALLOS','RAMOS','LOURDES.CEBALLOS@IMSS.GOB.MX','OOAD','PERSONAL','PERSONAL','PRESTACIONES','RETIRO','OPERATIVO'),
            ('99270478','123123','MARIELOS','MARIA DE LOS ANGELES','CABADA','ENCINAS','MARIA.CABADA@IMSS.GOB.MX','OOAD','PERSONAL','PERSONAL','DOTACION', NULL,'OFICINA'),
            ('99272593','123123','MARTIN','MARTIN','VALENZUELA','ARAGON','MARTIN.VALENZUELAA@IMSS.GOB.MX','OOAD','PERSONAL','PERSONAL','DOTACION','ESCALAFON','SECCION'),
            ('99271401','123123','LILA','LILA MARIA','CAMARENA','GARCIA','LILA.CAMARENA@IMSS.GOB.MX','OOAD','PERSONAL','PERSONAL','DOTACION','CONFIANZAS','SECCION');

SELECT * FROM USUARIOS;

CREATE TABLE PERFILES (
    PID VARCHAR(50) PRIMARY KEY,
    TITLE VARCHAR(100) NOT NULL,
    ICON VARCHAR(100),
    PATH VARCHAR(100),
    PARENT_ID VARCHAR(50),
    FOREIGN KEY (PARENT_ID) REFERENCES PERFILES(PID)
);

SELECT * FROM PERFILES;

INSERT INTO PERFILES (PID, TITLE, ICON, PATH, PARENT_ID) VALUES
('inicio',             'Inicio',                    'bi-house-fill',              '/inicio',              NULL),
('critica_calculo',    'Crítica de cálculo',        'bi-card-checklist',          NULL,                   NULL),
('ejecutar_calculos',  'Ejecutar Cálculos',         'bi-menu-button-wide',        '/calculos-ejecucion',  'critica_calculo'),
('activar_critica',    'Activar Crítica',           'bi-bookmark-check-fill',     '/calculos-activar',    'critica_calculo'),
('calculo_individual', 'Cálculos Individuales',     'bi-calculator-fill',         '/calculo-individual',  'critica_calculo'),
('solicitudes-calculos','Solicitudes calculos',     'bi-browser-safari',          '/calculos-pendientes', 'critica_calculo'),
('imprimir-calculos',  'Imprimir Solicitudes',      'bi-filetype-pdf',            '/imprimir-calculos',    'critica_calculo'),
('archivos',           'Archivos',                  'bi-files',                   NULL,                   NULL),
('archivo_calculos',   'Cargar Archivo Cálculos',   'bi-file-earmark-text-fill',  '/archivo-calculos',    'archivos'),
('archivo_maestro',    'Cargar Archivo Maestro',    'bi-file-earmark-person',     '/archivo-maestro',     'archivos'),
('usuarios',           'Usuarios',                  'bi-person-circle',           NULL,                   NULL),
('crud_usuarios',      'CRUD Usuarios',             'bi-person-fill-gear',        '/usuarios-CRUD',       'usuarios'),
('consulta_usuarios',  'Consulta',                  'bi-person-vcard-fill',       '/usuarios-consulta',   'usuarios'),
('contacto',           'Contacto',                  'bi-info-circle-fill',        '/contacto',            NULL);

SELECT * FROM PERFILES;


CREATE TABLE USUARIO_PERFILES (
    PID VARCHAR(20) NOT NULL,
    MATRICULA VARCHAR(20) NOT NULL,
    PRIMARY KEY (PID, MATRICULA),
    FOREIGN KEY (PID) REFERENCES PERFILES(PID),
    FOREIGN KEY (MATRICULA) REFERENCES USUARIOS(MATRICULA)
);

SELECT * FROM USUARIO_PERFILES;

INSERT INTO USUARIO_PERFILES (MATRICULA, PID) VALUES
('311270027', 'inicio'),
('311270027', 'critica_calculo'),
('311270027', 'ejecutar_calculos'),
('311270027', 'activar_critica'),
('311270027', 'archivos'),
('311270027', 'archivo_calculos'),
('311270027', 'archivo_maestro'),
('311270027', 'usuarios'),
('311270027', 'crud_usuarios'),
('311270027', 'consulta_usuarios'),
('311270027', 'contacto'),
('99274577', 'inicio'),
('99274577', 'critica_calculo'),
('99274577', 'ejecutar_calculos'),
('99274577', 'activar_critica'),
('99274577', 'archivos'),
('99274577', 'archivo_calculos'),
('99274577', 'archivo_maestro'),
('99274577', 'usuarios'),
('99274577', 'crud_usuarios'),
('99274577', 'consulta_usuarios'),
('99274577', 'contacto'),
('99278356', 'inicio'),
('99278356', 'critica_calculo'),
('99278356', 'ejecutar_calculos'),
('99278356', 'activar_critica'),
('99278356', 'archivos'),
('99278356', 'archivo_calculos'),
('99278356', 'archivo_maestro'),
('99278356', 'usuarios'),
('99278356', 'crud_usuarios'),
('99278356', 'consulta_usuarios'),
('99278356', 'contacto'),
('10970088', 'inicio'),
('10970088', 'critica_calculo'),
('10970088', 'calculo_individual'),
('10970088', 'solicitudes-calculos'),
('10970088', 'imprimir-calculos'),
('10970088', 'contacto'),
('99274742', 'inicio'),
('99274742', 'critica_calculo'),
('99274742', 'calculo_individual'),
('99274742', 'solicitudes-calculos'),
('99274742', 'imprimir-calculos'),
('99274742', 'contacto'),
('311270024', 'inicio'),
('311270024', 'critica_calculo'),
('311270024', 'calculo_individual'),
('311270024', 'solicitudes-calculos'),
('311270024', 'imprimir-calculos'),
('311270024', 'contacto'),
('99279914', 'inicio'),
('99279914', 'critica_calculo'),
('99279914', 'calculo_individual'),
('99279914', 'solicitudes-calculos'),
('99279914', 'imprimir-calculos'),
('99279914', 'contacto'),
('99270296', 'inicio'),
('99270296', 'critica_calculo'),
('99270296', 'calculo_individual'),
('99270296', 'solicitudes-calculos'),
('99270296', 'imprimir-calculos'),
('99270296', 'contacto'),
('99273316', 'inicio'),
('99273316', 'critica_calculo'),
('99273316', 'calculo_individual'),
('99273316', 'solicitudes-calculos'),
('99273316', 'imprimir-calculos'),
('99273316', 'contacto'),
('11922621', 'inicio'),
('11922621', 'critica_calculo'),
('11922621', 'calculo_individual'),
('11922621', 'solicitudes-calculos'),
('11922621', 'imprimir-calculos'),
('11922621', 'contacto'),
('11443529', 'inicio'),
('11443529', 'critica_calculo'),
('11443529', 'calculo_individual'),
('11443529', 'solicitudes-calculos'),
('11443529', 'imprimir-calculos'),
('11443529', 'contacto'),
('311270163', 'inicio'),
('311270163', 'critica_calculo'),
('311270163', 'calculo_individual'),
('311270163', 'solicitudes-calculos'),
('311270163', 'imprimir-calculos'),
('311270163', 'contacto'),
('99273348', 'inicio'),
('99273348', 'critica_calculo'),
('99273348', 'calculo_individual'),
('99273348', 'solicitudes-calculos'),
('99273348', 'imprimir-calculos'),
('99273348', 'contacto'),
('99270478', 'inicio'),
('99270478', 'contacto'),
('99272593', 'inicio'),
('99272593', 'contacto'),
('99271401', 'inicio'),
('99271401', 'contacto');

SELECT * FROM USUARIO_PERFILES;


            
           
            
            
           



SELECT * FROM USERS;

-- CREAR VÍA API:
-- admin@admin.com, vet_1@vet.com, client_1@client.com

-- ACTUALIZAR ROLE ADMIN
UPDATE USERS
SET ROLE_ID = 1
WHERE EMAIL = 'admin@admin.com';

-- VIDEO 3 PAGINACIÓN
SELECT * FROM USERS;
SELECT * FROM PETS;

-- verificar que tengas un usuario client y según su uid crear pets
-- CREAR PETS 21 PETS CON OWNER 3 (siempre y cuando exista el owner 3)
INSERT INTO pets (NAME, SPECIES, BREED, OWNER) VALUES
('Firulais', 'Perro', 'Labrador', 3),
('Mishi', 'Gato', 'Siames', 3),
('Milo', 'Perro', 'Chihuahua', 3),
('Molly', 'Perro', 'Pug', 3),
('Max', 'Perro', 'Pastor Aleman', 3),
('Luna', 'Perro', 'Labrador', 3),
('Bella', 'Perro', 'Labrador', 3),
('Daisy', 'Perro', 'Labrador', 3),
('Lucy', 'Perro', 'Labrador', 3),
('Cooper', 'Perro', 'Labrador', 3),
('Charlie', 'Perro', 'Labrador', 3),
('Rocky', 'Perro', 'Labrador', 3),
('Buddy', 'Perro', 'Labrador', 3),
('Lola', 'Perro', 'Labrador', 3),
('Sadie', 'Perro', 'Labrador', 3),
('Duke', 'Perro', 'Labrador', 3),
('Zoe', 'Perro', 'Labrador', 3),
('Stella', 'Perro', 'Labrador', 3),
('Penny', 'Perro', 'Labrador', 3),
('Ruby', 'Perro', 'Labrador', 3),
('Rosie', 'Perro', 'Labrador', 3);