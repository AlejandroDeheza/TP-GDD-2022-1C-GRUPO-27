USE GD1C2022
GO

-- Eliminacion de tablas
CREATE PROCEDURE borrar_tablas
AS
BEGIN 	
	IF OBJECT_ID('AJO_DER.[cambio_neumaticos]','U') IS NOT NULL
		DROP TABLE AJO_DER.[cambio_neumaticos]

	IF OBJECT_ID('AJO_DER.[parada_box]','U') IS NOT NULL
		DROP TABLE AJO_DER.[parada_box]

	IF OBJECT_ID('AJO_DER.[incidente_auto]','U') IS NOT NULL
		DROP TABLE AJO_DER.[incidente_auto]

	IF OBJECT_ID('AJO_DER.[tipo_incidente]','U') IS NOT NULL
		DROP TABLE AJO_DER.[tipo_incidente]

	IF OBJECT_ID('AJO_DER.[incidente]','U') IS NOT NULL
		DROP TABLE AJO_DER.[incidente]

	IF OBJECT_ID('AJO_DER.[bandera]','U') IS NOT NULL
		DROP TABLE AJO_DER.[bandera]

	IF OBJECT_ID('AJO_DER.[estado_de_caja_de_cambios]','U') IS NOT NULL
		DROP TABLE AJO_DER.[estado_de_caja_de_cambios]

	IF OBJECT_ID('AJO_DER.[estado_neumatico]','U') IS NOT NULL
		DROP TABLE AJO_DER.[estado_neumatico]

	IF OBJECT_ID('AJO_DER.[estado_freno]','U') IS NOT NULL
		DROP TABLE AJO_DER.[estado_freno]

	IF OBJECT_ID('AJO_DER.[estado_de_motor]','U') IS NOT NULL
		DROP TABLE AJO_DER.[estado_de_motor]

	IF OBJECT_ID('AJO_DER.[freno]','U') IS NOT NULL
		DROP TABLE AJO_DER.[freno]

	IF OBJECT_ID('AJO_DER.[motor]','U') IS NOT NULL
		DROP TABLE AJO_DER.[motor]

	IF OBJECT_ID('AJO_DER.[caja_de_cambios]','U') IS NOT NULL
		DROP TABLE AJO_DER.[caja_de_cambios]

	IF OBJECT_ID('AJO_DER.[medicion]','U') IS NOT NULL
		DROP TABLE AJO_DER.[medicion]

	IF OBJECT_ID('AJO_DER.[sector]','U') IS NOT NULL
		DROP TABLE AJO_DER.[sector]

	IF OBJECT_ID('AJO_DER.[Tipo_sector]','U') IS NOT NULL
		DROP TABLE AJO_DER.[Tipo_sector]


	IF OBJECT_ID('AJO_DER.[carrera]','U') IS NOT NULL
		DROP TABLE AJO_DER.[carrera]

	IF OBJECT_ID('AJO_DER.[circuito]','U') IS NOT NULL
		DROP TABLE AJO_DER.[circuito]

	IF OBJECT_ID('AJO_DER.[neumatico]','U') IS NOT NULL
		DROP TABLE AJO_DER.[neumatico]

	IF OBJECT_ID('AJO_DER.[tipo_neumatico]','U') IS NOT NULL
		DROP TABLE AJO_DER.[tipo_neumatico]
	

	IF OBJECT_ID('AJO_DER.[auto]','U') IS NOT NULL
		DROP TABLE AJO_DER.[auto]


	IF OBJECT_ID('AJO_DER.[escuderia]','U') IS NOT NULL
		DROP TABLE AJO_DER.[escuderia]

	IF OBJECT_ID('AJO_DER.[posicion]','U') IS NOT NULL
		DROP TABLE AJO_DER.[posicion]

	IF OBJECT_ID('AJO_DER.[piloto]','U') IS NOT NULL
		DROP TABLE AJO_DER.[piloto]

	IF OBJECT_ID('AJO_DER.[pais]','U') IS NOT NULL
		DROP TABLE AJO_DER.[pais]

	IF OBJECT_ID('AJO_DER.[nacionalidad]','U') IS NOT NULL
		DROP TABLE AJO_DER.[nacionalidad]
