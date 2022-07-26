USE GD1C2022
GO

-- Eliminacion de tablas si existen
IF EXISTS(SELECT name FROM sys.tables WHERE name LIKE 'BI_FACT_medicion')
	DROP TABLE AJO_DER.BI_FACT_medicion

IF EXISTS(SELECT name FROM sys.tables WHERE name LIKE 'BI_FACT_parada_box')
	DROP TABLE AJO_DER.BI_FACT_parada_box

IF EXISTS(SELECT name FROM sys.tables WHERE name LIKE 'BI_FACT_incidente_auto')
	DROP TABLE AJO_DER.BI_FACT_incidente_auto

IF EXISTS(SELECT name FROM sys.tables WHERE name LIKE 'BI_DIM_auto')
	DROP TABLE AJO_DER.BI_DIM_auto

IF EXISTS(SELECT name FROM sys.tables WHERE name LIKE 'BI_DIM_piloto')
	DROP TABLE AJO_DER.BI_DIM_piloto

IF EXISTS(SELECT name FROM sys.tables WHERE name LIKE 'BI_DIM_escuderia')
	DROP TABLE AJO_DER.BI_DIM_escuderia

IF EXISTS(SELECT name FROM sys.tables WHERE name LIKE 'BI_DIM_circuito')
	DROP TABLE AJO_DER.BI_DIM_circuito

IF EXISTS(SELECT name FROM sys.tables WHERE name LIKE 'BI_DIM_tipo_neumatico')
	DROP TABLE AJO_DER.BI_DIM_tipo_neumatico

IF EXISTS(SELECT name FROM sys.tables WHERE name LIKE 'BI_DIM_tipo_incidente')
	DROP TABLE AJO_DER.BI_DIM_tipo_incidente

IF EXISTS(SELECT name FROM sys.tables WHERE name LIKE 'BI_DIM_tipo_sector')
	DROP TABLE AJO_DER.BI_DIM_tipo_sector

IF EXISTS(SELECT name FROM sys.tables WHERE name LIKE 'BI_DIM_tiempo')
	DROP TABLE AJO_DER.BI_DIM_tiempo
GO


-- Eliminacion de vistas si existen
IF OBJECT_ID('AJO_DER.BI_desgaste_promedio_componentes_cada_auto_x_vuelta_x_circuito') IS NOT NULL
	DROP VIEW AJO_DER.BI_desgaste_promedio_componentes_cada_auto_x_vuelta_x_circuito

IF OBJECT_ID('AJO_DER.BI_mejor_tiempo_de_vuelta_de_cada_escuderia') IS NOT NULL
	DROP VIEW AJO_DER.BI_mejor_tiempo_de_vuelta_de_cada_escuderia

IF OBJECT_ID('AJO_DER.BI_circuitos_con_mayor_consumo_de_combustible_promedio') IS NOT NULL
	DROP VIEW AJO_DER.BI_circuitos_con_mayor_consumo_de_combustible_promedio

IF OBJECT_ID('AJO_DER.BI_maxima_velocidad_alcanzada_por_cada_auto') IS NOT NULL
	DROP VIEW AJO_DER.BI_maxima_velocidad_alcanzada_por_cada_auto

IF OBJECT_ID('AJO_DER.BI_tiempo_promedio_que_tardo_cada_escuderia') IS NOT NULL
	DROP VIEW AJO_DER.BI_tiempo_promedio_que_tardo_cada_escuderia

IF OBJECT_ID('AJO_DER.BI_cantidad_de_paradas_por_circuito') IS NOT NULL
	DROP VIEW AJO_DER.BI_cantidad_de_paradas_por_circuito

IF OBJECT_ID('AJO_DER.BI_circuitos_con_mayor_tiempo_en_paradas') IS NOT NULL
	DROP VIEW AJO_DER.BI_circuitos_con_mayor_tiempo_en_paradas

IF OBJECT_ID('AJO_DER.BI_circuitos_mas_peligrosos_del_anio') IS NOT NULL
	DROP VIEW AJO_DER.BI_circuitos_mas_peligrosos_del_anio

IF OBJECT_ID('AJO_DER.BI_promedio_incidentes_escuderia_anio_tipo_de_sector') IS NOT NULL
	DROP VIEW AJO_DER.BI_promedio_incidentes_escuderia_anio_tipo_de_sector
GO


-- Eliminacion de funciones si existen
IF OBJECT_ID('AJO_DER.BI_obtener_cuatrimestre') IS NOT NULL
	DROP FUNCTION AJO_DER.BI_obtener_cuatrimestre

