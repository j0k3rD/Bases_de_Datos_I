#create database ferreteria;
use ferreteriaomar;

#----------- Creacion de Tablas --------------#

#----------- Tabla Deposito --------------#
CREATE TABLE `ferreteriaomar`.`deposito` (
  `deposito_id` INT(5) NOT NULL AUTO_INCREMENT,
  `producto_id` INT(10) NOT NULL,
  `cantidad` DECIMAL(10,3) NOT NULL,
  `fecha` TIMESTAMP NOT NULL,
  PRIMARY KEY (`deposito_id`),
  INDEX `producto_id_DEPOS_idx` (`producto_id` ASC) VISIBLE,
  CONSTRAINT `producto_id_DEPOS`
    FOREIGN KEY (`producto_id`)
    REFERENCES `ferreteriaomar`.`producto` (`producto_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
#----------- Tabla Deposito --------------#

#----------- Tabla Producto --------------#
CREATE TABLE `ferreteriaomar`.`producto` (
  `producto_id` INT(10) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(50) NOT NULL,
  `descripcion` VARCHAR(250) NOT NULL,
  `precio_prod` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`producto_id`));
#----------- Tabla Producto --------------#

#----------- Tabla Venta --------------#
CREATE TABLE `ferreteriaomar`.`venta` (
  `venta_id` INT(100) NOT NULL AUTO_INCREMENT,
  `deposito_id` INT(10) NOT NULL,
  `cliente_id` INT(20) NOT NULL,
  `cantidad` DECIMAL(10,3) NOT NULL,
  `precio_venta` DECIMAL(10,2) NOT NULL,
  `fecha_venta` TIMESTAMP NOT NULL,
  PRIMARY KEY (`venta_id`),
  INDEX `deposito_id_VENTA_idx` (`deposito_id` ASC) VISIBLE,
  INDEX `cliente_id_VENTA_idx` (`cliente_id` ASC) VISIBLE,
  CONSTRAINT `deposito_id_VENTA`
    FOREIGN KEY (`deposito_id`)
    REFERENCES `ferreteriaomar`.`deposito` (`deposito_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `cliente_id_VENTA`
    FOREIGN KEY (`cliente_id`)
    REFERENCES `ferreteriaomar`.`cliente` (`cliente_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
#----------- Tabla Venta --------------#

#----------- Tabla Cliente --------------#
CREATE TABLE `ferreteriaomar`.`cliente` (
  `cliente_id` INT(20) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(50) NOT NULL,
  `telefono` VARCHAR(30) NOT NULL,
  `direccion` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`cliente_id`));
#----------- Tabla Cliente --------------#

#----------- Creacion de Tablas --------------#



#----------- Ingresado de Datos --------------#
#Clientes
INSERT INTO `ferreteriaomar`.`cliente` (`nombre`, `telefono`, `direccion`)
VALUES	('Mario Casas', '2604234567', 'Roca 242');
INSERT INTO `ferreteriaomar`.`cliente` (`nombre`, `telefono`, `direccion`)
VALUES	('Fernando Ramos', '2604987654', 'Maza 1234');


#Productos
INSERT INTO `ferreteriaomar`.`producto` (`nombre`, `descripcion`, `precio_prod`)
VALUES ('Clavo Espiral Punta Paris 6pul ', 'Clavos Espiralados Punta París 6 Pulgadas 1 Kg', '950.00');
INSERT INTO `ferreteriaomar`.`producto` (`nombre`, `descripcion`, `precio_prod`)
VALUES ('Tornillo Madera 12', 'Tornillo Vialro Fix Dorado Madera 3.5 X 12 Mm Jasper Caja 200 Unidades', '320.00');
INSERT INTO `ferreteriaomar`.`producto` (`nombre`, `descripcion`, `precio_prod`)
VALUES ('Destornillador Phillips Imantado', 'Destornillador Punta Imantada Phillips 4 X 100mm Bremen 6210', '330.00');


#Deposito
INSERT INTO `ferreteriaomar`.`deposito` (`producto_id`, `cantidad`, `fecha`)
VALUES	('1', '30', current_timestamp());
INSERT INTO `ferreteriaomar`.`deposito` (`producto_id`, `cantidad`, `fecha`)
VALUES	('2', '100', current_timestamp());
INSERT INTO `ferreteriaomar`.`deposito` (`producto_id`, `cantidad`, `fecha`)
VALUES	('3', '60', current_timestamp());



#Venta 1
INSERT INTO `ferreteriaomar`.`venta` (`deposito_id`, `cliente_id`, `cantidad`, `precio_venta`, `fecha_venta`)
VALUES ('3', '1', '2', (select CalcularPrecio(3, 2) as precio_final), current_timestamp());

#Venta 2
INSERT INTO `ferreteriaomar`.`venta` (`deposito_id`, `cliente_id`, `cantidad`, `precio_venta`, `fecha_venta`)
VALUES ('2', '2', '1', (select CalcularPrecio(2, 1) as precio_final), current_timestamp());

#Venta 3
INSERT INTO `ferreteriaomar`.`venta` (`deposito_id`, `cliente_id`, `cantidad`, `precio_venta`, `fecha_venta`)
VALUES ('1', '2', '0.950', (select CalcularPrecio(1, 0.950) as precio_final), current_timestamp());

#----------- Ingresado de Datos --------------#

#----------- Consultas --------------#

# Consultar Stock de productos por Fechas

select deposito_id "ID del Deposito",
	(select P.nombre from producto P where P.producto_id = D.producto_id) 'Producto: ',
    (select P.descripcion from producto P where P.producto_id = D.producto_id) 'Descripcion: ',
	Cantidad,
	Fecha
from deposito D
where date(fecha) = date("2022-01-31");


#Consultar Pedidos Diarios

select venta_id "ID de la Venta",
	(select P.nombre from producto P where P.producto_id = (select D.producto_id from deposito D where D.deposito_id = V.deposito_id)) "Nombre del Producto: ",
    Cantidad,
    precio_venta "Precio de la Venta: ",
    fecha_venta "Fecha de Venta: "
from venta V
where date(fecha_venta) = date("2022-01-31");


#----------- Vistas --------------#

# Vista de Deposito

Create View VistaDeposito as
select deposito_id "ID del Deposito",
	(select P.nombre from producto P where P.producto_id = D.producto_id) "Producto",
    (select P.descripcion from producto P where P.producto_id = D.producto_id) "Descripcion",
	Cantidad,
	Fecha
from deposito D;

# Vista de Ventas

Create View VistaVentas as
select venta_id "ID de la Venta",
	(select P.nombre from producto P where P.producto_id = (select D.producto_id from deposito D where D.deposito_id = V.deposito_id)) "Nombre del Producto",
    Cantidad,
    precio_venta "Precio de la Venta",
    fecha_venta "Fecha de Venta"
from venta V;

Create View VistaProductos as
select * 
from producto;
































    
