CREATE DATABASE parkwisePI;
USE parkwisePI;

CREATE TABLE estacionamento(
	idEstacionamento int primary key auto_increment,
	nome varchar(45),
	telefone char(15),
	capacidadeVagas int,
	cnpjEstacionamento char(18),
	logradouro varchar(45),
	numeroEnd char(4),
	bairro varchar(45),
	email varchar(100),
	senha varchar(50)
);

CREATE TABLE funcionario(
	idFuncionario int primary key auto_increment,
	nomeFuncionario varchar(45),
	email varchar(100),
	senha varchar(45),
	funcao varchar(45),
	fkEstacionamento int,
	constraint fkUsuarioEstacionamento foreign key (fkEstacionamento)
	references estacionamento(idEstacionamento)
);

CREATE TABLE suporte(
	idSuporte int primary key auto_increment,
	email varchar(100),
	descricao varchar(300),
	dataSuporte date,
	fkFuncionario int,
	constraint fkSuporteFuncionario foreign key (fkFuncionario)
	references funcionario(idFuncionario)
);

CREATE TABLE sensor(
	idSensor int primary key auto_increment,
	localizacao int,
	fkEstacionamento int,
	constraint fkSensorEstacionamento foreign key (fkEstacionamento)
	references estacionamento(idEstacionamento)
);

CREATE TABLE fluxo(
	idFluxo int primary key auto_increment,
	entrada datetime,
	statusVaga tinyint,
	constraint chkStatus check (statusVaga in(0,1))
);

create table vaga(
	fkSensor int,
	fkFluxo int,
	constraint pk_composta primary key (fkSensor, fkFluxo),
    constraint fk_VagaSensor foreign key (fkSensor) references sensor(idSensor),
    constraint fk_VagaFluxo foreign key (fkFluxo) references fluxo(idFluxo)
);


INSERT INTO estacionamento (nome, telefone, capacidadeVagas, cnpjEstacionamento, logradouro, numeroEnd, bairro) VALUES
	('Estacionamento Central Park','11912345678',200,'12.345.678/0001-90','Rua das Flores','150','Centro'),
	('Estacionamento Fácil Parking','21923456789',150,'23.456.789/0001-80','Avenida Rio Branco','220','Copacabana'),
	('Estacionamento Rápido','31934567890',120,'34.567.890/0001-70','Rua João Pinheiro','300','Lourdes'),
	('Estacionamento Segurança Total','41945678901',250,'45.678.901/0001-60','Avenida Paraná','180','Batel'),
	('Estacionamento VIP','51956789012',300,'56.789.012/0001-50','Rua dos Andradas','75','Moinhos de Vento'),
	('Estacionamento Econômico','71967890123',180,'67.890.123/0001-40','Avenida Sete de Setembro','400','Comércio');
    
INSERT INTO funcionario (nomeFuncionario, email, senha, funcao, fkEstacionamento) VALUES
    ('João Silva', 'joao@centralpark.com', 'senha123', 'Gerente', 1),
    ('Maria Oliveira', 'maria@facilparking.com', 'senha456', 'Atendente', 2),
    ('Carlos Souza', 'carlos@rapido.com', 'senha789', 'Supervisor', 3),
    ('Ana Pereira', 'ana@segurancatotal.com', 'senha321', 'Gerente', 4),
    ('Lucas Lima', 'lucas@vip.com', 'senha654', 'Atendente', 5),
    ('Fernanda Santos', 'fernanda@economico.com', 'senha987', 'Supervisor', 6);
    
