-- Base de Datos I - Unidad 4 - Ej08: CadenaSuministro
-- Script portable (SQLite / MySQL). En SQLite activar antes: PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS orden_producto;
DROP TABLE IF EXISTS producto_proveedor;
DROP TABLE IF EXISTS producto_deposito;
DROP TABLE IF EXISTS ORDEN_COMPRA;
DROP TABLE IF EXISTS PROVEEDOR;
DROP TABLE IF EXISTS DEPOSITO;
DROP TABLE IF EXISTS PRODUCTO;

CREATE TABLE PRODUCTO (
    id_producto INT PRIMARY KEY,
    codigo_barras VARCHAR(50) UNIQUE,
    descripcion_producto VARCHAR(50),
    peso DECIMAL(12,2),
    dimensiones VARCHAR(100),
    stock_minimo INT,
    categoria VARCHAR(50)
);

CREATE TABLE DEPOSITO (
    id_deposito INT PRIMARY KEY,
    numero_deposito VARCHAR(50),
    nombre_deposito VARCHAR(50),
    direccion_deposito VARCHAR(50),
    responsable_cargo VARCHAR(50),
    capacidad_m3 INT
);

CREATE TABLE PROVEEDOR (
    id_proveedor INT PRIMARY KEY,
    cuit_proveedor VARCHAR(50),
    razon_social VARCHAR(50),
    pais_origen VARCHAR(50),
    persona_contacto VARCHAR(50),
    email_contacto VARCHAR(100) UNIQUE,
    telefono_proveedor VARCHAR(100)
);

CREATE TABLE ORDEN_COMPRA (
    id_orden INT PRIMARY KEY,
    id_proveedor INT,
    id_deposito INT,
    numero_orden VARCHAR(50),
    fecha_emision DATE,
    estado_orden VARCHAR(50),
    fecha_recepcion DATE,
    monto_total DECIMAL(12,2),
    FOREIGN KEY (id_proveedor) REFERENCES PROVEEDOR(id_proveedor),
    FOREIGN KEY (id_deposito) REFERENCES DEPOSITO(id_deposito)
);

CREATE TABLE producto_deposito (
    id_prod_dep INT PRIMARY KEY,
    id_producto INT,
    id_deposito INT,
    cantidad_stock INT,
    ubicacion_fisica VARCHAR(50),
    fecha_ultimo_mov DATE,
    FOREIGN KEY (id_producto) REFERENCES PRODUCTO(id_producto),
    FOREIGN KEY (id_deposito) REFERENCES DEPOSITO(id_deposito)
);

CREATE TABLE producto_proveedor (
    id_prod_prov INT PRIMARY KEY,
    id_producto INT,
    id_proveedor INT,
    precio_costo DECIMAL(12,2),
    plazo_entrega_dias INT,
    fecha_vigencia DATE,
    FOREIGN KEY (id_producto) REFERENCES PRODUCTO(id_producto),
    FOREIGN KEY (id_proveedor) REFERENCES PROVEEDOR(id_proveedor)
);

CREATE TABLE orden_producto (
    id_detalle INT PRIMARY KEY,
    id_orden INT,
    id_producto INT,
    cantidad_pedida INT,
    precio_pactado DECIMAL(12,2),
    cantidad_recibida INT,
    FOREIGN KEY (id_orden) REFERENCES ORDEN_COMPRA(id_orden),
    FOREIGN KEY (id_producto) REFERENCES PRODUCTO(id_producto)
);

-- Datos de PRODUCTO
INSERT INTO PRODUCTO (id_producto, codigo_barras, descripcion_producto, categoria, stock_minimo) VALUES (1, '7791234500011', 'Yerba mate 1kg', 'Infusiones', 100);
INSERT INTO PRODUCTO (id_producto, codigo_barras, descripcion_producto, categoria, stock_minimo) VALUES (2, '7791234500035', 'Arroz largo fino 1kg', 'Cereales', 80);
INSERT INTO PRODUCTO (id_producto, codigo_barras, descripcion_producto, categoria, stock_minimo) VALUES (3, '7791234500042', 'Fideos tirabuzón 500g', 'Pastas', 40);
INSERT INTO PRODUCTO (id_producto, codigo_barras, descripcion_producto, categoria, stock_minimo) VALUES (4, '7791234500059', 'Azúcar 1kg', 'Endulzantes', 120);