END
GO

-- Eliminacion de esquema
IF EXISTS (SELECT SCHEMA_NAME FROM INFORMATION_SCHEMA.SCHEMATA WHERE SCHEMA_NAME = 'AJO_DER')
    DROP SCHEMA AJO_DER
GO

-- Creacion de esquema
CREATE SCHEMA AJO_DER;
GO

-- Creacion de tablas
CREATE PROCEDURE crear_tablas
AS
BEGIN
CREATE TABLE AJO_DER.parada_box (
    id INT NOT NULL IDENTITY PRIMARY KEY,
	id_carrera INT, -- FK
    id_auto INT, -- FK
    numero_vuelta DECIMAL(18,0),
	tiempo_parada DECIMAL(18,2)
);

CREATE TABLE AJO_DER.cambio_neumaticos (
    id INT NOT NULL IDENTITY PRIMARY KEY,
	id_parada_box INT, -- FK
    id_neumatico_anterior INT, -- FK
    id_neumatico_nuevo INT, -- FK
	id_posicion INT -- FK
);

CREATE TABLE AJO_DER.auto (
    id INT NOT NULL IDENTITY PRIMARY KEY,
    id_escuderia INT, -- FK
    id_piloto INT, -- FK
    numero_auto INT,
	modelo VARCHAR(10)
);

CREATE TABLE AJO_DER.posicion (
    id INT NOT NULL IDENTITY PRIMARY KEY,
	descripcion VARCHAR(10)
);

CREATE TABLE AJO_DER.escuderia (
    id INT NOT NULL IDENTITY PRIMARY KEY,
    nombre VARCHAR(10),
    id_nacionalidad INT -- FK
);

CREATE TABLE AJO_DER.piloto (
    id INT NOT NULL IDENTITY PRIMARY KEY,
    id_nacionalidad INT, -- FK
    nombre VARCHAR(10),
	apellido VARCHAR(10),
	fecha_nacimiento DATETIME
);

CREATE TABLE AJO_DER.nacionalidad (
    id INT NOT NULL IDENTITY PRIMARY KEY,
    nombre VARCHAR(50)
);

CREATE TABLE AJO_DER.motor (
    id INT NOT NULL IDENTITY PRIMARY KEY,
	id_auto INT -- FK
);

CREATE TABLE AJO_DER.caja_de_cambios (
    id INT NOT NULL IDENTITY PRIMARY KEY,
	id_auto INT -- FK
);

CREATE TABLE AJO_DER.freno (
    id INT NOT NULL IDENTITY PRIMARY KEY,
	id_auto INT -- FK
);

CREATE TABLE AJO_DER.neumatico (
    id INT NOT NULL IDENTITY PRIMARY KEY,
	id_auto INT, -- FK
	id_tipo_neumatico INT -- FK
);

CREATE TABLE AJO_DER.tipo_neumatico (
    id INT NOT NULL IDENTITY PRIMARY KEY,
	tipo VARCHAR(10)
);

CREATE TABLE AJO_DER.estado_de_motor (
    id INT NOT NULL IDENTITY PRIMARY KEY,
	id_medicion INT, -- FK
	id_motor INT, -- FK
	potencia DECIMAL,
	temperatura_aceite DECIMAL,
	temperatura_agua DECIMAL,
	rpm INT
);

CREATE TABLE AJO_DER.estado_de_caja_de_cambios (
    id INT NOT NULL IDENTITY PRIMARY KEY,
	id_medicion INT, -- FK
	id_caja_de_cambios INT, -- FK
	temperatura_aceite DECIMAL,
	temperatura_agua DECIMAL,
	rpm INT,
	desgaste DECIMAL
);

CREATE TABLE AJO_DER.bandera (
	id INT NOT NULL IDENTITY PRIMARY KEY,
	color VARCHAR
);