INSERT INTO suporte (email, descricao, dataSuporte, fkFuncionario) VALUES
    ('suporte@centralpark.com', 'Problema com o sistema de câmeras', '2024-12-01', 1),
    ('suporte@facilparking.com', 'Dúvida sobre funcionamento do sensor de vagas', '2024-12-02', 2),
    ('suporte@rapido.com', 'Problema de conexão no software de gestão', '2024-12-03', 3),
    ('suporte@segurancatotal.com', 'Erro na leitura das placas', '2024-12-04', 4),
    ('suporte@vip.com', 'Sistema de pagamento não está funcionando', '2024-12-05', 5),
    ('suporte@economico.com', 'Falha no registro de entrada de veículos', '2024-12-06', 6);
   
INSERT INTO sensor (localizacao, fkEstacionamento) VALUES
    (1, 1),
    (2, 2),
    (3, 3),
    (4, 4),
    (5, 5),
    (6, 6);

INSERT INTO fluxo (entrada, statusVaga) VALUES
    ('2024-12-01 08:00:00', 1),
    ('2024-12-01 09:00:00', 0),
    ('2024-12-01 10:00:00', 1),
    ('2024-12-01 11:00:00', 0),
    ('2024-12-01 12:00:00', 1),
    ('2024-12-01 13:00:00', 0);
    
INSERT INTO vaga (fkSensor, fkFluxo) VALUES
    (1, 1),
    (2, 2),
    (3, 3),
    (4, 4),
    (5, 5),
    (6, 6);
    
