CREATE DATABASE BBDDAseguradora
GO
USE BBDDAseguradora

CREATE TABLE Provincias(
id_provincia INT IDENTITY(1,1),
nombre_provincia VARCHAR(100) NOT NULL,
CONSTRAINT pk_provincias PRIMARY KEY(id_provincia),
);

CREATE TABLE Localidades(
id_localidad int IDENTITY(1,1),
nombre_localidad VARCHAR(100) NOT NULL,
id_provincia INT,
CONSTRAINT pk_localidad PRIMARY KEY(id_localidad),
CONSTRAINT fk_localidades_provincias FOREIGN KEY(id_provincia)
  		  REFERENCES Provincias(id_provincia)
);

CREATE TABLE Barrios(
id_barrio INT IDENTITY(1,1),
nombre_barrio VARCHAR(100) NOT NULL,
id_localidad INT,
CONSTRAINT pk_barrio PRIMARY KEY(id_barrio),
CONSTRAINT fk_barrios_localidades FOREIGN KEY(id_localidad)
  		  REFERENCES Localidades(id_localidad)
);

CREATE TABLE Codigos_postales(
id_cod_postal INT IDENTITY(1,1),
id_barrio INT,
numero INT NOT NULL,
CONSTRAINT pk_codigos_postales PRIMARY KEY (id_cod_postal),
CONSTRAINT fk_codigos_barrios FOREIGN KEY (id_barrio)
		REFERENCES Barrios (id_barrio)
);

CREATE TABLE Sucursales(
id_sucursal INT IDENTITY(1,1),
direccion VARCHAR(100) NOT NULL,
id_localidad INT NOT NULL,
CONSTRAINT pk_sucursales PRIMARY KEY (id_sucursal),
CONSTRAINT fk_sucursales_localidades FOREIGN KEY (id_localidad)
		REFERENCES Localidades (id_localidad)
);

CREATE TABLE Clientes (
id_cliente INT IDENTITY(1,1),
apellido VARCHAR(150) NOT NULL,
nombre VARCHAR(150) NOT NULL,
telefono VARCHAR(10) NOT NULL,
mail VARCHAR(100) NOT NULL,
CONSTRAINT pk_clientes PRIMARY KEY(id_cliente),
);

CREATE TABLE Anios (
id_anio INT IDENTITY(1,1),
año INT NOT NULL,
CONSTRAINT pk_anios PRIMARY KEY (id_anio)
);

CREATE TABLE Tipos_vehiculos (
id_tipo INT IDENTITY(1,1),
nombre VARCHAR(100) NOT NULL
CONSTRAINT pk_tipos_vehic PRIMARY KEY (id_tipo)
);

CREATE TABLE Marcas (
id_marca INT IDENTITY(1,1),
nombre VARCHAR(100) NOT NULL,
id_tipo INT,
CONSTRAINT pk_marcas PRIMARY KEY (id_marca),
CONSTRAINT fk_marcas_tipos FOREIGN KEY (id_tipo)
		REFERENCES Tipos_vehiculos (id_tipo)
);

CREATE TABLE Modelos (
id_modelo INT IDENTITY(1,1),
nombre VARCHAR(100) NOT NULL,
id_marca INT,
CONSTRAINT pk_modelos PRIMARY KEY (id_modelo),
CONSTRAINT fk_modelos_marcas FOREIGN KEY (id_marca)
		REFERENCES Marcas (id_marca)
);

CREATE TABLE Versiones (
id_version INT IDENTITY (1,1),
descripcion VARCHAR(100) NOT NULL,
id_modelo INT,
id_anio INT,
CONSTRAINT pk_versiones PRIMARY KEY (id_version),
CONSTRAINT fk_versiones_modelos FOREIGN KEY (id_modelo)
		REFERENCES Modelos (id_modelo),
CONSTRAINT fk_versiones_anios FOREIGN KEY (id_anio)
		REFERENCES Anios (id_anio)
);

CREATE TABLE Tipos_seguros (
id_tipo_seg INT IDENTITY(1, 1),
nombre VARCHAR(100) NOT NULL,
CONSTRAINT pk_tipos_seg PRIMARY KEY	(id_tipo_seg),
);

CREATE TABLE Coberturas (
id_cobertura INT IDENTITY(1,1),
descripcion VARCHAR(100) NOT NULL,
CONSTRAINT pk_coberturas PRIMARY KEY (id_cobertura)
);

CREATE TABLE Niveles_riesgo (
id_nivel INT IDENTITY(1,1),
nombre VARCHAR(20) NOT NULL,
CONSTRAINT pk_niveles PRIMARY KEY (id_nivel)
);

CREATE TABLE Zonas_riesgo (
id_zona INT IDENTITY(1,1),
id_nivel INT,
id_cod_postal INT,
CONSTRAINT pk_zonas PRIMARY KEY (id_zona),
CONSTRAINT fk_zonas_niveles FOREIGN KEY (id_nivel)
		REFERENCES Niveles_riesgo (id_nivel),
CONSTRAINT fk_zonas_codigos FOREIGN KEY (id_cod_postal)
		REFERENCES Codigos_postales (id_cod_postal)
);

CREATE TABLE Seguros (
id_seguro INT IDENTITY (1,1),
id_tipo_seg INT,
id_version INT,
precio DECIMAL(10,2) NOT NULL,
CONSTRAINT pk_seguros PRIMARY KEY (id_seguro),
CONSTRAINT fk_seguros_tipos FOREIGN KEY (id_tipo_seg)
		REFERENCES Tipos_seguros (id_tipo_seg),
CONSTRAINT fk_seguros_versiones FOREIGN KEY (id_version)
		REFERENCES Versiones (id_version)
);

CREATE TABLE Detalles_seguro (
id_detalle INT IDENTITY(1,1),
id_seguro INT,
id_cobertura INT,
CONSTRAINT pk_detalles PRIMARY KEY (id_detalle),
CONSTRAINT fk_detalles_seguros FOREIGN key (id_seguro)
		REFERENCES Seguros (id_seguro),
CONSTRAINT fk_detalles_coberturas FOREIGN KEY(id_cobertura)
		REFERENCES Coberturas (id_cobertura)
);

CREATE TABLE Cotizaciones (
id_cotizacion INT IDENTITY(1,1),
id_cliente INT,
fecha_emision DATETIME NOT NULL,
fecha_venc DATETIME NOT NULL,
id_cod_postal INT, 
id_seguro INT,
precio DECIMAL(10,2) NOT NULL,
aprobada BIT NOT NULL,
id_sucursal INT,
CONSTRAINT pk_cotizaciones PRIMARY KEY (id_cotizacion),
CONSTRAINT fk_cotizaciones_clientes FOREIGN KEY (id_cliente)
		REFERENCES Clientes (id_cliente),
CONSTRAINT fk_cotizaciones_codigos FOREIGN KEY (id_cod_postal)
		REFERENCES Codigos_postales (id_cod_postal),
CONSTRAINT fk_cotizaciones_seguros FOREIGN KEY (id_seguro)
		REFERENCES Seguros (id_seguro),
CONSTRAINT fk_cotizaciones_sucursales FOREIGN KEY (id_sucursal)
		REFERENCES Sucursales (id_sucursal)
);




--INSERTS 
--COPIAR ESTO SI O SI
SET DATEFORMAT dmy
--- PROVINCIAS 
INSERT INTO Provincias (nombre_provincia) VALUES ('Cordoba');
INSERT INTO Provincias (nombre_provincia) VALUES ('Mendoza');
INSERT INTO Provincias (nombre_provincia) VALUES ('Buenos Aires');
INSERT INTO Provincias (nombre_provincia) VALUES ('Santa Fe');
INSERT INTO Provincias (nombre_provincia) VALUES ('Neuquen');

--- LOCALIDADES
INSERT INTO Localidades (nombre_localidad, id_provincia) VALUES ('Cordoba', 1);
INSERT INTO Localidades (nombre_localidad, id_provincia) VALUES ('Villa Carlos Paz', 1);
INSERT INTO Localidades (nombre_localidad, id_provincia) VALUES ('Rio Cuarto', 1);
INSERT INTO Localidades (nombre_localidad, id_provincia) VALUES ('San Francisco', 1);
INSERT INTO Localidades (nombre_localidad, id_provincia) VALUES ('Alta Gracia', 1);
INSERT INTO Localidades (nombre_localidad, id_provincia) VALUES ('Mendoza', 2);
INSERT INTO Localidades (nombre_localidad, id_provincia) VALUES ('San Rafael', 2);
INSERT INTO Localidades (nombre_localidad, id_provincia) VALUES ('Godoy Cruz', 2);
INSERT INTO Localidades (nombre_localidad, id_provincia) VALUES ('Lujan de Cuyo', 2);
INSERT INTO Localidades (nombre_localidad, id_provincia) VALUES ('Maipu', 2);
INSERT INTO Localidades (nombre_localidad, id_provincia) VALUES ('La Plata', 3);
INSERT INTO Localidades (nombre_localidad, id_provincia) VALUES ('Mar del Plata', 3);
INSERT INTO Localidades (nombre_localidad, id_provincia) VALUES ('Bahía Blanca', 3);
INSERT INTO Localidades (nombre_localidad, id_provincia) VALUES ('Tandil', 3);
INSERT INTO Localidades (nombre_localidad, id_provincia) VALUES ('Olavarria', 3);
INSERT INTO Localidades (nombre_localidad, id_provincia) VALUES ('Santa Fe', 4);
INSERT INTO Localidades (nombre_localidad, id_provincia) VALUES ('Rosario', 4);
INSERT INTO Localidades (nombre_localidad, id_provincia) VALUES ('Venado Tuerto', 4);
INSERT INTO Localidades (nombre_localidad, id_provincia) VALUES ('Rafaela', 4);
INSERT INTO Localidades (nombre_localidad, id_provincia) VALUES ('Reconquista', 4);
INSERT INTO Localidades (nombre_localidad, id_provincia) VALUES ('Neuquen', 5);
INSERT INTO Localidades (nombre_localidad, id_provincia) VALUES ('San Martin de los Andes', 5);
INSERT INTO Localidades (nombre_localidad, id_provincia) VALUES ('Villa La Angostura', 5);
INSERT INTO Localidades (nombre_localidad, id_provincia) VALUES ('Plottier', 5);
INSERT INTO Localidades (nombre_localidad, id_provincia) VALUES ('Zapala', 5);

