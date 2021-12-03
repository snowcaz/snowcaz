/*=================================================================================================*/
  
--Crear usuarios
--Creacion de usuarios 
ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;
CREATE USER "USUARIO"
IDENTIFIED BY "1234" 
DEFAULT TABLESPACE users -- lugar de trabajo
TEMPORARY TABLESPACE temp -- carpeta temporal
QUOTA UNLIMITED ON users -- maximo de espacio que usa en el tablespace
PROFILE "Nombre del perfil";
--Poder conectar al usuario
GRANT CREATE SESSION TO "USUARIO";
--Creacion de ROL
CREATE PROFILE "PERFIL" LIMIT
SESSIONS_PER_USER "0" -- sesiones maxima abiertas
CONNECT_TIME "0" -- minutos maximo conectado
CONNECT_TIME  UNLIMITED -- sin limite de tiempo de conexion
IDLE_TIME "0" ;-- tiempo maximo de inactividad

-- ALTERAR USUARIOS OPCIONES
ALTER USER "usuario" IDENTIFIED BY "1234" 
ALTER USER "usuario" DEFAULT TABLESPACE users -- lugar de trabajo
ALTER USER "usuario" TEMPORARY TABLESPACE temp -- carpeta temporal
ALTER USER "usuario" QUOTA UNLIMITED ON users -- maximo de espacio que usa en el tablespace
ALTER USER "usuario" PROFILE "Nombre del perfil";

-- ALTERAR PERFILES
ALTER PROFILE SESSIONS_PER_USER "0" -- sesiones maxima abiertas
ALTER PROFILE CONNECT_TIME "0" -- minutos maximo conectado
ALTER PROFILE CONNECT_TIME  UNLIMITED -- sin limite de tiempo de conexion
ALTER PROFILE IDLE_TIME "0" ;-- tiempo maximo de inactividad

--ELIMINAR USUARIOS
DROP  USER "usuario" CASCADE -- el cascade permite eliminar todos los objetos del usuario

/*==================================================================================================*/
--Seguridad de Sistema: acceso y uso a nivel de sistema como                                         
--userName, pass, espacio de disco y operaciones a realizar en el sistema                          
----------PRIVILEGIOS DE SISTEMA DE LOS USUARIOS----------                                         
-- Conectar al base de datos                                                                       
CREATE SESSION                                                                                    
-- Crear tablas en el esquema del usuario                                                           
CREATE TABLE
--Crear vista en el esquema del usuario
CREATE VIEW
--CREAR VISTAS MATERIALIZADAS (LOS DATOS ESTAN GUARDADOS DE MANERA FISICA)
CREATE MATERIALIZED VIEW
-- CREAR SINONIMOS
CREATE SYNONYM 
--CREAR SEQUENCIA EN EL ESQUEMA DEL USUARIO
CREATE SEQUENCE
--CREAR USURIO
CREATE USER
--CREAR TIPOS DE INDICES
CREATE INDEXTYPE
--CREAR PROCEDIMIENTOS ALMACENADOS PL/SQL
CREATE PROCEDURE
-- CREAR TRIGERS PL/SQL
CREATE TRIGGER
--CREAR UNA CONEXION REMOTA A LA BASE DE DATOS
CREATE DATABASE LINK
--ELIMINAR TABLAS DE CUALQUIER ESQUEMA
DROP ANY TABLE
--LEER DATOS DE TABLAS DE CUALQUIER ESQUEMA
SELECT ANY TABLE
--INSERTAR DATOS D TABLAS DE CUALQUIER ESQUEMA
INSERT ANY TABLE
--ACTUALIZAR DATOS DE TABLAS DE CUALQUIER ESQUEMA
UPDATE ANY TABLE
--ELIMINAR DATOS DE TABLAS DE CUALQUIER ESQUEMA
DELETE ANY TABLE

----------OTORGAR PRIVILEGIOS DE SISTEMA----------
GRANT 'privilegio 1','privilegio 2','privilegio ETC'
TO 'usuario o rol_de_usuarios'
/*=================================================================================================*/
--Seguridad de datos
--Los privilegios de los objetos los dan
--dueño del objeto, el administrador de la base de datos o alguien que haya recibido este permiso explícitamente
----------PRIVILEGIOS DE OBJETOS DE LOS USUARIO----------
--Objeto TABLE
SELECT, READ, INSERT UPDATE, DELETE, ALTER, DEBUG FLASHBACK, ON COMMIT REFRESH, QUERY REWRITE, REFERENCES, ALL
--Objeto View: 
SELECT, INSERT, UPDATE, DELETE, UNDER, REFERENCES, FLASHBACK, DEBUG
--Objeto Sequence 
ALTER, SELECT
----Objeto Packages, Procedures, Functions (Clases Javas, otros programas): 
EXECUTE, DEBUG
--Objeto Materialized View: 
DELETE, FLASHBACK, INSERT, SELECT, UPDATE
--Objeto Directory: 
READ, WRITE
--Objeto Library:
EXECUTE
--Objeto Types: 
EXECUTE, DEBUG, UNDER
--Objeto Operator: 
EXECUTE
--Objeto Indextypes: 
EXECUTE