INSERT INTO fluxo VALUES
(7, '2024-11-25 08:00:00', 1),
(8, '2024-11-25 09:30:00', 0),
(9, '2024-11-25 10:00:00', 1),
(10, '2024-11-25 11:15:00', 1),
(11, '2024-11-25 12:45:00', 0),
(12, '2024-11-25 14:00:00', 1),
(13, '2024-11-26 08:30:00', 1),
(14, '2024-11-26 09:30:00', 0),
(15, '2024-11-26 11:00:00', 1),
(16, '2024-11-26 12:15:00', 1),
(17, '2024-11-26 13:30:00', 0),
(18, '2024-11-26 14:30:00', 1),
(19, '2024-11-27 08:00:00', 1),
(20, '2024-11-27 09:30:00', 0),
(21, '2024-11-27 11:00:00', 1),
(22, '2024-11-27 12:30:00', 1),
(23, '2024-11-27 13:45:00', 0),
(24, '2024-11-27 14:15:00', 1),
(25, '2024-11-28 08:00:00', 1),
(26, '2024-11-28 09:00:00', 0),
(27, '2024-11-28 10:30:00', 1),
(28, '2024-11-28 11:45:00', 1),
(29, '2024-11-28 13:00:00', 0),
(30, '2024-11-28 14:00:00', 1),
(31, '2024-11-29 08:00:00', 1),
(32, '2024-11-29 09:30:00', 0),
(33, '2024-11-29 10:00:00', 1),
(34, '2024-11-29 11:30:00', 1),
(35, '2024-11-29 13:00:00', 0),
(36, '2024-11-29 14:30:00', 1),
(37, '2024-11-30 08:00:00', 1),
(38, '2024-11-30 09:30:00', 0),
(39, '2024-11-30 10:30:00', 1),
(40, '2024-11-30 11:45:00', 1),
(41, '2024-11-30 12:30:00', 0),
(42, '2024-11-30 14:00:00', 1),
(43, '2024-11-08 08:00:00', 1),
(44, '2024-11-08 09:30:00', 0),
(45, '2024-11-08 10:30:00', 1),
(46, '2024-11-08 11:45:00', 1),
(47, '2024-11-08 12:30:00', 0),
(48, '2024-11-08 14:00:00', 1),
(49, '2024-11-15 08:00:00', 1),
(50, '2024-11-15 09:30:00', 0),
(51, '2024-11-15 10:30:00', 1),
(52, '2024-11-15 11:45:00', 1),
(53, '2024-11-15 12:30:00', 0),
(54, '2024-11-15 14:00:00', 1),
(55, '2024-10-31 08:00:00', 1),
(56, '2024-10-31 09:30:00', 0),
(57, '2024-10-31 10:30:00', 1),
(58, '2024-10-31 11:45:00', 1),
(59, '2024-10-31 12:30:00', 0),
(60, '2024-10-31 14:00:00', 1),
(61, '2024-11-01 08:00:00', 1),
(62, '2024-11-01 09:30:00', 0),
(63, '2024-11-01 10:00:00', 1),
(64, '2024-11-01 11:15:00', 1),
(65, '2024-11-01 12:45:00', 0),
(66, '2024-11-01 14:00:00', 1),
(67, '2024-11-02 08:00:00', 1),
(68, '2024-11-02 09:30:00', 0),
(69, '2024-11-02 10:30:00', 1),
(70, '2024-11-02 11:45:00', 1),
(71, '2024-11-02 12:30:00', 0),
(72, '2024-11-02 14:00:00', 1),
(73, '2024-11-03 08:00:00', 1),
(74, '2024-11-03 09:30:00', 0),
(75, '2024-11-03 10:00:00', 1),
(76, '2024-11-03 11:15:00', 1),
(77, '2024-11-03 12:45:00', 0),
(78, '2024-11-03 14:00:00', 1),
(79, '2024-11-04 08:30:00', 1),
(80, '2024-11-04 09:30:00', 0),
(81, '2024-11-04 11:00:00', 1),
(82, '2024-11-04 12:15:00', 1),
(83, '2024-11-04 13:30:00', 0),
(84, '2024-11-04 14:30:00', 1),
(85, '2024-11-05 08:00:00', 1),
(86, '2024-11-05 09:30:00', 0),
(87, '2024-11-05 11:00:00', 1),
(88, '2024-11-05 12:30:00', 1),
(89, '2024-11-05 13:45:00', 0),
(90, '2024-11-05 14:15:00', 1),
(91, '2024-11-06 08:00:00', 1),
(92, '2024-11-06 09:00:00', 0),
(93, '2024-11-06 10:30:00', 1),
(94, '2024-11-06 11:45:00', 1),
(95, '2024-11-06 13:00:00', 0),
(96, '2024-11-06 14:00:00', 1),
(97, '2024-11-07 08:00:00', 1),
(98, '2024-11-07 09:30:00', 0),
(99, '2024-11-07 10:00:00', 1),
(100, '2024-11-07 11:30:00', 1),
(101, '2024-11-07 13:00:00', 0),
(102, '2024-11-07 14:30:00', 1),
(103, '2024-11-08 08:00:00', 1),
(104, '2024-11-08 09:30:00', 0),
(105, '2024-11-08 10:00:00', 1),
(106, '2024-11-08 11:30:00', 1),
(107, '2024-11-08 13:00:00', 0),
(108, '2024-11-08 14:30:00', 1),
(109, '2024-11-09 08:00:00', 1),
(110, '2024-11-09 09:30:00', 0),
(111, '2024-11-09 10:30:00', 1),
(112, '2024-11-09 11:45:00', 1),
(113, '2024-11-09 12:30:00', 0),
(114, '2024-11-09 14:00:00', 1),
(115, '2024-11-10 08:00:00', 1),
(116, '2024-11-10 09:30:00', 0),
(117, '2024-11-10 10:00:00', 1),
(118, '2024-11-10 11:30:00', 1),
(119, '2024-11-10 13:00:00', 0),
(120, '2024-11-10 14:30:00', 1),
(121, '2024-11-11 08:00:00', 1),
(122, '2024-11-11 09:30:00', 0),
(123, '2024-11-11 10:00:00', 1),
(124, '2024-11-11 11:30:00', 1),
(125, '2024-11-11 13:00:00', 0),
(126, '2024-11-11 14:30:00', 1);