--- BARRIOS
INSERT INTO Barrios (nombre_barrio, id_localidad) VALUES ('Nueva Córdoba', 1);
INSERT INTO Barrios (nombre_barrio, id_localidad) VALUES ('Güemes', 1);
INSERT INTO Barrios (nombre_barrio, id_localidad) VALUES ('Alta Córdoba', 1);
INSERT INTO Barrios (nombre_barrio, id_localidad) VALUES ('Centro', 2);
INSERT INTO Barrios (nombre_barrio, id_localidad) VALUES ('Villa del Lago', 2);
INSERT INTO Barrios (nombre_barrio, id_localidad) VALUES ('El Fantasio', 2);
INSERT INTO Barrios (nombre_barrio, id_localidad) VALUES ('Centro', 3);
INSERT INTO Barrios (nombre_barrio, id_localidad) VALUES ('Alberdi', 3);
INSERT INTO Barrios (nombre_barrio, id_localidad) VALUES ('Las Delicias', 3);
INSERT INTO Barrios (nombre_barrio, id_localidad) VALUES ('Centro', 4);
INSERT INTO Barrios (nombre_barrio, id_localidad) VALUES ('Barrio Sarmiento', 4);
INSERT INTO Barrios (nombre_barrio, id_localidad) VALUES ('Villa El Parque', 4);
INSERT INTO Barrios (nombre_barrio, id_localidad) VALUES ('Centro', 5);
INSERT INTO Barrios (nombre_barrio, id_localidad) VALUES ('Villa Oviedo', 5);
INSERT INTO Barrios (nombre_barrio, id_localidad) VALUES ('Parque Virrey', 5);
INSERT INTO Barrios (nombre_barrio, id_localidad) VALUES ('Ciudad', 6);
INSERT INTO Barrios (nombre_barrio, id_localidad) VALUES ('Godoy Cruz', 6);
INSERT INTO Barrios (nombre_barrio, id_localidad) VALUES ('Guaymallén', 6);
INSERT INTO Barrios (nombre_barrio, id_localidad) VALUES ('Centro', 7);
INSERT INTO Barrios (nombre_barrio, id_localidad) VALUES ('El Nihuil', 7);
INSERT INTO Barrios (nombre_barrio, id_localidad) VALUES ('Pueblo Histórico', 7);
INSERT INTO Barrios (nombre_barrio, id_localidad) VALUES ('Centro', 8);
INSERT INTO Barrios (nombre_barrio, id_localidad) VALUES ('Villa del Parque', 8);
INSERT INTO Barrios (nombre_barrio, id_localidad) VALUES ('La Gloria', 8);
INSERT INTO Barrios (nombre_barrio, id_localidad) VALUES ('Chacras de Coria', 9);
INSERT INTO Barrios (nombre_barrio, id_localidad) VALUES ('Vistalba', 9);
INSERT INTO Barrios (nombre_barrio, id_localidad) VALUES ('Luján Centro', 9);
INSERT INTO Barrios (nombre_barrio, id_localidad) VALUES ('Centro', 10);
INSERT INTO Barrios (nombre_barrio, id_localidad) VALUES ('La Primavera', 10);
INSERT INTO Barrios (nombre_barrio, id_localidad) VALUES ('Rodeo del Medio', 10);
INSERT INTO Barrios (nombre_barrio, id_localidad) VALUES ('Centro', 11);
INSERT INTO Barrios (nombre_barrio, id_localidad) VALUES ('City Bell', 11);
INSERT INTO Barrios (nombre_barrio, id_localidad) VALUES ('Tolosa', 11);
INSERT INTO Barrios (nombre_barrio, id_localidad) VALUES ('Centro', 12);
INSERT INTO Barrios (nombre_barrio, id_localidad) VALUES ('Playa Grande', 12);
INSERT INTO Barrios (nombre_barrio, id_localidad) VALUES ('La Perla', 12);
INSERT INTO Barrios (nombre_barrio, id_localidad) VALUES ('Centro', 13);
INSERT INTO Barrios (nombre_barrio, id_localidad) VALUES ('Palihue', 13);
INSERT INTO Barrios (nombre_barrio, id_localidad) VALUES ('Villa Mitre', 13);
INSERT INTO Barrios (nombre_barrio, id_localidad) VALUES ('Centro', 14);
INSERT INTO Barrios (nombre_barrio, id_localidad) VALUES ('La Movediza', 14);
INSERT INTO Barrios (nombre_barrio, id_localidad) VALUES ('Villa Italia', 14);
INSERT INTO Barrios (nombre_barrio, id_localidad) VALUES ('Centro', 15);
INSERT INTO Barrios (nombre_barrio, id_localidad) VALUES ('Villa Floresta', 15);
INSERT INTO Barrios (nombre_barrio, id_localidad) VALUES ('Barrio San Vicente', 15);
INSERT INTO Barrios (nombre_barrio, id_localidad) VALUES ('Centro', 16);
INSERT INTO Barrios (nombre_barrio, id_localidad) VALUES ('Candioti', 16);
INSERT INTO Barrios (nombre_barrio, id_localidad) VALUES ('Guadalupe', 16);
INSERT INTO Barrios (nombre_barrio, id_localidad) VALUES ('Centro', 17);
INSERT INTO Barrios (nombre_barrio, id_localidad) VALUES ('Echesortu', 17);
INSERT INTO Barrios (nombre_barrio, id_localidad) VALUES ('Pichincha', 17);
INSERT INTO Barrios (nombre_barrio, id_localidad) VALUES ('Centro', 18);
INSERT INTO Barrios (nombre_barrio, id_localidad) VALUES ('Santa Fe', 18);
INSERT INTO Barrios (nombre_barrio, id_localidad) VALUES ('La Loma', 18);
INSERT INTO Barrios (nombre_barrio, id_localidad) VALUES ('Centro', 19);
INSERT INTO Barrios (nombre_barrio, id_localidad) VALUES ('Villa Los Eucaliptos', 19);
INSERT INTO Barrios (nombre_barrio, id_localidad) VALUES ('La Cañada', 19);
INSERT INTO Barrios (nombre_barrio, id_localidad) VALUES ('Centro', 20);
INSERT INTO Barrios (nombre_barrio, id_localidad) VALUES ('Barrio Norte', 20);
INSERT INTO Barrios (nombre_barrio, id_localidad) VALUES ('La Loma', 20);
INSERT INTO Barrios (nombre_barrio, id_localidad) VALUES ('Centro', 21);
INSERT INTO Barrios (nombre_barrio, id_localidad) VALUES ('Confluencia', 21);
INSERT INTO Barrios (nombre_barrio, id_localidad) VALUES ('Alta Barda', 21);
INSERT INTO Barrios (nombre_barrio, id_localidad) VALUES ('Centro', 22);
INSERT INTO Barrios (nombre_barrio, id_localidad) VALUES ('Villa Cahuín', 22);
INSERT INTO Barrios (nombre_barrio, id_localidad) VALUES ('Barrio El Arenal', 22);
INSERT INTO Barrios (nombre_barrio, id_localidad) VALUES ('Centro', 23);
INSERT INTO Barrios (nombre_barrio, id_localidad) VALUES ('Puerto Manzano', 23);
INSERT INTO Barrios (nombre_barrio, id_localidad) VALUES ('Villa de los Coihues', 23);
INSERT INTO Barrios (nombre_barrio, id_localidad) VALUES ('Centro', 24);
INSERT INTO Barrios (nombre_barrio, id_localidad) VALUES ('Barrio San Pablo', 24);
INSERT INTO Barrios (nombre_barrio, id_localidad) VALUES ('Barrio El Trapial', 24);
INSERT INTO Barrios (nombre_barrio, id_localidad) VALUES ('Centro', 25);
INSERT INTO Barrios (nombre_barrio, id_localidad) VALUES ('Barrio Los Arrayanes', 25);
INSERT INTO Barrios (nombre_barrio, id_localidad) VALUES ('Barrio La Unión', 25);

