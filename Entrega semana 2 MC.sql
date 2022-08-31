USE Estudiante_9_202214;
--------------------- MODELO ROLAP CASO MOVIMIENTOS WWImporter ------------------------------

--------------------- Miguel Camargo

# 1-) Entregable CREATE 

CREATE TABLE Proveedor (
ID_Proveedor INT,
Nombre varchar(50),
Categoria varchar(20),
Contacto_primcipal varchar(30),
Referencia varchar(30),
Dias_pago INT,
Codigo_postal INT,
PRIMARY KEY(ID_Proveedor)
);

CREATE TABLE TipoTransaccion(
ID_Tipo_transaccion tinyint,
Tipo varchar(50),
primary key (ID_Tipo_transaccion));

CREATE TABLE Cliente (
ID_Cliente SMALLINT,
ID_Categoria INT, 
ID_GrupoCompra INT,
Nombre VARCHAR(50),
ClienteFactura VARCHAR(30),
ID_CiudadEntrega INT,
LimiteCredito INT,
FezchaAperturaCuenta DATETIME,
DiasPago INT,
NombreGrupoCompra VARCHAR(40),
NombreCategoria VARCHAR(40), 
PRIMARY KEY(ID_Cliente));

CREATE TABLE Producto(
ID_Producto INT,
Nombre varchar(100),
Marca varchar(20),
Color varchar(10),
Necesita_refigeracion boolean,
Dias_tiempo_entrega smallint,
Cantidad_por_salida int,
Precio_minoriasta_recomendado float,
Impuesto float,
Precio_unitario float,
primary key (ID_Producto)
);

CREATE TABLE Fecha (
Fecha DATETIME, 
Dia TINYINT, 
Mes VARCHAR(20), 
Anio SMALLINT,
Numero_semana_ISO TINYINT,
PRIMARY KEY(Fecha));

CREATE TABLE Movimientos (
Fecha_movimiento DATETIME,
ID_Producto SMALLINT,
ID_Provedor SMALLINT,
ID_Cliente INT,
ID_Tipo_transaccion SMALLINT,
Cantidad INT,
PRIMARY KEY(ID_Producto,Fecha_movimiento, ID_Provedor, ID_Tipo_transaccion));

# 2-) Entregable INSERT

insert into Proveedor values 
(4,"Fabrikam Inc.","Ropa","(203) 555-0104","293092",30,40351),
(5,"Graphic Design Institute","Productos novedosos","(406) 555-0105","8803922",14,64847),
(7,"Litware Inc.","Embalaje","(209) 555-0108","BC0280982",30,95245),
(9,"Nod Publishers","Productos novedosos","(252) 555-0100","GL08029802",7,27906),
(10,"Northwind Electric Cars","Juguetes","(201) 555-0105","ML0300202",30,7860);

INSERT INTO `TipoTransaccion` (`ID_Tipo_transaccion`,`Tipo`) VALUES (2,'Customer Credit NotTipoe');
INSERT INTO `TipoTransaccion` (`ID_Tipo_transaccion`,`Tipo`) VALUES (3,'Customer Payment Received');
INSERT INTO `TipoTransaccion` (`ID_Tipo_transaccion`,`Tipo`) VALUES (4,'Customer Refund');
INSERT INTO `TipoTransaccion` (`ID_Tipo_transaccion`,`Tipo`) VALUES (5,'Supplier Invoice');
INSERT INTO `TipoTransaccion` (`ID_Tipo_transaccion`,`Tipo`) VALUES (6,'Supplier Credit Note');
INSERT INTO `TipoTransaccion` (`ID_Tipo_transaccion`,`Tipo`) VALUES (7,'Supplier Payment Issued');
INSERT INTO `TipoTransaccion` (`ID_Tipo_transaccion`,`Tipo`) VALUES (8,'Supplier Refund');
INSERT INTO `TipoTransaccion` (`ID_Tipo_transaccion`,`Tipo`) VALUES (9,'Stock Transfer');
INSERT INTO `TipoTransaccion` (`ID_Tipo_transaccion`,`Tipo`) VALUES (10,'Stock Issue');
INSERT INTO `TipoTransaccion` (`ID_Tipo_transaccion`,`Tipo`) VALUES (11,'Stock Receipt');
INSERT INTO `TipoTransaccion` (`ID_Tipo_transaccion`,`Tipo`) VALUES (12,'Stock Adjustment at Stocktake');
INSERT INTO `TipoTransaccion` (`ID_Tipo_transaccion`,`Tipo`) VALUES (13,'Customer Contra');

insert into Cliente values
(1,3,1,"Tailspin Toys (Head Office)",3,19586,2400,"2013-01-01 00:00:00",7,"Tailspin Toys","Novelty Shop"),
(2,3,1,"Tailspin Toys (Sylvanite, MT)",3,33475,2400,"2013-01-01 00:00:00",7,"Tailspin Toys","Novelty Shop"),
(452,3,2,"Wingtip Toys (Lake Davis, CA)",401,18340,null,"2013-01-01 00:00:00",7,"Wingtip Toys","Novelty Shop"),
(455,3,2,"Wingtip Toys (Taft Heights, CA)",401,33520,null,"2013-01-01 00:00:00",7,"Wingtip Toys","Novelty Shop"),
(456,3,2,"Wingtip Toys (West Hempstead, NY)",401,36531,null,"2013-01-01 00:00:00",7,"Wingtip Toys","Novelty Shop");

INSERT INTO Producto values
(4,"USB food flash drive - sushi roll",null,null,false,14,50,48,15,32),
(5,"USB food flash drive - hamburger",null,null,false,14,50,48,15,32),
(6,"USB food flash drive - hot dog",null,null,false,14,50,48,15,32),
(7,"USB food flash drive - pizza slice",null,null,false,14,50,48,15,32),
(8,"USB food flash drive - dim sum 10 drive variety pack",null,null,false,14,50,359,15,240);

INSERT INTO Fecha values 
( '1998-01-23 12:45:56', 23, 'Jan', 1998, 3),
( '1998-01-30 01:40:16', 30, 'Jan', 1998, 4),
( '1998-02-16 16:00:13', 16, 'Feb', 1998, 7),
( '1998-03-26 11:45:12', 26, 'Mar', 1998, 12),
( '1998-04-06 20:22:17', 14, 'Apr', 1998, 14);

insert into Movimientos values
('1998-01-23 12:45:56',4,4,1,2,500),
('1998-01-30 01:40:16',5,5,2,3,150),
('1998-02-16 16:00:13',6,7,452,4,30),
('1998-03-26 11:45:12',6,7,452,5,12),
('1998-04-06 20:22:17',8,10,456,6,10845);

# 3-) Entregable SELECT

select pr.Nombre Producto, cl.Nombre Cliente, pd.Nombre Proveedor, count(mv.ID_Producto) from Movimientos mv
inner join Producto pr on pr.ID_Producto = mv.ID_Producto
left join Cliente cl on cl.ID_Cliente = mv.ID_Cliente
left join Proveedor pd on pd.ID_Proveedor = mv.ID_Provedor
where mv.Fecha_movimiento between '1998-01-23' and '1998-04-06'
group by pr.ID_Producto, cl.ID_Cliente, pd.ID_Proveedor;
