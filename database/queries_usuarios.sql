DROP TABLE IF EXISTS USUARIO_CATALOGO_MENUS;
DROP TABLE IF EXISTS USUARIO_CATALOGO_PERFILES;
DROP TABLE IF EXISTS USUARIO_MENUS;
DROP TABLE IF EXISTS USUARIO_ROLES;
DROP TABLE IF EXISTS USUARIOS;
DROP TABLE IF EXISTS USUARIO_PERFILES;


----------------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE USUARIO_CATALOGO_MENUS (
  CMID VARCHAR(20) NOT NULL,        -- ID del menú (ej. ADMINISTRADOR)
  NOMBRE VARCHAR(50) NOT NULL  ,    -- Descripción del menu
  PRIMARY KEY (CMID)
);

SELECT * FROM USUARIO_CATALOGO_MENUS;

INSERT INTO USUARIO_CATALOGO_MENUS (CMID, NOMBRE) VALUES
('ADMINISTRADOR', 'Administrador del Sistema'),
('CONTROL_PROCESO', 'Oficina de Control del proceso'),
('DEPTO_PERSONAL', 'Departamento de Personal');

SELECT * FROM USUARIO_CATALOGO_MENUS;







----------------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE USUARIO_CATALOGO_PERFILES (
    CPID VARCHAR(50) PRIMARY KEY,
    TITLE VARCHAR(100) NOT NULL,
    ICON VARCHAR(100),
    PATH VARCHAR(100)
);

SELECT * FROM USUARIO_CATALOGO_PERFILES;

INSERT INTO USUARIO_CATALOGO_PERFILES (CPID, TITLE, ICON, PATH) VALUES
('inicio',             'Inicio',                    'bi-house-fill',              '/inicio'),
('critica_calculo',    'Crítica de cálculo',        'bi-card-checklist',          NULL),
('ejecutar_calculos',  'Ejecutar Cálculos',         'bi-menu-button-wide',        '/calculos-ejecucion'),
('activar_critica',    'Activar Crítica',           'bi-bookmark-check-fill',     '/calculos-activar'),
('calculo_individual', 'Cálculos Individuales',     'bi-calculator-fill',         '/calculo-individual'),
('solicitudes-calculos','Solicitudes calculos',     'bi-browser-safari',          '/calculos-pendientes'),
('imprimir-calculos',  'Imprimir Solicitudes',      'bi-filetype-pdf',            '/imprimir-calculos'),
('archivos',           'Archivos',                  'bi-files',                   NULL),
('archivo_calculos',   'Cargar Archivo Cálculos',   'bi-file-earmark-text-fill',  '/archivo-calculos'),
('archivo_maestro',    'Cargar Archivo Maestro',    'bi-file-earmark-person',     '/archivo-maestro'),
('usuarios',           'Usuarios',                  'bi-person-circle',           NULL),
('crud_usuarios',      'CRUD Usuarios',             'bi-person-fill-gear',        '/usuarios-CRUD'),
('consulta_usuarios',  'Consulta',                  'bi-person-vcard-fill',       '/usuarios-consulta'),
('contacto',           'Contacto',                  'bi-info-circle-fill',        '/contacto');

SELECT * FROM USUARIO_CATALOGO_PERFILES;








----------------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE USUARIO_MENUS (
  MID VARCHAR(50) NOT NULL,         -- ID del menú (ej. ADMINISTRADOR)
  PID VARCHAR(50) NOT NULL,         -- ID del perfil (ej. inicio, contacto)
  ORDEN INT NOT NULL,               -- Orden en que aparecerá el menú
  PARENT_PID VARCHAR(50),           -- Nodo padre si es submenu, puede ser NULL
  PRIMARY KEY (MID, PID),
  FOREIGN KEY (MID) REFERENCES USUARIO_CATALOGO_MENUS(CMID),
  FOREIGN KEY (PID) REFERENCES USUARIO_CATALOGO_PERFILES(CPID),
  FOREIGN KEY (PARENT_PID) REFERENCES USUARIO_CATALOGO_PERFILES(CPID)
);

SELECT * FROM USUARIO_MENUS;