--- CODIGOS_POSTALES
--- CÓDIGOS POSTALES
INSERT INTO Codigos_postales (id_barrio, numero) VALUES (1, 5000); 
INSERT INTO Codigos_postales (id_barrio, numero) VALUES (2, 5000); 
INSERT INTO Codigos_postales (id_barrio, numero) VALUES (3, 5000);  
INSERT INTO Codigos_postales (id_barrio, numero) VALUES (4, 5152);  
INSERT INTO Codigos_postales (id_barrio, numero) VALUES (5, 5152);  
INSERT INTO Codigos_postales (id_barrio, numero) VALUES (6, 5152);  
INSERT INTO Codigos_postales (id_barrio, numero) VALUES (7, 5800);  
INSERT INTO Codigos_postales (id_barrio, numero) VALUES (8, 5800);  
INSERT INTO Codigos_postales (id_barrio, numero) VALUES (9, 5800);  
INSERT INTO Codigos_postales (id_barrio, numero) VALUES (10, 2400); 
INSERT INTO Codigos_postales (id_barrio, numero) VALUES (11, 2400); 
INSERT INTO Codigos_postales (id_barrio, numero) VALUES (12, 2400); 
INSERT INTO Codigos_postales (id_barrio, numero) VALUES (13, 5186); 
INSERT INTO Codigos_postales (id_barrio, numero) VALUES (14, 5186); 
INSERT INTO Codigos_postales (id_barrio, numero) VALUES (15, 5186); 
INSERT INTO Codigos_postales (id_barrio, numero) VALUES (16, 5500); 
INSERT INTO Codigos_postales (id_barrio, numero) VALUES (17, 5501); 
INSERT INTO Codigos_postales (id_barrio, numero) VALUES (18, 5509); 
INSERT INTO Codigos_postales (id_barrio, numero) VALUES (19, 5600); 
INSERT INTO Codigos_postales (id_barrio, numero) VALUES (20, 5600); 
INSERT INTO Codigos_postales (id_barrio, numero) VALUES (21, 5600); 
INSERT INTO Codigos_postales (id_barrio, numero) VALUES (22, 5505); 
INSERT INTO Codigos_postales (id_barrio, numero) VALUES (23, 5505);
INSERT INTO Codigos_postales (id_barrio, numero) VALUES (24, 5505); 
INSERT INTO Codigos_postales (id_barrio, numero) VALUES (25, 5507); 
INSERT INTO Codigos_postales (id_barrio, numero) VALUES (26, 5509);
INSERT INTO Codigos_postales (id_barrio, numero) VALUES (27, 5509); 
INSERT INTO Codigos_postales (id_barrio, numero) VALUES (28, 5515); 
INSERT INTO Codigos_postales (id_barrio, numero) VALUES (29, 5515); 
INSERT INTO Codigos_postales (id_barrio, numero) VALUES (30, 5515); 
INSERT INTO Codigos_postales (id_barrio, numero) VALUES (31, 1900); 
INSERT INTO Codigos_postales (id_barrio, numero) VALUES (32, 1900); 
INSERT INTO Codigos_postales (id_barrio, numero) VALUES (33, 1900); 
INSERT INTO Codigos_postales (id_barrio, numero) VALUES (34, 7600); 
INSERT INTO Codigos_postales (id_barrio, numero) VALUES (35, 7600); 
INSERT INTO Codigos_postales (id_barrio, numero) VALUES (36, 7600); 
INSERT INTO Codigos_postales (id_barrio, numero) VALUES (37, 8000); 
INSERT INTO Codigos_postales (id_barrio, numero) VALUES (38, 8000); 
INSERT INTO Codigos_postales (id_barrio, numero) VALUES (39, 8000); 
INSERT INTO Codigos_postales (id_barrio, numero) VALUES (40, 7000); 
INSERT INTO Codigos_postales (id_barrio, numero) VALUES (41, 7000); 
INSERT INTO Codigos_postales (id_barrio, numero) VALUES (42, 7000); 
INSERT INTO Codigos_postales (id_barrio, numero) VALUES (43, 7400); 
INSERT INTO Codigos_postales (id_barrio, numero) VALUES (44, 7400); 
INSERT INTO Codigos_postales (id_barrio, numero) VALUES (45, 7400); 
INSERT INTO Codigos_postales (id_barrio, numero) VALUES (46, 3000); 
INSERT INTO Codigos_postales (id_barrio, numero) VALUES (47, 3000); 
INSERT INTO Codigos_postales (id_barrio, numero) VALUES (48, 3000); 
INSERT INTO Codigos_postales (id_barrio, numero) VALUES (49, 2000); 
INSERT INTO Codigos_postales (id_barrio, numero) VALUES (50, 2000); 
INSERT INTO Codigos_postales (id_barrio, numero) VALUES (51, 2000); 
INSERT INTO Codigos_postales (id_barrio, numero) VALUES (52, 3000); 
INSERT INTO Codigos_postales (id_barrio, numero) VALUES (53, 3000);
INSERT INTO Codigos_postales (id_barrio, numero) VALUES (54, 3000); 
INSERT INTO Codigos_postales (id_barrio, numero) VALUES (55, 3400); 
INSERT INTO Codigos_postales (id_barrio, numero) VALUES (56, 3400);
INSERT INTO Codigos_postales (id_barrio, numero) VALUES (57, 3400); 
INSERT INTO Codigos_postales (id_barrio, numero) VALUES (58, 8300); 
INSERT INTO Codigos_postales (id_barrio, numero) VALUES (59, 8300); 
INSERT INTO Codigos_postales (id_barrio, numero) VALUES (60, 8300);
INSERT INTO Codigos_postales (id_barrio, numero) VALUES (61, 8316); 
INSERT INTO Codigos_postales (id_barrio, numero) VALUES (62, 8316); 
INSERT INTO Codigos_postales (id_barrio, numero) VALUES (63, 8316); 
INSERT INTO Codigos_postales (id_barrio, numero) VALUES (64, 8407); 
INSERT INTO Codigos_postales (id_barrio, numero) VALUES (65, 8407); 
INSERT INTO Codigos_postales (id_barrio, numero) VALUES (66, 8407); 
INSERT INTO Codigos_postales (id_barrio, numero) VALUES (67, 8340); 
INSERT INTO Codigos_postales (id_barrio, numero) VALUES (68, 8340); 
INSERT INTO Codigos_postales (id_barrio, numero) VALUES (69, 8340); 
INSERT INTO Codigos_postales (id_barrio, numero) VALUES (70, 8340);
INSERT INTO Codigos_postales (id_barrio, numero) VALUES (71, 8340); 

--- SUCURSALES
INSERT INTO Sucursales (direccion, id_localidad) VALUES ('Calle Falsa 123', 1);
INSERT INTO Sucursales (direccion, id_localidad) VALUES ('Av. San Martin 456', 2);
INSERT INTO Sucursales (direccion, id_localidad) VALUES ('Ruta 36 Km 90', 3);
INSERT INTO Sucursales (direccion, id_localidad) VALUES ('Calle Belgrano 789', 4);
INSERT INTO Sucursales (direccion, id_localidad) VALUES ('Av. España 101', 5);
INSERT INTO Sucursales (direccion, id_localidad) VALUES ('Calle 9 de Julio 202', 6);
INSERT INTO Sucursales (direccion, id_localidad) VALUES ('Ruta Nacional 143 303', 7);
INSERT INTO Sucursales (direccion, id_localidad) VALUES ('Calle Colón 404', 8);
INSERT INTO Sucursales (direccion, id_localidad) VALUES ('Av. San Martín 505', 9);
INSERT INTO Sucursales (direccion, id_localidad) VALUES ('Calle Belgrano 606', 10);
INSERT INTO Sucursales (direccion, id_localidad) VALUES ('Calle 7 Nº 701', 11);
INSERT INTO Sucursales (direccion, id_localidad) VALUES ('Av. Luro 802', 12);
INSERT INTO Sucursales (direccion, id_localidad) VALUES ('Calle Roca 903', 13);
INSERT INTO Sucursales (direccion, id_localidad) VALUES ('Calle 9 de Julio 1004', 14);
INSERT INTO Sucursales (direccion, id_localidad) VALUES ('Av. Colón 1105', 15);
INSERT INTO Sucursales (direccion, id_localidad) VALUES ('Calle San Martin 1206', 16);
INSERT INTO Sucursales (direccion, id_localidad) VALUES ('Av. Pellegrini 1307', 17);
INSERT INTO Sucursales (direccion, id_localidad) VALUES ('Calle Italia 1408', 18);
INSERT INTO Sucursales (direccion, id_localidad) VALUES ('Calle Belgrano 1509', 19);
INSERT INTO Sucursales (direccion, id_localidad) VALUES ('Calle Tucumán 1610', 20);
INSERT INTO Sucursales (direccion, id_localidad) VALUES ('Av. Argentina 1701', 21);
INSERT INTO Sucursales (direccion, id_localidad) VALUES ('Calle Mitre 1802', 22);
INSERT INTO Sucursales (direccion, id_localidad) VALUES ('Ruta 40 1903', 23);
INSERT INTO Sucursales (direccion, id_localidad) VALUES ('Calle Mendoza 2004', 24);
INSERT INTO Sucursales (direccion, id_localidad) VALUES ('Av. San Martín 2105', 25);