IF OBJECT_ID('AJO_DER.BI_primer_tipo_neumatico') IS NOT NULL
	DROP FUNCTION AJO_DER.BI_primer_tipo_neumatico

IF OBJECT_ID('AJO_DER.BI_obtener_tiempos_de_vuelta') IS NOT NULL
	DROP FUNCTION AJO_DER.BI_obtener_tiempos_de_vuelta

IF OBJECT_ID('AJO_DER.BI_obtener_Consumo_x_Auto') IS NOT NULL
	DROP FUNCTION AJO_DER.BI_obtener_Consumo_x_Auto

IF OBJECT_ID('AJO_DER.BI_ranking_incidentes_x_Circuito_x_anio') IS NOT NULL
	DROP FUNCTION AJO_DER.BI_ranking_incidentes_x_Circuito_x_anio

IF OBJECT_ID('AJO_DER.BI_cantidad_incidentes') IS NOT NULL
	DROP FUNCTION AJO_DER.BI_cantidad_incidentes
GO


-- Eliminacion de indices si existen
IF EXISTS(SELECT name FROM sys.indexes WHERE name LIKE 'BI_IDX_medicion_1')
	DROP INDEX BI_IDX_medicion_1 ON AJO_DER.estado_de_motor
GO

IF EXISTS(SELECT name FROM sys.indexes WHERE name LIKE 'BI_IDX_medicion_2')
	DROP INDEX BI_IDX_medicion_2 ON AJO_DER.estado_de_caja_de_cambios
GO

IF EXISTS(SELECT name FROM sys.indexes WHERE name LIKE 'BI_IDX_medicion_3')
	DROP INDEX BI_IDX_medicion_3 ON AJO_DER.estado_freno
GO

IF EXISTS(SELECT name FROM sys.indexes WHERE name LIKE 'BI_IDX_medicion_4')
	DROP INDEX BI_IDX_medicion_4 ON AJO_DER.estado_neumatico
GO

IF EXISTS(SELECT name FROM sys.indexes WHERE name LIKE 'BI_IDX_auto')
	DROP INDEX BI_IDX_auto ON AJO_DER.medicion
GO

IF EXISTS(SELECT name FROM sys.indexes WHERE name LIKE 'BI_IDX_sector')
	DROP INDEX BI_IDX_sector ON AJO_DER.medicion
GO


-- Creacion de tablas
CREATE TABLE AJO_DER.BI_DIM_auto (
	id INT IDENTITY PRIMARY KEY,
	modelo NVARCHAR(255),
	numero_auto INT
);

CREATE TABLE AJO_DER.BI_DIM_piloto(
	id INT IDENTITY PRIMARY KEY,
	nombre NVARCHAR(50),
	apellido NVARCHAR(50),
);

CREATE TABLE AJO_DER.BI_DIM_escuderia(
	id INT IDENTITY PRIMARY KEY,
	nombre NVARCHAR(255),
);

CREATE TABLE AJO_DER.BI_DIM_circuito(
	id INT IDENTITY PRIMARY KEY,
	nombre NVARCHAR(255),
);

CREATE TABLE AJO_DER.BI_DIM_tipo_neumatico (
	id INT IDENTITY PRIMARY KEY,
	tipo NVARCHAR(255)
);

CREATE TABLE AJO_DER.BI_DIM_tipo_incidente (
	id INT IDENTITY PRIMARY KEY,
	tipo NVARCHAR(255)
);

CREATE TABLE AJO_DER.BI_DIM_tipo_sector (
	id INT IDENTITY PRIMARY KEY,
	tipo NVARCHAR(255)
);

CREATE TABLE AJO_DER.BI_DIM_tiempo(
	id INT IDENTITY PRIMARY KEY,
	anio INT,
	cuatrimestre INT,
);

