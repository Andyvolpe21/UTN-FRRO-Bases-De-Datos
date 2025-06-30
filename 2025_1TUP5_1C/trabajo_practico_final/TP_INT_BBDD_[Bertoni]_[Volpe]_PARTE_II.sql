CREATE DATABASE ALLSTAR;
USE ALLSTAR;

CREATE TABLE Tributo (
    id_tributo INT AUTO_INCREMENT PRIMARY KEY,
    tipo VARCHAR(20)
);

CREATE TABLE Cliente (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    direccion VARCHAR(40),
    email VARCHAR(40),
    telefono VARCHAR(14),
    apellido VARCHAR(20),
    nombre VARCHAR(20),
    id_tributo INT,
    FOREIGN KEY (id_tributo) REFERENCES Tributo(id_tributo)
);

CREATE TABLE Promociones (
    id_promo INT AUTO_INCREMENT PRIMARY KEY,
    descripcion VARCHAR(40),
    valido VARCHAR(2) NOT NULL, -- 'SI' o 'NO'
    porcentaje VARCHAR(4) -- Ej: '10%', '5%'
);

CREATE TABLE Categoria (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(30)
);

CREATE TABLE Proveedor (
    id_proveedor INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) NOT NULL,
    telefono VARCHAR(14),
    descripcion_productos TEXT,
    id_categoria INT,
    CONSTRAINT chk_email CHECK (email LIKE '%_@_%._%'),
    FOREIGN KEY (id_categoria) REFERENCES Categoria(id_categoria)
);

CREATE TABLE Producto (
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT,
    id_categoria INT,
    id_proveedor INT,
    id_promo INT,
    activo BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente),
    FOREIGN KEY (id_categoria) REFERENCES Categoria(id_categoria),
    FOREIGN KEY (id_proveedor) REFERENCES Proveedor(id_proveedor),
    FOREIGN KEY (id_promo) REFERENCES Promociones(id_promo)
);

CREATE TABLE Carrito (
    id_carrito INT AUTO_INCREMENT PRIMARY KEY,
    cantidad INT,
    monto DECIMAL(10,2),
    id_producto INT,
    FOREIGN KEY (id_producto) REFERENCES Producto(id_producto)
);

CREATE TABLE Vendedor (
    id_vendedor INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(30),
    apellido VARCHAR(30),
    email VARCHAR(50),
    telefono VARCHAR(14),
    id_carrito INT,
    FOREIGN KEY (id_carrito) REFERENCES Carrito(id_carrito)
);

CREATE TABLE Vendedor_Carrito (
    id_vendedor INT,
    id_carrito INT,
    PRIMARY KEY (id_vendedor, id_carrito),
    FOREIGN KEY (id_vendedor) REFERENCES Vendedor(id_vendedor),
    FOREIGN KEY (id_carrito) REFERENCES Carrito(id_carrito)
);

CREATE TABLE Metodo_de_Pago (
    id_pago INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(30)
);

CREATE TABLE Metodo_Envio (
    id_metodo_e INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(30)
);

CREATE TABLE Venta (
    id_venta INT AUTO_INCREMENT PRIMARY KEY,
    id_vendedor INT,
    id_pago INT,
    id_metodo_e INT,
    FOREIGN KEY (id_vendedor) REFERENCES Vendedor(id_vendedor),
    FOREIGN KEY (id_pago) REFERENCES Metodo_de_Pago(id_pago),
    FOREIGN KEY (id_metodo_e) REFERENCES Metodo_Envio(id_metodo_e)
);

CREATE TABLE Paquete (
    id_paquete INT AUTO_INCREMENT PRIMARY KEY,
    id_venta INT,
    FOREIGN KEY (id_venta) REFERENCES Venta(id_venta)
);

CREATE TABLE Transportista (
    id_transportista INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(30),
    apellido VARCHAR(30),
    telefono VARCHAR(14),
    ruta VARCHAR(50),
    destinos TEXT,
    id_paquete INT,
    FOREIGN KEY (id_paquete) REFERENCES Paquete(id_paquete)
);

INSERT INTO Tributo (id_tributo, tipo) VALUES
(1, 'Factura A'),
(2, 'Factura B'),
(3, 'Factura C');

-- Promociones
INSERT INTO Promociones (id_promo, descripcion, valido, porcentaje) VALUES
(1, 'Descuento verano', 'SI', '20%'),
(2, '2x1 en remeras', 'SI', '50%'),
(3, 'Envío gratis', 'SI', '0%'),
(4, 'Black Friday', 'NO', '30%'),
(5, 'Cyber Monday', 'NO', '25%'),
(6, 'Descuento acumulable', 'SI', '15%'),
(7, 'Outlet invierno', 'SI', '40%'),
(8, 'Primera compra', 'SI', '10%'),
(9, 'Combo familiar', 'SI', '12%'),
(10, 'Día del padre', 'NO', '18%');

-- Categorías
INSERT INTO Categoria (id_categoria, nombre) VALUES
(1, 'Remeras'),
(2, 'Buzos'),
(3, 'Pantalones'),
(4, 'Camperas'),
(5, 'Zapatillas'),
(6, 'Gorras'),
(7, 'Medias'),
(8, 'Accesorios');

-- Métodos de pago
INSERT INTO Metodo_de_Pago (id_pago, nombre) VALUES
(1, 'Efectivo'),
(2, 'Crédito'),
(3, 'Débito'),
(4, 'Transferencia');