--- CLIENTES
INSERT INTO Clientes (apellido, nombre, telefono, mail) VALUES ('Gómez', 'Laura', '3513040501', 'laura.gomez01@gmail.com');
INSERT INTO Clientes (apellido, nombre, telefono, mail) VALUES ('Fernández', 'Juan', '3513040502', 'juan.fernandez02@hotmail.com');
INSERT INTO Clientes (apellido, nombre, telefono, mail) VALUES ('Pérez', 'Ana', '3513040503', 'ana.perez03@gmail.com');
INSERT INTO Clientes (apellido, nombre, telefono, mail) VALUES ('Rodríguez', 'Luis', '3513040504', 'luis.rodriguez04@hotmail.com');
INSERT INTO Clientes (apellido, nombre, telefono, mail) VALUES ('López', 'María', '3513040505', 'maria.lopez05@gmail.com');
INSERT INTO Clientes (apellido, nombre, telefono, mail) VALUES ('García', 'Carlos', '3513040506', 'carlos.garcia06@hotmail.com');
INSERT INTO Clientes (apellido, nombre, telefono, mail) VALUES ('Mendoza', 'Juana', '3513040507', 'juana.mendoza07@gmail.com');
INSERT INTO Clientes (apellido, nombre, telefono, mail) VALUES ('Martínez', 'José', '3513040508', 'jose.martinez08@hotmail.com');
INSERT INTO Clientes (apellido, nombre, telefono, mail) VALUES ('Álvarez', 'Sofia', '3513040509', 'sofia.alvarez09@gmail.com');
INSERT INTO Clientes (apellido, nombre, telefono, mail) VALUES ('Moreno', 'Ricardo', '3513040510', 'ricardo.moreno10@hotmail.com');
INSERT INTO Clientes (apellido, nombre, telefono, mail) VALUES ('Cruz', 'Patricia', '3513040511', 'patricia.cruz11@gmail.com');
INSERT INTO Clientes (apellido, nombre, telefono, mail) VALUES ('Ríos', 'Fernando', '3513040512', 'fernando.rios12@hotmail.com');
INSERT INTO Clientes (apellido, nombre, telefono, mail) VALUES ('Vázquez', 'Valeria', '3513040513', 'valeria.vazquez13@gmail.com');
INSERT INTO Clientes (apellido, nombre, telefono, mail) VALUES ('Sánchez', 'Héctor', '3513040514', 'hector.sanchez14@hotmail.com');
INSERT INTO Clientes (apellido, nombre, telefono, mail) VALUES ('Gómez', 'Gabriela', '3513040515', 'gabriela.gomez15@gmail.com');
INSERT INTO Clientes (apellido, nombre, telefono, mail) VALUES ('Campos', 'Miguel', '3513040516', 'miguel.campos16@hotmail.com');
INSERT INTO Clientes (apellido, nombre, telefono, mail) VALUES ('Guerrero', 'Verónica', '3513040517', 'veronica.guerrero17@gmail.com');
INSERT INTO Clientes (apellido, nombre, telefono, mail) VALUES ('Ruiz', 'Andrés', '3513040518', 'andres.ruiz18@hotmail.com');
INSERT INTO Clientes (apellido, nombre, telefono, mail) VALUES ('Benítez', 'Claudia', '3513040519', 'claudia.benitez19@gmail.com');
INSERT INTO Clientes (apellido, nombre, telefono, mail) VALUES ('Castro', 'Eduardo', '3513040520', 'eduardo.castro20@hotmail.com');
INSERT INTO Clientes (apellido, nombre, telefono, mail) VALUES ('Mora', 'Jessica', '3513040521', 'jessica.mora21@gmail.com');
INSERT INTO Clientes (apellido, nombre, telefono, mail) VALUES ('Vega', 'Oscar', '3513040522', 'oscar.vega22@hotmail.com');
INSERT INTO Clientes (apellido, nombre, telefono, mail) VALUES ('Bravo', 'Lucía', '3513040523', 'lucia.bravo23@gmail.com');
INSERT INTO Clientes (apellido, nombre, telefono, mail) VALUES ('Jara', 'Luis', '3513040524', 'luis.jara24@hotmail.com');
INSERT INTO Clientes (apellido, nombre, telefono, mail) VALUES ('Salazar', 'Carmen', '3513040525', 'carmen.salazar25@gmail.com');
INSERT INTO Clientes (apellido, nombre, telefono, mail) VALUES ('Acosta', 'Jorge', '3513040526', 'jorge.acosta26@hotmail.com');
INSERT INTO Clientes (apellido, nombre, telefono, mail) VALUES ('Riviera', 'Diana', '3513040527', 'diana.riviera27@gmail.com');
INSERT INTO Clientes (apellido, nombre, telefono, mail) VALUES ('Morales', 'Alejandro', '3513040528', 'alejandro.morales28@hotmail.com');
INSERT INTO Clientes (apellido, nombre, telefono, mail) VALUES ('Hernández', 'Beatriz', '3513040529', 'beatriz.hernandez29@gmail.com');
INSERT INTO Clientes (apellido, nombre, telefono, mail) VALUES ('Cardozo', 'Natalia', '3513040530', 'natalia.cardozo30@hotmail.com');
INSERT INTO Clientes (apellido, nombre, telefono, mail) VALUES ('Ponce', 'Emilio', '3513040531', 'emilio.ponce31@gmail.com');
INSERT INTO Clientes (apellido, nombre, telefono, mail) VALUES ('Escobar', 'Silvia', '3513040532', 'silvia.escobar32@hotmail.com');
INSERT INTO Clientes (apellido, nombre, telefono, mail) VALUES ('Núñez', 'Luis', '3513040533', 'luis.nunez33@gmail.com');
INSERT INTO Clientes (apellido, nombre, telefono, mail) VALUES ('Cordero', 'Martina', '3513040534', 'martina.cordero34@hotmail.com');
INSERT INTO Clientes (apellido, nombre, telefono, mail) VALUES ('Beltrán', 'Ricardo', '3513040535', 'ricardo.beltran35@gmail.com');
INSERT INTO Clientes (apellido, nombre, telefono, mail) VALUES ('Marín', 'Juliana', '3513040536', 'juliana.marin36@hotmail.com');
INSERT INTO Clientes (apellido, nombre, telefono, mail) VALUES ('Díaz', 'Manuel', '3513040537', 'manuel.diaz37@gmail.com');
INSERT INTO Clientes (apellido, nombre, telefono, mail) VALUES ('Villar', 'Mónica', '3513040538', 'monica.villar38@hotmail.com');
INSERT INTO Clientes (apellido, nombre, telefono, mail) VALUES ('Alonso', 'Roberto', '3513040539', 'roberto.alonso39@gmail.com');
INSERT INTO Clientes (apellido, nombre, telefono, mail) VALUES ('Herrera', 'Cecilia', '3513040540', 'cecilia.herrera40@hotmail.com');
INSERT INTO Clientes (apellido, nombre, telefono, mail) VALUES ('Sosa', 'Martín', '3513040541', 'martin.sosa41@gmail.com');
INSERT INTO Clientes (apellido, nombre, telefono, mail) VALUES ('Palacios', 'Viviana', '3513040542', 'viviana.palacios42@hotmail.com');
INSERT INTO Clientes (apellido, nombre, telefono, mail) VALUES ('Gutiérrez', 'Diego', '3513040543', 'diego.gutierrez43@gmail.com');
INSERT INTO Clientes (apellido, nombre, telefono, mail) VALUES ('Ruiz', 'Lorena', '3513040544', 'lorena.ruiz44@hotmail.com');
INSERT INTO Clientes (apellido, nombre, telefono, mail) VALUES ('Márquez', 'Héctor', '3513040545', 'hector.marquez45@gmail.com');
INSERT INTO Clientes (apellido, nombre, telefono, mail) VALUES ('Carrillo', 'Sandra', '3513040546', 'sandra.carrillo46@hotmail.com');
INSERT INTO Clientes (apellido, nombre, telefono, mail) VALUES ('González', 'Luis', '3513040547', 'luis.gonzalez47@gmail.com');
INSERT INTO Clientes (apellido, nombre, telefono, mail) VALUES ('Lara', 'Adriana', '3513040548', 'adriana.lara48@hotmail.com');
INSERT INTO Clientes (apellido, nombre, telefono, mail) VALUES ('Maldonado', 'Cristian', '3513040549', 'cristian.maldonado49@gmail.com');
INSERT INTO Clientes (apellido, nombre, telefono, mail) VALUES ('Morales', 'Patricia', '3513040550', 'patricia.morales50@hotmail.com');
INSERT INTO Clientes (apellido, nombre, telefono, mail) VALUES ('Ortega', 'Oscar', '3513040551', 'oscar.ortega51@gmail.com');
INSERT INTO Clientes (apellido, nombre, telefono, mail) VALUES ('Zúñiga', 'Natalia', '3513040552', 'natalia.zuniga52@hotmail.com');
INSERT INTO Clientes (apellido, nombre, telefono, mail) VALUES ('Fuentes', 'Alejandro', '3513040553', 'alejandro.fuentes53@gmail.com');
INSERT INTO Clientes (apellido, nombre, telefono, mail) VALUES ('Pardo', 'Martha', '3513040554', 'martha.pardo54@hotmail.com');
INSERT INTO Clientes (apellido, nombre, telefono, mail) VALUES ('Salinas', 'Ricardo', '3513040555', 'ricardo.salinas55@gmail.com');
INSERT INTO Clientes (apellido, nombre, telefono, mail) VALUES ('Ríos', 'Viviana', '3513040556', 'viviana.rios56@hotmail.com');
INSERT INTO Clientes (apellido, nombre, telefono, mail) VALUES ('López', 'Fernando', '3513040557', 'fernando.lopez57@gmail.com');
INSERT INTO Clientes (apellido, nombre, telefono, mail) VALUES ('Herrera', 'Mónica', '3513040558', 'monica.herrera58@hotmail.com');
INSERT INTO Clientes (apellido, nombre, telefono, mail) VALUES ('Gómez', 'Oscar', '3513040559', 'oscar.gomez59@gmail.com');
INSERT INTO Clientes (apellido, nombre, telefono, mail) VALUES ('Mendoza', 'Laura', '3513040560', 'laura.mendoza60@hotmail.com');

--- ANIOS
INSERT INTO Anios (año) VALUES (2010);
INSERT INTO Anios (año) VALUES (2011);
INSERT INTO Anios (año) VALUES (2012);
INSERT INTO Anios (año) VALUES (2013);
INSERT INTO Anios (año) VALUES (2014);
INSERT INTO Anios (año) VALUES (2015);
INSERT INTO Anios (año) VALUES (2016);
INSERT INTO Anios (año) VALUES (2017);
INSERT INTO Anios (año) VALUES (2018);
INSERT INTO Anios (año) VALUES (2019);
INSERT INTO Anios (año) VALUES (2020);
INSERT INTO Anios (año) VALUES (2021);
INSERT INTO Anios (año) VALUES (2022);
INSERT INTO Anios (año) VALUES (2023);
INSERT INTO Anios (año) VALUES (2024);

--- TIPOS_VEHICULOS
INSERT INTO Tipos_vehiculos (nombre) VALUES ('Automovil');
INSERT INTO Tipos_vehiculos (nombre) VALUES ('Motocicleta');


--- MARCAS
INSERT INTO Marcas (nombre, id_tipo) VALUES ('Toyota', 1);
INSERT INTO Marcas (nombre, id_tipo) VALUES ('Volkswagen', 1);
INSERT INTO Marcas (nombre, id_tipo) VALUES ('Ford', 1);
INSERT INTO Marcas (nombre, id_tipo) VALUES ('Chevrolet', 1);
INSERT INTO Marcas (nombre, id_tipo) VALUES ('Renault', 1);
INSERT INTO Marcas (nombre, id_tipo) VALUES ('Honda', 2);
INSERT INTO Marcas (nombre, id_tipo) VALUES ('Yamaha', 2);
INSERT INTO Marcas (nombre, id_tipo) VALUES ('Zanella', 2);
INSERT INTO Marcas (nombre, id_tipo) VALUES ('Suzuki', 2);
INSERT INTO Marcas (nombre, id_tipo) VALUES ('Motomel', 2);