CREATE TABLE AJO_DER.tipo_incidente (
	id INT NOT NULL IDENTITY PRIMARY KEY,
	tipo VARCHAR
);

CREATE TABLE AJO_DER.incidente (
	id INT NOT NULL IDENTITY PRIMARY KEY,
	id_carrera INT, -- FK
	id_sector INT, -- FK
	id_bandera INT, -- FK
	tiempo DECIMAL,
	fecha DATETIME
);

CREATE TABLE AJO_DER.incidente_auto (
	id_incidente INT, -- FK
	id_auto INT, -- FK
	id_tipo_incidente INT, -- FK
	numero_vuelta INT
);

CREATE TABLE AJO_DER.sector (
	id INT NOT NULL IDENTITY PRIMARY KEY,
	id_circuito INT, -- FK
	id_tipo_sector INT, -- FK
	distancia DECIMAL(18,2),
	codigo INT
);

CREATE TABLE AJO_DER.tipo_sector (
	id INT NOT NULL IDENTITY PRIMARY KEY,
	tipo VARCHAR(255)
);

CREATE TABLE AJO_DER.pais (
	id INT NOT NULL IDENTITY PRIMARY KEY,
	nombre VARCHAR(255)
);

CREATE TABLE AJO_DER.circuito (
	id INT NOT NULL IDENTITY PRIMARY KEY,
	id_pais INT, -- FK
	codigo INT,
	nombre VARCHAR(255)
);

CREATE TABLE AJO_DER.medicion (
	id INT NOT NULL IDENTITY PRIMARY KEY,
	id_auto INT, -- FK
	id_carrera INT, -- FK
	id_sector INT, -- FK
	nro_vuelta DECIMAL(18,0),
	distancia_carrera DECIMAL(18,6),
	distancia_vuelta DECIMAL(18,2),
	tiempo_vuelta DECIMAL(18,10),
	posicion DECIMAL(18,0),
	velocidad DECIMAL(18,2),
	cant_combustible DECIMAL(18,2)
);

CREATE TABLE AJO_DER.carrera (
	id INT NOT NULL IDENTITY PRIMARY KEY,
	id_circuito INT, -- FK
	cant_vueltas INT,
	fecha DATE,
	codigo INT,
	clima VARCHAR(100),
	total_carrera DECIMAL(18,2)
);

CREATE TABLE AJO_DER.estado_freno (
	id INT NOT NULL IDENTITY PRIMARY KEY,
	id_medicion INT, -- FK
	id_freno INT, -- FK
	id_posicion INT, -- FK
	grosor_pastilla DECIMAL,
	temperatura DECIMAL
);