-- MENÚ ADMINISTRADOR
INSERT INTO USUARIO_MENUS (MID, PID, ORDEN, PARENT_PID) VALUES ('ADMINISTRADOR', 'inicio', 1, NULL);
INSERT INTO USUARIO_MENUS (MID, PID, ORDEN, PARENT_PID) VALUES ('ADMINISTRADOR', 'critica_calculo', 2, NULL);
INSERT INTO USUARIO_MENUS (MID, PID, ORDEN, PARENT_PID) VALUES ('ADMINISTRADOR', 'ejecutar_calculos', 3, 'critica_calculo');
INSERT INTO USUARIO_MENUS (MID, PID, ORDEN, PARENT_PID) VALUES ('ADMINISTRADOR', 'activar_critica', 4, 'critica_calculo');
INSERT INTO USUARIO_MENUS (MID, PID, ORDEN, PARENT_PID) VALUES ('ADMINISTRADOR', 'archivos', 5, NULL);
INSERT INTO USUARIO_MENUS (MID, PID, ORDEN, PARENT_PID) VALUES ('ADMINISTRADOR', 'archivo_calculos', 6, 'archivos');
INSERT INTO USUARIO_MENUS (MID, PID, ORDEN, PARENT_PID) VALUES ('ADMINISTRADOR', 'archivo_maestro', 7, 'archivos');
INSERT INTO USUARIO_MENUS (MID, PID, ORDEN, PARENT_PID) VALUES ('ADMINISTRADOR', 'usuarios', 8, NULL);
INSERT INTO USUARIO_MENUS (MID, PID, ORDEN, PARENT_PID) VALUES ('ADMINISTRADOR', 'crud_usuarios', 9, 'usuarios');
INSERT INTO USUARIO_MENUS (MID, PID, ORDEN, PARENT_PID) VALUES ('ADMINISTRADOR', 'consulta_usuarios', 10, 'usuarios');
INSERT INTO USUARIO_MENUS (MID, PID, ORDEN, PARENT_PID) VALUES ('ADMINISTRADOR', 'contacto', 11, NULL);
            
-- MENÚ CONTROL_PROCESO
INSERT INTO USUARIO_MENUS (MID, PID, ORDEN, PARENT_PID) VALUES ('CONTROL_PROCESO', 'inicio', 1, NULL);
INSERT INTO USUARIO_MENUS (MID, PID, ORDEN, PARENT_PID) VALUES ('CONTROL_PROCESO', 'critica_calculo', 2, NULL);
INSERT INTO USUARIO_MENUS (MID, PID, ORDEN, PARENT_PID) VALUES ('CONTROL_PROCESO', 'ejecutar_calculos', 3, 'critica_calculo');
INSERT INTO USUARIO_MENUS (MID, PID, ORDEN, PARENT_PID) VALUES ('CONTROL_PROCESO', 'activar_critica', 4, 'critica_calculo');
INSERT INTO USUARIO_MENUS (MID, PID, ORDEN, PARENT_PID) VALUES ('CONTROL_PROCESO', 'archivos', 5, NULL);
INSERT INTO USUARIO_MENUS (MID, PID, ORDEN, PARENT_PID) VALUES ('CONTROL_PROCESO', 'archivo_calculos', 6, 'archivos');
INSERT INTO USUARIO_MENUS (MID, PID, ORDEN, PARENT_PID) VALUES ('CONTROL_PROCESO', 'archivo_maestro', 7, 'archivos');
INSERT INTO USUARIO_MENUS (MID, PID, ORDEN, PARENT_PID) VALUES ('CONTROL_PROCESO', 'usuarios', 8, NULL);
INSERT INTO USUARIO_MENUS (MID, PID, ORDEN, PARENT_PID) VALUES ('CONTROL_PROCESO', 'crud_usuarios', 9, 'usuarios');
INSERT INTO USUARIO_MENUS (MID, PID, ORDEN, PARENT_PID) VALUES ('CONTROL_PROCESO', 'consulta_usuarios', 10, 'usuarios');
INSERT INTO USUARIO_MENUS (MID, PID, ORDEN, PARENT_PID) VALUES ('CONTROL_PROCESO', 'contacto', 11, NULL);

-- MENÚ DEPTO_PERSONAL
INSERT INTO USUARIO_MENUS (MID, PID, ORDEN, PARENT_PID) VALUES ('DEPTO_PERSONAL', 'inicio', 1, NULL);
INSERT INTO USUARIO_MENUS (MID, PID, ORDEN, PARENT_PID) VALUES ('DEPTO_PERSONAL', 'critica_calculo', 2, NULL);
INSERT INTO USUARIO_MENUS (MID, PID, ORDEN, PARENT_PID) VALUES ('DEPTO_PERSONAL', 'calculo_individual', 3, 'critica_calculo');
INSERT INTO USUARIO_MENUS (MID, PID, ORDEN, PARENT_PID) VALUES ('DEPTO_PERSONAL', 'solicitudes-calculos', 4, 'critica_calculo');
INSERT INTO USUARIO_MENUS (MID, PID, ORDEN, PARENT_PID) VALUES ('DEPTO_PERSONAL', 'imprimir-calculos', 5, 'critica_calculo');
INSERT INTO USUARIO_MENUS (MID, PID, ORDEN, PARENT_PID) VALUES ('DEPTO_PERSONAL', 'contacto', 6, NULL);
           