-- Métodos de envío
INSERT INTO Metodo_Envio (id_metodo_e, nombre) VALUES
(1, 'Correo Argentino'),
(2, 'OCA'),
(3, 'Andreani');


-- Insertar registros en la tabla Cliente
INSERT INTO Cliente (id_cliente, direccion, email, telefono, apellido, nombre, id_tributo) VALUES
(1, 'Calle Falsa 123', 'cliente1@example.com', 1234567890, 'Gomez', 'Juan', 1),
(2, 'Avenida Siempre Viva 742', 'cliente2@example.com', 1234567891, 'Pérez', 'Ana', 1),
(3, 'Calle 1', 'cliente3@example.com', 1234567892, 'Lopez', 'Carlos', 2),
(4, 'Calle 2', 'cliente4@example.com', 1234567893, 'Martinez', 'Laura', 2),
(5, 'Calle 3', 'cliente5@example.com', 1234567894, 'Fernandez', 'Luis', 3),
(6, 'Calle 4', 'cliente6@example.com', 1234567895, 'Rodriguez', 'Marta', 3),
(7, 'Calle 5', 'cliente7@example.com', 1234567896, 'Gonzalez', 'Pedro', 1),
(8, 'Calle 6', 'cliente8@example.com', 1234567897, 'Hernandez', 'Sofia', 1),
(9, 'Calle 7', 'cliente9@example.com', 1234567898, 'Diaz', 'Javier', 2),
(10, 'Calle 8', 'cliente10@example.com', 1234567899, 'Cruz', 'Elena', 2),
(11, 'Calle 9', 'cliente11@example.com', 1234567800, 'Sanchez', 'Diego', 3),
(12, 'Calle 10', 'cliente12@example.com', 1234567801, 'Morales', 'Clara', 3),
(13, 'Calle 11', 'cliente13@example.com', 1234567802, 'Ortega', 'Fernando', 1),
(14, 'Calle 12', 'cliente14@example.com', 1234567803, 'Castro', 'Patricia', 1),
(15, 'Calle 13', 'cliente15@example.com', 1234567804, 'Rivas', 'Ricardo', 2),
(16, 'Calle 14', 'cliente16@example.com', 1234567805, 'Salazar', 'Veronica', 2),
(17, 'Calle 15', 'cliente17@example.com', 1234567806, 'Mendoza', 'Alberto', 3),
(18, 'Calle 16', 'cliente18@example.com', 1234567807, 'Vega', 'Gabriela', 3),
(19, 'Calle 17', 'cliente19@example.com', 1234567808, 'Cano', 'Jorge', 1),
(20, 'Calle 18', 'cliente20@example.com', 1234567809, 'Soto', 'Lucia', 1),
(21, 'Calle 19', 'cliente21@example.com', 1234567810, 'Rojas', 'Mario', 2),
(22, 'Calle 20', 'cliente22@example.com', 1234567811, 'Ponce', 'Silvia', 2),
(23, 'Calle 21', 'cliente23@example.com', 1234567812, 'Ceballos', 'Hugo', 3),
(24, 'Calle 22', 'cliente24@example.com', 1234567813, 'Cordero', 'Rosa', 3),
(25, 'Calle 23', 'cliente25@example.com', 1234567814, 'Salas', 'Nicolas', 1),
(26, 'Calle 24', 'cliente26@example.com', 1234567815, 'Cruz', 'Mariana', 1),
(27, 'Calle 25', 'cliente27@example.com', 1234567816, 'Maldonado', 'Esteban', 2),
(28, 'Calle 26', 'cliente28@example.com', 1234567817, 'Paredes', 'Claudia', 2),
(29, 'Calle 27', 'cliente29@example.com', 1234567818, 'Sierra', 'Joaquin', 3),
(30, 'Calle 28', 'cliente30@example.com', 1234567819, 'Valdez', 'Patricia', 3),
(31, 'Calle 29', 'cliente31@example.com', 1234567820, 'Cruz', 'Fernando', 1),
(32, 'Calle 30', 'cliente32@example.com', 1234567821, 'Gonzalez', 'Sofia', 1),
(33, 'Calle 31', 'cliente33@example.com', 1234567822, 'Hernandez', 'Luis', 2),
(34, 'Calle 32', 'cliente34@example.com', 1234567823, 'Martinez', 'Ana', 2),
(35, 'Calle 33', 'cliente35@example.com', 1234567824, 'Lopez', 'Carlos', 3),
(36, 'Calle 34', 'cliente36@example.com', 1234567825, 'Diaz', 'Elena', 3),
(37, 'Calle 35', 'cliente37@example.com', 1234567826, 'Gonzalez', 'Pedro', 1),
(38, 'Calle 36', 'cliente38@example.com', 1234567827, 'Fernandez', 'Marta', 1),
(39, 'Calle 37', 'cliente39@example.com', 1234567828, 'Rodriguez', 'Javier', 2),
(40, 'Calle 38', 'cliente40@example.com', 1234567829, 'Sanchez', 'Lucia', 2),
(41, 'Calle 39', 'cliente41@example.com', 1234567830, 'Morales', 'Diego', 3),
(42, 'Calle 40', 'cliente42@example.com', 1234567831, 'Ortega', 'Clara', 3),
(43, 'Calle 41', 'cliente43@example.com', 1234567832, 'Castro', 'Fernando', 1),
(44, 'Calle 42', 'cliente44@example.com', 1234567833, 'Rivas', 'Patricia', 1),
(45, 'Calle 43', 'cliente45@example.com', 1234567834, 'Salazar', 'Ricardo', 2),
(46, 'Calle 44', 'cliente46@example.com', 1234567835, 'Vega', 'Veronica', 2),
(47, 'Calle 45', 'cliente47@example.com', 1234567836, 'Mendoza', 'Alberto', 3),
(48, 'Calle 46', 'cliente48@example.com', 1234567837, 'Cano', 'Gabriela', 3),
(49, 'Calle 47', 'cliente49@example.com', 1234567838, 'Ceballos', 'Jorge', 1),
(50, 'Calle 48', 'cliente50@example.com', 1234567839, 'Cordero', 'Lucia', 1),
(51, 'Calle 49', 'cliente51@example.com', 1234567840, 'Rojas', 'Mario', 2),
(52, 'Calle 50', 'cliente52@example.com', 1234567841, 'Ponce', 'Silvia', 2),
(53, 'Calle 51', 'cliente53@example.com', 1234567842, 'Sierra', 'Hugo', 3),
(54, 'Calle 52', 'cliente54@example.com', 1234567843, 'Valdez', 'Rosa', 3),
(55, 'Calle 53', 'cliente55@example.com', 1234567844, 'Salas', 'Nicolas', 1),
(56, 'Calle 54', 'cliente56@example.com', 1234567845, 'Cruz', 'Mariana', 1),
(57, 'Calle 55', 'cliente57@example.com', 1234567846, 'Maldonado', 'Esteban', 2),
(58, 'Calle 56', 'cliente58@example.com', 1234567847, 'Paredes', 'Claudia', 2),
(59, 'Calle 57', 'cliente59@example.com', 1234567848, 'Sierra', 'Joaquin', 3),
(60, 'Calle 58', 'cliente60@example.com', 1234567849, 'Valdez', 'Patricia', 3),
(61, 'Calle 59', 'cliente61@example.com', 1234567850, 'Cruz', 'Fernando', 1),
(62, 'Calle 60', 'cliente62@example.com', 1234567851, 'Gonzalez', 'Sofia', 1),
(63, 'Calle 61', 'cliente63@example.com', 1234567852, 'Hernandez', 'Luis', 2),
(64, 'Calle 62', 'cliente64@example.com', 1234567853, 'Martinez', 'Ana', 2),
(65, 'Calle 63', 'cliente65@example.com', 1234567854, 'Lopez', 'Carlos', 3),
(66, 'Calle 64', 'cliente66@example.com', 1234567855, 'Diaz', 'Elena', 3),
(67, 'Calle 65', 'cliente67@example.com', 1234567856, 'Gonzalez', 'Pedro', 1),
(68, 'Calle 66', 'cliente68@example.com', 1234567857, 'Fernandez', 'Marta', 1),
(69, 'Calle 67', 'cliente69@example.com', 1234567858, 'Rodriguez', 'Javier', 2),
(70, 'Calle 68', 'cliente70@example.com', 1234567859, 'Sanchez', 'Lucia', 2),
(71, 'Calle 69', 'cliente71@example.com', 1234567860, 'Morales', 'Diego', 3),
(72, 'Calle 70', 'cliente72@example.com', 1234567861, 'Ortega', 'Clara', 3),
(73, 'Calle 71', 'cliente73@example.com', 1234567862, 'Castro', 'Fernando', 1),
(74, 'Calle 72', 'cliente74@example.com', 1234567863, 'Rivas', 'Patricia', 1),
(75, 'Calle 73', 'cliente75@example.com', 1234567864, 'Salazar', 'Ricardo', 2),
(76, 'Calle 74', 'cliente76@example.com', 1234567865, 'Vega', 'Veronica', 2),
(77, 'Calle 75', 'cliente77@example.com', 1234567866, 'Mendoza', 'Alberto', 3),
(78, 'Calle 76', 'cliente78@example.com', 1234567867, 'Cano', 'Gabriela', 3),
(79, 'Calle 77', 'cliente79@example.com', 1234567868, 'Ceballos', 'Jorge', 1),
(80, 'Calle 78', 'cliente80@example.com', 1234567869, 'Cordero', 'Lucia', 1),
(81, 'Calle 79', 'cliente81@example.com', 1234567870, 'Rojas', 'Mario', 2),
(82, 'Calle 80', 'cliente82@example.com', 1234567871, 'Ponce', 'Silvia', 2),
(83, 'Calle 81', 'cliente83@example.com', 1234567872, 'Sierra', 'Hugo', 3),
(84, 'Calle 82', 'cliente84@example.com', 1234567873, 'Valdez', 'Rosa', 3),
(85, 'Calle 83', 'cliente85@example.com', 1234567874, 'Salas', 'Nicolas', 1),
(86, 'Calle 84', 'cliente86@example.com', 1234567875, 'Cruz', 'Mariana', 1),
(87, 'Calle 85', 'cliente87@example.com', 1234567876, 'Maldonado', 'Esteban', 2),
(88, 'Calle 86', 'cliente88@example.com', 1234567877, 'Paredes', 'Claudia', 2),
(89, 'Calle 87', 'cliente89@example.com', 1234567878, 'Sierra', 'Joaquin', 3),
(90, 'Calle 88', 'cliente90@example.com', 1234567879, 'Valdez', 'Patricia', 3),
(91, 'Calle 89', 'cliente91@example.com', 1234567880, 'Cruz', 'Fernando', 1),
(92, 'Calle 90', 'cliente92@example.com', 1234567881, 'Gonzalez', 'Sofia', 1),
(93, 'Calle 91', 'cliente93@example.com', 1234567882, 'Hernandez', 'Luis', 2),
(94, 'Calle 92', 'cliente94@example.com', 1234567883, 'Martinez', 'Ana', 2),
(95, 'Calle 93', 'cliente95@example.com', 1234567884, 'Lopez', 'Carlos', 3),
(96, 'Calle 94', 'cliente96@example.com', 1234567885, 'Diaz', 'Elena', 3),
(97, 'Calle 95', 'cliente97@example.com', 1234567886, 'Gonzalez', 'Pedro', 1),
(98, 'Calle 96', 'cliente98@example.com', 1234567887, 'Fernandez', 'Marta', 1),
(99, 'Calle 97', 'cliente99@example.com', 1234567888, 'Rodriguez', 'Javier', 2),
(100, 'Calle 98', 'cliente100@example.com', 1234567889, 'Sanchez', 'Lucia', 2);

