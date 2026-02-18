CREATE DATABASE  tarea_db;
USE tarea_db;

CREATE TABLE producto (
    codigo_prod VARCHAR(50) PRIMARY KEY,
    nombre VARCHAR(150) not null,
    descripcion TEXT,
    precio_unitario DECIMAL(10,2) not null,
    stock INT not null DEFAULT 0
);

CREATE TABLE proveedor (
    id_proveedor INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(150) not null,
    direccion VARCHAR(200),
    contacto_principal VARCHAR(100)
);

CREATE TABLE producto_proveedor (
    id_proveedor INT,
    codigo_prod VARCHAR(50),
    PRIMARY KEY (id_proveedor, codigo_prod),
    FOREIGN KEY (id_proveedor) REFERENCES proveedor(id_proveedor),
    FOREIGN KEY (codigo_prod) REFERENCES producto(codigo_prod)        
);

CREATE TABLE cliente (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(150) not null,
    direccion VARCHAR(200),
    tipo_cliente ENUM('individual','corporativo') not null
);

CREATE TABLE sucursal (
    cod_sucursal INT PRIMARY KEY,
    ubicacion VARCHAR(150) not null
);

CREATE TABLE empleado (
    id_empleado INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(150) not null,
    cargo VARCHAR(100) not null,
    cod_sucursal INT not null,
    FOREIGN KEY (cod_sucursal) REFERENCES sucursal(cod_sucursal)       
);

CREATE TABLE pedido (
    num_pedido INT AUTO_INCREMENT PRIMARY KEY,
    fecha_compra DATE not null,
    id_cliente INT not null,
    id_empleado INT not null,
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),        
    FOREIGN KEY (id_empleado) REFERENCES empleado(id_empleado)       
);

CREATE TABLE factura (
    numero_factura INT AUTO_INCREMENT PRIMARY KEY,
    fecha_emision DATE not null,
    monto_total DECIMAL(12,2) not null,
    estado_pago ENUM('pendiente','pagado') not null,
    num_pedido INT not null,
    FOREIGN KEY (num_pedido) REFERENCES pedido(num_pedido)       
);

CREATE TABLE producto_pedido (
    num_pedido INT,
    codigo_prod VARCHAR(50),
    cantidad INT not null,
    precio_unitario DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (num_pedido, codigo_prod),
    FOREIGN KEY (num_pedido) REFERENCES pedido(num_pedido),
    FOREIGN KEY (codigo_prod) REFERENCES producto(codigo_prod)        
);

INSERT INTO sucursal (codigo_sucursal, ubicacion) VALUES
(1, "Xela"),
(2, "Toto");

INSERT INTO empleado (nombre, cargo, cod_sucursal) VALUES 
("Jose Lopez", "Vendedor",1), 
("Marcos Perez", "Vendedor", 2), 
("Luis Morales", "Gerente", 1), 
("Maria Gomez", "Gerente", 2);
 
INSERT INTO proveedor (nombre, direccion, contacto) VALUES 
("Proveedor 1", "Ciudad capital", "Julio Gomez"), 
("proveedor 2", "Centro de Xela", "Marvin Alvarez");
  
INSERT INTO producto (codigo_prod, nombre, descripcion, precio_unitario, stock) VALUES 
("P001", "Laptop Lenovo", "Laptop nueva 1", 7250.50, 6), 
("P002", "Mouse gamer", "mouse gamer 1", 85.00, 12), 
("p003", "Laptop Victus", "Laptop nueva 2", 8250, 3);
   
INSERT INTO producto_proveedor VALUES (1, "P001"), (1, "p002"),(2, "p003");

INSERT INTO pedido (fecha_compra, id_cliente, id_empleado) VALUES ('2026-02-01', 1, 1), ('2026-02-02',2,2);

INSERT INTO producto_pedido VALUES (1, "P001", 1, 7250.50), (2, "p003", 2, 8250);

INSERT INTO factura (fecha_emision, monto_total, estado_pago, num_pedido) VALUES 
('2026-02-01', 7250.50, 'pendiente', 1), 
('2026-02-02', 8250, 'pagado', 2); 