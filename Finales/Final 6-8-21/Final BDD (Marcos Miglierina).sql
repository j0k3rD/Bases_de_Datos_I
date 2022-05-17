# Final de Base de Datos I
# Nombre: Marcos Miglierina

create database ladrillos;

use ladrillos;

#--------------- Creación de Tablas -----------------------
# Producto
CREATE TABLE `ladrillos`.`producto` (
  `idLadrillo` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(25) NOT NULL,
  `descripcion` VARCHAR(250) NOT NULL,
  `precio` FLOAT NOT NULL,
  PRIMARY KEY (`idLadrillo`))
COMMENT = 'Tipo de ladrillo que se tiene almacenado en el deposito, sirve para obtener mayor información sobre el tipo de ladrillo que se tiene almacenado.';

# Deposito
CREATE TABLE `ladrillos`.`deposito` (
  `idDeposito` INT NOT NULL AUTO_INCREMENT,
  `idLadrillo` INT NOT NULL,
  `cantidad` INT NOT NULL,
  `fecha` TIMESTAMP NOT NULL,
  PRIMARY KEY (`idDeposito`),
  INDEX `idLadrillosFK_idx` (`idLadrillo` ASC) VISIBLE,
  CONSTRAINT `idLadrillosFK`
    FOREIGN KEY (`idLadrillo`)
    REFERENCES `ladrillos`.`producto` (`idLadrillo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
COMMENT = 'Deposito donde se registran el almacenamiento temporal de los ladrillos, tantos los recien produccidos como los empaquetados.';

# Cliente
CREATE TABLE `ladrillos`.`cliente` (
  `idCliente` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(25) NOT NULL,
  `apellido` VARCHAR(45) NOT NULL,
  `direccion` VARCHAR(45) NOT NULL,
  `telefono` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idCliente`))
COMMENT = 'Registro de clientes que realizan pedidos a la empresa.';

# Pedido
CREATE TABLE `ladrillos`.`pedido` (
  `idPedido` INT NOT NULL AUTO_INCREMENT,
  `idDeposito` INT NOT NULL,
  `idCliente` INT NOT NULL,
  `cantidad` INT NOT NULL,
  `precioVenta` DECIMAL(10,2) NOT NULL,
  `direccionEnvio` VARCHAR(45) NOT NULL,
  `fecha` TIMESTAMP NOT NULL,
  PRIMARY KEY (`idPedido`))
COMMENT = 'Pedidos realizados por los clientes.';
#--------------- Creación de Tablas -----------------------

#--------------- Ingreso de Datos -----------------------
# Producto
INSERT INTO `ladrillos`.`producto` (`nombre`, `descripcion`, `precio`) VALUES ('Ladrillo Horneado', 'Ladrillos recien creados mediante horno.', '0');
INSERT INTO `ladrillos`.`producto` (`nombre`, `descripcion`, `precio`) VALUES ('Ladrillo Adobón', 'Ladrillo comun de Adobón.', '100');
INSERT INTO `ladrillos`.`producto` (`nombre`, `descripcion`, `precio`) VALUES ('Ladrillo Construcción', 'Ladrillos de Construcción de medida estandar.', '150');
INSERT INTO `ladrillos`.`producto` (`nombre`, `descripcion`, `precio`) VALUES ('Ladrillo A. Palet', 'Ladrillos de Adobón empacados en pallets de 500 unidades.', '50000');
INSERT INTO `ladrillos`.`producto` (`nombre`, `descripcion`, `precio`) VALUES ('Ladrillo C. Palet', 'Ladrillos de Construcción empacados en pallets de 500 unidades.', '75000');

# Deposito
INSERT INTO `ladrillos`.`deposito` (`idLadrillo`, `cantidad`, `fecha`) VALUES ('1', '5000', current_timestamp());
INSERT INTO `ladrillos`.`deposito` (`idLadrillo`, `cantidad`, `fecha`) VALUES ('2', CalcularPorcentaje(5000, 30), current_timestamp());
INSERT INTO `ladrillos`.`deposito` (`idLadrillo`, `cantidad`, `fecha`) VALUES ('3', CalcularPorcentaje(5000, 70), current_timestamp());
INSERT INTO `ladrillos`.`deposito` (`idLadrillo`, `cantidad`, `fecha`) VALUES ('4', '3', current_timestamp());
INSERT INTO `ladrillos`.`deposito` (`idLadrillo`, `cantidad`, `fecha`) VALUES ('5', '7', current_timestamp());

# Cliente
INSERT INTO `ladrillos`.`cliente` (`nombre`, `apellido`, `direccion`, `telefono`) VALUES ('Juan', 'Perez', 'Mitre 2223', '+15 2604 123548');
INSERT INTO `ladrillos`.`cliente` (`nombre`, `apellido`, `direccion`, `telefono`) VALUES ('Roberto', 'Romero', 'Barcala 643', '+15 2604 254852');

# Pedido
INSERT INTO `ladrillos`.`pedido` (`idDeposito`, `idCliente`, `cantidad`, `precioVenta`, `direccionEnvio`, `fecha`) VALUES ('4', '1', '1', CalcularPrecio(4, 1), 'Mitre 223', current_timestamp());
INSERT INTO `ladrillos`.`pedido` (`idDeposito`, `idCliente`, `cantidad`, `precioVenta`, `direccionEnvio`, `fecha`) VALUES ('5', '2', '2', CalcularPrecio(5, 2), 'Jose Quiroga 1223', current_timestamp());
INSERT INTO `ladrillos`.`pedido` (`idDeposito`, `idCliente`, `cantidad`, `precioVenta`, `direccionEnvio`, `fecha`) VALUES ('5', '1', '1', CalcularPrecio(5, 1), 'Mitre 223', current_timestamp());
#--------------- Ingreso de Datos -----------------------

#--------------- Consultas -----------------------
# Consulta Producción registrada en determinada fecha.
Select D.idDeposito "ID de Deposito",
	   (select P.nombre from producto P where P.idLadrillo = D.idLadrillo) "Nombre de Producto",
       (select P.descripcion from producto P where P.idLadrillo = D.idLadrillo) "Descripción Producto",
	   D.cantidad,
       D.fecha
from deposito D
Where date(D.fecha) = date("2021-08-06"); # El valor dentro del date, es el ingresado por el usuario.

# Consulta para ver los pedidos diarios.
Select P.idPedido "ID de Pedido",
	   (select concat(C.nombre, " ", C.apellido) from cliente C where P.idCliente = C.idCliente) "Nombre y Apellido del cliente",
       (select Pr.nombre from producto Pr where Pr.idLadrillo = (select D.idLadrillo from deposito D where D.idDeposito = P.idDeposito)) "Nombre de Producto",
       P.cantidad,
       P.precioVenta "Precio",
       P.direccionEnvio "Dirección de Envio",
       P.fecha
from pedido P
where date(P.fecha) = date("2021-08-06"); # El día de los pedidos los coloca el usuario.
#--------------- Consultas -----------------------