-- INSERT COMPLETO PARA PROVEEDORES (10 registros)
INSERT INTO Proveedor (id_proveedor, email, telefono, descripcion_productos, id_categoria) VALUES
(1, 'proveedor1@moda.com', 1144556677, 'Remeras algodón premium', 1),
(2, 'proveedor2@moda.com', 1144556688, 'Buzos oversize con estampados', 2),
(3, 'proveedor3@moda.com', 1144556699, 'Jeans slim fit y rectos', 3),
(4, 'proveedor4@moda.com', 1144556600, 'Camperas impermeables abrigadas', 4),
(5, 'proveedor5@moda.com', 1144556611, 'Zapatillas running y urbanas', 5),
(6, 'proveedor6@moda.com', 1144556622, 'Gorras planas y snapbacks', 6),
(7, 'proveedor7@moda.com', 1144556633, 'Medias deportivas y casual', 7),
(8, 'proveedor8@moda.com', 1144556644, 'Cinturones y accesorios de cuero', 8),
(9, 'proveedor9@moda.com', 1144556655, 'Remeras manga larga y polo', 1),
(10, 'proveedor10@moda.com', 1144556666, 'Buzos con corderoy y felpa', 2);

-- INSERT COMPLETO PARA PRODUCTOS (100 registros)
INSERT INTO Producto (id_cliente, id_categoria, id_proveedor, id_promo, activo) VALUES
-- Remeras (20 productos)
(1, 1, 1, 1, TRUE), (2, 1, 1, NULL, TRUE), (3, 1, 1, 2, TRUE), (4, 1, 1, NULL, TRUE), (5, 1, 1, 6, TRUE),
(6, 1, 1, NULL, TRUE), (7, 1, 1, 8, TRUE), (8, 1, 1, NULL, TRUE), (9, 1, 1, 1, TRUE), (10, 1, 1, NULL, TRUE),
(11, 1, 9, 2, TRUE), (12, 1, 9, NULL, TRUE), (13, 1, 9, 6, TRUE), (14, 1, 9, NULL, TRUE), (15, 1, 9, 8, TRUE),
(16, 1, 9, NULL, TRUE), (17, 1, 9, 1, TRUE), (18, 1, 9, NULL, TRUE), (19, 1, 9, 2, TRUE), (20, 1, 9, NULL, TRUE),

