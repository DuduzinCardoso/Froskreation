/* para workbench - local - desenvolvimento */

-- DROP DATABASE Froskreation;
CREATE DATABASE Froskreation;
CREATE USER IF NOT EXISTS 'editor'@'localhost' IDENTIFIED BY '@editor999';
ALTER USER 'editor'@'localhost' IDENTIFIED WITH mysql_native_password BY '@editor999';
-- ----------------------------------------------------------------------------------------------------------
-- -----------------------------------------Criação DB e User------------------------------------------------
-- ----------------------------------------------------------------------------------------------------------
USE Froskreation;

CREATE TABLE cliente (
	id INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(50),
    sobrenome VARCHAR(50),
    empresa VARCHAR(50),
    cnpj VARCHAR(14),
    endereco VARCHAR(60),
    bairro VARCHAR(50),
    telefone VARCHAR(13),
	email VARCHAR(50),
	senha VARCHAR(50)
    )auto_increment = 1000;
    
-- select * from cliente;
    
CREATE TABLE sensoresCadastrados(
id int primary key not null auto_increment,
tipo varchar(10),
tanque int,
fk_cliente int,
foreign key (fk_cliente) references cliente(id)
);

-- insert into sensoresCadastrados (tipo, tanque, fk_cliente) values ("lm35",1,1000),("lm35",4,1000),("lm35",4,1000),("lm35",5,1000);

CREATE TABLE aviso (
	id INT PRIMARY KEY AUTO_INCREMENT,
	titulo VARCHAR(100),
    descricao VARCHAR(150),
	fk_cliente INT,
	FOREIGN KEY (fk_cliente) REFERENCES cliente(id)
); 

CREATE TABLE medidaLm35 (
	id INT PRIMARY KEY AUTO_INCREMENT,
	temperatura DECIMAL(4,2),
    umidade DECIMAL(4,2),
	momento DATETIME,
	fk_aquario INT,
    foreign key (fk_sensores) references sensoresCadastrados(id)
);

-- select * from medidaLm35;

CREATE TABLE produtos(
id int primary key not null auto_increment,
nome varchar(10),
preco decimal(10,2),
estoque int
)auto_increment = 1;

CREATE TABLE historicoAquisicao (
id int primary key not null auto_increment,
fk_cliente int,
foreign key (fk_cliente) references cliente(id),
fk_produtos int,
foreign key (fk_produtos) references produtos(id),
dataCompra date,
valorPago decimal(10,2)
)auto_increment = 1;

-- ----------------------------------------------------------------------------------------------------------
-- -------------------------------Privilégios do Usuário Editor----------------------------------------------
-- ----------------------------------------------------------------------------------------------------------

GRANT SELECT, INSERT ON Froskreation.cliente TO 'editor'@'localhost';
GRANT SELECT, INSERT ON Froskreation.aviso TO 'editor'@'localhost';
GRANT SELECT, INSERT ON Froskreation.medidaLm35 TO 'editor'@'localhost';
GRANT SELECT, INSERT ON Froskreation.sensoresCadastrados TO 'editor'@'localhost';
GRANT SELECT, INSERT ON Froskreation.produtos TO 'editor'@'localhost';
GRANT SELECT, INSERT ON Froskreation.historicoAquisicao TO 'editor'@'localhost';
FLUSH PRIVILEGES;