----------OTORGAR PRIVILEGIOS DE OBJETO----------
-- SOLO USAR UN GRANT por objeto
GRANT 'privilegio 1','privilegio 2' ('columnas si el objeto es una tabla o vista') -- los privilegios dependen del objeto
GRANT ALL -- entrega todos los privilegios del objeto
ON 'esquema_usuario/esquema_rol'.'objeto'  -- usuario/rol dueño del objeto . nombre
-- usar solo 1 TO usuario/rol ó TO PUBLIC
TO 'usuario/rol 1','usuario/rol 2'  -- usuario/rol que recibe los permisos
TO PUBLIC -- si los permisos son para todos los usuarios
WITH GRANT OPTION -- permite que los usuarios definidos en el TO puedan entregar los privilegios de GRANT al objeto puesto en el ON
----------OTORGAR PRIVILEGIOS DE OBJETO----------

REVOKE 'privilegio 1','privilegio 2' ('columnas si el objeto es una tabla o vista') -- los privilegios dependen del objeto
REVOKE ALL -- ELIMINAR todos los privilegios del objeto
ON 'esquema_usuario/esquema_rol'.'objeto'  -- usuario/rol dueño del objeto . nombre
-- usar solo 1 TO usuario/rol ó TO PUBLIC
FROM 'usuario/rol 1','usuario/rol 2' ; -- usuario/rol que deja de tener los permisos

--=========================================================================================
--CREACION DE VISTAS
CREATE OR REPLACE VIEW "VISTA"
(columna1DeLaVista,columna2DeLaVista) -- esto es opvional
AS "QUERY" -- query hace referencia a la consulta
WITH CHECK OPTION -- permite modificacion mientras no viole algo de la vista
WITH READ ONLY; --no permite modificaciones

--LAS VISTAS SE PUEDEN TENER UPGRADE O INSERT MIENTRAS SE CUMPLA ESTO WITH CHECK OPTION
--Eliminar VISTA
DROP VIEW "vista"
--=========================================================================================

-- SECUENCIAS
--Crear
CREATE SEQUENCE "secuencia"
INCREMENT BY numero -- cantidad que incrementa la secuencia
START WITH numero -- de donde parte
MAXVALUE numero -- valor maximo SI NO SE PONE MAXVALUE la seq no tiene maximo
MINVALUE numero -- valor minimo SI NO SE PONE MINVALUE la seq no tiene minimo
CYCLE -- si se repite la secuencia cuando llega al maximo, por defecto se usa el NOCYCLE
--Modificar
ALTER SEQUENCE  "secuencia"
INCREMENT BY numero -- cantidad que incrementa la secuencia
START WITH numero -- de donde parte
MAXVALUE numero -- valor maximo SI NO SE PONE MAXVALUE la seq no tiene maximo
MINVALUE numero -- valor minimo SI NO SE PONE MINVALUE la seq no tiene minimo
CYCLE -- si se repite la secuencia cuando llega al maximo, por defecto se usa el NOCYCLE

-- ELIMINAR
DROP SEQUENCE "secuencia"
-- uso de SECUENCIAS
"nombre de la sequencia".currval -- valor actual de la secuencia
"nombre de la sequencia".nextval -- valor siguiente de la secuencia
--=========================================================================================
--Sinonimos PRIVADO
CREATE OR REPLACE SYNONYM "esquema/usuario/rol dueño del objeto"."nombre del sinonimo"
FOR "esquema/usuario/rol que usara el objeto"."objeto que tendra el synonym"
--Sinonimos PUBLICO
CREATE OR REPLACE PUBLIC SYNONYM "nombre del sinonimo"
FOR objeto que tendra el synonym
--ELIMINAR Sinonimos PRIVADO
DROP SYNONYM "esquema/usuario/rol dueño del objeto"."nombre del sinonimo"
--ELIMINAR Sinonimos PRIVADO
DROP PUBLIC SYNONYM "nombre del sinonimo"
--=========================================================================================