-- Buzos (15 productos)
(21, 2, 2, 1, TRUE), (22, 2, 2, NULL, TRUE), (23, 2, 2, 6, TRUE), (24, 2, 2, NULL, TRUE), (25, 2, 2, 8, TRUE),
(26, 2, 2, NULL, TRUE), (27, 2, 2, 1, TRUE), (28, 2, 2, NULL, TRUE), (29, 2, 2, 6, TRUE), (30, 2, 2, NULL, TRUE),
(31, 2, 10, 8, TRUE), (32, 2, 10, NULL, TRUE), (33, 2, 10, 1, TRUE), (34, 2, 10, NULL, TRUE), (35, 2, 10, 6, TRUE),

-- Pantalones (15 productos)
(36, 3, 3, 3, TRUE), (37, 3, 3, NULL, TRUE), (38, 3, 3, 7, TRUE), (39, 3, 3, NULL, TRUE), (40, 3, 3, 1, TRUE),
(41, 3, 3, NULL, TRUE), (42, 3, 3, 3, TRUE), (43, 3, 3, NULL, TRUE), (44, 3, 3, 7, TRUE), (45, 3, 3, NULL, TRUE),
(46, 3, 3, 1, TRUE), (47, 3, 3, NULL, TRUE), (48, 3, 3, 3, TRUE), (49, 3, 3, NULL, TRUE), (50, 3, 3, 7, TRUE),

-- Camperas (10 productos)
(51, 4, 4, 4, TRUE), (52, 4, 4, NULL, TRUE), (53, 4, 4, 9, TRUE), (54, 4, 4, NULL, TRUE), (55, 4, 4, 4, TRUE),
(56, 4, 4, NULL, TRUE), (57, 4, 4, 9, TRUE), (58, 4, 4, NULL, TRUE), (59, 4, 4, 4, TRUE), (60, 4, 4, NULL, TRUE),

