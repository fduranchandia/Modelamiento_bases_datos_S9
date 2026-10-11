-- Generado por Oracle SQL Developer Data Modeler 24.3.1.351.0831
--   en:        2026-10-10 19:11:28 CLST
--   sitio:      Oracle Database 11g
--   tipo:      Oracle Database 11g



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE


-- ==========================================
-- ELIMINACION DE OBJETOS EXISTENTES
-- ==========================================

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE JUGADOR_IDIOMA CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -942 THEN RAISE; END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE HISTORIAL_CLUB CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -942 THEN RAISE; END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE JUGADOR CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -942 THEN RAISE; END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE PERSONAL_PLANTA CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -942 THEN RAISE; END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE TRABAJADOR CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -942 THEN RAISE; END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE ESCUELA_FUTBOL CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -942 THEN RAISE; END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE CLUB_FUTBOL CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -942 THEN RAISE; END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE COMUNA CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -942 THEN RAISE; END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE REGION CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -942 THEN RAISE; END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE ASOCIACION CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -942 THEN RAISE; END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE NACIONALIDAD CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -942 THEN RAISE; END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE IDIOMA CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -942 THEN RAISE; END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP SEQUENCE CLUB_FUTBOL_SEQ';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -2289 THEN RAISE; END IF;
END;
/
-- CREACION DE TABLAS

CREATE TABLE ASOCIACION 
    ( 
     id_asociacion     NUMBER (10)  NOT NULL , 
     nombre_asociacion VARCHAR2 (100)  NOT NULL , 
     fecha_creacion    DATE  NOT NULL , 
     tipo_asociacion   CHAR (1)  NOT NULL 
    ) 
;

ALTER TABLE ASOCIACION 
    ADD CONSTRAINT ASOCIACION_PK PRIMARY KEY ( id_asociacion ) ;
    
ALTER TABLE ASOCIACION
    ADD CONSTRAINT ASOCIACION_FECHA_CK
    CHECK (fecha_creacion >= DATE '1980-12-31');

CREATE TABLE CLUB_FUTBOL 
    ( 
     cod_club        NUMBER (10)  NOT NULL , 
     nombre_club     VARCHAR2 (100)  NOT NULL , 
     patrimonio      NUMBER (15)  NOT NULL , 
     ubicacion_calle VARCHAR2 (150)  NOT NULL 
    ) 
;

ALTER TABLE CLUB_FUTBOL 
    ADD CONSTRAINT CLUB_FUTBOL_PK PRIMARY KEY ( cod_club ) ;
    
ALTER TABLE CLUB_FUTBOL
    ADD (tipo_club VARCHAR2(20) DEFAULT 'Profesional' NOT NULL);
    
ALTER TABLE CLUB_FUTBOL
    ADD CONSTRAINT CLUB_FUTBOL_NOMBRE_UK UNIQUE (nombre_club);

ALTER TABLE CLUB_FUTBOL
    ADD CONSTRAINT CLUB_FUTBOL_TIPO_CK
    CHECK (tipo_club IN ('Profesional', 'Amateur'));

CREATE TABLE COMUNA 
    ( 
     id_comuna        NUMBER (10)  NOT NULL , 
     nombre_comuna    VARCHAR2 (100)  NOT NULL , 
     REGION_id_region NUMBER (10)  NOT NULL 
    ) 
;

ALTER TABLE COMUNA 
    ADD CONSTRAINT COMUNA_PK PRIMARY KEY ( id_comuna ) ;

CREATE TABLE ESCUELA_FUTBOL 
    ( 
     id_escuela      NUMBER (10)  NOT NULL , 
     nombre_escuela  VARCHAR2 (100)  NOT NULL , 
     capacidad       NUMBER (8)  NOT NULL , 
     fecha_fundacion DATE  NOT NULL 
    ) 
;

ALTER TABLE ESCUELA_FUTBOL 
    ADD CONSTRAINT ESCUELA_FUTBOL_PK PRIMARY KEY ( id_escuela ) ;

CREATE TABLE HISTORIAL_CLUB 
    ( 
     id_historial            NUMBER (10)  NOT NULL , 
     fecha_inicio            DATE  NOT NULL , 
     fecha_termino           DATE  NOT NULL , 
     JUGADOR_cod_inscripcion NUMBER (10)  NOT NULL , 
     CLUB_FUTBOL_cod_club    NUMBER (10)  NOT NULL 
    ) 
;

ALTER TABLE HISTORIAL_CLUB 
    ADD CONSTRAINT HISTORIAL_CLUB_PK PRIMARY KEY ( id_historial ) ;

CREATE TABLE IDIOMA 
    ( 
     id_idioma     NUMBER (10)  NOT NULL , 
     nombre_idioma VARCHAR2 (50)  NOT NULL 
    ) 
