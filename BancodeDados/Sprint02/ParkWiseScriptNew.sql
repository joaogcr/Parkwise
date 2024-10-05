CREATE DATABASE ParkWiseScript;
USE ParkWiseScript;

CREATE TABLE estacionamento(
idEstacionamento int primary key auto_increment,
nome varchar(45),
telefone varchar(45),
capacidadeVagas int,
cnpjEstacionamento char(18),
logradouro varchar(45),
numeroEnd varchar(45),
bairro varchar(45)
);

CREATE TABLE usuario(
idUsuario int primary key auto_increment,
email varchar(255),
senha varchar(45),
nomeUsuario varchar(45),
fkEstacionamento int,
	constraint fkUsuarioEstacionamento foreign key (fkEstacionamento)
		references estacionamento(idEstacionamento)
);

CREATE TABLE suporte(
idSuporte int primary key auto_increment,
email varchar(255),
descricao varchar(300),
dataSuporte date,
fkUsuario int,
	constraint fkSuporteUsuario foreign key (fkUsuario)
		references usuario(idUsuario)
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
saida datetime, 
fkSensor int,
	constraint fkFluxoSensor foreign key (fkSensor)
		references sensor(idSensor)
);

INSERT INTO estacionamento (nome, telefone, capacidadeVagas, cnpjEstacionamento, logradouro, numeroEnd, bairro) VALUES
	('Estacionamento Central Park','11912345678',200,'12.345.678/0001-90','Rua das Flores','150','Centro'),
	('Estacionamento Fácil Parking','21923456789',150,'23.456.789/0001-80','Avenida Rio Branco','220','Copacabana'),
	('Estacionamento Rápido','31934567890',120,'34.567.890/0001-70','Rua João Pinheiro','300','Lourdes'),
	('Estacionamento Segurança Total','41945678901',250,'45.678.901/0001-60','Avenida Paraná','180','Batel'),
	('Estacionamento VIP','51956789012',300,'56.789.012/0001-50','Rua dos Andradas','75','Moinhos de Vento'),
	('Estacionamento Econômico','71967890123',180,'67.890.123/0001-40','Avenida Sete de Setembro','400','Comércio');
    
INSERT INTO usuario (email, senha, nomeUsuario, fkEstacionamento) VALUES
	('joao.silva123@email.com','Abc@1234','João Silva', 1), 
	('maria.oliveira456@email.com','Olh*4567','Maria Oliveira', 2), 
	('carlos.pereira789@email.com','P&asw0rd9','Carlos Pereira', 3), 
	('ana.costa101@email.com','C0sta!2023','Ana Costa', 4), 
	('pedro.souza202@email.com','5ouz@2024','Pedro Souza', 5), 
	('juliana.santos303@email.com','Ju&liana03','Juliana Santos', 6);
    
INSERT INTO suporte (email, descricao, dataSuporte, fkUsuario) VALUES
	('cliente1@example.com', 'Problema com o acesso ao estacionamento', '2024-09-05', 1),
    ('cliente2@example.com', 'Dificuldade em efetuar o pagamento', '2024-09-06', 2),
    ('cliente3@example.com', 'Vaga indisponível', '2024-09-07', 3),
    ('cliente4@example.com', 'Falha no sensor de entrada', '2024-09-08', 4),
    ('cliente5@example.com', 'Problema na saída', '2024-09-09', 5),
    ('cliente6@example.com', 'Problema na organização das entradas e das saídas', '2024-09-10', 6);
    
INSERT INTO sensor (localizacao, fkEstacionamento) VALUES
	('200',1),
	('150',2),
	('120',3),
	('250',4),
	('300',5),
	('180',6);
    
INSERT INTO fluxo (entrada, saida, fkSensor) VALUES
	('2024-10-04 09:15:00','2024-10-04 17:30:00', 1),
	('2024-10-05 08:00:00','2024-10-05 16:45:00', 1),
	('2024-10-06 10:20:00','2024-10-06 18:50:00', 2),
	('2024-10-07 07:45:00','2024-10-07 14:30:00', 4),
	('2024-10-08 13:00:00','2024-10-08 19:15:00', 3),
	('2024-10-09 08:30:00','2024-10-09 16:00:00', 3),
	('2024-10-10 11:10:00','2024-10-10 17:55:00', 6),
	('2024-10-11 09:00:00','2024-10-11 18:30:00', 5);

-- gabi
SELECT nomeUsuario as 'Nome do Usuário', 
	   e.nome as 'Nome do Estacionamento', 
       e.capacidadeVagas as 'Total de Vagas'
	FROM usuario
    JOIN estacionamento as e
		ON fkEstacionamento = idEstacionamento;
    
SELECT * FROM usuario;
select * from suporte;
select * from estacionamento;
select * from sensor;

-- nicoly
SELECT u.nomeUsuario as 'Nome do usuario', sup.descricao as 'Descricao do chamado', 
sup.dataSuporte as 'Data da criacao do chamado', e.nome as 'Nome do estacionamento', s.idSensor as 'Sensor do chamado'
FROM usuario as u
JOIN suporte as sup ON u.idUsuario = sup.fkUsuario
JOIN estacionamento as e ON u.fkEstacionamento = e.idEstacionamento
JOIN sensor as s ON e.idEstacionamento = s.fkEstacionamento;

-- Miguel

SELECT * FROM estacionamento join usuario on idEstacionamento = fkEstacionamento;

SELECT e.idEstacionamento as 'ID Estacionamento', e.nome as 'Nome Estacionamento', e.telefone as 'Telefone',
 e.capacidadeVagas as 'Capacidade', u.idUsuario as 'ID Usuario', u.email as 'E-MAIL', u.senha as 'SENHA',
 u.nomeUsuario as 'Usuario'
 FROM estacionamento as e join usuario as u on idEstacionamento = fkEstacionamento;