CREATE TABLE AJO_DER.BI_FACT_medicion (
	id INT IDENTITY PRIMARY KEY,
	id_tiempo INT REFERENCES AJO_DER.BI_DIM_tiempo, -- FK
	id_auto INT REFERENCES AJO_DER.BI_DIM_auto, -- FK
	id_piloto INT REFERENCES AJO_DER.BI_DIM_piloto, -- FK
	id_escuderia INT REFERENCES AJO_DER.BI_DIM_escuderia, -- FK
	id_circuito INT REFERENCES AJO_DER.BI_DIM_circuito, -- FK
	id_tipo_sector INT REFERENCES AJO_DER.BI_DIM_tipo_sector, -- FK

	nro_vuelta DECIMAL(18,0),

	tiempo_vuelta_sector DECIMAL(18,10),
	velocidad_maxima_sector DECIMAL(18,4),
	consumo_combustible_sector DECIMAL(18,4),

	desgaste_promedio_motor_sector DECIMAL(18,6),
	desgaste_promedio_caja_sector DECIMAL(18,4),
	desgaste_promedio_frenos_sector DECIMAL(18,4),
	desgaste_promedio_neumaticos_sector DECIMAL(18,6),

	id_tipo_neumatico_1_inicio_sector INT REFERENCES AJO_DER.BI_DIM_tipo_neumatico, -- FK
	id_tipo_neumatico_2_inicio_sector INT REFERENCES AJO_DER.BI_DIM_tipo_neumatico, -- FK
	id_tipo_neumatico_3_inicio_sector INT REFERENCES AJO_DER.BI_DIM_tipo_neumatico, -- FK
	id_tipo_neumatico_4_inicio_sector INT REFERENCES AJO_DER.BI_DIM_tipo_neumatico  -- FK
);

CREATE TABLE AJO_DER.BI_FACT_parada_box (
	id INT IDENTITY PRIMARY KEY,
	id_tiempo INT REFERENCES AJO_DER.BI_DIM_tiempo, -- FK
	id_circuito INT REFERENCES AJO_DER.BI_DIM_circuito, -- FK
	id_escuderia INT REFERENCES AJO_DER.BI_DIM_escuderia, -- FK
	tiempo_parada DECIMAL(18,2)
);

CREATE TABLE AJO_DER.BI_FACT_incidente_auto (
	id INT IDENTITY PRIMARY KEY,
	id_tiempo INT REFERENCES AJO_DER.BI_DIM_tiempo, -- FK
	id_circuito INT REFERENCES AJO_DER.BI_DIM_circuito, -- FK
	id_escuderia INT REFERENCES AJO_DER.BI_DIM_escuderia, -- FK
	id_tipo_sector INT REFERENCES AJO_DER.BI_DIM_tipo_sector, -- FK
	id_tipo_incidente INT REFERENCES AJO_DER.BI_DIM_tipo_incidente -- FK
);
GO


-- Creacion de indices
CREATE INDEX BI_IDX_medicion_1 ON AJO_DER.estado_de_motor(id_medicion)
GO

CREATE INDEX BI_IDX_medicion_2 ON AJO_DER.estado_de_caja_de_cambios(id_medicion)
GO

CREATE INDEX BI_IDX_medicion_3 ON AJO_DER.estado_freno(id_medicion)
GO

CREATE INDEX BI_IDX_medicion_4 ON AJO_DER.estado_neumatico(id_medicion)
GO


CREATE INDEX BI_IDX_auto ON AJO_DER.medicion(id_auto)
GO

CREATE INDEX BI_IDX_sector ON AJO_DER.medicion(id_sector)
GO


-- Creacion de funciones
CREATE FUNCTION AJO_DER.BI_obtener_cuatrimestre(@fecha DATE)
	RETURNS INT
	AS
	BEGIN
		RETURN CASE
			WHEN MONTH(@fecha) BETWEEN 1 AND 4 THEN 1 
			WHEN MONTH(@fecha) BETWEEN 5 AND 8 THEN 2
			WHEN MONTH(@fecha) BETWEEN 9 AND 12 THEN 3
			ELSE NULL
		END
	END
GO

CREATE FUNCTION AJO_DER.BI_primer_tipo_neumatico(@posicion INT, @auto INT, @circuito INT, @nro_vuelta DECIMAL(18,0), @sector INT)
	RETURNS INT
	AS
	BEGIN
		RETURN
		( 
			SELECT TOP 1 n.id_tipo_neumatico
			FROM AJO_DER.medicion m
				JOIN AJO_DER.carrera c ON c.id = m.id_carrera
				JOIN AJO_DER.estado_neumatico e ON e.id_medicion = m.id
				JOIN AJO_DER.neumatico n ON n.id = e.id_neumatico AND 
					n.id_posicion = @posicion
			WHERE
				m.id_auto = @auto AND
				c.id_circuito = @circuito AND
				m.nro_vuelta = @nro_vuelta AND
				m.id_sector = @sector
			ORDER BY m.distancia_vuelta
		)
	END
GO