CREATE TABLE AJO_DER.estado_neumatico (
	id INT NOT NULL IDENTITY PRIMARY KEY,
	id_medicion INT, -- FK
	id_neumatico INT, -- FK
	id_posicion INT, -- FK
	profundidad DECIMAL,
	presion DECIMAL,
	temperatura DECIMAL
);

	-- FKs de parada_box
	ALTER TABLE AJO_DER.parada_box ADD FOREIGN KEY(id_carrera) REFERENCES AJO_DER.carrera(id);
	ALTER TABLE AJO_DER.parada_box ADD FOREIGN KEY(id_auto) REFERENCES AJO_DER.auto(id);

	-- FKs de cambio_neumaticos
	ALTER TABLE AJO_DER.cambio_neumaticos ADD FOREIGN KEY(id_parada_box) REFERENCES AJO_DER.parada_box(id);
	ALTER TABLE AJO_DER.cambio_neumaticos ADD FOREIGN KEY(id_neumatico_anterior) REFERENCES AJO_DER.neumatico(id);
	ALTER TABLE AJO_DER.cambio_neumaticos ADD FOREIGN KEY(id_neumatico_nuevo) REFERENCES AJO_DER.neumatico(id);
	ALTER TABLE AJO_DER.cambio_neumaticos ADD FOREIGN KEY(id_posicion) REFERENCES AJO_DER.posicion(id);

	-- FKs de auto
	ALTER TABLE AJO_DER.auto ADD FOREIGN KEY(id_escuderia) REFERENCES AJO_DER.escuderia(id);
	ALTER TABLE AJO_DER.auto ADD FOREIGN KEY(id_piloto) REFERENCES AJO_DER.piloto(id);

	-- FKs de posicion
	-- N/A

	-- FKs de escuderia
	ALTER TABLE AJO_DER.escuderia ADD FOREIGN KEY(id_nacionalidad) REFERENCES AJO_DER.nacionalidad(id);

	-- FKs de piloto
	ALTER TABLE AJO_DER.piloto ADD FOREIGN KEY(id_nacionalidad) REFERENCES AJO_DER.nacionalidad(id);

	-- FKs de nacionalidad
	-- N/A

	-- FKs de motor
	ALTER TABLE AJO_DER.motor ADD FOREIGN KEY(id_auto) REFERENCES AJO_DER.auto(id);

	-- FKs de caja_de_cambios
	ALTER TABLE AJO_DER.caja_de_cambios ADD FOREIGN KEY(id_auto) REFERENCES AJO_DER.auto(id);

	-- FKs de freno
	ALTER TABLE AJO_DER.freno ADD FOREIGN KEY(id_auto) REFERENCES AJO_DER.auto(id);

	-- FKs de neumatico
	ALTER TABLE AJO_DER.neumatico ADD FOREIGN KEY(id_auto) REFERENCES AJO_DER.auto(id);
	ALTER TABLE AJO_DER.neumatico ADD FOREIGN KEY(id_tipo_neumatico) REFERENCES AJO_DER.tipo_neumatico(id);

	-- FKs de tipo_neumatico
	-- N/A

	-- FKs de estado_de_motor
	ALTER TABLE AJO_DER.estado_de_motor ADD FOREIGN KEY(id_medicion) REFERENCES AJO_DER.medicion(id);
	ALTER TABLE AJO_DER.estado_de_motor ADD FOREIGN KEY(id_motor) REFERENCES AJO_DER.motor(id);

	-- FKs de estado_de_caja_de_cambios
	ALTER TABLE AJO_DER.estado_de_caja_de_cambios ADD FOREIGN KEY(id_medicion) REFERENCES AJO_DER.medicion(id);
	ALTER TABLE AJO_DER.estado_de_caja_de_cambios ADD FOREIGN KEY(id_caja_de_cambios) REFERENCES AJO_DER.caja_de_cambios(id);

	-- FKs de bandera
	-- N/A

	-- FKs de tipo_incidente
	-- N/A

	-- FKs de incidente
	ALTER TABLE AJO_DER.incidente ADD FOREIGN KEY(id_carrera) REFERENCES AJO_DER.carrera(id);
	ALTER TABLE AJO_DER.incidente ADD FOREIGN KEY(id_sector) REFERENCES AJO_DER.sector(id);
	ALTER TABLE AJO_DER.incidente ADD FOREIGN KEY(id_bandera) REFERENCES AJO_DER.bandera(id);

	-- FKs de incidente_auto
	ALTER TABLE AJO_DER.incidente_auto ADD FOREIGN KEY(id_incidente) REFERENCES AJO_DER.incidente(id);
	ALTER TABLE AJO_DER.incidente_auto ADD FOREIGN KEY(id_auto) REFERENCES AJO_DER.auto(id);
	ALTER TABLE AJO_DER.incidente_auto ADD FOREIGN KEY(id_tipo_incidente) REFERENCES AJO_DER.tipo_incidente(id);

	-- FKs de sector
	ALTER TABLE AJO_DER.sector ADD FOREIGN KEY(id_circuito) REFERENCES AJO_DER.circuito(id);
	ALTER TABLE AJO_DER.sector ADD FOREIGN KEY(id_tipo_sector) REFERENCES AJO_DER.tipo_sector(id);

	-- FKs de tipo_sector
	-- N/A

	-- FKs de pais
	-- N/A

	-- FKs de circuito
	ALTER TABLE AJO_DER.circuito ADD FOREIGN KEY(id_pais) REFERENCES AJO_DER.pais(id);

	-- FKs de medicion
	ALTER TABLE AJO_DER.medicion ADD FOREIGN KEY(id_auto) REFERENCES AJO_DER.auto(id);
	ALTER TABLE AJO_DER.medicion ADD FOREIGN KEY(id_carrera) REFERENCES AJO_DER.carrera(id);
	ALTER TABLE AJO_DER.medicion ADD FOREIGN KEY(id_sector) REFERENCES AJO_DER.sector(id);

	-- FKs de carrera
	ALTER TABLE AJO_DER.carrera ADD FOREIGN KEY(id_circuito) REFERENCES AJO_DER.circuito(id);

	-- FKs de estado_freno
	ALTER TABLE AJO_DER.estado_freno ADD FOREIGN KEY(id_medicion) REFERENCES AJO_DER.medicion(id);
	ALTER TABLE AJO_DER.estado_freno ADD FOREIGN KEY(id_freno) REFERENCES AJO_DER.freno(id);
	ALTER TABLE AJO_DER.estado_freno ADD FOREIGN KEY(id_posicion) REFERENCES AJO_DER.posicion(id);

	-- FKs de estado_neumatico
	ALTER TABLE AJO_DER.estado_neumatico ADD FOREIGN KEY(id_medicion) REFERENCES AJO_DER.medicion(id);
	ALTER TABLE AJO_DER.estado_neumatico ADD FOREIGN KEY(id_neumatico) REFERENCES AJO_DER.neumatico(id);
	ALTER TABLE AJO_DER.estado_neumatico ADD FOREIGN KEY(id_posicion) REFERENCES AJO_DER.posicion(id);