;

ALTER TABLE IDIOMA 
    ADD CONSTRAINT IDIOMA_PK PRIMARY KEY ( id_idioma ) ;

CREATE TABLE JUGADOR 
    ( 
     cod_inscripcion           NUMBER (10)  NOT NULL , 
     puesto                    VARCHAR2 (30)  NOT NULL , 
     premios_acumulados        NUMBER (12)  NOT NULL , 
     ESCUELA_FUTBOL_id_escuela NUMBER (10)  NOT NULL , 
     anio_fin_amateurismo      NUMBER (4) , 
     ASOCIACION_id_asociacion  NUMBER (10)  NOT NULL 
    ) 
;

ALTER TABLE JUGADOR 
    ADD CONSTRAINT JUGADOR_PK PRIMARY KEY ( cod_inscripcion ) ;

CREATE TABLE JUGADOR_IDIOMA 
    ( 
     JUGADOR_cod_inscripcion NUMBER (10)  NOT NULL , 
     IDIOMA_id_idioma        NUMBER (10)  NOT NULL , 
     nivel_dominio           VARCHAR2 (20)  NOT NULL 
    ) 
;

ALTER TABLE JUGADOR_IDIOMA 
    ADD CONSTRAINT JUGADOR_IDIOMA_PK PRIMARY KEY ( JUGADOR_cod_inscripcion, IDIOMA_id_idioma ) ;

CREATE TABLE NACIONALIDAD
(
    id_nacion NUMBER(10)
        GENERATED BY DEFAULT AS IDENTITY
        (START WITH 210 INCREMENT BY 2) NOT NULL,
    descripcion VARCHAR2(50) NOT NULL
);

ALTER TABLE NACIONALIDAD 
    ADD CONSTRAINT NACIONALIDAD_PK PRIMARY KEY ( id_nacion ) ;

CREATE TABLE PERSONAL_PLANTA 
    ( 
     cod_inscripcion           NUMBER (10)  NOT NULL , 
     cantidad_horas_trabajadas NUMBER (5) , 
     valor_horas_extras        NUMBER (12) 
    ) 
;

ALTER TABLE PERSONAL_PLANTA 
    ADD CONSTRAINT PERSONAL_PLANTA_PK PRIMARY KEY ( cod_inscripcion ) ;

CREATE TABLE REGION 
    ( 
     id_region     NUMBER (10)  NOT NULL , 
     nombre_region VARCHAR2 (100)  NOT NULL 
    ) 
;

ALTER TABLE REGION 
    ADD CONSTRAINT REGION_PK PRIMARY KEY ( id_region ) ;

CREATE TABLE TRABAJADOR 
    ( 
     cod_inscripcion    NUMBER (10)  NOT NULL , 
     rut                VARCHAR2 (8)  NOT NULL , 
     digito_verificador CHAR (1)  NOT NULL , 
     nombres            VARCHAR2 (60)  NOT NULL , 
     apellidos          VARCHAR2 (60)  NOT NULL , 
     sueldo_base        NUMBER (12)  NOT NULL , 
     fecha_nacimiento   DATE  NOT NULL , 
     genero             VARCHAR2 (20)  NOT NULL , 
     estado_civil       VARCHAR2 (20)  NOT NULL , 
     telefono_movil     VARCHAR2 (15)  NOT NULL , 
     direccion          VARCHAR2 (120)  NOT NULL , 
     COMUNA_id_comuna   NUMBER (10)  NOT NULL 
    ) 
;

ALTER TABLE TRABAJADOR 
    ADD CONSTRAINT TRABAJADOR_PK PRIMARY KEY ( cod_inscripcion ) ;

ALTER TABLE COMUNA 
    ADD CONSTRAINT COMUNA_REGION_FK FOREIGN KEY 
    ( 
     REGION_id_region
    ) 
    REFERENCES REGION 
    ( 
     id_region
    ) 
;

ALTER TABLE HISTORIAL_CLUB 
    ADD CONSTRAINT HISTORIAL_CLUB_CLUB_FUTBOL_FK FOREIGN KEY 
    ( 
     CLUB_FUTBOL_cod_club
    ) 
    REFERENCES CLUB_FUTBOL 
    ( 
     cod_club
    ) 
;

ALTER TABLE HISTORIAL_CLUB 
    ADD CONSTRAINT HISTORIAL_CLUB_JUGADOR_FK FOREIGN KEY 
    ( 
     JUGADOR_cod_inscripcion
    ) 
    REFERENCES JUGADOR 
    ( 
     cod_inscripcion
    ) 
;