--- MODELOS
INSERT INTO Modelos (nombre, id_marca) VALUES ('Corolla', 1);
INSERT INTO Modelos (nombre, id_marca) VALUES ('Camry', 1);
INSERT INTO Modelos (nombre, id_marca) VALUES ('Hilux', 1);
INSERT INTO Modelos (nombre, id_marca) VALUES ('Yaris', 1);
INSERT INTO Modelos (nombre, id_marca) VALUES ('Golf', 2);
INSERT INTO Modelos (nombre, id_marca) VALUES ('Passat', 2);
INSERT INTO Modelos (nombre, id_marca) VALUES ('Polo', 2);
INSERT INTO Modelos (nombre, id_marca) VALUES ('Tiguan', 2);
INSERT INTO Modelos (nombre, id_marca) VALUES ('Focus', 3);
INSERT INTO Modelos (nombre, id_marca) VALUES ('Fiesta', 3);
INSERT INTO Modelos (nombre, id_marca) VALUES ('Mustang', 3);
INSERT INTO Modelos (nombre, id_marca) VALUES ('Ranger', 3);
INSERT INTO Modelos (nombre, id_marca) VALUES ('Onix', 4);
INSERT INTO Modelos (nombre, id_marca) VALUES ('Tracker', 4);
INSERT INTO Modelos (nombre, id_marca) VALUES ('Malibu', 4);
INSERT INTO Modelos (nombre, id_marca) VALUES ('S10', 4);
INSERT INTO Modelos (nombre, id_marca) VALUES ('Clio', 5);
INSERT INTO Modelos (nombre, id_marca) VALUES ('Duster', 5);
INSERT INTO Modelos (nombre, id_marca) VALUES ('Logan', 5);
INSERT INTO Modelos (nombre, id_marca) VALUES ('Koleos', 5);
INSERT INTO Modelos (nombre, id_marca) VALUES ('CBR500R', 6);
INSERT INTO Modelos (nombre, id_marca) VALUES ('CRF250L', 6);
INSERT INTO Modelos (nombre, id_marca) VALUES ('CB500X', 6);
INSERT INTO Modelos (nombre, id_marca) VALUES ('Wave', 6);
INSERT INTO Modelos (nombre, id_marca) VALUES ('YZF-R1', 7);
INSERT INTO Modelos (nombre, id_marca) VALUES ('MT-07', 7);
INSERT INTO Modelos (nombre, id_marca) VALUES ('FZ-S', 7);
INSERT INTO Modelos (nombre, id_marca) VALUES ('XTZ 250', 7);
INSERT INTO Modelos (nombre, id_marca) VALUES ('RX 150', 8);
INSERT INTO Modelos (nombre, id_marca) VALUES ('ZB 110', 8);
INSERT INTO Modelos (nombre, id_marca) VALUES ('Patagonian Eagle 250', 8);
INSERT INTO Modelos (nombre, id_marca) VALUES ('V-Strom 650', 9);
INSERT INTO Modelos (nombre, id_marca) VALUES ('GSX-R1000', 9);
INSERT INTO Modelos (nombre, id_marca) VALUES ('Burgman 400', 9);
INSERT INTO Modelos (nombre, id_marca) VALUES ('DR-Z400', 9);
INSERT INTO Modelos (nombre, id_marca) VALUES ('Skua 250', 10);
INSERT INTO Modelos (nombre, id_marca) VALUES ('Blitz 110', 10);
INSERT INTO Modelos (nombre, id_marca) VALUES ('C110', 10);

--- VERSIONES
INSERT INTO Versiones (descripcion, id_modelo, id_anio) VALUES ('Corolla XLi', 1, 10); 
INSERT INTO Versiones (descripcion, id_modelo, id_anio) VALUES ('Corolla XEi', 1, 12);  
INSERT INTO Versiones (descripcion, id_modelo, id_anio) VALUES ('Camry LE', 2, 11);  
INSERT INTO Versiones (descripcion, id_modelo, id_anio) VALUES ('Camry SE', 2, 13);  
INSERT INTO Versiones (descripcion, id_modelo, id_anio) VALUES ('Hilux SR', 3, 9);  
INSERT INTO Versiones (descripcion, id_modelo, id_anio) VALUES ('Hilux SRV', 3, 11);  
INSERT INTO Versiones (descripcion, id_modelo, id_anio) VALUES ('Golf Comfortline', 5, 10);  
INSERT INTO Versiones (descripcion, id_modelo, id_anio) VALUES ('Passat Highline', 6, 12);  
INSERT INTO Versiones (descripcion, id_modelo, id_anio) VALUES ('Focus Titanium', 9, 9);  
INSERT INTO Versiones (descripcion, id_modelo, id_anio) VALUES ('Mustang GT', 11, 15);  
INSERT INTO Versiones (descripcion, id_modelo, id_anio) VALUES ('Onix Joy', 13, 11); 
INSERT INTO Versiones (descripcion, id_modelo, id_anio) VALUES ('Tracker LTZ', 14, 12);  
INSERT INTO Versiones (descripcion, id_modelo, id_anio) VALUES ('Clio Mio', 17, 5);  
INSERT INTO Versiones (descripcion, id_modelo, id_anio) VALUES ('Duster Dynamique', 18, 11);  
INSERT INTO Versiones (descripcion, id_modelo, id_anio) VALUES ('CBR500R ABS', 21, 12);  
INSERT INTO Versiones (descripcion, id_modelo, id_anio) VALUES ('YZF-R1 Sport', 25, 13);  
INSERT INTO Versiones (descripcion, id_modelo, id_anio) VALUES ('V-Strom 650 XT', 33, 10); 
INSERT INTO Versiones (descripcion, id_modelo, id_anio) VALUES ('Yaris XS', 4, 11); 
INSERT INTO Versiones (descripcion, id_modelo, id_anio) VALUES ('Yaris XLS', 4, 13); 
INSERT INTO Versiones (descripcion, id_modelo, id_anio) VALUES ('Polo Trendline', 7, 12); 
INSERT INTO Versiones (descripcion, id_modelo, id_anio) VALUES ('Polo Highline', 7, 14); 
INSERT INTO Versiones (descripcion, id_modelo, id_anio) VALUES ('Tiguan Allspace', 8, 15); 
INSERT INTO Versiones (descripcion, id_modelo, id_anio) VALUES ('Tiguan Comfortline', 8, 15); 
INSERT INTO Versiones (descripcion, id_modelo, id_anio) VALUES ('Fiesta SE', 10, 9); 
INSERT INTO Versiones (descripcion, id_modelo, id_anio) VALUES ('Fiesta Titanium', 10, 11); 
INSERT INTO Versiones (descripcion, id_modelo, id_anio) VALUES ('Ranger XL', 12, 13); 
INSERT INTO Versiones (descripcion, id_modelo, id_anio) VALUES ('Ranger XLT', 12, 14); 
INSERT INTO Versiones (descripcion, id_modelo, id_anio) VALUES ('Malibu LT', 15, 14); 
INSERT INTO Versiones (descripcion, id_modelo, id_anio) VALUES ('Malibu Premier', 15, 15); 
INSERT INTO Versiones (descripcion, id_modelo, id_anio) VALUES ('S10 LT', 16, 12); 
INSERT INTO Versiones (descripcion, id_modelo, id_anio) VALUES ('S10 High Country', 16, 14); 
INSERT INTO Versiones (descripcion, id_modelo, id_anio) VALUES ('Logan Life', 19, 9); 
INSERT INTO Versiones (descripcion, id_modelo, id_anio) VALUES ('Logan Intens', 19, 12); 
INSERT INTO Versiones (descripcion, id_modelo, id_anio) VALUES ('Koleos Zen', 20, 15); 
INSERT INTO Versiones (descripcion, id_modelo, id_anio) VALUES ('Koleos Iconic', 20, 15); 
INSERT INTO Versiones (descripcion, id_modelo, id_anio) VALUES ('CRF250L Rally', 22, 13); 
INSERT INTO Versiones (descripcion, id_modelo, id_anio) VALUES ('CRF250L Standard', 22, 14); 
INSERT INTO Versiones (descripcion, id_modelo, id_anio) VALUES ('CB500X ABS', 23, 12); 
INSERT INTO Versiones (descripcion, id_modelo, id_anio) VALUES ('CB500X Adventure', 23, 14); 
INSERT INTO Versiones (descripcion, id_modelo, id_anio) VALUES ('Wave Alpha', 24, 10); 
INSERT INTO Versiones (descripcion, id_modelo, id_anio) VALUES ('Wave Deluxe', 24, 11); 
INSERT INTO Versiones (descripcion, id_modelo, id_anio) VALUES ('MT-07 Tracer', 26, 13); 
INSERT INTO Versiones (descripcion, id_modelo, id_anio) VALUES ('MT-07 Hypernaked', 26, 15); 
INSERT INTO Versiones (descripcion, id_modelo, id_anio) VALUES ('FZ-S V3', 27, 12); 
INSERT INTO Versiones (descripcion, id_modelo, id_anio) VALUES ('FZ-S Deluxe', 27, 13); 
INSERT INTO Versiones (descripcion, id_modelo, id_anio) VALUES ('XTZ 250 Adventure', 28, 11); 
INSERT INTO Versiones (descripcion, id_modelo, id_anio) VALUES ('XTZ 250 Cross', 28, 12); 
INSERT INTO Versiones (descripcion, id_modelo, id_anio) VALUES ('RX 150 Sport', 29, 10); 
INSERT INTO Versiones (descripcion, id_modelo, id_anio) VALUES ('RX 150 Touring', 29, 12); 
INSERT INTO Versiones (descripcion, id_modelo, id_anio) VALUES ('ZB 110 Standard', 30, 9); 
INSERT INTO Versiones (descripcion, id_modelo, id_anio) VALUES ('ZB 110 Deluxe', 30, 11); 
INSERT INTO Versiones (descripcion, id_modelo, id_anio) VALUES ('Patagonian Eagle 250 Cruiser', 31, 13); 
INSERT INTO Versiones (descripcion, id_modelo, id_anio) VALUES ('Patagonian Eagle 250 Sport', 31, 15); 
INSERT INTO Versiones (descripcion, id_modelo, id_anio) VALUES ('GSX-R1000R', 33, 12); 
INSERT INTO Versiones (descripcion, id_modelo, id_anio) VALUES ('GSX-R1000 Standard', 33, 14); 
INSERT INTO Versiones (descripcion, id_modelo, id_anio) VALUES ('Burgman 400 ABS', 34, 13); 
INSERT INTO Versiones (descripcion, id_modelo, id_anio) VALUES ('Burgman 400 Standard', 34, 15); 
INSERT INTO Versiones (descripcion, id_modelo, id_anio) VALUES ('DR-Z400 Supermoto', 35, 11); 
INSERT INTO Versiones (descripcion, id_modelo, id_anio) VALUES ('DR-Z400 Trail', 35, 12); 
INSERT INTO Versiones (descripcion, id_modelo, id_anio) VALUES ('Skua 250 Adventure', 36, 10); 
INSERT INTO Versiones (descripcion, id_modelo, id_anio) VALUES ('Skua 250 Cross', 36, 12); 
INSERT INTO Versiones (descripcion, id_modelo, id_anio) VALUES ('Blitz 110 Classic', 37, 9); 
INSERT INTO Versiones (descripcion, id_modelo, id_anio) VALUES ('Blitz 110 Pro', 37, 11); 
INSERT INTO Versiones (descripcion, id_modelo, id_anio) VALUES ('C110 Standard', 38, 8); 
INSERT INTO Versiones (descripcion, id_modelo, id_anio) VALUES ('C110 Deluxe', 38, 10); 


--- TIPOS_SEGUROS
INSERT INTO Tipos_seguros (nombre) VALUES ('Terceros Completo Básica');
INSERT INTO Tipos_seguros (nombre) VALUES ('Terceros Completo Plus');
INSERT INTO Tipos_seguros (nombre) VALUES ('Todo Riesgo con Franquicia');
INSERT INTO Tipos_seguros (nombre) VALUES ('Cobertura Limitada con Franquicia');

