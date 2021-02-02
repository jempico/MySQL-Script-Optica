CREATE DATABASE cul_dampolla_JemPi;
USE cul_dampolla_JemPi;

-- CREATING TABLES
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


CREATE TABLE `muntura` (
  `id_muntura` int PRIMARY KEY NOT NULL AUTO_INCREMENT,
	`tipus` ENUM('pasta', 'flotant', 'metàlica')
);  

CREATE TABLE `color_muntura` (
  `id_color_muntura` int PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `color` VARCHAR(20)
);

CREATE TABLE `color_vidre` (
  `id_color_vidre` int PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `color` VARCHAR(20)
);

CREATE TABLE `empleat` (
  `id_empleat` int PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(25)
);

CREATE TABLE `producte` (
  `id_producte` varchar(50) PRIMARY KEY  NOT NULL UNIQUE,
  `marca` varchar(25) NOT NULL,
  `id_muntura` INT,
  `id_color_muntura` INT,
  `id_color_vidre` INT,
  `preu` float,
  `id_proveidor` int,

);

CREATE TABLE `comanda` (
  `id_comanda` int PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `id_client` int,
  `data_comanda` DATETIME NOT NULL
                DEFAULT CURRENT_TIMESTAMP, 
  `preu_final` float,
  `id_empleat` INT
);

CREATE TABLE `producte_processat` (
  `id_producte` varchar(50) NOT NULL,
  `id_comanda` int NOT NULL,
  `graduacio` float,
  `quantitat` int,
  `preu_unitari` float,
  PRIMARY KEY (`id_producte`, `id_comanda`)
);



-- ADDING FOREIGN KEYS

ALTER TABLE `producte` ADD FOREIGN KEY (`id_proveidor`) REFERENCES `proveidor` (`id_proveidor`);

ALTER TABLE `producte` ADD FOREIGN KEY (`id_muntura`) REFERENCES `muntura` (`id_muntura`);

ALTER TABLE `producte` ADD FOREIGN KEY (`id_color_muntura`) REFERENCES `color_muntura` (`id_color_muntura`);

ALTER TABLE `producte` ADD FOREIGN KEY (`id_color_vidre`) REFERENCES `color_vidre` (`id_color_vidre`);

ALTER TABLE `client` ADD FOREIGN KEY (`recomanat_per`) REFERENCES `client` (`id_client`);

ALTER TABLE `comanda` ADD FOREIGN KEY (`id_client`) REFERENCES `client` (`id_client`);

ALTER TABLE `comanda` ADD FOREIGN KEY (`id_empleat`) REFERENCES `empleat` (`id_empleat`);

ALTER TABLE `producte_processat` ADD FOREIGN KEY (`id_producte`) REFERENCES `producte` (`id_producte`);

ALTER TABLE `producte_processat` ADD FOREIGN KEY (`id_comanda`) REFERENCES `comanda` (`id_comanda`);


-- INSERTING DATA

INSERT INTO client (nom, cognoms, telf, ciutat) VALUES ('Tomas', 'Rodriguez Blanco', '935647896', 'Barcelona'), ('Maria', 'Carmona Lopez', '935647896', 'Barcelona'), ('Estel', 'Duran Blasco', '935646596', 'Barcelona'),('Eloi', 'Bayo Pico', '935647865', 'Badalona'),('Lenka', 'Jaraba Guim', '935127890', 'Girona');
INSERT INTO client (nom, cognoms, adreca, email, codi_postal, ciutat, recomanat_per) VALUES ('Biel', 'Martínez Closas', 'c/ Cardener 9 2-1', 'bclosas@gmail.com', '08024', 'Barcelona', 1), ('Mel', 'Ruiz Casadesús', 'c/ La Granja 9 2-1', 'mruiz@gmail.com', '08020', 'Barcelona', 3),  ('Lisa', 'McCarthy Finn', 'c/ Dublin 9 2-1', 'lfinn@gmail.com', '08015', 'Badalona', 3), ('James', 'Augustine Joyce', 'c/ Dublin 9 2-1', 'jamesjoyces@gmail.com', '08015', 'Badalona', 3);


INSERT INTO color_muntura (color) VALUES ('negre'), ('daurat'), ('vermell'), ('plata'), ('verd'), ('lila'), ('multicolor'), ('marro'), ('gris'),('transparent');
INSERT INTO color_vidre (color) VALUES ('groc'), ('daurat'), ('taronja'), ('vermell'), ('plata'), ('blau'), ('lila'), ('multicolor'), ('marro'), ('gris'),('transparent');
INSERT INTO muntura (tipus) VALUES ('pasta'), ('flotant'), ('metalica');
INSERT INTO proveidor (nom, telf, nif, codi_postal, ciutat) VALUES ('Prosun Optica', 913456789, 'B9153252N', 41001, 'Sevilla'),  ('Macrostocks', 933456789, 'Y9153252L', 08001, 'Barcelona') , ('Vistaoptica', 913567119, 'B9153252T', 28005, 'Madrid');
INSERT INTO empleat (nom) VALUES ('Esther'), ('Alan'), ('Teo'), ('Júlia'), ('Rafa');
INSERT INTO producte (id_producte, marca, id_muntura, id_color_muntura, id_color_vidre, preu, id_proveidor) 
VALUES ('JC4340601', 'Jimmy Choo', 1, 6, 11, 154.50, 1),('JC0340606', 'Jimmy Choo', 1, 5, 7, 144.50, 1),('JC4340602', 'Jimmy Choo', 1, 3, 10, 134.50, 1), ('RB1340602', 'Ray-ban', 1, 1, 2, 89.00, 3),('RB2340603', 'Ray-ban', 2, 1, 2, 99.00, 3), ('RB5340606', 'Ray-ban', 3, 1, 2, 95.00, 3), ('OA1340609', 'Oakley', 2, 3, 1, 84.90, 3), ('PO1113406U', 'Polaroid', 3, 5, 1, 94.50, 3), ('PO223406U', 'Polaroid', 3, 6, 2, 99.50, 3), ('PE1134060','Persol', 1, 7, 4, 129.50, 2), ('PE5134060', 'Persol', 1, 8, 5, 115.50, 2),('PE7134060' , 'Persol', 2, 10, 9, 139.00, 2),('AR81134068', 'Arnette', 2, 10, 5, 169.00, 2);


INSERT INTO comanda (id_client, id_empleat) VALUES (1, 3);

SELECT * FROM producte;

INSERT INTO producte (id_producte, marca, id_muntura, id_color_muntura, id_color_vidre, preu, id_proveidor) 
VALUES ('AR81134068', 'Arnette', 2, 10, 5, 169.00, 2);

INSERT INTO producte (id_producte, marca, id_muntura, id_color_muntura, id_color_vidre, preu, id_proveidor) 
VALUES ('AR81134black', 'Arnette', 1, 2, 5, 169.00, 2);