END

-- STORED PROCEDURES para migraciones
-- Migrar tipo_sector
GO

CREATE PROCEDURE migrar_tipo_sector
AS
BEGIN
	INSERT INTO tipo_sector(tipo)
	SELECT DISTINCT SECTO_TIPO FROM GD1C2022.gd_esquema.Maestra
		WHERE SECTO_TIPO IS NOT NULL
END

-- Migrar pais
GO
CREATE PROCEDURE migrar_pais
AS
BEGIN
	INSERT INTO pais(nombre)
	SELECT DISTINCT CIRCUITO_PAIS FROM GD1C2022.gd_esquema.Maestra
		WHERE CIRCUITO_PAIS IS NOT NULL
END

-- Migrar circuito
GO
CREATE PROCEDURE migrar_circuito
AS
BEGIN
	INSERT INTO circuito(
		id_pais,
		codigo,
		nombre
	)
	SELECT DISTINCT pais.id, CIRCUITO_CODIGO, CIRCUITO_NOMBRE FROM GD1C2022.gd_esquema.Maestra
		JOIN pais ON GD1C2022.gd_esquema.Maestra.CIRCUITO_PAIS = pais.nombre
		GROUP BY pais.id, CIRCUITO_CODIGO, CIRCUITO_NOMBRE
		ORDER BY CIRCUITO_CODIGO
END

-- Migrar sector
GO
CREATE PROCEDURE migrar_sector
AS
BEGIN
	INSERT INTO sector(
		id_circuito,
		id_tipo_sector,
		distancia,
		codigo
	)
	SELECT DISTINCT circuito.id, tipo_sector.id, SECTOR_DISTANCIA, CODIGO_SECTOR FROM GD1C2022.gd_esquema.Maestra
		JOIN circuito ON GD1C2022.gd_esquema.Maestra.CIRCUITO_CODIGO = circuito.codigo
		JOIN tipo_sector ON GD1C2022.gd_esquema.Maestra.SECTO_TIPO = tipo_sector.tipo
		GROUP BY circuito.id, tipo_sector.id, SECTOR_DISTANCIA, CODIGO_SECTOR
		ORDER BY circuito.id, CODIGO_SECTOR, tipo_sector.id
END