CREATE FUNCTION AJO_DER.BI_obtener_tiempos_de_vuelta()
	RETURNS @Result TABLE (
		tiempo_vuelta DECIMAL(18,10), 
		nro_vuelta DECIMAL(18,0),
		id_auto INT,
		escuderia NVARCHAR(255), 
		circuito NVARCHAR(255), 
		anio INT 
	)
	AS
	BEGIN
		INSERT INTO @Result
		SELECT
			MAX(medicion.tiempo_vuelta_sector),
			medicion.nro_vuelta,
			medicion.id_auto,
			escuderia.nombre,
			circuito.nombre,
			tiempo.anio
		FROM AJO_DER.BI_FACT_medicion medicion
			JOIN AJO_DER.BI_DIM_escuderia escuderia ON escuderia.id = medicion.id_escuderia
			JOIN AJO_DER.BI_DIM_circuito circuito on circuito.id = medicion.id_circuito
			JOIN AJO_DER.BI_DIM_tiempo tiempo on tiempo.id = medicion.id_tiempo
		GROUP BY medicion.nro_vuelta, medicion.id_auto, escuderia.nombre, circuito.nombre, tiempo.anio
		ORDER BY medicion.id_auto, escuderia.nombre, circuito.nombre, tiempo.anio, medicion.nro_vuelta
	RETURN
	END
GO

CREATE FUNCTION AJO_DER.BI_obtener_Consumo_x_Auto()
	RETURNS @Result TABLE (
		circuito NVARCHAR(255), 
		id_tiempo INT,
		id_auto INT,
		consumo_combustible DECIMAL(18,3)
	)
	AS
	BEGIN
		INSERT INTO @Result
		SELECT
			circuito.nombre,
			id_tiempo,
			id_auto,
			SUM(consumo_combustible_sector)
		FROM AJO_DER.BI_FACT_medicion medicion
			JOIN AJO_DER.BI_DIM_circuito circuito ON circuito.id = medicion.id_circuito
		GROUP BY circuito.id, circuito.nombre, id_tiempo, id_auto
		ORDER BY circuito.nombre, id_auto
	RETURN
	END
GO

CREATE FUNCTION AJO_DER.BI_ranking_incidentes_x_Circuito_x_anio()
	RETURNS @Result TABLE (
		circuito NVARCHAR(255), 
		anio INT,
		cantidad_incidentes INT,
		ranking INT
	)
	AS
	BEGIN
		INSERT INTO @Result
		SELECT
			circuito.nombre,
			fecha.anio,
			COUNT(*),
			ROW_NUMBER() OVER (PARTITION BY fecha.anio ORDER BY COUNT(*) DESC)
		FROM AJO_DER.BI_FACT_incidente_auto incidente_auto
			JOIN AJO_DER.BI_DIM_circuito circuito ON circuito.id = incidente_auto.id_circuito
			JOIN AJO_DER.BI_DIM_tiempo fecha ON fecha.id = incidente_auto.id_tiempo
		GROUP BY circuito.nombre, fecha.anio
	RETURN
	END
GO

CREATE FUNCTION AJO_DER.BI_cantidad_incidentes()
	RETURNS @Result TABLE (
		frenada INT, 
		recta INT,
		curva INT,
		escuderia NVARCHAR(255),
		anio INT
	)
	AS
	BEGIN
		INSERT INTO @Result
		SELECT
			SUM(CASE WHEN tipo_sector.tipo = 'Frenada' THEN 1 ELSE 0 END)
			AS 'Cantidad de incidentes en Frenada',
			SUM(CASE WHEN tipo_sector.tipo = 'Recta' THEN 1 ELSE 0 END)
			AS 'Cantidad de incidentes en Recta',
			SUM(CASE WHEN tipo_sector.tipo = 'Curva' THEN 1 ELSE 0 END)
			AS 'Cantidad de incidentes en Curva',
			escuderia.nombre AS 'Escuderia',
			fecha.anio AS 'A�o'
		FROM AJO_DER.BI_FACT_incidente_auto incidente_auto
			JOIN AJO_DER.BI_DIM_tipo_sector tipo_sector ON tipo_sector.id = incidente_auto.id_tipo_sector
			JOIN AJO_DER.BI_DIM_escuderia escuderia ON escuderia.id = incidente_auto.id_escuderia
			JOIN AJO_DER.BI_DIM_tiempo fecha ON fecha.id = incidente_auto.id_tiempo
		GROUP BY escuderia.id, escuderia.nombre, fecha.anio
		RETURN
	END
GO

-- Carga de datos de auto
INSERT INTO AJO_DER.BI_DIM_auto
SELECT modelo, numero_auto
FROM AJO_DER.auto