ALTER TABLE JUGADOR 
    ADD CONSTRAINT JUGADOR_ASOCIACION_FK FOREIGN KEY 
    ( 
     ASOCIACION_id_asociacion
    ) 
    REFERENCES ASOCIACION 
    ( 
     id_asociacion
    ) 
;

ALTER TABLE JUGADOR 
    ADD CONSTRAINT JUGADOR_ESCUELA_FUTBOL_FK FOREIGN KEY 
    ( 
     ESCUELA_FUTBOL_id_escuela
    ) 
    REFERENCES ESCUELA_FUTBOL 
    ( 
     id_escuela
    ) 
;

ALTER TABLE JUGADOR_IDIOMA 
    ADD CONSTRAINT JUGADOR_IDIOMA_IDIOMA_FK FOREIGN KEY 
    ( 
     IDIOMA_id_idioma
    ) 
    REFERENCES IDIOMA 
    ( 
     id_idioma
    ) 
;

ALTER TABLE JUGADOR_IDIOMA 
    ADD CONSTRAINT JUGADOR_IDIOMA_JUGADOR_FK FOREIGN KEY 
    ( 
     JUGADOR_cod_inscripcion
    ) 
    REFERENCES JUGADOR 
    ( 
     cod_inscripcion
    ) 
;

ALTER TABLE JUGADOR 
    ADD CONSTRAINT JUGADOR_TRABAJADOR_FK FOREIGN KEY 
    ( 
     cod_inscripcion
    ) 
    REFERENCES TRABAJADOR 
    ( 
     cod_inscripcion
    ) 
;

ALTER TABLE PERSONAL_PLANTA 
    ADD CONSTRAINT PERSONAL_PLANTA_TRABAJADOR_FK FOREIGN KEY 
    ( 
     cod_inscripcion
    ) 
    REFERENCES TRABAJADOR 
    ( 
     cod_inscripcion
    ) 
;

ALTER TABLE TRABAJADOR 
    ADD CONSTRAINT TRABAJADOR_COMUNA_FK FOREIGN KEY 
    ( 
     COMUNA_id_comuna
    ) 
    REFERENCES COMUNA 
    ( 
     id_comuna
    ) 
;

CREATE SEQUENCE CLUB_FUTBOL_SEQ
    START WITH 703
    INCREMENT BY 4
    NOCACHE
    NOCYCLE;
    
-- Poblamiento de REGION
INSERT INTO REGION (id_region, nombre_region)
VALUES (1, 'ARICA Y PARINACOTA Y TARAPACA');

INSERT INTO REGION (id_region, nombre_region)
VALUES (2, 'ANTOFAGASTA');

INSERT INTO REGION (id_region, nombre_region)
VALUES (3, 'ATACAMA');

INSERT INTO REGION (id_region, nombre_region)
VALUES (5, 'VALPARAISO');

INSERT INTO REGION (id_region, nombre_region)
VALUES (8, 'BIOBIO');

INSERT INTO REGION (id_region, nombre_region)
VALUES (13, 'METROPOLITANA');

INSERT INTO REGION (id_region, nombre_region)
VALUES (16, 'ÑUBLE');

-- Poblamiento de COMUNA
INSERT INTO COMUNA (id_comuna, nombre_comuna, region_id_region)
VALUES (101, 'Santiago', 13);

INSERT INTO COMUNA (id_comuna, nombre_comuna, region_id_region)
VALUES (102, 'Valparaiso', 5);

INSERT INTO COMUNA (id_comuna, nombre_comuna, region_id_region)
VALUES (103, 'Concepcion', 8);

INSERT INTO COMUNA (id_comuna, nombre_comuna, region_id_region)
VALUES (104, 'Antofagasta', 2);

INSERT INTO COMUNA (id_comuna, nombre_comuna, region_id_region)
VALUES (105, 'Chillan', 16);

-- Poblamiento de ASOCIACION
INSERT INTO ASOCIACION (id_asociacion, nombre_asociacion, fecha_creacion, tipo_asociacion)
VALUES (25, 'Asociación de Fútbol de Santiago', DATE '2001-05-15', 'P');

INSERT INTO ASOCIACION (id_asociacion, nombre_asociacion, fecha_creacion, tipo_asociacion)
VALUES (26, 'Asociación Nacional de Fútbol Amateur', DATE '1998-03-10', 'A');

INSERT INTO ASOCIACION (id_asociacion, nombre_asociacion, fecha_creacion, tipo_asociacion)
VALUES (27, 'Asociación de Fútbol de Valparaiso', DATE '1987-07-21', 'P');

INSERT INTO ASOCIACION (id_asociacion, nombre_asociacion, fecha_creacion, tipo_asociacion)
VALUES (28, 'Asociación de Fútbol de Concepción', DATE '1995-11-30', 'A');

