-- Eliminacion de funciones si existen
IF OBJECT_ID('AJO_DER.mejor_tiempo_de_vuelta_de_cada_escuderia') IS NOT NULL
	DROP FUNCTION AJO_DER.mejor_tiempo_de_vuelta_de_cada_escuderia
IF OBJECT_ID('AJO_DER.m�xima_velocidad_alcanzada_por_cada_auto') IS NOT NULL
	DROP FUNCTION AJO_DER.m�xima_velocidad_alcanzada_por_cada_auto
IF OBJECT_ID('AJO_DER.cantidad_de_paradas_por_circuito') IS NOT NULL
	DROP FUNCTION AJO_DER.cantidad_de_paradas_por_circuito
IF OBJECT_ID('AJO_DER.Tiempo_promedio_que_tardo_cada_escuderia') IS NOT NULL
	DROP FUNCTION AJO_DER.Tiempo_promedio_que_tardo_cada_escuderia

GO
--- Mejor tiempo de vuelta de cada escuder�a por circuito por a�o.
--El mejor tiempo est� dado por el m�nimo tiempo en que un auto logra
--realizar una vuelta de un circuito.
CREATE FUNCTION AJO_DER.mejor_tiempo_de_vuelta_de_cada_escuderia()
RETURNS @Result TABLE ( tiempo_vuelta decimal(18,10), escuderia_nombre nvarchar(255),circuito_nombre nvarchar(255), a�o nvarchar(255) )
AS
BEGIN
	Insert into @Result (medicion.tiempo_vuelta,escuderia_nombre,circuito_nombre,a�o)
	select 
	medicion.tiempo_vuelta,
	escuderia.nombre,
	circuito.nombre,
	year(carrera.fecha)
	from 
	AJO_DER.medicion medicion
	inner join AJO_DER.auto auto on auto.id=medicion.id_auto
	inner join AJO_DER.escuderia escuderia on escuderia.id=auto.id_escuderia
	inner join AJO_DER.carrera  carrera on carrera.id=medicion.id_carrera
	inner join AJO_DER.circuito  circuito on circuito.id=medicion.id_carrera
	group by medicion.tiempo_vuelta,escuderia.nombre,circuito.nombre,carrera.fecha
	order by medicion.tiempo_vuelta
RETURN 
END
GO
--- M�xima velocidad alcanzada por cada auto en cada tipo de sector de cada circuito. (agrupar por sector y decorar un poco el resultado)
CREATE FUNCTION AJO_DER.m�xima_velocidad_alcanzada_por_cada_auto()
RETURNS @Result TABLE ( velocidad decimal(18,10), sector int,circuito_nombre nvarchar(255), id_tipo_sector int,  numero_auto int)
AS
BEGIN
	Insert into @Result (velocidad,sector,circuito_nombre,id_tipo_sector,numero_auto)
	select
	medicion.velocidad,
	medicion.id_sector,
	circuito.nombre,
	sector.id_tipo_sector,
	auto.numero_auto	
	from 
	AJO_DER.medicion medicion
	inner join AJO_DER.auto auto on auto.id=medicion.id_auto
	inner join AJO_DER.carrera  carrera on carrera.id=medicion.id_carrera
	inner join AJO_DER.circuito  circuito on circuito.id=medicion.id_carrera
	inner join AJO_DER.sector sector on circuito.id=medicion.id_carrera
	group by auto.numero_auto, medicion.velocidad,sector.id_tipo_sector,medicion.id_sector,circuito.nombre
	order by medicion.velocidad desc
RETURN 
END
GO
--- Cantidad de paradas por circuito por escuder�a por a�o.
CREATE FUNCTION AJO_DER.cantidad_de_paradas_por_circuito()
RETURNS @Result TABLE ( paradas int, circuito_nombre nvarchar(255), escuderia_nombre nvarchar(255), a�o nvarchar(255))
AS
BEGIN
	Insert into @Result (paradas,circuito_nombre,escuderia_nombre,a�o)
	select	
	count(parada.id) [cantida de paradas],
	circuito.nombre,
	escuderia.nombre,
	year(carrera.fecha) [fecha]
	from 
	AJO_DER.medicion medicion
	inner join AJO_DER.auto auto on auto.id=medicion.id_auto
	inner join AJO_DER.escuderia escuderia on escuderia.id=auto.id_escuderia
	inner join AJO_DER.carrera  carrera on carrera.id=medicion.id_carrera
	inner join AJO_DER.circuito  circuito on circuito.id=medicion.id_carrera
	inner join AJO_DER.parada_box parada on parada.id_carrera=carrera.id
	group by circuito.nombre,escuderia.nombre,carrera.fecha
RETURN 
END
GO
--Tiempo promedio que tard� cada escuder�a en las paradas por cuatrimestre
CREATE FUNCTION AJO_DER.Tiempo_promedio_que_tardo_cada_escuderia()
RETURNS @Result TABLE (escuderia_nombre nvarchar(255),promedio_tiempo_parada decimal(18,10), cuatrimestre int )
AS
BEGIN
	Insert into @Result (escuderia_nombre,promedio_tiempo_parada,cuatrimestre)
	select
	escuderia.nombre,
	AVG(parada.tiempo_parada),
	DATENAME(quarter,carrera.fecha)
	from AJO_DER.medicion medicion
	inner join AJO_DER.auto auto on auto.id=medicion.id_auto
	inner join AJO_DER.escuderia escuderia on escuderia.id=auto.id_escuderia
	inner join AJO_DER.carrera  carrera on carrera.id=medicion.id_carrera
	inner join AJO_DER.circuito  circuito on circuito.id=medicion.id_carrera
	inner join AJO_DER.parada_box parada on parada.id_carrera=carrera.id
	group by escuderia.nombre,DATENAME(quarter,carrera.fecha)
RETURN 
END
GO

select * from AJO_DER.cantidad_de_paradas_por_circuito()	
select * from AJO_DER.m�xima_velocidad_alcanzada_por_cada_auto()
select * from AJO_DER.mejor_tiempo_de_vuelta_de_cada_escuder�a()
select * from AJO_DER.Tiempo_promedio_que_tardo_cada_escuderia()