INSERT INTO vaga (fkSensor, fkFluxo) VALUES
    (1, 7), (1, 8), (1, 9), (1, 10), (1, 11), (1, 12),
    (2, 13), (2, 14), (2, 15), (2, 16), (2, 17), (2, 18),
    (3, 19), (3, 20), (3, 21), (3, 22), (3, 23), (3, 24),
    (4, 25), (4, 26), (4, 27), (4, 28), (4, 29), (4, 30),
    (5, 31), (5, 32), (5, 33), (5, 34), (5, 35), (5, 36),
    (6, 37), (6, 38), (6, 39), (6, 40), (6, 41), (6, 42),
    (1, 43), (1, 44), (1, 45), (1, 46), (1, 47), (1, 48),
    (2, 49), (2, 50), (2, 51), (2, 52), (2, 53), (2, 54),
    (3, 55), (3, 56), (3, 57), (3, 58), (3, 59), (3, 60),
    (4, 61), (4, 62), (4, 63), (4, 64), (4, 65), (4, 66),
    (5, 67), (5, 68), (5, 69), (5, 70), (5, 71), (5, 72),
    (6, 73), (6, 74), (6, 75), (6, 76), (6, 77), (6, 78),
    (1, 79), (1, 80), (1, 81), (1, 82), (1, 83), (1, 84),
    (2, 85), (2, 86), (2, 87), (2, 88), (2, 89), (2, 90),
    (3, 91), (3, 92), (3, 93), (3, 94), (3, 95), (3, 96),
    (4, 97), (4, 98), (4, 99), (4, 100), (4, 101), (4, 102),
    (5, 103), (5, 104), (5, 105), (5, 106), (5, 107), (5, 108),
    (6, 109), (6, 110), (6, 111), (6, 112), (6, 113), (6, 114),
    (1, 115), (1, 116), (1, 117), (1, 118), (1, 119), (1, 120),
    (2, 121), (2, 122), (2, 123), (2, 124), (2, 125), (2, 126);
    
select * from estacionamento;

update estacionamento set email = "teste@gmail.com" where idEstacionamento = 1;
update estacionamento set senha = "12345678!" where idEstacionamento = 1;

UPDATE estacionamento
SET email = 'estacionamento_facil_parking@exemplo.com', 
    senha = 'Estac@namento123'
WHERE idEstacionamento = 2;

UPDATE estacionamento 
SET email = 'estacionamento_rapido@exemplo.com',
    senha = 'Estac@namento123'
WHERE idEstacionamento = 3;

UPDATE estacionamento
SET email = 'estacionamento_seguranca_total@exemplo.com',
    senha = 'Estac@namento123' 
WHERE idEstacionamento = 4;

UPDATE estacionamento
SET email = 'estacionamento_vip@exemplo.com',
    senha = 'Estac@namento123'
WHERE idEstacionamento = 5; 

UPDATE estacionamento
SET email = 'estacionamento_economico@exemplo.com',
    senha = 'Estac@namento123'
WHERE idEstacionamento = 6;

<<<<<<< HEAD
CREATE DATABASE parkwisePI;
USE parkwisePI;

CREATE TABLE estacionamento(
	idEstacionamento int primary key auto_increment,
	nome varchar(45),
	telefone char(15),
	capacidadeVagas int,
	cnpjEstacionamento char(18),
	logradouro varchar(45),
	numeroEnd char(4),
	bairro varchar(45),
	email varchar(100),
	senha varchar(50)
);

CREATE TABLE funcionario(
	idFuncionario int primary key auto_increment,
	nomeFuncionario varchar(45),
	email varchar(100),
	senha varchar(45),
	funcao varchar(45),
	fkEstacionamento int,
	constraint fkUsuarioEstacionamento foreign key (fkEstacionamento)
	references estacionamento(idEstacionamento)
);

CREATE TABLE suporte(
	idSuporte int primary key auto_increment,
	email varchar(100),
	descricao varchar(300),
	dataSuporte date,
	fkFuncionario int,
	constraint fkSuporteFuncionario foreign key (fkFuncionario)
	references funcionario(idFuncionario)
);

