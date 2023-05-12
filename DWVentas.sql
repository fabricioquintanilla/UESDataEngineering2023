/*Crear base de datos para Datawarehouse*/
create database DWVentasDemo
go

--Cambiamos a utilizar la base creada
use DWVentasDemo
go

--Crear dimensiones
create table DimRepresentanteVentas(
RepresentanteVentasKey int identity(1,1) primary key,
idRepresentanteVentas int not null, --Llave de negocio que no acepta null
NombreRepresentanteVentas varchar(50) not null,
AcuerdosComerciales varchar(500),
DescuentoAutorizado float --Ejemplo: 90% se almacena 0.90
)
go
