CREATE DATABASE  ParkWise;
USE ParkWise;

CREATE TABLE cliente(
	id_Cliente INT PRIMARY KEY AUTO_INCREMENT,
    nomeCompleto VARCHAR(45),
    telefone CHAR(13), 
    endereco VARCHAR(255),
    cnpj CHAR(18),
    email VARCHAR(100),
    senha VARCHAR(50),
    qtd_Estacionamento INT
);

CREATE TABLE sensor_estacionamento(
	id_sensor INT PRIMARY KEY AUTO_INCREMENT,
    estadoVaga boolean,
    horarioEntrada CHAR(12), -- DATETIME
    horarioSaida CHAR(12) -- DATETIME 
);
CREATE TABLE estacionamento(
	id_Estacionamento INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45),
    endereco VARCHAR(255),
    capacidadeVaga INT
);

INSERT INTO cliente (nomeCompleto, telefone, endereco, cnpj, email, senha, qtd_estacionamento) VALUES
('João Silva', '11912345678', 'Rua A, 123, São Paulo, SP', '12.345.678/0001-90', 'joao.silva@email.com', 'senha123', 3),
('Maria Oliveira', '11987654321', 'Avenida B, 456, Rio de Janeiro, RJ', '23.456.789/0001-01', 'maria.oliveira@email.com', 'senha456', 2),
('Carlos Souza', '11923456789', 'Rua C, 789, Belo Horizonte, MG', '34.567.890/0001-12', 'carlos.souza@email.com', 'senha789', 4),
('Ana Costa', '11934567890', 'Avenida D, 321, Porto Alegre, RS', '45.678.901/0001-23', 'ana.costa@email.com', 'senha321', 1),
('Luiz Pereira', '11945678901', 'Rua E, 654, Curitiba, PR', '56.789.012/0001-34', 'luiz.pereira@email.com', 'senha654', 5);

INSERT INTO sensor_estacionamento (estadoVaga, horarioEntrada, horarioSaida) VALUES
(TRUE, '06/16 08:00', ' 06/16 12:30'),
(FALSE, '09/10 13:00', ' 09/10 17:00'),
(TRUE, '10/10 09:30', '10/10 12:00'),
(FALSE, '11/10 11:00', '11/10 15:00'),
(TRUE, '12/10 14:00', '13/10 18:00');

INSERT INTO estacionamento (nome, endereco, capacidadeVaga) VALUES
('Estacionamento Central', 'Rua A, 123, São Paulo, SP', 50),
('Estacionamento Norte', 'Avenida B, 456, Rio de Janeiro, RJ', 30),
('Estacionamento Sul', 'Rua C, 789, Belo Horizonte, MG', 20),
('Estacionamento Leste', 'Avenida D, 321, Porto Alegre, RS', 40),
('Estacionamento Oeste', 'Rua E, 654, Curitiba, PR', 60);

select * from cliente;
select * from sensor_estacionamento;
select * from estacionamento;