-- Zapatillas (15 productos)
(61, 5, 5, 2, TRUE), (62, 5, 5, NULL, TRUE), (63, 5, 5, 5, TRUE), (64, 5, 5, NULL, TRUE), (65, 5, 5, 2, TRUE),
(66, 5, 5, NULL, TRUE), (67, 5, 5, 5, TRUE), (68, 5, 5, NULL, TRUE), (69, 5, 5, 2, TRUE), (70, 5, 5, NULL, TRUE),
(71, 5, 5, 5, TRUE), (72, 5, 5, NULL, TRUE), (73, 5, 5, 2, TRUE), (74, 5, 5, NULL, TRUE), (75, 5, 5, 5, TRUE),

-- Gorras (10 productos)
(76, 6, 6, 6, TRUE), (77, 6, 6, NULL, TRUE), (78, 6, 6, 1, TRUE), (79, 6, 6, NULL, TRUE), (80, 6, 6, 6, TRUE),
(81, 6, 6, NULL, TRUE), (82, 6, 6, 1, TRUE), (83, 6, 6, NULL, TRUE), (84, 6, 6, 6, TRUE), (85, 6, 6, NULL, TRUE),

-- Medias (10 productos) 
(86, 7, 7, 7, TRUE), (87, 7, 7, NULL, TRUE), (88, 7, 7, 2, TRUE), (89, 7, 7, NULL, TRUE), (90, 7, 7, 7, TRUE),
(91, 7, 7, NULL, TRUE), (92, 7, 7, 2, TRUE), (93, 7, 7, NULL, TRUE), (94, 7, 7, 7, TRUE), (95, 7, 7, NULL, TRUE),

-- Accesorios (5 productos)
(96, 8, 8, 8, TRUE), (97, 8, 8, NULL, TRUE), (98, 8, 8, 3, TRUE), (99, 8, 8, NULL, TRUE), (100, 8, 8, 8, TRUE);

-- INSERT COMPLETO PARA CARRITO (100 registros)
INSERT INTO Carrito (id_carrito, cantidad, monto, id_producto) VALUES
-- Carritos para productos 1-100
(1, 2, 5998.00, 1), (2, 1, 2499.00, 2), (3, 3, 6597.00, 3), (4, 1, 1899.00, 4), (5, 2, 4998.00, 5),
(6, 1, 1299.00, 6), (7, 4, 11996.00, 7), (8, 1, 3499.00, 8), (9, 2, 4598.00, 9), (10, 1, 1799.00, 10),
(11, 3, 6297.00, 11), (12, 1, 2299.00, 12), (13, 2, 3198.00, 13), (14, 1, 1599.00, 14), (15, 4, 7596.00, 15),
(16, 1, 1999.00, 16), (17, 2, 4398.00, 17), (18, 1, 2199.00, 18), (19, 3, 9897.00, 19), (20, 1, 2999.00, 20),
(21, 2, 8998.00, 21), (22, 1, 4599.00, 22), (23, 3, 9297.00, 23), (24, 1, 2799.00, 24), (25, 2, 6198.00, 25),
(26, 1, 3399.00, 26), (27, 4, 12396.00, 27), (28, 1, 2999.00, 28), (29, 2, 6998.00, 29), (30, 1, 3499.00, 30),
(31, 3, 10197.00, 31), (32, 1, 3799.00, 32), (33, 2, 7198.00, 33), (34, 1, 3699.00, 34), (35, 4, 14396.00, 35),
(36, 1, 4599.00, 36), (37, 2, 9198.00, 37), (38, 1, 4799.00, 38), (39, 3, 13497.00, 39), (40, 1, 4999.00, 40),
(41, 2, 9998.00, 41), (42, 1, 5199.00, 42), (43, 4, 20396.00, 43), (44, 1, 5299.00, 44), (45, 2, 10598.00, 45),
(46, 1, 5399.00, 46), (47, 3, 14697.00, 47), (48, 1, 5499.00, 48), (49, 2, 10998.00, 49), (50, 1, 5599.00, 50),
(51, 4, 22396.00, 51), (52, 1, 5699.00, 52), (53, 2, 11398.00, 53), (54, 1, 5799.00, 54), (55, 3, 15897.00, 55),
(56, 1, 5899.00, 56), (57, 2, 11798.00, 57), (58, 1, 5999.00, 58), (59, 4, 23996.00, 59), (60, 1, 6099.00, 60),
(61, 2, 12198.00, 61), (62, 1, 6199.00, 62), (63, 3, 17097.00, 63), (64, 1, 6299.00, 64), (65, 2, 12598.00, 65),
(66, 1, 6399.00, 66), (67, 4, 25596.00, 67), (68, 1, 6499.00, 68), (69, 2, 12998.00, 69), (70, 1, 6599.00, 70),
(71, 3, 18297.00, 71), (72, 1, 6699.00, 72), (73, 2, 13398.00, 73), (74, 1, 6799.00, 74), (75, 4, 27196.00, 75),
(76, 1, 6899.00, 76), (77, 2, 13798.00, 77), (78, 1, 6999.00, 78), (79, 3, 19497.00, 79), (80, 1, 7099.00, 80),
(81, 2, 14198.00, 81), (82, 1, 7199.00, 82), (83, 4, 28796.00, 83), (84, 1, 7299.00, 84), (85, 2, 14598.00, 85),
(86, 1, 7399.00, 86), (87, 3, 20697.00, 87), (88, 1, 7499.00, 88), (89, 2, 14998.00, 89), (90, 1, 7599.00, 90),
(91, 4, 30396.00, 91), (92, 1, 7699.00, 92), (93, 2, 15398.00, 93), (94, 1, 7799.00, 94), (95, 3, 21897.00, 95),
(96, 1, 7899.00, 96), (97, 2, 15798.00, 97), (98, 1, 7999.00, 98), (99, 4, 31996.00, 99), (100, 1, 8099.00, 100);