SELECT * FROM USUARIO_MENUS;







----------------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE USUARIO_ROLES (
    RID VARCHAR(20) PRIMARY KEY,
    NOMBRE VARCHAR(50) NOT NULL UNIQUE,
    UNIDAD VARCHAR(20) NOT NULL CHECK (UNIDAD IN ('OOAD', 'UNIDAD')),
    MENU_ID VARCHAR(20) NULL,
    FOREIGN KEY (MENU_ID) REFERENCES USUARIO_CATALOGO_MENUS(CMID)
);

SELECT * FROM USUARIO_ROLES;

INSERT INTO USUARIO_ROLES (RID,NOMBRE,UNIDAD,MENU_ID) VALUES ('ADMIN','ADMINISTRADOR DEL SSITEMA','OOAD','ADMINISTRADOR');
INSERT INTO USUARIO_ROLES (RID,NOMBRE,UNIDAD,MENU_ID) VALUES ('CONTROL','CONTROL DEL PROCESO ','OOAD','CONTROL_PROCESO');
INSERT INTO USUARIO_ROLES (RID,NOMBRE,UNIDAD,MENU_ID) VALUES ('OPERATIVO','OPERADOR DEL SISTEMA EN OOAD ','OOAD','DEPTO_PERSONAL');
INSERT INTO USUARIO_ROLES (RID,NOMBRE,UNIDAD,MENU_ID) VALUES ('SECCION','JEFE DE SECCIÓN EN OOAD ','OOAD','DEPTO_PERSONAL');
INSERT INTO USUARIO_ROLES (RID,NOMBRE,UNIDAD,MENU_ID) VALUES ('OFICINA','JEFE DE OFICINA EN OOAD ','OOAD','DEPTO_PERSONAL');
INSERT INTO USUARIO_ROLES (RID,NOMBRE,UNIDAD,MENU_ID) VALUES ('DEPARTAMENTO','JEFE DE DEPARTAMENTO EN OOAD ','OOAD','DEPTO_PERSONAL');
INSERT INTO USUARIO_ROLES (RID,NOMBRE,UNIDAD,MENU_ID) VALUES ('SERVICIO','JEFE DE SERVICIO EN OOAD ','OOAD','DEPTO_PERSONAL');
INSERT INTO USUARIO_ROLES (RID,NOMBRE,UNIDAD,MENU_ID) VALUES ('OPERATIVO_UNIDAD','OPERADOR DEL SISTEMA EN UNIDAD','UNIDAD',NULL);
INSERT INTO USUARIO_ROLES (RID,NOMBRE,UNIDAD,MENU_ID) VALUES ('OFICINA_UNIDAD','JEFE DE OFICINA EN UNIDAD','UNIDAD',NULL);
INSERT INTO USUARIO_ROLES (RID,NOMBRE,UNIDAD,MENU_ID) VALUES ('DEPARTAMENTO_UNIDAD','JEFE DE DEPARTAMENTO EN UNIDAD','UNIDAD',NULL);
INSERT INTO USUARIO_ROLES (RID,NOMBRE,UNIDAD,MENU_ID) VALUES ('ADMINISTRADOR_UNIDAD','ADMINISTRADOR EN UNIDAD','UNIDAD',NULL);
INSERT INTO USUARIO_ROLES (RID,NOMBRE,UNIDAD,MENU_ID) VALUES ('DIRECTOR','DIRECTOR EN UNIDAD','UNIDAD',NULL);

SELECT * FROM USUARIO_ROLES;








----------------------------------------------------------------------------------------------------------------------------------------------
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
    CREADO_EN TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    ULTIMO_CAMBIO_PASSWORD TIMESTAMP NULL,
    ULTIMA_MODIFICACION TIMESTAMP NULL,
    FOREIGN KEY (ROLE_ID) REFERENCES USUARIO_ROLES(RID)
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





----------------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE USUARIO_PERFILES (
    PID VARCHAR(20) NOT NULL,
    MATRICULA VARCHAR(20) NOT NULL,
    PRIMARY KEY (PID, MATRICULA),
    FOREIGN KEY (PID) REFERENCES USUARIO_CATALOGO_PERFILES(CPID),
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