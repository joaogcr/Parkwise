CREATE DATABASE ParkWise;

USE ParkWise;

DROP DATABASE ParkWise;
DROP TABLE estacionamento;

CREATE TABLE usuario (
    idUsuario INT PRIMARY KEY AUTO_INCREMENT,
    nomeUsuario VARCHAR(100),
    email CHAR(255),
    senha VARCHAR(45)
);

CREATE TABLE sessao (
    idSessao INT PRIMARY KEY AUTO_INCREMENT,
    horarioEntrada TIME,
    fkUsuario INT,
    CONSTRAINT fk_Sessao_Cliente FOREIGN KEY (fkUsuario) REFERENCES usuario(idUsuario)
);

CREATE TABLE estacionamento (
    idEstacionamento INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45),
    endereco VARCHAR(45),
    cnpjEstacionamento CHAR(18),
    capacidadeVagas INT,
    fkEstacionamentoCliente INT,
    CONSTRAINT fk_Estacionamento_Cliente FOREIGN KEY (fkEstacionamentoCliente) REFERENCES usuario(idUsuario)
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
    id_suporte INT PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(255),
    descricao VARCHAR(300),
    dataChamado DATE,
    fkUsuario INT,
    CONSTRAINT fk_SuporteChamados_Estacionamento FOREIGN KEY (fkUsuario) REFERENCES estacionamento(idEstacionamento)
);

CREATE TABLE empresa (
	idCliente int primary key auto_increment,
	nomeEmpresa varchar(100),
	telefone char(13),
	endereco varchar(255),
	qtdEstacionamento INT,
	cnpjEmpresa char(18),
	fkUsuario int,
	constraint fkUsuarioEmpresa foreign key (fkUsuario)
		references usuario(idUsuario)
);

INSERT INTO usuario (nomeUsuario, email, senha) VALUES 
    ('João Silva', 'joao.silva@gmail.com', 'Aventur@123!'),
    ('Maria Oliveira', 'maria.oliveira@gmail.com', 'In0v@dora2024'),
    ('Pedro Santos', 'pedro.santos@gmail.com', 'Dest!n0#456'),
    ('Ana Costa', 'ana.costa@gmail.com', 'Exp!0r@Dora789'),
    ('Carlos Lima', 'carlos.lima@gmail.com', 'S0nh@dor!2024');

INSERT INTO estacionamento (nome, endereco, cnpjEstacionamento, capacidadeVagas, fkEstacionamentoCliente) VALUES
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

SELECT c.nomeCompleto as 'Nome do Cliente', 
	e.nome as 'Estacionamento',
    concat(e.endereco, ' | ', e.cnpj) as 'Endereço + CNPJ',
	sc.dataChamado as 'Data da abertura do Chamado', 
	sc.descricao as 'Sobre o Chamado'
    FROM cliente as c
    JOIN estacionamento as e
		ON e.fkEstacionamentoCliente = c.idCliente
	JOIN suporteChamados as sc
		ON sc.fkSuporteEstacionamento = idEstacionamento;