INSERT INTO ASOCIACION (id_asociacion, nombre_asociacion, fecha_creacion, tipo_asociacion)
VALUES (29, 'Asociación de Fútbol de Antofagasta', DATE '2003-06-25', 'P');

INSERT INTO ASOCIACION (id_asociacion, nombre_asociacion, fecha_creacion, tipo_asociacion)
VALUES (30, 'Asociación de Fútbol de Temuco', DATE '2010-01-12', 'A');

INSERT INTO ASOCIACION (id_asociacion, nombre_asociacion, fecha_creacion, tipo_asociacion)
VALUES (31, 'Asociación de Fútbol de Rancagua', DATE '1999-09-08', 'P');

INSERT INTO ASOCIACION (id_asociacion, nombre_asociacion, fecha_creacion, tipo_asociacion)
VALUES (32, 'Asociación de Fútbol de Puerto Montt', DATE '2005-04-20', 'A');

INSERT INTO ASOCIACION (id_asociacion, nombre_asociacion, fecha_creacion, tipo_asociacion)
VALUES (33, 'Asociación de Fútbol de La Serena', DATE '2012-08-14', 'P');

INSERT INTO ASOCIACION (id_asociacion, nombre_asociacion, fecha_creacion, tipo_asociacion)
VALUES (34, 'Asociación de Fútbol de Chillán', DATE '2018-12-01', 'A');

-- Poblamiento de NACIONALIDAD
INSERT INTO NACIONALIDAD (descripcion)
VALUES ('Chilena');

INSERT INTO NACIONALIDAD (descripcion)
VALUES ('Argentina');

INSERT INTO NACIONALIDAD (descripcion)
VALUES ('Peruana');

INSERT INTO NACIONALIDAD (descripcion)
VALUES ('Boliviana');

INSERT INTO NACIONALIDAD (descripcion)
VALUES ('Brasilena');

-- Poblamiento de CLUB_FUTBOL
INSERT INTO CLUB_FUTBOL
    (cod_club, nombre_club, patrimonio, ubicacion_calle, tipo_club)
VALUES
    (CLUB_FUTBOL_SEQ.NEXTVAL, 'Colo-Colo', 500000000,
     'Av. Maraton 5306', 'Profesional');

INSERT INTO CLUB_FUTBOL
    (cod_club, nombre_club, patrimonio, ubicacion_calle, tipo_club)
VALUES
    (CLUB_FUTBOL_SEQ.NEXTVAL, 'Universidad de Chile', 450000000,
     'Av. El Parron 0931', 'Profesional');

INSERT INTO CLUB_FUTBOL
    (cod_club, nombre_club, patrimonio, ubicacion_calle, tipo_club)
VALUES
    (CLUB_FUTBOL_SEQ.NEXTVAL, 'Deportes Antofagasta', 180000000,
     'Avenida Angamos 6606', 'Profesional');

INSERT INTO CLUB_FUTBOL
    (cod_club, nombre_club, patrimonio, ubicacion_calle, tipo_club)
VALUES
    (CLUB_FUTBOL_SEQ.NEXTVAL, 'Huachipato', 220000000,
     'Avenida Desiderio Garcia 909', 'Profesional');

INSERT INTO CLUB_FUTBOL
    (cod_club, nombre_club, patrimonio, ubicacion_calle, tipo_club)
VALUES
    (CLUB_FUTBOL_SEQ.NEXTVAL, 'Ñublense', 170000000,
     'Avenida Pedro Aguirre Cerda 1003', 'Profesional');
     
-- ==========================================
-- FASE 4: RECUPERACION DE DATOS
-- ==========================================

-- INFORME 1: Asociaciones de futbol profesional

SELECT *
FROM ASOCIACION
WHERE tipo_asociacion = 'P'
  AND fecha_creacion >= DATE '2001-01-01'
ORDER BY fecha_creacion DESC;


-- INFORME 2: Patrimonio de clubes de futbol

SELECT
    cod_club,
    nombre_club,
    patrimonio AS patrimonio_pesos,
    ROUND(patrimonio / 955, 2) AS patrimonio_dolares
FROM CLUB_FUTBOL
WHERE LOWER(nombre_club) LIKE '%a%'
  AND patrimonio > 200000000
  AND tipo_club = 'Profesional'
ORDER BY cod_club DESC;


--  ERROR: No Discriminator Column found in Arc FKArc_1 - constraint trigger for Arc cannot be generated 

--  ERROR: No Discriminator Column found in Arc FKArc_1 - constraint trigger for Arc cannot be generated



-- Informe de Resumen de Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                            12
-- CREATE INDEX                             0
-- ALTER TABLE                             22
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   2
-- WARNINGS                                 0