-- INSERT COMPLETO PARA VENDEDORES (10 registros)
INSERT INTO Vendedor (id_vendedor, nombre, apellido, email, telefono) VALUES
(1, 'Carlos', 'Gutiérrez', 'vendedor1@tienda.com', 1155667788),
(2, 'María', 'López', 'vendedor2@tienda.com', 1155667789),
(3, 'Juan', 'Martínez', 'vendedor3@tienda.com', 1155667790),
(4, 'Ana', 'Rodríguez', 'vendedor4@tienda.com', 1155667791),
(5, 'Pedro', 'Gómez', 'vendedor5@tienda.com', 1155667792),
(6, 'Lucía', 'Fernández', 'vendedor6@tienda.com', 1155667793),
(7, 'Diego', 'Pérez', 'vendedor7@tienda.com', 1155667794),
(8, 'Sofía', 'Díaz', 'vendedor8@tienda.com', 1155667795),
(9, 'Javier', 'Sánchez', 'vendedor9@tienda.com', 1155667796),
(10, 'Laura', 'Romero', 'vendedor10@tienda.com', 1155667797);

INSERT INTO Vendedor_Carrito (id_vendedor, id_carrito) VALUES
-- Vendedor 1 (10 carritos)
(1, 1), (1, 11), (1, 21), (1, 31), (1, 41), (1, 51), (1, 61), (1, 71), (1, 81), (1, 91),

-- Vendedor 2 (10 carritos)
(2, 2), (2, 12), (2, 22), (2, 32), (2, 42), (2, 52), (2, 62), (2, 72), (2, 82), (2, 92),

-- Vendedor 3 (10 carritos)
(3, 3), (3, 13), (3, 23), (3, 33), (3, 43), (3, 53), (3, 63), (3, 73), (3, 83), (3, 93),

-- Vendedor 4 (10 carritos)
(4, 4), (4, 14), (4, 24), (4, 34), (4, 44), (4, 54), (4, 64), (4, 74), (4, 84), (4, 94),

-- Vendedor 5 (10 carritos)
(5, 5), (5, 15), (5, 25), (5, 35), (5, 45), (5, 55), (5, 65), (5, 75), (5, 85), (5, 95),

-- Vendedor 6 (10 carritos)
(6, 6), (6, 16), (6, 26), (6, 36), (6, 46), (6, 56), (6,66), (6, 76), (6, 86), (6, 96),

-- Vendedor 7 (10 carritos)
(7, 7), (7, 17), (7, 27), (7, 37), (7, 47), (7, 57), (7, 67), (7, 77), (7, 87), (7, 97),

-- Vendedor 8 (10 carritos)
(8, 8), (8, 18), (8, 28), (8, 38), (8, 48), (8, 58), (8, 68), (8, 78), (8, 88), (8, 98),

-- Vendedor 9 (10 carritos)
(9, 9), (9, 19), (9, 29), (9, 39), (9, 49), (9, 59), (9, 69), (9, 79), (9, 89), (9, 99),

-- Vendedor 10 (10 carritos)
(10, 10), (10, 20), (10, 30), (10, 40), (10, 50), (10, 60), (10, 70), (10, 80), (10, 90), (10, 100);

-- INSERT COMPLETO PARA VENTAS (100 registros)
INSERT INTO Venta (id_venta, id_vendedor, id_pago, id_metodo_e) VALUES
-- Ventas 1-100 relacionadas con vendedores 1-10 y métodos aleatorios
(1, 1, 1, 1), (2, 2, 2, 2), (3, 3, 3, 3), (4, 4, 4, 1), (5, 5, 1, 2),
(6, 6, 2, 3), (7, 7, 3, 1), (8, 8, 4, 2), (9, 9, 1, 3), (10, 10, 2, 1),
(11, 1, 3, 2), (12, 2, 4, 3), (13, 3, 1, 1), (14, 4, 2, 2), (15, 5, 3, 3),
(16, 6, 4, 1), (17, 7, 1, 2), (18, 8, 2, 3), (19, 9, 3, 1), (20, 10, 4, 2),
(21, 1, 1, 3), (22, 2, 2, 1), (23, 3, 3, 2), (24, 4, 4, 3), (25, 5, 1, 1),
(26, 6, 2, 2), (27, 7, 3, 3), (28, 8, 4, 1), (29, 9, 1, 2), (30, 10, 2, 3),
(31, 1, 3, 1), (32, 2, 4, 2), (33, 3, 1, 3), (34, 4, 2, 1), (35, 5, 3, 2),
(36, 6, 4, 3), (37, 7, 1, 1), (38, 8, 2, 2), (39, 9, 3, 3), (40, 10, 4, 1),
(41, 1, 1, 2), (42, 2, 2, 3), (43, 3, 3, 1), (44, 4, 4, 2), (45, 5, 1, 3),
(46, 6, 2, 1), (47, 7, 3, 2), (48, 8, 4, 3), (49, 9, 1, 1), (50, 10, 2, 2),
(51, 1, 3, 3), (52, 2, 4, 1), (53, 3, 1, 2), (54, 4, 2, 3), (55, 5, 3, 1),
(56, 6, 4, 2), (57, 7, 1, 3), (58, 8, 2, 1), (59, 9, 3, 2), (60, 10, 4, 3),
(61, 1, 1, 1), (62, 2, 2, 2), (63, 3, 3, 3), (64, 4, 4, 1), (65, 5, 1, 2),
(66, 6, 2, 3), (67, 7, 3, 1), (68, 8, 4, 2), (69, 9, 1, 3), (70, 10, 2, 1),
(71, 1, 3, 2), (72, 2, 4, 3), (73, 3, 1, 1), (74, 4, 2, 2), (75, 5, 3, 3),
(76, 6, 4, 1), (77, 7, 1, 2), (78, 8, 2, 3), (79, 9, 3, 1), (80, 10, 4, 2),
(81, 1, 1, 3), (82, 2, 2, 1), (83, 3, 3, 2), (84, 4, 4, 3), (85, 5, 1, 1),
(86, 6, 2, 2), (87, 7, 3, 3), (88, 8, 4, 1), (89, 9, 1, 2), (90, 10, 2, 3),
(91, 1, 3, 1), (92, 2, 4, 2), (93, 3, 1, 3), (94, 4, 2, 1), (95, 5, 3, 2),
(96, 6, 4, 3), (97, 7, 1, 1), (98, 8, 2, 2), (99, 9, 3, 3), (100, 10, 4, 1);

