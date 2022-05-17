## Final Base de Datos 2-8 
## Aaron Moya

#create database hornoladrillos;

use hornoladrillos;

##---------- Creacion de Tablas ----------##

##---------- Tabla Deposito ----------##
CREATE TABLE `hornoladrillos`.`deposito` (
  `deposito_id` INT(10) NOT NULL AUTO_INCREMENT,
  `ladrillo_id` INT(10) NOT NULL,
  `cantidad` INT(100) NOT NULL,
  `fecha` TIMESTAMP NOT NULL,
  PRIMARY KEY (`deposito_id`),
  INDEX `ladrillo_id_DEPOS_idx` (`ladrillo_id` ASC) VISIBLE,
  CONSTRAINT `ladrillo_id_DEPOS`
    FOREIGN KEY (`ladrillo_id`)
    REFERENCES `hornoladrillos`.`producto` (`ladrillo_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
##---------- Tabla Deposito ----------##


##---------- Tabla Producto ----------##
CREATE TABLE `hornoladrillos`.`producto` (
  `ladrillo_id` INT(10) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(200) NOT NULL,
  `descripcion` VARCHAR(250) NOT NULL,
  `precio_prod` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`ladrillo_id`));
##---------- Tabla Producto ----------##


##---------- Tabla de Pedidos ----------##
CREATE TABLE `hornoladrillos`.`pedido` (
  `pedido_id` INT(100) NOT NULL AUTO_INCREMENT,
  `deposito_id` INT(10) NOT NULL,
  `cliente_id` INT(10) NOT NULL,
  `cantidad` INT(100) NOT NULL,
  `direccion_pedido` VARCHAR(250) NOT NULL,
  `precio_pedido` DECIMAL(10,2) NOT NULL,
  `fecha_pedido` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`pedido_id`),
  INDEX `deposito_id_PEDIDO_idx` (`deposito_id` ASC) VISIBLE,
  INDEX `cliente_id_PEDIDO_idx` (`cliente_id` ASC) VISIBLE,
  CONSTRAINT `deposito_id_PEDIDO`
    FOREIGN KEY (`deposito_id`)
    REFERENCES `hornoladrillos`.`deposito` (`deposito_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `cliente_id_PEDIDO`
    FOREIGN KEY (`cliente_id`)
    REFERENCES `hornoladrillos`.`cliente` (`cliente_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
##---------- Tabla de Pedidos ----------##


##---------- Tabla de Cliente ----------##
CREATE TABLE `hornoladrillos`.`cliente` (
  `cliente_id` INT(10) NOT NULL AUTO_INCREMENT,
  `tipo` VARCHAR(20) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido` VARCHAR(45) NOT NULL,
  `direccion` VARCHAR(100) NOT NULL,
  `telefono` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`cliente_id`));
##---------- Tabla de Cliente ----------##


##---------- Ingreso de Datos ----------##

##---------- Ingreso de Clientes ----------##
INSERT INTO `hornoladrillos`.`cliente` (`tipo`, `nombre`, `apellido`, `direccion`, `telefono`) VALUES ('fijo', 'Gerardo', 'Morales', 'Roca 242', '2604234567');
INSERT INTO `hornoladrillos`.`cliente` (`tipo`, `nombre`, `apellido`, `direccion`, `telefono`) VALUES ('ocasional', 'Ramiro', 'Ramal', 'Illesca 1212', '2604987654');
INSERT INTO `hornoladrillos`.`cliente` (`tipo`, `nombre`, `apellido`, `direccion`, `telefono`) VALUES ('fijo', 'Fernando', 'Canales', 'Mitre 200', '2604124356');


##---------- Ingreso de Productos ----------##
INSERT INTO `hornoladrillos`.`producto` (`nombre`, `descripcion`, `precio_prod`) VALUES ('Ladrillo Horneado', 'Ladrillo recien horneado', '0');
INSERT INTO `hornoladrillos`.`producto` (`nombre`, `descripcion`, `precio_prod`) VALUES ('Ladrillo de Adobón', 'Ladrillo de Adobón ', '100');
INSERT INTO `hornoladrillos`.`producto` (`nombre`, `descripcion`, `precio_prod`) VALUES ('Ladrillo de Construcción', 'Ladriollo de Construcción Estandar', '150');
INSERT INTO `hornoladrillos`.`producto` (`nombre`, `descripcion`, `precio_prod`) VALUES ('Palet Ladrillo Adobon', 'Palet x500unid. de Ladrillo Adobon', '50000');
INSERT INTO `hornoladrillos`.`producto` (`nombre`, `descripcion`, `precio_prod`) VALUES ('Palet Ladrillo Construccion', 'Palet x500unid. Ladrillo Construccion', '75000');

##---------- Ingreso de Deposito ----------##
INSERT INTO `hornoladrillos`.`deposito` (`ladrillo_id`, `cantidad`, `fecha`) VALUES ('1', '5000', current_timestamp());
INSERT INTO `hornoladrillos`.`deposito` (`ladrillo_id`, `cantidad`, `fecha`) VALUES ('2', (select CalcularPorcentaje(5000,30)), current_timestamp());
INSERT INTO `hornoladrillos`.`deposito` (`ladrillo_id`, `cantidad`, `fecha`) VALUES ('3', (select CalcularPorcentaje(5000,70)), current_timestamp());
INSERT INTO `hornoladrillos`.`deposito` (`ladrillo_id`, `cantidad`, `fecha`) VALUES ('4', '3', current_timestamp());
INSERT INTO `hornoladrillos`.`deposito` (`ladrillo_id`, `cantidad`, `fecha`) VALUES ('5', '7', current_timestamp());

##---------- Ingreso de Pedidos ----------##

INSERT INTO `hornoladrillos`.`pedido` (`deposito_id`, `cliente_id`, `cantidad`, `direccion_pedido`, `precio_pedido`, `fecha_pedido`) VALUES ('5', '1', '2', 'Roca 123', (select CalcularPrecio (5, 2)), current_timestamp());
INSERT INTO `hornoladrillos`.`pedido` (`deposito_id`, `cliente_id`, `cantidad`, `direccion_pedido`, `precio_pedido`, `fecha_pedido`) VALUES ('4', '3', '1', 'San Martin 202', (select CalcularPrecio (4, 1)), current_timestamp());
INSERT INTO `hornoladrillos`.`pedido` (`deposito_id`, `cliente_id`, `cantidad`, `direccion_pedido`, `precio_pedido`, `fecha_pedido`) VALUES ('5', '2', '3', 'Illesca 1212', (select CalcularPrecio (5, 3)), current_timestamp());


##---------- Creacion de Consultas ----------##

#Consulta sobre Stock por fecha

select deposito_id "ID del Deposito: ",
	(select P.nombre from producto P where P.ladrillo_id = D.ladrillo_id) "Producto: ",
    (select P.descripcion from producto P where P.ladrillo_id = D.ladrillo_id) "Descripcion Producto: ",
    Cantidad,
    Fecha
from deposito D
where date(fecha) = date('2022-02-01');

#Consulta Pedidos Diarios

select pedido_id "ID Pedido: ",
	(select P.nombre from producto P where P.ladrillo_id = (select D.ladrillo_id from deposito D where D.deposito_id = PE.deposito_id)) "Producto: ",
    (select P.descripcion from producto P where P.ladrillo_id = (select D.ladrillo_id from deposito D where D.deposito_id = PE.deposito_id)) "Descripcion: ",
    (select C.nombre from cliente C where C.cliente_id = PE.cliente_id) "Nombre Cliente: ",
    (select C.apellido from cliente C where C.cliente_id = PE.cliente_id) "Apellido Cliente: ",
    Cantidad,
    direccion_pedido "Direccion del Envio: ",
    precio_pedido "Precio: ",
    fecha_pedido "Fecha: "
from pedido PE
where date(fecha_pedido) = date('2022-02-01');


##---------- Creacion de Vistas ----------##

#Vista de Deposito
create view VistaDeposito as
select deposito_id "ID del Deposito",
	(select P.nombre from producto P where P.ladrillo_id = D.ladrillo_id) "Producto",
    (select P.descripcion from producto P where P.ladrillo_id = D.ladrillo_id) "Descripcion Producto",
    Cantidad,
    Fecha
from deposito D;

#Vista de Pedidos
create view VistaPedidos as
select pedido_id "ID Pedido",
	(select P.nombre from producto P where P.ladrillo_id = (select D.ladrillo_id from deposito D where D.deposito_id = PE.deposito_id)) "Producto",
    (select P.descripcion from producto P where P.ladrillo_id = (select D.ladrillo_id from deposito D where D.deposito_id = PE.deposito_id)) "Descripcion",
    (select C.nombre from cliente C where C.cliente_id = PE.cliente_id) "Nombre Cliente",
    (select C.apellido from cliente C where C.cliente_id = PE.cliente_id) "Apellido Cliente",
    Cantidad,
    direccion_pedido "Direccion del Envio",
    precio_pedido "Precio",
    fecha_pedido "Fecha"
from pedido PE;

#Vista de Productos
create view VistaProdcutos as
select * from producto;

    