CREATE TABLE sensor(
	idSensor int primary key auto_increment,
	localizacao int,
	fkEstacionamento int,
	constraint fkSensorEstacionamento foreign key (fkEstacionamento)
	references estacionamento(idEstacionamento)
);

CREATE TABLE fluxo(
	idFluxo int primary key auto_increment,
	entrada datetime,
	statusVaga tinyint,
	constraint chkStatus check (statusVaga in(0,1))
);

create table vaga(
	fkSensor int,
	fkFluxo int,
	constraint pk_composta primary key (fkSensor, fkFluxo),
    constraint fk_VagaSensor foreign key (fkSensor) references sensor(idSensor),
    constraint fk_VagaFluxo foreign key (fkFluxo) references fluxo(idFluxo)
);

INSERT INTO estacionamento (nome, telefone, capacidadeVagas, cnpjEstacionamento, logradouro, numeroEnd, bairro) VALUES
	('Estacionamento Central Park','11912345678',200,'12.345.678/0001-90','Rua das Flores','150','Centro'),
	('Estacionamento Fácil Parking','21923456789',150,'23.456.789/0001-80','Avenida Rio Branco','220','Copacabana'),
	('Estacionamento Rápido','31934567890',120,'34.567.890/0001-70','Rua João Pinheiro','300','Lourdes'),
	('Estacionamento Segurança Total','41945678901',250,'45.678.901/0001-60','Avenida Paraná','180','Batel'),
	('Estacionamento VIP','51956789012',300,'56.789.012/0001-50','Rua dos Andradas','75','Moinhos de Vento'),
	('Estacionamento Econômico','71967890123',180,'67.890.123/0001-40','Avenida Sete de Setembro','400','Comércio');
    
INSERT INTO funcionario (nomeFuncionario, email, senha, funcao, fkEstacionamento) VALUES
    ('João Silva', 'joao@centralpark.com', 'senha123', 'Gerente', 1),
    ('Maria Oliveira', 'maria@facilparking.com', 'senha456', 'Atendente', 2),
    ('Carlos Souza', 'carlos@rapido.com', 'senha789', 'Supervisor', 3),
    ('Ana Pereira', 'ana@segurancatotal.com', 'senha321', 'Gerente', 4),
    ('Lucas Lima', 'lucas@vip.com', 'senha654', 'Atendente', 5),
    ('Fernanda Santos', 'fernanda@economico.com', 'senha987', 'Supervisor', 6);
    
INSERT INTO suporte (email, descricao, dataSuporte, fkFuncionario) VALUES
    ('suporte@centralpark.com', 'Problema com o sistema de câmeras', '2024-12-01', 1),
    ('suporte@facilparking.com', 'Dúvida sobre funcionamento do sensor de vagas', '2024-12-02', 2),
    ('suporte@rapido.com', 'Problema de conexão no software de gestão', '2024-12-03', 3),
    ('suporte@segurancatotal.com', 'Erro na leitura das placas', '2024-12-04', 4),
    ('suporte@vip.com', 'Sistema de pagamento não está funcionando', '2024-12-05', 5),
    ('suporte@economico.com', 'Falha no registro de entrada de veículos', '2024-12-06', 6);
=======
>>>>>>> f77ee24c47b30ce7a9c8b679d19a898b0dbbbb22

INSERT INTO sensor (localizacao, fkEstacionamento) VALUES
    (1, 1),
    (2, 2),
    (3, 3),
    (4, 4),
    (5, 5),
    (6, 6);
    
INSERT INTO fluxo (entrada, statusVaga) VALUES
    ('2024-12-01 08:00:00', 1),
    ('2024-12-01 09:00:00', 0),
    ('2024-12-01 10:00:00', 1),
    ('2024-12-01 11:00:00', 0),
    ('2024-12-01 12:00:00', 1),
    ('2024-12-01 13:00:00', 0);
    