-- INSERT COMPLETO PARA PAQUETES (100 registros)
INSERT INTO Paquete (id_paquete, id_venta) VALUES
-- Paquetes 1-100 relacionados con ventas 1-100
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5),
(6, 6), (7, 7), (8, 8), (9, 9), (10, 10),
(11, 11), (12, 12), (13, 13), (14, 14), (15, 15),
(16, 16), (17, 17), (18, 18), (19, 19), (20, 20),
(21, 21), (22, 22), (23, 23), (24, 24), (25, 25),
(26, 26), (27, 27), (28, 28), (29, 29), (30, 30),
(31, 31), (32, 32), (33, 33), (34, 34), (35, 35),
(36, 36), (37, 37), (38, 38), (39, 39), (40, 40),
(41, 41), (42, 42), (43, 43), (44, 44), (45, 45),
(46, 46), (47, 47), (48, 48), (49, 49), (50, 50),
(51, 51), (52, 52), (53, 53), (54, 54), (55, 55),
(56, 56), (57, 57), (58, 58), (59, 59), (60, 60),
(61, 61), (62, 62), (63, 63), (64, 64), (65, 65),
(66, 66), (67, 67), (68, 68), (69, 69), (70, 70),
(71, 71), (72, 72), (73, 73), (74, 74), (75, 75),
(76, 76), (77, 77), (78, 78), (79, 79), (80, 80),
(81, 81), (82, 82), (83, 83), (84, 84), (85, 85),
(86, 86), (87, 87), (88, 88), (89, 89), (90, 90),
(91, 91), (92, 92), (93, 93), (94, 94), (95, 95),
(96, 96), (97, 97), (98, 98), (99, 99), (100, 100);

-- INSERT COMPLETO PARA TRANSPORTISTAS (10 registros)
INSERT INTO Transportista (id_transportista, nombre, apellido, telefono, ruta, destinos, id_paquete) VALUES
(1, 'Roberto', 'García', 1166778899, 'Centro-Norte', 'Capital, GBA Norte, Tigre, San Fernando', 1),
(2, 'Miguel', 'Suárez', 1166778800, 'Centro-Sur', 'Capital, GBA Sur, Avellaneda, Quilmes', 2),
(3, 'Alejandro', 'Fernández', 1166778811, 'Oeste', 'Capital, GBA Oeste, Morón, Merlo', 3),
(4, 'Ricardo', 'Pereyra', 1166778822, 'Norte', 'GBA Norte, San Isidro, Vicente López', 4),
(5, 'Oscar', 'Dominguez', 1166778833, 'Sur', 'GBA Sur, Lanús, Lomas de Zamora', 5),
(6, 'Gabriel', 'López', 1166778844, 'CABA', 'Capital Federal', 6),
(7, 'Daniel', 'Martinez', 1166778855, 'Interior', 'Córdoba, Rosario, Mendoza', 7),
(8, 'Jorge', 'Rodriguez', 1166778866, 'Centro-Este', 'Capital, GBA Este, Berazategui', 8),
(9, 'Luis', 'González', 1166778877, 'Metropolitana', 'Capital + GBA', 9),
(10, 'Pablo', 'Hernández', 1166778888, 'Nacional', 'Todo el país', 10);

-- ==============================================================================================================
-- a) INNER JOIN

-- mostrar clientes que compraron productos fuera de promocion
SELECT c.nombre, c.apellido FROM cliente c
INNER JOIN producto p on p.id_cliente=c.id_cliente
WHERE P.id_promo IS NULL;

-- mostrar clientes que compraron remeras
SELECT c.nombre, c.apellido, l.nombre as categoria FROM cliente c
INNER JOIN producto p on p.id_cliente=c.id_cliente
INNER JOIN categoria l on l.id_categoria=p.id_categoria
WHERE P.id_categoria = '1';

-- =================================================================================================================
-- b) LEFT o RIGHT JOIN 
 