-- Carga de datos de piloto
INSERT INTO AJO_DER.BI_DIM_piloto
SELECT nombre, apellido
FROM AJO_DER.piloto

-- Carga de datos de escuderia
INSERT INTO AJO_DER.BI_DIM_escuderia
SELECT nombre
FROM AJO_DER.escuderia

-- Carga de datos de circuito
INSERT INTO AJO_DER.BI_DIM_circuito
SELECT nombre
FROM AJO_DER.circuito

-- Carga de datos de tipo_neumatico
INSERT INTO AJO_DER.BI_DIM_tipo_neumatico
SELECT tipo
FROM AJO_DER.tipo_neumatico

-- Carga de datos de tipo_incidente
INSERT INTO AJO_DER.BI_DIM_tipo_incidente
SELECT tipo
FROM AJO_DER.tipo_incidente

-- Carga de datos de tipo_sector
INSERT INTO AJO_DER.BI_DIM_tipo_sector
SELECT tipo
FROM AJO_DER.tipo_sector

-- Carga de datos de tiempo
INSERT INTO AJO_DER.BI_DIM_tiempo
SELECT DISTINCT 
	YEAR(fecha), 
	AJO_DER.BI_obtener_cuatrimestre(fecha) 
FROM AJO_DER.carrera

-- Carga de datos de medicion
-- esta carga es bastante pesada, se agregaron los indices de mas arriba para que sea posible correrla en un tiempo aceptable
INSERT INTO AJO_DER.BI_FACT_medicion
SELECT
	tiempo.id,
	medicion.id_auto,
	auto.id_piloto,
	auto.id_escuderia, 
	carrera.id_circuito,
	sector.id_tipo_sector,
	
	medicion.nro_vuelta,

	MAX(medicion.tiempo_vuelta),
	MAX(medicion.velocidad),
	MAX(cant_combustible) - MIN(cant_combustible),

	MAX(estado_de_motor.potencia) - MIN(estado_de_motor.potencia),
	MAX(estado_de_caja_de_cambios.desgaste) - MIN(estado_de_caja_de_cambios.desgaste),
	(MAX(estado_freno_1.grosor_pastilla) - MIN(estado_freno_1.grosor_pastilla) +
	 MAX(estado_freno_2.grosor_pastilla) - MIN(estado_freno_2.grosor_pastilla) +
	 MAX(estado_freno_3.grosor_pastilla) - MIN(estado_freno_3.grosor_pastilla) +
	 MAX(estado_freno_4.grosor_pastilla) - MIN(estado_freno_4.grosor_pastilla)
	 ) / 4,

	(MAX(estado_neumatico_1.profundidad) - MIN(estado_neumatico_1.profundidad) +
	 MAX(estado_neumatico_2.profundidad) - MIN(estado_neumatico_2.profundidad) +
	 MAX(estado_neumatico_3.profundidad) - MIN(estado_neumatico_3.profundidad) +
	 MAX(estado_neumatico_4.profundidad) - MIN(estado_neumatico_4.profundidad) 
	 ) / 4,

	CASE WHEN COUNT(DISTINCT neumatico_1.id_tipo_neumatico) > 1 THEN
	AJO_DER.BI_primer_tipo_neumatico(1, medicion.id_auto, carrera.id_circuito, medicion.nro_vuelta, medicion.id_sector)
	ELSE MIN(neumatico_1.id_tipo_neumatico) END,
	-- como es solo 1, el MIN() siempre devuelve el correcto
	-- esto es para evitar agrupar por este campo "neumatico_x.id_tipo_neumatico"

	CASE WHEN COUNT(DISTINCT neumatico_2.id_tipo_neumatico) > 1 THEN
	AJO_DER.BI_primer_tipo_neumatico(2, medicion.id_auto, carrera.id_circuito, medicion.nro_vuelta, medicion.id_sector)
	ELSE MIN(neumatico_2.id_tipo_neumatico) END,

	CASE WHEN COUNT(DISTINCT neumatico_3.id_tipo_neumatico) > 1 THEN
	AJO_DER.BI_primer_tipo_neumatico(3, medicion.id_auto, carrera.id_circuito, medicion.nro_vuelta, medicion.id_sector) 
	ELSE MIN(neumatico_3.id_tipo_neumatico) END,

	CASE WHEN COUNT(DISTINCT neumatico_4.id_tipo_neumatico) > 1 THEN
	AJO_DER.BI_primer_tipo_neumatico(4, medicion.id_auto, carrera.id_circuito, medicion.nro_vuelta, medicion.id_sector)
	ELSE MIN(neumatico_4.id_tipo_neumatico) END