INSERT INTO vaga (fkSensor, fkFluxo) VALUES
    (1, 1),
    (2, 2),
    (3, 3),
    (4, 4),
    (5, 5),
    (6, 6);
    
INSERT INTO fluxo VALUES
(7, '2024-11-25 08:00:00', 1),
(8, '2024-11-25 09:30:00', 0),
(9, '2024-11-25 10:00:00', 1),
(10, '2024-11-25 11:15:00', 1),
(11, '2024-11-25 12:45:00', 0),
(12, '2024-11-25 14:00:00', 1),
(13, '2024-11-26 08:30:00', 1),
(14, '2024-11-26 09:30:00', 0),
(15, '2024-11-26 11:00:00', 1),
(16, '2024-11-26 12:15:00', 1),
(17, '2024-11-26 13:30:00', 0),
(18, '2024-11-26 14:30:00', 1),
(19, '2024-11-27 08:00:00', 1),
(20, '2024-11-27 09:30:00', 0),
(21, '2024-11-27 11:00:00', 1),
(22, '2024-11-27 12:30:00', 1),
(23, '2024-11-27 13:45:00', 0),
(24, '2024-11-27 14:15:00', 1),
(25, '2024-11-28 08:00:00', 1),
(26, '2024-11-28 09:00:00', 0),
(27, '2024-11-28 10:30:00', 1),
(28, '2024-11-28 11:45:00', 1),
(29, '2024-11-28 13:00:00', 0),
(30, '2024-11-28 14:00:00', 1),
(31, '2024-11-29 08:00:00', 1),
(32, '2024-11-29 09:30:00', 0),
(33, '2024-11-29 10:00:00', 1),
(34, '2024-11-29 11:30:00', 1),
(35, '2024-11-29 13:00:00', 0),
(36, '2024-11-29 14:30:00', 1),
(37, '2024-11-30 08:00:00', 1),
(38, '2024-11-30 09:30:00', 0),
(39, '2024-11-30 10:30:00', 1),
(40, '2024-11-30 11:45:00', 1),
(41, '2024-11-30 12:30:00', 0),
(42, '2024-11-30 14:00:00', 1),
(43, '2024-11-08 08:00:00', 1),
(44, '2024-11-08 09:30:00', 0),
(45, '2024-11-08 10:30:00', 1),
(46, '2024-11-08 11:45:00', 1),
(47, '2024-11-08 12:30:00', 0),
(48, '2024-11-08 14:00:00', 1),
(49, '2024-11-15 08:00:00', 1),
(50, '2024-11-15 09:30:00', 0),
(51, '2024-11-15 10:30:00', 1),
(52, '2024-11-15 11:45:00', 1),
(53, '2024-11-15 12:30:00', 0),
(54, '2024-11-15 14:00:00', 1),
(55, '2024-10-31 08:00:00', 1),
(56, '2024-10-31 09:30:00', 0),
(57, '2024-10-31 10:30:00', 1),
(58, '2024-10-31 11:45:00', 1),
(59, '2024-10-31 12:30:00', 0),
(60, '2024-10-31 14:00:00', 1),
(61, '2024-11-01 08:00:00', 1),
(62, '2024-11-01 09:30:00', 0),
(63, '2024-11-01 10:00:00', 1),
(64, '2024-11-01 11:15:00', 1),
(65, '2024-11-01 12:45:00', 0),
(66, '2024-11-01 14:00:00', 1),
(67, '2024-11-02 08:00:00', 1),
(68, '2024-11-02 09:30:00', 0),
(69, '2024-11-02 10:30:00', 1),
(70, '2024-11-02 11:45:00', 1),
(71, '2024-11-02 12:30:00', 0),
(72, '2024-11-02 14:00:00', 1),
(73, '2024-11-03 08:00:00', 1),
(74, '2024-11-03 09:30:00', 0),
(75, '2024-11-03 10:00:00', 1),
(76, '2024-11-03 11:15:00', 1),
(77, '2024-11-03 12:45:00', 0),
(78, '2024-11-03 14:00:00', 1),
(79, '2024-11-04 08:30:00', 1),
(80, '2024-11-04 09:30:00', 0),
(81, '2024-11-04 11:00:00', 1),
(82, '2024-11-04 12:15:00', 1),
(83, '2024-11-04 13:30:00', 0),
(84, '2024-11-04 14:30:00', 1),
(85, '2024-11-05 08:00:00', 1),
(86, '2024-11-05 09:30:00', 0),
(87, '2024-11-05 11:00:00', 1),
(88, '2024-11-05 12:30:00', 1),
(89, '2024-11-05 13:45:00', 0),
(90, '2024-11-05 14:15:00', 1),
(91, '2024-11-06 08:00:00', 1),
(92, '2024-11-06 09:00:00', 0),
(93, '2024-11-06 10:30:00', 1),
(94, '2024-11-06 11:45:00', 1),
(95, '2024-11-06 13:00:00', 0),
(96, '2024-11-06 14:00:00', 1),
(97, '2024-11-07 08:00:00', 1),
(98, '2024-11-07 09:30:00', 0),
(99, '2024-11-07 10:00:00', 1),
(100, '2024-11-07 11:30:00', 1),
(101, '2024-11-07 13:00:00', 0),
(102, '2024-11-07 14:30:00', 1),
(103, '2024-11-08 08:00:00', 1),
(104, '2024-11-08 09:30:00', 0),
(105, '2024-11-08 10:00:00', 1),
(106, '2024-11-08 11:30:00', 1),
(107, '2024-11-08 13:00:00', 0),
(108, '2024-11-08 14:30:00', 1),
(109, '2024-11-09 08:00:00', 1),
(110, '2024-11-09 09:30:00', 0),
(111, '2024-11-09 10:30:00', 1),
(112, '2024-11-09 11:45:00', 1),
(113, '2024-11-09 12:30:00', 0),
(114, '2024-11-09 14:00:00', 1),
(115, '2024-11-10 08:00:00', 1),
(116, '2024-11-10 09:30:00', 0),
(117, '2024-11-10 10:00:00', 1),
(118, '2024-11-10 11:30:00', 1),
(119, '2024-11-10 13:00:00', 0),
(120, '2024-11-10 14:30:00', 1),
(121, '2024-11-11 08:00:00', 1),
(122, '2024-11-11 09:30:00', 0),
(123, '2024-11-11 10:00:00', 1),
(124, '2024-11-11 11:30:00', 1),
(125, '2024-11-11 13:00:00', 0),
(126, '2024-11-11 14:30:00', 1);
update vaga set fkSensor = 1 where fkFluxo between 49 and 54;
INSERT INTO vaga (fkSensor, fkFluxo) VALUES
    (1, 7), (1, 8), (1, 9), (1, 10), (1, 11), (1, 12),
    (2, 13), (2, 14), (2, 15), (2, 16), (2, 17), (2, 18),
    (3, 19), (3, 20), (3, 21), (3, 22), (3, 23), (3, 24),
    (4, 25), (4, 26), (4, 27), (4, 28), (4, 29), (4, 30),
    (5, 31), (5, 32), (5, 33), (5, 34), (5, 35), (5, 36),
    (6, 37), (6, 38), (6, 39), (6, 40), (6, 41), (6, 42),
    (1, 43), (1, 44), (1, 45), (1, 46), (1, 47), (1, 48),
    (2, 49), (2, 50), (2, 51), (2, 52), (2, 53), (2, 54),
    (3, 55), (3, 56), (3, 57), (3, 58), (3, 59), (3, 60),
    (4, 61), (4, 62), (4, 63), (4, 64), (4, 65), (4, 66),
    (5, 67), (5, 68), (5, 69), (5, 70), (5, 71), (5, 72),
    (6, 73), (6, 74), (6, 75), (6, 76), (6, 77), (6, 78),
    (1, 79), (1, 80), (1, 81), (1, 82), (1, 83), (1, 84),
    (2, 85), (2, 86), (2, 87), (2, 88), (2, 89), (2, 90),
    (3, 91), (3, 92), (3, 93), (3, 94), (3, 95), (3, 96),
    (4, 97), (4, 98), (4, 99), (4, 100), (4, 101), (4, 102),
    (5, 103), (5, 104), (5, 105), (5, 106), (5, 107), (5, 108),
    (6, 109), (6, 110), (6, 111), (6, 112), (6, 113), (6, 114),
    (1, 115), (1, 116), (1, 117), (1, 118), (1, 119), (1, 120),
    (2, 121), (2, 122), (2, 123), (2, 124), (2, 125), (2, 126);
    
    
