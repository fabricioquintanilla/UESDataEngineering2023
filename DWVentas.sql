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

--Crear la dimension de tiempo
create table DimFechas(
FechasKey int primary key, --Ejemplo: 20230511
Fecha date not null,
dia tinyint not null,
mes tinyint not null, --0 a 255
anio smallint not null) --0 a 32656
go

--Crear la dimension de ordenes de venta
create table DimOrdenVenta(
OrdenVentaKey int identity(1,1) primary key, --Llave surrogada
NumeroOrden varchar(100) not null, --Llave de negocio
FechaOrden datetime not null,
MontoOrden float not null)
go

--Crear la dimension de producto
create table DimProducto(
ProductoKey int identity(1,1) primary key, --Llave surrogada
NumeroProducto bigint not null, --Llave de negocio
TipoProducto varchar(100) not null,
CalidadProducto varchar(100) not null,
PrecioLista float not null default 0,
FechaUltimaOrden date not null default getdate())
go

--Crear la dimension de cliente
create table DimCliente(
ClienteKey int identity(1,1) primary key, --Llave surrogada
idCliente varchar(100) not null, --Llave de negocio
NombreCliente varchar(100) not null default 'Cliente desconocido',
DireccionCliente varchar(250) not null default 'Direccion desconocida',
Activo char(1) not null default 'S', --Se manejara 'S' para activo y 'N' inactivo
FechaInicio date not null default getdate(), --Fecha de inicio del registro activo
FechaFin date null)
go

--Crear tabla de hechos
create table FactVentas(
RepresentanteVentasKey int not null foreign key 
references DimRepresentanteVentas(RepresentanteVentasKey),
FechasKey int not null foreign key
references DimFechas(FechasKey),
OrdenVentaKey int not null foreign key 
references DimOrdenVenta(OrdenVentaKey),
ClienteKey int not null foreign key
references DimCliente(ClienteKey),
ProductoKey int not null foreign key
references DimProducto(ProductoKey),
MontoPorCliente float not null default 0,
MontoPorProducto float not null default 0,
MontoPorPromocion float not null default 0)
go

--Crear la llave primaria de la tabla de hechos
alter table FactVentas
Add constraint PK_FactVentas PRIMARY KEY(RepresentanteVentasKey,
FechasKey, OrdenVentaKey, ClienteKey, ProductoKey)