FROM AJO_DER.medicion
	JOIN AJO_DER.sector ON sector.id = medicion.id_sector
	JOIN AJO_DER.carrera ON id_carrera = carrera.id
	JOIN AJO_DER.BI_DIM_tiempo tiempo ON YEAR(carrera.fecha) = tiempo.anio
		AND AJO_DER.BI_obtener_cuatrimestre(carrera.fecha) = tiempo.cuatrimestre
	JOIN AJO_DER.auto ON id_auto = auto.id

	JOIN AJO_DER.estado_de_motor ON estado_de_motor.id_medicion = medicion.id
	JOIN AJO_DER.estado_de_caja_de_cambios ON estado_de_caja_de_cambios.id_medicion = medicion.id


	JOIN AJO_DER.estado_freno estado_freno_1 ON estado_freno_1.id_medicion = medicion.id
	JOIN AJO_DER.freno freno_1 ON freno_1.id = estado_freno_1.id_freno AND
				freno_1.id_posicion = 1

	JOIN AJO_DER.estado_freno estado_freno_2 ON estado_freno_2.id_medicion = medicion.id
	JOIN AJO_DER.freno freno_2 ON freno_2.id = estado_freno_2.id_freno AND
				freno_2.id_posicion = 2

	JOIN AJO_DER.estado_freno estado_freno_3 ON estado_freno_3.id_medicion = medicion.id
	JOIN AJO_DER.freno freno_3 ON freno_3.id = estado_freno_3.id_freno AND
				freno_3.id_posicion = 3

	JOIN AJO_DER.estado_freno estado_freno_4 ON estado_freno_4.id_medicion = medicion.id
	JOIN AJO_DER.freno freno_4 ON freno_4.id = estado_freno_4.id_freno AND
				freno_4.id_posicion = 4


	JOIN AJO_DER.estado_neumatico estado_neumatico_1 ON estado_neumatico_1.id_medicion = medicion.id
	JOIN AJO_DER.neumatico neumatico_1 ON neumatico_1.id = estado_neumatico_1.id_neumatico AND
				neumatico_1.id_posicion = 1

	JOIN AJO_DER.estado_neumatico estado_neumatico_2 ON estado_neumatico_2.id_medicion = medicion.id
	JOIN AJO_DER.neumatico neumatico_2 ON neumatico_2.id = estado_neumatico_2.id_neumatico AND
				neumatico_2.id_posicion = 2

	JOIN AJO_DER.estado_neumatico estado_neumatico_3 ON estado_neumatico_3.id_medicion = medicion.id
	JOIN AJO_DER.neumatico neumatico_3 ON neumatico_3.id = estado_neumatico_3.id_neumatico AND
				neumatico_3.id_posicion = 3

	JOIN AJO_DER.estado_neumatico estado_neumatico_4 ON estado_neumatico_4.id_medicion = medicion.id
	JOIN AJO_DER.neumatico neumatico_4 ON neumatico_4.id = estado_neumatico_4.id_neumatico AND
				neumatico_4.id_posicion = 4
GROUP BY
	medicion.id_auto,
	auto.id_piloto,
	auto.id_escuderia,
	carrera.id_circuito,
	tiempo.id,
	medicion.nro_vuelta,
	medicion.id_sector,
	sector.id_tipo_sector


-- Carga de datos de parada_box
INSERT INTO AJO_DER.BI_FACT_parada_box
SELECT 
	tiempo.id,
	carrera.id_circuito,
	auto.id_escuderia,
	tiempo_parada
FROM AJO_DER.parada_box
	JOIN AJO_DER.carrera ON parada_box.id_carrera = carrera.id
	JOIN AJO_DER.BI_DIM_tiempo tiempo ON YEAR(carrera.fecha) = tiempo.anio
		AND AJO_DER.BI_obtener_cuatrimestre(carrera.fecha) = tiempo.cuatrimestre
	JOIN AJO_DER.auto ON parada_box.id_auto = auto.id

-- Carga de datos de incidente_auto
INSERT INTO AJO_DER.BI_FACT_incidente_auto
SELECT
	tiempo.id,
	carrera.id_circuito,
	auto.id_escuderia,
	sector.id_tipo_sector,
	id_tipo_incidente
