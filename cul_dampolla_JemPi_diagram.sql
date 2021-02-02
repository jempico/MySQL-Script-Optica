CREATE TABLE [proveidor] (
  [id_proveidor] int PRIMARY KEY NOT NULL IDENTITY(1, 1),
  [nom] varchar(25) NOT NULL,
  [adreca] varchar(100),
  [telf] varchar(25),
  [fax] varchar(25),
  [nif] varchar(9) NOT NULL,
  [codi_postal] VARCHAR(9),
  [ciutat] VARCHAR(25)
)
GO

CREATE TABLE [producte] (
  [id_producte] VARCHAR(50) UNIQUE PRIMARY KEY NOT NULL,
  [marca] varchar(25) NOT NULL,
  [graduacio] tinyint,
  [id_muntura] INT,
  [id_color_muntura] INT,
  [id_color_vidre] INT,
  [preu] float,
  [id_proveidor] int
)
GO

CREATE TABLE [muntura] (
  [id_muntura] int PRIMARY KEY NOT NULL IDENTITY(1, 1),
  [tipus] enum
)
GO

CREATE TABLE [color_muntura] (
  [id_color_muntura] int PRIMARY KEY NOT NULL IDENTITY(1, 1),
  [color] VARCHAR(20)
)
GO

CREATE TABLE [color_vidre] (
  [id_color_vidre] int PRIMARY KEY NOT NULL IDENTITY(1, 1),
  [color] VARCHAR(20)
)
GO

CREATE TABLE [producte_processat] (
  [id_producte] VARCHAR(50) NOT NULL,
  [id_comanda] int NOT NULL,
  [quantitat] int,
  [preu_unitari] float,
  PRIMARY KEY ([id_producte], [id_comanda])
)
GO

CREATE TABLE [comanda] (
  [id_comanda] int PRIMARY KEY NOT NULL IDENTITY(1, 1),
  [id_client] int,
  [data_comanda] timestamp,
  [preu_final] float,
  [id_empleat] INT
)
GO

CREATE TABLE [client] (
  [id_client] int PRIMARY KEY NOT NULL IDENTITY(1, 1),
  [nom] varchar(25),
  [cognoms] varchar(45),
  [adreca] varchar(100),
  [telf] varchar(25),
  [email] varchar(25),
  [data_registre] datetime,
  [codi_postal] VARCHAR(9),
  [ciutat] VARCHAR(25),
  [recomanat_per] int
)
GO

CREATE TABLE [empleat] (
  [id_empleat] int PRIMARY KEY NOT NULL IDENTITY(1, 1),
  [nom] VARCHAR(25)
)
GO

ALTER TABLE [producte] ADD FOREIGN KEY ([id_proveidor]) REFERENCES [proveidor] ([id_proveidor])
GO

ALTER TABLE [producte] ADD FOREIGN KEY ([id_muntura]) REFERENCES [muntura] ([id_muntura])
GO

ALTER TABLE [producte] ADD FOREIGN KEY ([id_color_muntura]) REFERENCES [color_muntura] ([id_color_muntura])
GO

ALTER TABLE [producte] ADD FOREIGN KEY ([id_color_vidre]) REFERENCES [color_vidre] ([id_color_vidre])
GO

ALTER TABLE [producte_processat] ADD FOREIGN KEY ([id_producte]) REFERENCES [producte] ([id_producte])
GO

ALTER TABLE [producte_processat] ADD FOREIGN KEY ([id_comanda]) REFERENCES [comanda] ([id_comanda])
GO

ALTER TABLE [comanda] ADD FOREIGN KEY ([id_client]) REFERENCES [client] ([id_client])
GO

ALTER TABLE [comanda] ADD FOREIGN KEY ([id_empleat]) REFERENCES [empleat] ([id_empleat])
GO

ALTER TABLE [client] ADD FOREIGN KEY ([id_client]) REFERENCES [client] ([recomanat_per])
GO