-- Clientes y sus carritos
SELECT c.nombre AS Cliente, apellido AS Apellido, c.email AS Email, c.telefono AS Telefono,
ca.id_carrito AS Carrito_ID, ca.monto AS Monto FROM Cliente c
LEFT JOIN Carrito ca ON c.id_cliente = ca.id_producto;

-- Productos y sus proveedores

SELECT p.id_producto AS Producto_ID, p.id_categoria AS Categoria_ID, pr.descripcion_productos AS Descripcion_Productos,
pr.telefono AS Telefono_Proveedor FROM Producto p
RIGHT JOIN Proveedor pr ON p.id_proveedor = pr.id_proveedor;

-- ===============================================================================================================
-- c)
-- Total de monto por cada vendedor

SELECT v.nombre AS Vendedor, SUM(c.monto) AS Total_Monto FROM Vendedor v
JOIN Vendedor_Carrito vc ON v.id_vendedor = vc.id_vendedor
JOIN Carrito c ON vc.id_carrito = c.id_carrito
GROUP BY v.id_vendedor, v.nombre;

--  Promedio de monto por categoría de producto con condición

SELECT cat.nombre AS Categoria, AVG(c.monto) AS Promedio_Monto FROM Categoria cat
JOIN Producto p ON cat.id_categoria = p.id_categoria
JOIN Carrito c ON p.id_producto = c.id_producto
GROUP BY cat.id_categoria, cat.nombre
HAVING AVG(c.monto) > 5000;

-- ==============================================================================================================

-- d) 

-- Vendedores con un total de monto superior al promedio

SELECT v.nombre AS Vendedor, SUM(c.monto) AS Total_Monto FROM Vendedor v
JOIN Vendedor_Carrito vc ON v.id_vendedor = vc.id_vendedor
JOIN Carrito c ON vc.id_carrito = c.id_carrito
GROUP BY v.id_vendedor, v.nombre
HAVING SUM(c.monto) > (SELECT AVG(Total) FROM (
            SELECT SUM(c2.monto) AS Total FROM Vendedor v2
            JOIN Vendedor_Carrito vc2 ON v2.id_vendedor = vc2.id_vendedor
            JOIN Carrito c2 ON vc2.id_carrito = c2.id_carrito
            GROUP BY v2.id_vendedor) AS Subquery
);

-- Productos que tienen un precio superior al promedio de su categoría

SELECT p.id_producto AS Producto_ID, p.id_categoria AS Categoria_ID, c.monto AS Monto FROM Producto p
JOIN Carrito c ON p.id_producto = c.id_producto
WHERE c.monto > (
        SELECT AVG(c2.monto) FROM Producto p2
        JOIN Carrito c2 ON p2.id_producto = c2.id_producto
        WHERE p2.id_categoria = p.id_categoria
);

-- ==============================================================================================================

-- e) ORDER BY

-- Vendedores con un total de monto superior al promedio (* agregue uno con ordenamiento porque no tenia *) 

SELECT v.nombre AS Vendedor, SUM(c.monto) AS Total_Monto FROM Vendedor v
JOIN Vendedor_Carrito vc ON v.id_vendedor = vc.id_vendedor
JOIN Carrito c ON vc.id_carrito = c.id_carrito
GROUP BY v.id_vendedor, v.nombre
HAVING SUM(c.monto) > ( SELECT AVG(Total) FROM (
            SELECT SUM(c2.monto) AS Total FROM Vendedor v2
            JOIN Vendedor_Carrito vc2 ON v2.id_vendedor = vc2.id_vendedor
            JOIN Carrito c2 ON vc2.id_carrito = c2.id_carrito
            GROUP BY v2.id_vendedor) 
            AS Subquery )
ORDER BY Total_Monto DESC;

-- ==============================================================================================================

-- 4)

-- a) Insertar un nuevo cliente

DELIMITER //
CREATE PROCEDURE InsertarCliente(
    IN p_direccion VARCHAR(40),
    IN p_email VARCHAR(40),
    IN p_telefono VARCHAR(14),
    IN p_apellido VARCHAR(20),
    IN p_nombre VARCHAR(20),
    IN p_id_tributo INT
)
BEGIN
    INSERT INTO Cliente (direccion, email, telefono, apellido, nombre, id_tributo)
    VALUES (p_direccion, p_email, p_telefono, p_apellido, p_nombre, p_id_tributo);
END // DELIMITER ;

-- Ejemplo

CALL InsertarCliente('Mitre 1234', 'nuevo_cliente@gmail.com', 3482255588, 'Bertoni', 'Ivo', 1);

-- =================================================================================================================

-- b) Actualizar el estado de un pedido

DELIMITER //
CREATE PROCEDURE ActualizarEstadoVenta(
    IN p_id_venta INT,
    IN p_id_metodo_e INT
)
BEGIN
    UPDATE Venta
    SET id_metodo_e = p_id_metodo_e
    WHERE id_venta = p_id_venta;
END // DELIMITER ;

-- Ejemplo 

CALL ActualizarEstadoVenta(1, 2);


-- =============================================================================================================

-- c) Eliminar un producto (SOFT)

DELIMITER //
CREATE PROCEDURE DesactivarProductoSimple(
    IN p_id_producto INT
)
BEGIN
    UPDATE Producto 
    SET activo = FALSE 
    WHERE id_producto = p_id_producto;
END // DELIMITER ;

-- Ejemplo 

CALL EliminarProducto(10);