FROM AJO_DER.incidente_auto
	JOIN AJO_DER.incidente ON incidente_auto.id_incidente = incidente.id
	JOIN AJO_DER.carrera ON incidente.id_carrera = carrera.id
	JOIN AJO_DER.BI_DIM_tiempo tiempo ON YEAR(carrera.fecha) = tiempo.anio
		AND AJO_DER.BI_obtener_cuatrimestre(carrera.fecha) = tiempo.cuatrimestre
	JOIN AJO_DER.sector ON sector.id = incidente.id_sector
	JOIN AJO_DER.auto ON incidente_auto.id_auto = auto.id
GO


-- Desgaste promedio de cada componente de cada auto por vuelta por circuito.
CREATE VIEW AJO_DER.BI_desgaste_promedio_componentes_cada_auto_x_vuelta_x_circuito AS
	SELECT
		SUM(desgaste_promedio_motor_sector) 'Desgaste Promedio de Motor',
		SUM(desgaste_promedio_caja_sector) 'Desgaste Promedio de Caja de Cambios',
		SUM(desgaste_promedio_frenos_sector) 'Desgaste Promedio de Frenos',
		SUM(desgaste_promedio_neumaticos_sector) 'Desgaste Promedio de Neumaticos',
		auto.modelo AS 'Modelo del Auto', 
		auto.numero_auto AS 'Numero del Auto de su Escuderia',
		medicion.nro_vuelta AS 'Numero de Vuelta', 
		circuito.nombre AS 'Circuito'
	FROM AJO_DER.BI_FACT_medicion medicion
		JOIN AJO_DER.BI_DIM_auto auto ON auto.id = medicion.id_auto
		JOIN AJO_DER.BI_DIM_circuito circuito ON circuito.id = medicion.id_circuito
	GROUP BY auto.id, auto.modelo, auto.numero_auto, medicion.nro_vuelta, circuito.id, circuito.nombre
GO

-- Mejor tiempo de vuelta de cada escuder�a por circuito por a�o.
-- El mejor tiempo est� dado por el m�nimo tiempo en que un auto logra realizar una vuelta de un circuito.
CREATE VIEW AJO_DER.BI_mejor_tiempo_de_vuelta_de_cada_escuderia AS
	SELECT
		MIN(tiempo_vuelta) AS 'Mejor Tiempo de Vuelta',
		escuderia AS 'Escuderia',
		circuito AS 'Circuito',
		anio AS 'A�o'
	FROM AJO_DER.BI_obtener_tiempos_de_vuelta()
	WHERE tiempo_vuelta != 0
	GROUP BY escuderia, circuito, anio
GO

-- Los 3 de circuitos con mayor consumo de combustible promedio
CREATE VIEW AJO_DER.BI_circuitos_con_mayor_consumo_de_combustible_promedio AS
	SELECT TOP 3
		circuito AS 'Circuito',
		AVG(consumo_combustible) AS 'Consumo de Combustible Promedio'
	FROM AJO_DER.BI_obtener_Consumo_x_Auto()
	GROUP BY circuito
	ORDER BY 2 DESC
GO

-- M�xima velocidad alcanzada por cada auto en cada tipo de sector de cada circuito.
CREATE VIEW AJO_DER.BI_maxima_velocidad_alcanzada_por_cada_auto AS
	SELECT
		MAX(medicion.velocidad_maxima_sector) AS 'Maxima Velocidad Alcanzada',
		auto.modelo AS 'Modelo del Auto',
		auto.numero_auto AS 'Numero del Auto de su Escuderia',
		tipo_sector.tipo AS 'Tipo Sector',
		circuito.nombre AS 'Circuito'
	FROM AJO_DER.BI_FACT_medicion medicion
		JOIN AJO_DER.BI_DIM_auto auto ON auto.id = medicion.id_auto
		JOIN AJO_DER.BI_DIM_tipo_sector tipo_sector ON tipo_sector.id = medicion.id_tipo_sector
		JOIN AJO_DER.BI_DIM_circuito circuito ON circuito.id = medicion.id_circuito
	GROUP BY auto.id, auto.modelo, auto.numero_auto, tipo_sector.id, tipo_sector.tipo, circuito.id, circuito.nombre
GO