--- COBERTURAS
INSERT INTO Coberturas (descripcion) VALUES ('Responsabilidad civil limitada');
INSERT INTO Coberturas (descripcion) VALUES ('Incendio total y parcial');
INSERT INTO Coberturas (descripcion) VALUES ('Robo y/o hurto total y parcial');
INSERT INTO Coberturas (descripcion) VALUES ('Daños totales por accidente');
INSERT INTO Coberturas (descripcion) VALUES ('Daños parciales al amparo de robo total');
INSERT INTO Coberturas (descripcion) VALUES ('Incluye franquicia');
INSERT INTO Coberturas (descripcion) VALUES ('Daños totales y parciales por accidente');
INSERT INTO Coberturas (descripcion) VALUES ('Asistencia en carretera');
INSERT INTO Coberturas (descripcion) VALUES ('Coche de sustitución');
INSERT INTO Coberturas (descripcion) VALUES ('Protección jurídica');

--- NIVELES_RIESGO
INSERT INTO Niveles_riesgo (nombre) VALUES ('Alto');
INSERT INTO Niveles_riesgo (nombre) VALUES ('Medio');
INSERT INTO Niveles_riesgo (nombre) VALUES ('Bajo');

--- ZONAS RIESGO
INSERT INTO Zonas_riesgo (id_nivel, id_cod_postal) VALUES (1, 1); 
INSERT INTO Zonas_riesgo (id_nivel, id_cod_postal) VALUES (2, 2); 
INSERT INTO Zonas_riesgo (id_nivel, id_cod_postal) VALUES (2, 3); 
INSERT INTO Zonas_riesgo (id_nivel, id_cod_postal) VALUES (2, 4);
INSERT INTO Zonas_riesgo (id_nivel, id_cod_postal) VALUES (2, 5); 
INSERT INTO Zonas_riesgo (id_nivel, id_cod_postal) VALUES (2, 6);
INSERT INTO Zonas_riesgo (id_nivel, id_cod_postal) VALUES (2, 7); 
INSERT INTO Zonas_riesgo (id_nivel, id_cod_postal) VALUES (2, 8); 
INSERT INTO Zonas_riesgo (id_nivel, id_cod_postal) VALUES (2, 9); 
INSERT INTO Zonas_riesgo (id_nivel, id_cod_postal) VALUES (2, 10); 
INSERT INTO Zonas_riesgo (id_nivel, id_cod_postal) VALUES (1, 6); 
INSERT INTO Zonas_riesgo (id_nivel, id_cod_postal) VALUES (2, 7); 
INSERT INTO Zonas_riesgo (id_nivel, id_cod_postal) VALUES (2, 8); 
INSERT INTO Zonas_riesgo (id_nivel, id_cod_postal) VALUES (2, 9); 
INSERT INTO Zonas_riesgo (id_nivel, id_cod_postal) VALUES (2, 10); 
INSERT INTO Zonas_riesgo (id_nivel, id_cod_postal) VALUES (2, 11); 
INSERT INTO Zonas_riesgo (id_nivel, id_cod_postal) VALUES (2, 12); 
INSERT INTO Zonas_riesgo (id_nivel, id_cod_postal) VALUES (2, 13); 
INSERT INTO Zonas_riesgo (id_nivel, id_cod_postal) VALUES (2, 14); 
INSERT INTO Zonas_riesgo (id_nivel, id_cod_postal) VALUES (2, 15); 
INSERT INTO Zonas_riesgo (id_nivel, id_cod_postal) VALUES (1, 11); 
INSERT INTO Zonas_riesgo (id_nivel, id_cod_postal) VALUES (1, 12); 
INSERT INTO Zonas_riesgo (id_nivel, id_cod_postal) VALUES (1, 13); 
INSERT INTO Zonas_riesgo (id_nivel, id_cod_postal) VALUES (2, 14); 
INSERT INTO Zonas_riesgo (id_nivel, id_cod_postal) VALUES (2, 15); 
INSERT INTO Zonas_riesgo (id_nivel, id_cod_postal) VALUES (2, 16); 
INSERT INTO Zonas_riesgo (id_nivel, id_cod_postal) VALUES (2, 17); 
INSERT INTO Zonas_riesgo (id_nivel, id_cod_postal) VALUES (2, 18); 
INSERT INTO Zonas_riesgo (id_nivel, id_cod_postal) VALUES (2, 19); 
INSERT INTO Zonas_riesgo (id_nivel, id_cod_postal) VALUES (2, 20); 
INSERT INTO Zonas_riesgo (id_nivel, id_cod_postal) VALUES (1, 16); 
INSERT INTO Zonas_riesgo (id_nivel, id_cod_postal) VALUES (1, 17); 
INSERT INTO Zonas_riesgo (id_nivel, id_cod_postal) VALUES (2, 18); 
INSERT INTO Zonas_riesgo (id_nivel, id_cod_postal) VALUES (2, 19);
INSERT INTO Zonas_riesgo (id_nivel, id_cod_postal) VALUES (2, 20); 
INSERT INTO Zonas_riesgo (id_nivel, id_cod_postal) VALUES (2, 21); 
INSERT INTO Zonas_riesgo (id_nivel, id_cod_postal) VALUES (2, 22); 
INSERT INTO Zonas_riesgo (id_nivel, id_cod_postal) VALUES (2, 23); 
INSERT INTO Zonas_riesgo (id_nivel, id_cod_postal) VALUES (2, 24); 
INSERT INTO Zonas_riesgo (id_nivel, id_cod_postal) VALUES (2, 25); 
INSERT INTO Zonas_riesgo (id_nivel, id_cod_postal) VALUES (2, 21); 
INSERT INTO Zonas_riesgo (id_nivel, id_cod_postal) VALUES (2, 22); 
INSERT INTO Zonas_riesgo (id_nivel, id_cod_postal) VALUES (2, 23); 
INSERT INTO Zonas_riesgo (id_nivel, id_cod_postal) VALUES (2, 24); 
INSERT INTO Zonas_riesgo (id_nivel, id_cod_postal) VALUES (2, 25); 
INSERT INTO Zonas_riesgo (id_nivel, id_cod_postal) VALUES (2, 26); 
INSERT INTO Zonas_riesgo (id_nivel, id_cod_postal) VALUES (2, 27); 
INSERT INTO Zonas_riesgo (id_nivel, id_cod_postal) VALUES (2, 28); 
INSERT INTO Zonas_riesgo (id_nivel, id_cod_postal) VALUES (2, 29); 
INSERT INTO Zonas_riesgo (id_nivel, id_cod_postal) VALUES (2, 30); 



--- SEGUROS
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (1, 1, 35000.00);  
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (3, 1, 80000.00);
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (1, 2, 38000.00); 
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (3, 2, 85000.00);  
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (1, 3, 55000.00);  
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (3, 3, 105000.00);  
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (1, 4, 58000.00);
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (3, 4, 110000.00); 
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (1, 5, 60000.00); 
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (3, 5, 120000.00);
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (1, 6, 65000.00);  
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (3, 6, 125000.00); 
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (1, 7, 40000.00); 
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (3, 7, 90000.00); 
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (1, 8, 55000.00);  
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (3, 8, 115000.00);
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (1, 9, 45000.00);  
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (3, 9, 100000.00);
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (1, 10, 90000.00); 
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (3, 10, 190000.00);
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (1, 11, 37000.00);  
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (3, 11, 78000.00); 
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (1, 12, 41000.00); 
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (3, 12, 83000.00); 
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (1, 13, 25000.00);  
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (3, 13, 60000.00); 
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (1, 14, 39000.00);  
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (3, 14, 80000.00); 
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (1, 15, 35000.00);  
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (3, 15, 78000.00); 
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (1, 16, 50000.00);  
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (3, 16, 95000.00);
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (1, 17, 55000.00);  
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (3, 17, 105000.00);  
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (1, 18, 42000.00);
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (3, 18, 85000.00);
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (1, 19, 31000.00);
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (3, 19, 67000.00);
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (1, 20, 43000.00);
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (3, 20, 90000.00);
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (1, 21, 36000.00);
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (3, 21, 78000.00);
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (1, 22, 38000.00);
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (3, 22, 82000.00);
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (1, 23, 39000.00);
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (3, 23, 84000.00);
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (1, 24, 31000.00);
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (3, 24, 69000.00);
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (1, 25, 42000.00);
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (3, 25, 86000.00);
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (1, 26, 45000.00);
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (3, 26, 88000.00);
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (1, 27, 38000.00);
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (3, 27, 82000.00);
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (1, 28, 37000.00);
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (3, 28, 80000.00);
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (1, 29, 34000.00);
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (3, 29, 76000.00);
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (1, 30, 39000.00);
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (3, 30, 83000.00);
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (1, 31, 41000.00);
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (3, 31, 85000.00);
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (1, 32, 34000.00);
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (3, 32, 78000.00);
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (1, 33, 37000.00);
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (3, 33, 80000.00);
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (1, 34, 42000.00);
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (3, 34, 84000.00);
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (1, 35, 39000.00);
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (3, 35, 82000.00);
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (1, 36, 36000.00);
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (3, 36, 79000.00);
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (1, 37, 33000.00);
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (3, 37, 75000.00);
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (1, 38, 31000.00);
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (3, 38, 72000.00);
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (1, 39, 33000.00);
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (3, 39, 74000.00);
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (1, 40, 34000.00);
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (3, 40, 75000.00);
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (1, 41, 32000.00);
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (3, 41, 73000.00);
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (1, 42, 33000.00);
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (3, 42, 74000.00);
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (1, 43, 31000.00);
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (3, 43, 72000.00);
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (1, 44, 34000.00);
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (3, 44, 75000.00);
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (1, 45, 33000.00);
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (3, 45, 74000.00);
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (1, 46, 34000.00);
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (3, 46, 75000.00);
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (1, 47, 31000.00);
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (3, 47, 73000.00);
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (1, 48, 33000.00);
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (3, 48, 74000.00);
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (1, 49, 32000.00);
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (3, 49, 73000.00);
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (1, 50, 34000.00);
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (3, 50, 75000.00);
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (1, 51, 32000.00);
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (3, 51, 74000.00);
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (1, 52, 33000.00);
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (3, 52, 75000.00);
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (1, 53, 31000.00);
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (3, 53, 73000.00);
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (1, 54, 33000.00);
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (3, 54, 74000.00);
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (1, 55, 34000.00);
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (3, 55, 75000.00);
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (1, 56, 33000.00);
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (3, 56, 74000.00);
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (1, 57, 34000.00);
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (3, 57, 75000.00);
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (1, 58, 32000.00);
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (3, 58, 73000.00);
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (1, 59, 34000.00);
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (3, 59, 75000.00);
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (1, 60, 33000.00);
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (3, 60, 74000.00);
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (1, 61, 32000.00);
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (3, 61, 73000.00);
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (1, 62, 33000.00);
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (3, 62, 74000.00);
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (1, 63, 34000.00);
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (3, 63, 75000.00);
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (1, 64, 33000.00);
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (3, 64, 74000.00);
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (1, 65, 34000.00);
INSERT INTO Seguros (id_tipo_seg, id_version, precio) VALUES (3, 65, 75000.00);

