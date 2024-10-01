CREATE DATABASE ParkWise;

USE ParkWise;

CREATE TABLE cliente (
    idCliente INT PRIMARY KEY AUTO_INCREMENT,
    nomeCompleto VARCHAR(100),
    telefone CHAR(13),
    endereco VARCHAR(255),
    qtdEstacionamento INT
);

CREATE TABLE sessao (
    idSessao INT PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(255),
    senha VARCHAR(45),
    horarioEntrada TIME,
    horarioSaida TIME,
    tokenAcesso INT,
    fkSessaoCliente INT,
    CONSTRAINT fk_Sessao_Cliente FOREIGN KEY (fkSessaoCliente) REFERENCES cliente(idCliente)
);

CREATE TABLE estacionamento (
    idEstacionamento INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45),
    endereco VARCHAR(45),
    cnpj CHAR(18),
    capacidadeVagas INT,
    fkEstacionamentoCliente INT,
    CONSTRAINT fk_Estacionamento_Cliente FOREIGN KEY (fkEstacionamentoCliente) REFERENCES cliente(idCliente)
);

CREATE TABLE sensor (
    idSensor INT PRIMARY KEY AUTO_INCREMENT,
    estadoVaga TINYINT,
    horarioEntrada CHAR(5),
    horarioSaida CHAR(5),
    dataLeitura DATE,
    fkSensorEstacionamento INT,
    CONSTRAINT fk_Sensor_Estacionamento FOREIGN KEY (fkSensorEstacionamento) REFERENCES estacionamento(idEstacionamento)
);

CREATE TABLE suporteChamados (
    idChamado INT PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(255),
    descricao VARCHAR(300),
    dataChamado DATE,
    fkSuporteEstacionamento INT,
    CONSTRAINT fk_SuporteChamados_Estacionamento FOREIGN KEY (fkSuporteEstacionamento) REFERENCES estacionamento(idEstacionamento)
);

INSERT INTO cliente (nomeCompleto, telefone, endereco, qtdEstacionamento) VALUES 
    ('João Silva', '11999999999', 'Av. Principal, 100', 1),
    ('Maria Oliveira', '11988888888', 'Rua Secundária, 200', 2),
    ('Pedro Santos', '11977777777', 'Travessa 3, 300', 1),
    ('Ana Costa', '11966666666', 'Beco 4, 400', 1),
    ('Carlos Lima', '11955555555', 'Praça 5, 500', 1);

INSERT INTO estacionamento (nome, endereco, cnpj, capacidadeVagas, fkEstacionamentoCliente) VALUES
    ('Estacionamento Central', 'Rua A, 123', '12.345.678/0001-90', 100, 1),
    ('Estacionamento Norte', 'Rua B, 456', '98.765.432/0001-21', 80, 2),
    ('Estacionamento Sul', 'Rua C, 789', '54.321.678/0001-11', 120, 3),
    ('Estacionamento Leste', 'Rua D, 101', '33.444.555/0001-22', 200, 4),
    ('Estacionamento Oeste', 'Rua E, 202', '22.333.111/0001-33', 200, 5);

INSERT INTO sensor (estadoVaga, horarioEntrada, horarioSaida, dataLeitura, fkSensorEstacionamento) VALUES
    (1, '08:00', '12:00', '2024-09-01', 1),
    (0, '13:00', '18:00', '2024-09-02', 2),
    (1, '09:30', '11:45', '2024-09-03', 3),
    (0, '14:45', '17:30', '2024-09-04', 4),
    (1, '07:00', '10:30', '2024-09-05', 5);

INSERT INTO suporteChamados (email, descricao, dataChamado, fkSuporteEstacionamento) VALUES
    ('cliente1@example.com', 'Problema com o acesso ao estacionamento', '2024-09-05', 1),
    ('cliente2@example.com', 'Dificuldade em efetuar o pagamento', '2024-09-06', 2),
    ('cliente3@example.com', 'Vaga indisponível', '2024-09-07', 3),
    ('cliente4@example.com', 'Falha no sensor de entrada', '2024-09-08', 4),
    ('cliente5@example.com', 'Problema na saída', '2024-09-09', 5);

INSERT INTO sessao (email, senha, horarioEntrada, horarioSaida, tokenAcesso, fkSessaoCliente) VALUES 
    ('cliente1@example.com', 'senha123', '08:00:00', '12:00:00', 123456, 1),
    ('cliente2@example.com', 'senha456', '09:00:00', '14:00:00', 234567, 2),
    ('cliente3@example.com', 'senha789', '10:00:00', '16:00:00', 345678, 3),
    ('cliente4@example.com', 'senha101', '11:00:00', '18:00:00', 456789, 4),
    ('cliente5@example.com', 'senha202', '12:00:00', '20:00:00', 243746, 5);

SELECT * FROM cliente;
SELECT * FROM estacionamento;
SELECT * FROM sensor;
SELECT * FROM suporteChamados;
SELECT * FROM sessao;
    
SELECT e.endereco as 'Endereco do estacionamento', 
s.estadoVaga as 'Vaga ocupada', 
s.dataLeitura as 'Data'
FROM estacionamento as e 
JOIN 
sensor as s ON e.idEstacionamento = s.fkSensorEstacionamento;

SELECT s.descricao as 'Descricao do chamado', 
s.dataChamado as 'Data do chamado', 
e.nome as 'Nome do estacionamento', 
e.endereco as 'Endereco do estacionamento'
FROM suporteChamados as s
JOIN estacionamento as e on s.fkSuporteEstacionamento = e.idEstacionamento
WHERE dataChamado >= '2024-09-07';

SELECT c.nomeCompleto as 'Nome do cliente',
s.email as 'Email logado', s.horarioEntrada as 'Horario entrada no sistema',
	CASE
    WHEN horarioEntrada = '09:00:00' THEN 'Cliente entra no inicio do horario de trabalho'
    WHEN horarioEntrada >= '11:00:00' THEN 'Cliente entra no horario de almoco'
    ELSE 'Cliente entra super cedo'
END AS 'Descricao'
FROM cliente as c
JOIN sessao as s ON c.idCliente = s.fkSessaoCliente;

SELECT c.nomeCompleto as 'Nome do cliente', 
e.nome as 'Nome do estacionamento', 
e.capacidadeVagas as 'Capacidade total',
IFNULL(capacidadeVagas, 'Cliente invalido')
FROM cliente as c JOIN estacionamento as e on c.idCliente = e.fkEstacionamentoCliente;