-- Migrar carrera
GO
CREATE PROCEDURE migrar_carrera
AS
BEGIN
	INSERT INTO carrera(
		id_circuito,
		cant_vueltas,
		fecha,
		codigo,
		clima,
		total_carrera
	)
	SELECT DISTINCT circuito.id, CARRERA_CANT_VUELTAS, CARRERA_FECHA, CODIGO_CARRERA, CARRERA_CLIMA, CARRERA_TOTAL_CARRERA FROM GD1C2022.gd_esquema.Maestra
		JOIN circuito ON GD1C2022.gd_esquema.Maestra.CIRCUITO_CODIGO = circuito.codigo
		GROUP BY circuito.id, CARRERA_CANT_VUELTAS, CARRERA_FECHA, CODIGO_CARRERA, CARRERA_CLIMA, CARRERA_TOTAL_CARRERA
		ORDER BY CODIGO_CARRERA
END

-- Migrar medicion
GO
CREATE PROCEDURE migrar_medicion
AS
BEGIN
	INSERT INTO medicion(
		id_auto,
		id_carrera,
		id_sector,
		nro_vuelta,
		distancia_carrera,
		distancia_vuelta,
		tiempo_vuelta,
		posicion,
		velocidad,
		cant_combustible
	)
	SELECT DISTINCT auto.id, carrera.id, sector.id, TELE_AUTO_NUMERO_VUELTA, TELE_AUTO_DISTANCIA_CARRERA, TELE_AUTO_DISTANCIA_VUELTA, TELE_AUTO_TIEMPO_VUELTA, TELE_AUTO_POSICION, TELE_AUTO_VELOCIDAD, TELE_AUTO_COMBUSTIBLE FROM GD1C2022.gd_esquema.Maestra
		JOIN escuderia ON GD1C2022.gd_esquema.Maestra.ESCUDERIA_NOMBRE = escuderia.nombre
		JOIN auto ON GD1C2022.gd_esquema.Maestra.AUTO_NUMERO = auto.numero_auto
		JOIN carrera ON GD1C2022.gd_esquema.Maestra.CODIGO_CARRERA = carrera.codigo
		JOIN sector ON GD1C2022.gd_esquema.Maestra.CODIGO_SECTOR = sector.codigo
		GROUP BY auto.id, carrera.id, sector.id, TELE_AUTO_NUMERO_VUELTA, TELE_AUTO_DISTANCIA_CARRERA, TELE_AUTO_DISTANCIA_VUELTA, TELE_AUTO_TIEMPO_VUELTA, TELE_AUTO_POSICION, TELE_AUTO_VELOCIDAD, TELE_AUTO_COMBUSTIBLE
		ORDER BY carrera.id, auto.id, TELE_AUTO_DISTANCIA_CARRERA
END

-- Migrar parada_box
GO
CREATE PROCEDURE migrar_parada_box
AS
BEGIN
	INSERT INTO parada_box(
		id_carrera,
		id_auto,
		numero_vuelta,
		tiempo_parada
	)
	SELECT DISTINCT carrera.id, auto.id, PARADA_BOX_VUELTA, PARADA_BOX_TIEMPO FROM GD1C2022.gd_esquema.Maestra
		JOIN carrera ON GD1C2022.gd_esquema.Maestra.CODIGO_CARRERA = carrera.codigo
		JOIN escuderia ON GD1C2022.gd_esquema.Maestra.ESCUDERIA_NOMBRE = escuderia.nombre
		JOIN auto ON GD1C2022.gd_esquema.Maestra.AUTO_NUMERO = auto.numero_auto
		GROUP BY carrera.id, auto.id, PARADA_BOX_VUELTA, PARADA_BOX_TIEMPO
		ORDER BY carrera.id, auto.id, PARADA_BOX_VUELTA
END

-- Migrar cambio_neumaticos
-- Pendiente

EXEC migrar_tipo_sector
EXEC migrar_pais
EXEC migrar_circuito
EXEC migrar_sector
EXEC migrar_carrera
EXEC migrar_medicion
EXEC migrar_parada_box