--- DETALLES_SEGURO
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (1, 2);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (1, 5);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (2, 1);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (2, 3);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (2, 6);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (3, 4);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (3, 7);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (4, 2);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (4, 5);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (4, 7);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (5, 1);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (5, 4);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (6, 3);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (6, 6);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (6, 7);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (7, 2);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (7, 4);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (8, 1);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (8, 5);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (8, 6);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (9, 3);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (9, 4);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (10, 2);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (10, 5);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (10, 7);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (11, 1);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (11, 6);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (12, 3);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (12, 4);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (12, 7);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (13, 2);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (13, 5);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (14, 1);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (14, 4);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (14, 6);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (15, 3);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (15, 5);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (16, 2);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (16, 6);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (16, 7);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (17, 1);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (17, 4);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (18, 3);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (18, 5);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (18, 7);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (19, 2);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (19, 4);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (20, 1);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (20, 6);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (20, 7);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (21, 2);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (21, 3);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (22, 4);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (22, 5);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (22, 7);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (23, 1);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (23, 2);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (24, 3);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (24, 6);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (24, 7);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (25, 4);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (25, 5);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (26, 2);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (26, 3);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (26, 7);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (27, 1);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (27, 6);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (28, 3);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (28, 4);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (28, 7);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (29, 2);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (29, 5);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (30, 1);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (30, 4);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (30, 7);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (31, 3);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (31, 5);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (32, 2);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (32, 6);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (32, 7);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (33, 1);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (33, 4);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (34, 3);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (34, 5);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (34, 7);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (35, 2);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (35, 6);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (36, 1);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (36, 4);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (36, 7);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (37, 2);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (37, 5);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (38, 3);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (38, 6);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (38, 7);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (39, 1);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (39, 4);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (40, 2);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (40, 5);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (40, 7);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (41, 3);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (41, 4);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (42, 1);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (42, 2);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (42, 6);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (43, 4);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (43, 5);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (44, 2);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (44, 3);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (44, 7);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (45, 1);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (45, 6);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (46, 3);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (46, 5);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (46, 7);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (47, 2);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (47, 4);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (48, 1);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (48, 5);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (48, 7);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (49, 2);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (49, 6);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (50, 3);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (50, 4);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (50, 7);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (51, 1);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (51, 5);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (52, 2);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (52, 3);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (52, 6);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (53, 4);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (53, 5);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (54, 2);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (54, 6);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (54, 7);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (55, 1);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (55, 4);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (56, 3);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (56, 5);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (56, 7);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (57, 2);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (57, 6);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (58, 1);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (58, 3);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (58, 4);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (59, 5);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (59, 6);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (60, 2);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (60, 4);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (60, 7);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (61, 1);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (61, 5);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (62, 3);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (62, 4);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (62, 6);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (63, 2);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (63, 5);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (64, 1);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (64, 3);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (64, 7);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (65, 4);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (65, 6);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (66, 2);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (66, 5);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (66, 7);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (67, 1);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (67, 3);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (68, 2);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (68, 4);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (68, 6);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (69, 5);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (69, 7);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (70, 1);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (70, 4);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (70, 6);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (71, 2);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (71, 3);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (72, 1);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (72, 5);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (72, 7);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (73, 2);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (73, 4);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (74, 3);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (74, 5);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (74, 7);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (75, 1);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (75, 6);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (76, 2);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (76, 4);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (76, 7);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (77, 3);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (77, 5);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (78, 2);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (78, 6);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (78, 7);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (79, 1);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (79, 4);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (80, 3);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (80, 5);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (80, 6);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (81, 2);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (81, 7);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (82, 1);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (82, 3);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (82, 5);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (83, 2);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (83, 6);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (84, 4);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (84, 5);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (84, 7);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (85, 1);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (85, 6);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (86, 2);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (86, 4);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (86, 7);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (87, 3);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (87, 5);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (88, 1);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (88, 4);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (88, 7);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (89, 2);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (89, 6);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (90, 1);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (90, 3);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (90, 5);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (91, 2);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (91, 4);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (91, 7);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (92, 1);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (92, 5);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (92, 7);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (93, 3);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (93, 6);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (94, 2);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (94, 4);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (94, 7);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (95, 1);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (95, 5);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (96, 3);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (96, 4);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (96, 6);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (97, 2);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (97, 7);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (98, 1);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (98, 3);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (98, 5);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (99, 2);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (99, 4);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (99, 6);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (100, 1);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (100, 3);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (101, 2);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (101, 5);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (101, 7);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (102, 4);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (102, 6);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (103, 1);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (103, 3);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (103, 7);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (104, 2);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (104, 5);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (105, 4);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (105, 6);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (105, 7);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (106, 1);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (106, 2);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (107, 3);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (107, 5);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (107, 6);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (108, 2);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (108, 7);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (109, 1);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (109, 3);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (109, 4);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (110, 5);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (110, 6);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (111, 1);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (111, 2);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (111, 4);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (112, 3);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (112, 5);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (113, 2);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (113, 6);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (113, 7);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (114, 1);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (114, 4);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (115, 3);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (115, 5);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (115, 7);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (116, 2);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (116, 6);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (117, 1);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (117, 3);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (117, 5);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (118, 2);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (118, 4);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (118, 6);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (119, 1);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (119, 4);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (120, 3);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (120, 5);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (120, 7);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (121, 2);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (121, 6);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (122, 1);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (122, 4);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (122, 7);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (123, 2);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (123, 3);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (124, 1);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (124, 5);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (124, 6);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (125, 2);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (125, 4);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (125, 7);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (126, 1);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (126, 6);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (127, 3);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (127, 5);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (127, 7);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (128, 2);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (128, 4);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (129, 1);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (129, 3);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (129, 5);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (130, 2);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (130, 6);
INSERT INTO detalles_seguro (id_seguro, id_cobertura) VALUES (130, 7);

