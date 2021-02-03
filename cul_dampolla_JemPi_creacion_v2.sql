DROP DATABASE IF EXISTS cul_dampolla_JemPi;
CREATE DATABASE cul_dampolla_JemPi CHARACTER SET utf8mb4;
USE cul_dampolla_JemPi;

-- CREATING TABLES
-- Proveidor

CREATE TABLE `proveidor` (
  `id_proveidor` int PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `nom` varchar(25) NOT NULL,
  `adreca` varchar(100),
  `telf` varchar(25),
  `fax` varchar(25),
  `nif` varchar(9) NOT NULL,
  `codi_postal` VARCHAR(9),
  `ciutat` VARCHAR(25)
);

-- Client
CREATE TABLE `client` (
  `id_client` int PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `nom` varchar(25),
  `cognoms` varchar(50),
  `adreca` varchar(100),
  `telf` varchar(25),
  `email` varchar(25),
  `data_registre` DATETIME NOT NULL
                DEFAULT CURRENT_TIMESTAMP, 
  `codi_postal` VARCHAR(9),
  `ciutat` VARCHAR(25),
  `recomanat_per` int
);

-- Muntura
CREATE TABLE `muntura` (
  `id_muntura` int PRIMARY KEY NOT NULL AUTO_INCREMENT,
	`tipus` ENUM('pasta', 'flotant', 'metàlica')
);  

-- Color Muntura
CREATE TABLE `color_muntura` (
  `id_color_muntura` int PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `color` VARCHAR(20)
);

-- Color Vidre
CREATE TABLE `color_vidre` (
  `id_color_vidre` int PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `color` VARCHAR(20)
);

-- Empleat
CREATE TABLE `empleat` (
  `id_empleat` int PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(25)
);

-- Marca
CREATE TABLE  `marca` (
  `id_marca` int PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `name` varchar(15),
  `id_proveidor` int
);

-- Producte
CREATE TABLE `producte` (
  `id_producte` varchar(50) PRIMARY KEY  NOT NULL UNIQUE,
  `id_marca` int NOT NULL,
  `id_muntura` INT,
  `id_color_muntura` INT,
  `id_color_vidre` INT,
  `preu` float
);

-- Comanda
CREATE TABLE `comanda` (
  `id_comanda` int PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `id_client` int,
  `data_comanda` DATETIME NOT NULL
                DEFAULT CURRENT_TIMESTAMP, 
  `preu_final` float,
  `id_empleat` INT
);

-- Producte_processat
CREATE TABLE `producte_processat` (
  `id_producte` varchar(50) NOT NULL,
  `id_comanda` int NOT NULL,
  `graduacio` float,
  `quantitat` int,
  `preu_unitari` float,
  PRIMARY KEY (`id_producte`, `id_comanda`)
);


-- ADDING FOREIGN KEYS

ALTER TABLE `producte` ADD FOREIGN KEY (`id_marca`) REFERENCES `marca` (`id_marca`);

ALTER TABLE `marca` ADD FOREIGN KEY (`id_proveidor`) REFERENCES `proveidor` (`id_proveidor`);

ALTER TABLE `producte` ADD FOREIGN KEY (`id_muntura`) REFERENCES `muntura` (`id_muntura`);

ALTER TABLE `producte` ADD FOREIGN KEY (`id_color_muntura`) REFERENCES `color_muntura` (`id_color_muntura`);

ALTER TABLE `producte` ADD FOREIGN KEY (`id_color_vidre`) REFERENCES `color_vidre` (`id_color_vidre`);

ALTER TABLE `client` ADD FOREIGN KEY (`recomanat_per`) REFERENCES `client` (`id_client`);

ALTER TABLE `comanda` ADD FOREIGN KEY (`id_client`) REFERENCES `client` (`id_client`);

ALTER TABLE `comanda` ADD FOREIGN KEY (`id_empleat`) REFERENCES `empleat` (`id_empleat`);

ALTER TABLE `producte_processat` ADD FOREIGN KEY (`id_producte`) REFERENCES `producte` (`id_producte`);

ALTER TABLE `producte_processat` ADD FOREIGN KEY (`id_comanda`) REFERENCES `comanda` (`id_comanda`);


-- INSERTING DATA

-- Client
INSERT INTO client (nom, cognoms, telf, ciutat) VALUES ('Tomas', 'Rodriguez Blanco', '935647896', 'Barcelona'), ('Maria', 'Carmona Lopez', '935647896', 'Barcelona'), ('Estel', 'Duran Blasco', '935646596', 'Barcelona'),('Eloi', 'Bayo Pico', '935647865', 'Badalona'),('Lenka', 'Jaraba Guim', '935127890', 'Girona');