insert into vaga (fkSensor, fkFluxo) values
    (1,13) , (1,14) , (1,15) , (1,16) , (1,17) , (1,18);
    
    INSERT INTO fluxo (entrada, statusVaga) VALUES
    ('2024-12-02 08:00:00', 1),
    ('2024-12-02 09:30:00', 0),
    ('2024-12-02 10:30:00', 1),
    ('2024-12-02 11:45:00', 1),
    ('2024-12-02 12:30:00', 0),
    ('2024-12-02 14:00:00', 1), -- 132
    ('2024-12-03 08:30:00', 1), -- 133
    ('2024-12-03 09:30:00', 0), -- 134
    ('2024-12-03 11:00:00', 1), -- 135
    ('2024-12-03 12:15:00', 1), -- 136
    ('2024-12-03 13:30:00', 0), -- 137
    ('2024-12-03 14:30:00', 1); -- 138
    
    -- atualizar dia futuro 
    update fluxo set entrada = '2024-12-01 14:30:00' where idFluxo between'132' and  '142';
    
    INSERT INTO vaga (fkSensor, fkFluxo) VALUES
    (1, 127), (1, 128), (1, 129), (1, 130), (1, 131), (1, 132),
    (1, 133), (1, 134), (1, 135), (1, 136), (1, 137), (1, 138);
    
    insert into fluxo (idFluxo, entrada, statusVaga) values
    (139,'2024-12-03 14:30:00', 1);
        
    insert into vaga (fkSensor, fkFluxo) values
    (7, 139);
    
	insert into sensor (localizacao, fkEstacionamento) values
	(2,1);
    
	insert into fluxo (idFluxo, entrada, statusVaga) values
    (140,'2024-12-03 15:30:00', 0);
    
    insert into vaga (fkSensor, fkFluxo) values
    (7, 140);
    
    insert into fluxo (idFluxo, entrada, statusVaga) values
    (141,'2024-12-03 15:30:00', 0);
    
    insert into vaga (fkSensor, fkFluxo) values
    (1, 141);
    
	insert into fluxo (idFluxo, entrada, statusVaga) values
    (142,'2024-12-03 16:30:00', 1);
    
    insert vaga (fkSensor, fkFluxo) values
    (7, 142);
    
	insert into fluxo (idFluxo, entrada, statusVaga) values
    (143, '2024-11-16 08:00:00' ,1);
    
    insert into sensor (idSensor, localizacao, fkEstacionamento) values
    (8, 3, 1);
    
    insert into vaga (fkSensor, fkFluxo) values
    (8, 143);
    
    insert into fluxo (idFluxo, entrada, statusVaga) values
    (144, '2024-11-26 17:00:00', 1);
    
    insert into vaga (fkSensor, fkFluxo) values
    (8, 144);
    
select * from estacionamento;

update estacionamento set email = "teste@gmail.com" where idEstacionamento = 1;
update estacionamento set senha = "12345678!" where idEstacionamento = 1;