-- Tiempo promedio que tard� cada escuder�a en las paradas por cuatrimestre
CREATE VIEW AJO_DER.BI_tiempo_promedio_que_tardo_cada_escuderia AS
	SELECT
		AVG(parada_box.tiempo_parada) AS 'Tiempo Promedio en Paradas',
		escuderia.nombre AS 'Escuderia',
		tiempo.cuatrimestre AS 'Cuatrimestre'
	FROM AJO_DER.BI_FACT_parada_box parada_box
		JOIN AJO_DER.BI_DIM_escuderia escuderia ON escuderia.id = parada_box.id_escuderia
		JOIN AJO_DER.BI_DIM_tiempo tiempo ON tiempo.id = parada_box.id_tiempo
	GROUP BY escuderia.id, escuderia.nombre, tiempo.cuatrimestre
GO

-- Cantidad de paradas por circuito por escuder�a por a�o.
CREATE VIEW AJO_DER.BI_cantidad_de_paradas_por_circuito AS
	SELECT
		COUNT(*) AS 'Cantidad de Paradas',
		circuito.nombre AS 'Circuito',
		escuderia.nombre AS 'Escuderia',
		tiempo.anio AS 'A�o'
	FROM AJO_DER.BI_FACT_parada_box parada_box
		JOIN AJO_DER.BI_DIM_circuito circuito ON circuito.id = parada_box.id_circuito
		JOIN AJO_DER.BI_DIM_escuderia escuderia ON escuderia.id = parada_box.id_escuderia
		JOIN AJO_DER.BI_DIM_tiempo tiempo ON tiempo.id = parada_box.id_tiempo
	GROUP BY circuito.id, circuito.nombre, escuderia.id, escuderia.nombre, tiempo.anio
GO

-- Los 3 circuitos donde se consume mayor cantidad en tiempo de paradas en boxes
CREATE VIEW AJO_DER.BI_circuitos_con_mayor_tiempo_en_paradas AS
	SELECT TOP 3
		circuito.nombre AS 'Circuito',
		SUM(parada_box.tiempo_parada) AS 'Tiempo total en paradas'
	FROM AJO_DER.BI_FACT_parada_box parada_box
		JOIN AJO_DER.BI_DIM_circuito circuito ON circuito.id = parada_box.id_circuito
	GROUP BY circuito.id, circuito.nombre
	ORDER BY 2 DESC
GO

-- Los 3 circuitos m�s peligrosos del a�o, en funci�n mayor cantidad de incidentes
CREATE VIEW AJO_DER.BI_circuitos_mas_peligrosos_del_anio AS
	SELECT
		circuito AS 'Circuito',
		anio AS 'A�o',
		cantidad_incidentes AS 'Cantidad de Incidentes'
	FROM AJO_DER.BI_ranking_incidentes_x_Circuito_x_anio()
	WHERE ranking <= 3
GO

-- Promedio de incidentes que presenta cada escuder�a por a�o en los distintos tipo de sectores
CREATE VIEW AJO_DER.BI_promedio_incidentes_escuderia_anio_tipo_de_sector AS
	SELECT
		AVG(frenada) AS 'Promedio de incidentes en Frenada',
		AVG(recta) AS 'Promedio de incidentes en Recta',
		AVG(curva) AS 'Promedio de incidentes en Curva',
		escuderia AS 'Escuderia',
		anio AS 'A�o'
	FROM AJO_DER.BI_cantidad_incidentes()
	GROUP BY escuderia, anio
GO

SELECT * FROM AJO_DER.BI_desgaste_promedio_componentes_cada_auto_x_vuelta_x_circuito
ORDER BY [Modelo del Auto], [Numero del Auto de su Escuderia], Circuito, [Numero de Vuelta]
SELECT * FROM AJO_DER.BI_mejor_tiempo_de_vuelta_de_cada_escuderia
ORDER BY A�o, Circuito, Escuderia
SELECT * FROM AJO_DER.BI_circuitos_con_mayor_consumo_de_combustible_promedio

SELECT * FROM AJO_DER.BI_maxima_velocidad_alcanzada_por_cada_auto
ORDER BY [Modelo del Auto], [Numero del Auto de su Escuderia], Circuito, [Tipo Sector]
SELECT * FROM AJO_DER.BI_tiempo_promedio_que_tardo_cada_escuderia
ORDER BY Cuatrimestre, Escuderia
SELECT * FROM AJO_DER.BI_cantidad_de_paradas_por_circuito
ORDER BY A�o, Circuito, Escuderia

SELECT * FROM AJO_DER.BI_circuitos_con_mayor_tiempo_en_paradas
SELECT * FROM AJO_DER.BI_circuitos_mas_peligrosos_del_anio
SELECT * FROM AJO_DER.BI_promedio_incidentes_escuderia_anio_tipo_de_sector
ORDER BY A�o, Escuderia