INSERT INTO client (nom, cognoms, adreca, email, codi_postal, ciutat, recomanat_per) VALUES ('Biel', 'Martínez Closas', 'c/ Cardener 9 2-1', 'bclosas@gmail.com', '08024', 'Barcelona', 1), ('Mel', 'Ruiz Casadesús', 'c/ La Granja 9 2-1', 'mruiz@gmail.com', '08020', 'Barcelona', 3),  ('Lisa', 'McCarthy Finn', 'c/ Dublin 9 2-1', 'lfinn@gmail.com', '08015', 'Badalona', 3), ('James', 'Augustine Joyce', 'c/ Dublin 9 2-1', 'jamesjoyces@gmail.com', '08015', 'Badalona', 3);

-- Color Muntura
INSERT INTO color_muntura (color) VALUES ('negre'), ('daurat'), ('vermell'), ('plata'), ('verd'), ('lila'), ('multicolor'), ('marro'), ('gris'),('transparent');

-- Color Vidre
INSERT INTO color_vidre (color) VALUES ('groc'), ('daurat'), ('taronja'), ('vermell'), ('plata'), ('blau'), ('lila'), ('multicolor'), ('marro'), ('gris'),('transparent');

-- Muntura
INSERT INTO muntura (tipus) VALUES ('pasta'), ('flotant'), ('metalica');

-- Proveidor
INSERT INTO proveidor (nom, telf, nif, codi_postal, ciutat) VALUES ('Prosun Optica', 913456789, 'B9153252N', 41001, 'Sevilla'),  ('Macrostocks', 933456789, 'Y9153252L', 08001, 'Barcelona') , ('Vistaoptica', 913567119, 'B9153252T', 28005, 'Madrid');

-- Empleat
INSERT INTO empleat (nom) VALUES ('Esther'), ('Alan'), ('Teo'), ('Júlia'), ('Rafa');

-- Marca
INSERT INTO marca (name, id_proveidor) 
VALUES ('Jimmy Choo', 1), ('Ray-ban', 3), ('Oakley', 3), ('Polaroid', 3), ('Persol', 2), ('Arnette', 2);

-- Producte
INSERT INTO producte (id_producte, id_marca, id_muntura, id_color_muntura, id_color_vidre, preu) 
VALUES ('JC4340601', 1, 1, 6, 11, 154.50),
('JC0340606', 1, 1, 5, 7, 144.50),
('JC4340602', 1, 1, 3, 10, 134.50), 
('RB1340602', 2, 1, 1, 2, 89.00),
('RB2340603', 2, 2, 1, 2, 99.00), 
('RB5340606', 2, 3, 1, 2, 95.00), 
('OA1340609', 3, 2, 3, 1, 84.90), 
('PO1113406U', 4, 3, 5, 1, 94.50), 
('PO223406U', 4, 3, 6, 2, 99.50), 
('PE1134060',5, 1, 7, 4, 129.50), 
('PE5134060', 5, 1, 8, 5, 115.50),
('PE7134060' , 5, 2, 10, 9, 139.00),
('AR81134068', 6, 2, 10, 5, 169.00);



-- INSERTING ORDER 1 
INSERT INTO comanda (id_client, id_empleat) VALUES (1, 3);

INSERT INTO producte_processat VALUES
	('JC4340601', LAST_INSERT_ID(), 0.5, 1, 154.50),
    ('RB2340603', LAST_INSERT_ID(), 0.5, 1, 99.0);

UPDATE comanda SET preu_final = 
		(SELECT SUM(preu_unitari * quantitat) 
        FROM producte_processat
		WHERE id_comanda = LAST_INSERT_ID())
WHERE id_comanda = LAST_INSERT_ID();


-- INSERTING ORDER 2 
INSERT INTO comanda (id_client, id_empleat) VALUES (3, 2);

INSERT INTO producte_processat VALUES
	('OA1340609', LAST_INSERT_ID(), 1.5, 2, 84.9);

UPDATE comanda SET preu_final = 
		(SELECT SUM(preu_unitari * quantitat) 
        FROM producte_processat
		WHERE id_comanda = LAST_INSERT_ID())
WHERE id_comanda = LAST_INSERT_ID();

-- INSERTING ORDER 3 
INSERT INTO comanda (id_client, id_empleat) VALUES (4, 1);

INSERT INTO producte_processat VALUES 
	('PO223406U', LAST_INSERT_ID(), 0.75, 1, 99.5),
	('JC4340601', LAST_INSERT_ID(), 0.75, 1, 154.5),
	('PE7134060', LAST_INSERT_ID(), 0, 1, 139);
    
UPDATE comanda SET preu_final = 
		(SELECT SUM(preu_unitari * quantitat) 
        FROM producte_processat
		WHERE id_comanda = LAST_INSERT_ID())
WHERE id_comanda = LAST_INSERT_ID();

-- INSERTING ORDER 4 
INSERT INTO comanda (id_client, id_empleat) VALUES (2, 4);

INSERT INTO producte_processat VALUES 
	('PO223406U', LAST_INSERT_ID(), 0.15, 1, 99.5);
    
UPDATE comanda SET preu_final = 
		(SELECT SUM(preu_unitari * quantitat) 
        FROM producte_processat
		WHERE id_comanda = LAST_INSERT_ID())
WHERE id_comanda = LAST_INSERT_ID();