--- COTIZACIONES
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (1, '01/09/2023', '16/09/2023', 1, 5, 9900.00, 1, 1);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (2, '05/09/2023', '20/09/2023', 2, 10, 11000.00, 0, 2);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (3, '08/09/2023', '23/09/2023', 3, 15, 9900.00, 1, 3);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (4, '12/09/2023', '27/09/2023', 4, 20, 10800.00, 0, 4);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (5, '15/09/2023', '30/09/2023', 5, 25, 11500.00, 1, 5);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (6, '18/09/2023', '03/10/2023', 6, 30, 9900.00, 0, 6);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (7, '22/09/2023', '07/10/2023', 7, 35, 11000.00, 1, 7);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (8, '25/09/2023', '10/10/2023', 8, 40, 10800.00, 0, 8);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (9, '28/09/2023', '13/10/2023', 9, 45, 11500.00, 1, 9);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (10, '01/10/2023', '17/10/2023', 10, 50, 9900.00, 0, 10);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (11, '05/10/2023', '21/10/2023', 11, 55, 11000.00, 1, 11);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (12, '08/10/2023', '24/10/2023', 12, 60, 10800.00, 0, 12);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (13, '12/10/2023', '28/10/2023', 13, 65, 11500.00, 1, 13);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (14, '15/10/2023', '31/10/2023', 14, 70, 9900.00, 0, 14);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (15, '18/10/2023', '03/11/2023', 15, 75, 10800.00, 1, 15);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (16, '22/10/2023', '07/11/2023', 16, 80, 11500.00, 0, 16);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (17, '25/10/2023', '10/11/2023', 17, 85, 9900.00, 1, 17);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (18, '28/10/2023', '13/11/2023', 18, 90, 10800.00, 0, 18);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (19, '01/11/2023', '17/11/2023', 19, 95, 11500.00, 1, 19);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (20, '05/11/2023', '21/11/2023', 20, 100, 9900.00, 0, 20);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (21, '08/11/2023', '24/11/2023', 21, 105, 10800.00, 1, 21);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (22, '12/11/2023', '28/11/2023', 22, 110, 11500.00, 0, 22);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (23, '15/11/2023', '01/12/2023', 23, 115, 9900.00, 1, 23);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (24, '18/11/2023', '04/12/2023', 24, 120, 10800.00, 0, 24);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (25, '22/11/2023', '08/12/2023', 25, 125, 11500.00, 1, 25);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (26, '25/11/2023', '11/12/2023', 1, 130, 10800.00, 0, 1);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (27, '28/11/2023', '14/12/2023', 2, 120, 11500.00, 1, 2);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (28, '01/12/2023', '18/12/2023', 3, 115, 9900.00, 0, 3);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (29, '05/12/2023', '22/12/2023', 4, 110, 10800.00, 1, 4);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (30, '08/12/2023', '26/12/2023', 5, 105, 11500.00, 0, 5);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (31, '12/12/2023', '30/12/2023', 6, 100, 9900.00, 1, 6);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (32, '15/12/2023', '02/01/2024', 7, 95, 10800.00, 0, 7);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (33, '18/12/2023', '05/01/2024', 8, 90, 11500.00, 1, 8);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (34, '22/12/2023', '10/01/2024', 9, 85, 9900.00, 0, 9);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (35, '25/12/2023', '15/01/2024', 10, 80, 10800.00, 1, 10);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (36, '28/12/2023', '18/01/2024', 11, 75, 11500.00, 0, 11);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (37, '01/01/2024', '22/01/2024', 12, 70, 9900.00, 1, 12);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (38, '05/01/2024', '25/01/2024', 13, 65, 10800.00, 0, 13);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (39, '08/01/2024', '29/01/2024', 14, 60, 11500.00, 1, 14);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (40, '12/01/2024', '02/02/2024', 15, 55, 9900.00, 0, 15);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (41, '15/01/2024', '06/02/2024', 16, 50, 10800.00, 1, 16);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (42, '18/01/2024', '09/02/2024', 17, 45, 11500.00, 0, 17);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (43, '22/01/2024', '12/02/2024', 18, 40, 9900.00, 1, 18);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (44, '25/01/2024', '15/02/2024', 19, 35, 10800.00, 0, 19);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (45, '28/01/2024', '18/02/2024', 20, 30, 11500.00, 1, 20);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (46, '01/02/2024', '21/02/2024', 21, 25, 9900.00, 0, 21);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (47, '05/02/2024', '25/02/2024', 22, 20, 10800.00, 1, 22);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (48, '08/02/2024', '28/02/2024', 23, 15, 11500.00, 0, 23);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (49, '12/02/2024', '02/03/2024', 24, 10, 9900.00, 1, 24);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (50, '15/02/2024', '05/03/2024', 25, 5, 10800.00, 0, 25);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (51, '18/02/2024', '08/03/2024', 1, 130, 11500.00, 1, 1);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (52, '22/02/2024', '12/03/2024', 2, 125, 9900.00, 0, 2);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (53, '25/02/2024', '15/03/2024', 3, 120, 10800.00, 1, 3);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (54, '01/03/2024', '19/03/2024', 4, 115, 11500.00, 0, 4);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (55, '05/03/2024', '22/03/2024', 5, 110, 9900.00, 1, 5);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (56, '08/03/2024', '25/03/2024', 6, 105, 10800.00, 0, 6);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (57, '12/03/2024', '28/03/2024', 7, 100, 11500.00, 1, 7);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (58, '15/03/2024', '01/04/2024', 8, 95, 9900.00, 0, 8);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (59, '18/03/2024', '05/04/2024', 9, 90, 10800.00, 1, 9);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (60, '22/03/2024', '09/04/2024', 10, 85, 11500.00, 0, 10);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (9, '20/09/2023', '05/10/2023', 10, 78, 99000.00, 1, 10);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (14, '15/10/2023', '30/10/2023', 5, 105, 59400.00, 0, 5);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (22, '23/11/2023', '08/12/2023', 8, 99, 45900.00, 1, 8);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (37, '04/12/2023', '19/12/2023', 12, 116, 121500.00, 0, 12);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (42, '29/01/2024', '13/02/2024', 25, 126, 84700.00, 1, 25);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (15, '18/09/2023', '03/10/2023', 18, 121, 61500.00, 1, 18);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (28, '22/10/2023', '06/11/2023', 21, 109, 118800.00, 0, 21);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (54, '10/11/2023', '25/11/2023', 2, 111, 75000.00, 1, 2);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (7, '03/12/2023', '18/12/2023', 24, 89, 48600.00, 1, 24);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (12, '21/10/2023', '05/11/2023', 14, 102, 63000.00, 0, 14);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (5, '12/11/2023', '27/11/2023', 16, 125, 110000.00, 1, 16);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (39, '08/09/2023', '23/09/2023', 7, 85, 56700.00, 0, 7);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (26, '02/10/2023', '17/10/2023', 4, 99, 67500.00, 1, 4);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (33, '11/12/2023', '26/12/2023', 9, 111, 118800.00, 0, 9);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (11, '19/10/2023', '03/11/2023', 15, 122, 68400.00, 1, 15);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (41, '04/01/2024', '19/01/2024', 22, 113, 66000.00, 0, 22);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (45, '14/12/2023', '29/12/2023', 13, 127, 121500.00, 1, 13);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (57, '23/11/2023', '08/12/2023', 11, 120, 99000.00, 0, 11);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (38, '12/10/2023', '27/10/2023', 6, 114, 92500.00, 1, 6);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (52, '06/11/2023', '21/11/2023', 3, 130, 115500.00, 0, 3);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (43, '20/12/2023', '04/01/2024', 23, 106, 72000.00, 1, 23);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (8, '30/09/2023', '15/10/2023', 25, 108, 66000.00, 0, 25);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (16, '16/10/2023', '31/10/2023', 17, 120, 82600.00, 1, 17);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (28, '21/11/2023', '06/12/2023', 20, 115, 110500.00, 0, 20);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (13, '05/10/2023', '20/10/2023', 19, 124, 60500.00, 1, 19);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (31, '29/12/2023', '13/01/2024', 1, 103, 67500.00, 0, 1);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (46, '07/01/2024', '22/01/2024', 25, 101, 65500.00, 1, 25);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (54, '11/12/2023', '26/12/2023', 4, 117, 68400.00, 0, 4);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (6, '09/11/2023', '24/11/2023', 18, 110, 71500.00, 1, 18);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (24, '15/10/2023', '30/10/2023', 12, 106, 65200.00, 0, 12);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (10, '03/01/2024', '18/01/2024', 8, 109, 82500.00, 1, 8);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (55, '02/12/2023', '17/12/2023', 2, 114, 99200.00, 0, 2);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (50, '23/11/2023', '08/12/2023', 21, 121, 104500.00, 1, 21);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (27, '16/12/2023', '31/12/2023', 13, 123, 76200.00, 0, 13);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (59, '05/12/2023', '20/12/2023', 14, 118, 54000.00, 1, 14);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (60, '10/10/2023', '25/10/2023', 16, 108, 67600.00, 0, 16);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (53, '19/11/2023', '04/12/2023', 7, 122, 67100.00, 1, 7);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (40, '13/12/2023', '28/12/2023', 25, 106, 73800.00, 0, 25);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (44, '21/10/2023', '05/11/2023', 19, 123, 78700.00, 1, 19);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (29, '17/11/2023', '02/12/2023', 6, 107, 68400.00, 0, 6);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (18, '08/12/2023', '23/12/2023', 1, 120, 79500.00, 1, 1);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (35, '04/12/2023', '19/12/2023', 10, 116, 85200.00, 0, 10);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (32, '01/12/2023', '16/12/2023', 20, 118, 66300.00, 1, 20);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (17, '26/10/2023', '10/11/2023', 8, 107, 60800.00, 0, 8);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (48, '07/11/2023', '22/11/2023', 3, 105, 59900.00, 1, 3);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (49, '15/09/2023', '30/09/2023', 12, 109, 76900.00, 0, 12);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (1, '01/03/2024', '16/03/2024', 5, 102, 87700.00, 1, 5);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (2, '04/03/2024', '19/03/2024', 11, 107, 76600.00, 0, 11);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (3, '07/03/2024', '22/03/2024', 8, 110, 90500.00, 1, 8);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (4, '10/03/2024', '25/03/2024', 13, 121, 99000.00, 1, 13);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (5, '13/03/2024', '28/03/2024', 4, 124, 72500.00, 0, 4);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (6, '16/03/2024', '31/03/2024', 17, 126, 87300.00, 1, 17);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (7, '19/03/2024', '03/04/2024', 22, 130, 115500.00, 1, 22);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (8, '22/03/2024', '06/04/2024', 10, 103, 69400.00, 0, 10);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (9, '25/03/2024', '09/04/2024', 19, 109, 87100.00, 1, 19);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (10, '28/03/2024', '12/04/2024', 7, 120, 94900.00, 0, 7);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (11, '01/04/2024', '16/04/2024', 6, 114, 80500.00, 1, 6);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (12, '04/04/2024', '19/04/2024', 16, 107, 69700.00, 0, 16);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (13, '07/04/2024', '22/04/2024', 25, 110, 87300.00, 1, 25);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (14, '10/04/2024', '25/04/2024', 3, 124, 76500.00, 1, 3);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (15, '13/04/2024', '28/04/2024', 20, 126, 105000.00, 0, 20);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (16, '16/04/2024', '01/05/2024', 12, 130, 94400.00, 1, 12);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (17, '19/04/2024', '04/05/2024', 11, 106, 70800.00, 0, 11);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (18, '22/04/2024', '07/05/2024', 14, 121, 87000.00, 1, 14);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (19, '25/04/2024', '10/05/2024', 8, 113, 65400.00, 0, 8);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (20, '28/04/2024', '13/05/2024', 23, 122, 98000.00, 1, 23);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (21, '01/05/2024', '16/05/2024', 13, 108, 87100.00, 1, 13);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (22, '04/05/2024', '19/05/2024', 18, 106, 85000.00, 0, 18);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (23, '07/05/2024', '22/05/2024', 4, 121, 69200.00, 1, 4);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (24, '10/05/2024', '25/05/2024', 6, 123, 84400.00, 0, 6);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (25, '13/05/2024', '28/05/2024', 7, 127, 99800.00, 1, 7);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (26, '16/05/2024', '31/05/2024', 12, 106, 73100.00, 1, 12);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (27, '19/05/2024', '03/06/2024', 20, 124, 79500.00, 0, 20);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (28, '22/05/2024', '06/06/2024', 2, 115, 73200.00, 1, 2);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (29, '25/05/2024', '09/06/2024', 5, 130, 113200.00, 0, 5);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (30, '28/05/2024', '12/06/2024', 15, 108, 92000.00, 1, 15);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (31, '01/06/2024', '16/06/2024', 8, 107, 77100.00, 0, 8);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (32, '04/06/2024', '19/06/2024', 18, 109, 87200.00, 1, 18);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (33, '07/06/2024', '22/06/2024', 14, 124, 76800.00, 0, 14);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (34, '10/06/2024', '25/06/2024', 11, 113, 84600.00, 1, 11);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (35, '13/06/2024', '28/06/2024', 19, 106, 68300.00, 1, 19);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (36, '16/06/2024', '01/07/2024', 25, 122, 91700.00, 0, 25);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (37, '19/06/2024', '04/07/2024', 6, 110, 73600.00, 1, 6);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (38, '22/06/2024', '07/07/2024', 23, 115, 80100.00, 0, 23);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (39, '25/06/2024', '10/07/2024', 9, 121, 79000.00, 1, 9);
INSERT INTO Cotizaciones (id_cliente, fecha_emision, fecha_venc, id_cod_postal, id_seguro, precio, aprobada, id_sucursal) VALUES (40, '28/06/2024', '13/07/2024', 7, 107, 85400.00, 0, 7);