-- Datos de DEPOSITO
INSERT INTO DEPOSITO (id_deposito, numero_deposito, nombre_deposito, responsable_cargo, direccion_deposito) VALUES (1, 'D-01', 'Central', 'Juan Pérez', 'Ruta 7 km 5');
INSERT INTO DEPOSITO (id_deposito, numero_deposito, nombre_deposito, responsable_cargo, direccion_deposito) VALUES (2, 'D-02', 'Norte', 'Rosa Díaz', 'Acceso Norte 1200');
INSERT INTO DEPOSITO (id_deposito, numero_deposito, nombre_deposito, responsable_cargo, direccion_deposito) VALUES (3, 'D-03', 'Sur', 'Luis Gómez', 'Ruta 40 km 3');
INSERT INTO DEPOSITO (id_deposito, numero_deposito, nombre_deposito, responsable_cargo, direccion_deposito) VALUES (4, 'D-05', 'Oeste', 'Pablo Ruiz', 'Av. Oeste 450');

-- Datos de PROVEEDOR
INSERT INTO PROVEEDOR (id_proveedor, cuit_proveedor, razon_social, pais_origen, persona_contacto) VALUES (1, '30-71234567-1', 'Molinos del Sur SA', 'Argentina', 'Hernán Molina');
INSERT INTO PROVEEDOR (id_proveedor, cuit_proveedor, razon_social, pais_origen, persona_contacto) VALUES (2, '30-71122334-5', 'Distribuidora Andina', 'Argentina', 'Pedro Lara');
INSERT INTO PROVEEDOR (id_proveedor, cuit_proveedor, razon_social, pais_origen, persona_contacto) VALUES (3, '30-70555666-7', 'AgroPack SA', 'Chile', 'Mónica Gil');
INSERT INTO PROVEEDOR (id_proveedor, cuit_proveedor, razon_social, pais_origen, persona_contacto) VALUES (4, '30-71888999-0', 'Dulces del Plata', 'Brasil', 'Raúl Dos Santos');

-- Datos de ORDEN_COMPRA
INSERT INTO ORDEN_COMPRA (id_orden, id_proveedor, id_deposito, numero_orden, estado_orden) VALUES (1, 1, 1, 'OC-0001', 'Recibida');
INSERT INTO ORDEN_COMPRA (id_orden, id_proveedor, id_deposito, numero_orden, estado_orden) VALUES (2, 2, 2, 'OC-0003', 'Pendiente');
INSERT INTO ORDEN_COMPRA (id_orden, id_proveedor, id_deposito, numero_orden, estado_orden) VALUES (3, 1, 3, 'OC-0004', 'Enviada');
INSERT INTO ORDEN_COMPRA (id_orden, id_proveedor, id_deposito, numero_orden, estado_orden) VALUES (4, 4, 1, 'OC-0005', 'Pendiente');

-- Datos de producto_deposito
INSERT INTO producto_deposito (id_prod_dep, id_producto, id_deposito, cantidad_stock, ubicacion_fisica) VALUES (1, 1, 1, 500, 'A-01');
INSERT INTO producto_deposito (id_prod_dep, id_producto, id_deposito, cantidad_stock, ubicacion_fisica) VALUES (2, 1, 2, 120, 'B-03');
INSERT INTO producto_deposito (id_prod_dep, id_producto, id_deposito, cantidad_stock, ubicacion_fisica) VALUES (3, 2, 3, 80, 'C-01');
INSERT INTO producto_deposito (id_prod_dep, id_producto, id_deposito, cantidad_stock, ubicacion_fisica) VALUES (4, 3, 1, 650, 'A-04');

-- Datos de producto_proveedor
INSERT INTO producto_proveedor (id_prod_prov, id_producto, id_proveedor, precio_costo, plazo_entrega_dias) VALUES (1, 1, 1, 1800, 7);
INSERT INTO producto_proveedor (id_prod_prov, id_producto, id_proveedor, precio_costo, plazo_entrega_dias) VALUES (2, 1, 2, 1850, 10);
INSERT INTO producto_proveedor (id_prod_prov, id_producto, id_proveedor, precio_costo, plazo_entrega_dias) VALUES (3, 2, 2, 900, 7);
INSERT INTO producto_proveedor (id_prod_prov, id_producto, id_proveedor, precio_costo, plazo_entrega_dias) VALUES (4, 4, 4, 650, 15);

-- Datos de orden_producto
INSERT INTO orden_producto (id_detalle, id_orden, id_producto, cantidad_pedida, precio_pactado) VALUES (1, 1, 1, 200, 1800);
INSERT INTO orden_producto (id_detalle, id_orden, id_producto, cantidad_pedida, precio_pactado) VALUES (2, 2, 2, 300, 900);
INSERT INTO orden_producto (id_detalle, id_orden, id_producto, cantidad_pedida, precio_pactado) VALUES (3, 3, 1, 150, 1800);
INSERT INTO orden_producto (id_detalle, id_orden, id_producto, cantidad_pedida, precio_pactado) VALUES (4, 4, 4, 400, 650);
