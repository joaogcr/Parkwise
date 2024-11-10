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
statusVaga tinyint,
fkSensor int,
	constraint fkFluxoSensor foreign key (fkSensor)
		references sensor(idSensor),
	constraint chkStatus check (statusVaga in(0,1))
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
    
INSERT INTO fluxo (statusVaga, fkSensor) VALUES
	(0, 1),
	(0, 1),
	(1, 2),
	(0, 4),
	(1, 3),
	(0, 3),
	(1, 6),
	(1, 5);

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
SELECT * FROM fluxo;

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
 
 -- Gabi
 SELECT e.nome as 'Nome do Estacionamento', 
	    u.nomeUsuario as 'Nome do Usuário', 
        u.email as 'Email do Usuário', 
        u.senha as 'Senha do Usuário', 
        ifnull(s.descricao, 'sem chamado') as 'Chamado feito pelo Usuário'
	FROM estacionamento as e
    JOIN usuario as u
		ON fkEstacionamento = idEstacionamento
	LEFT JOIN suporte as s
		ON fkUsuario = idUsuario;

-- bruno 
SELECT u.nomeUsuario AS 'Nome Cliente',
		e.nome AS 'Estacionamento',
CASE
WHEN f.statusVaga = 0 THEN 'Vaga livre'
ELSE 'Vaga Ocupada' 
END AS 'Status da Vaga',
		s.localizacao AS 'Local da vaga'
FROM usuario AS u
JOIN estacionamento AS e ON u.fkEstacionamento = e.idEstacionamento
JOIN sensor AS s ON s.fkEstacionamento = e.idEstacionamento
JOIN fluxo AS f ON f.fkSensor = s.idSensor;


-- Ariel

SELECT 
    u.nomeUsuario AS 'Usuario',
    u.email AS Email_Usuario,
    e.nome AS 'Nome_Estacionamento',
    e.cnpjEstacionamento AS CNPJ_Estacionamento,
    s.localizacao AS Localizacao_Sensor,
    f.statusVaga AS Status_Vaga
FROM 
    usuario u
JOIN 
    estacionamento e ON u.fkEstacionamento = e.idEstacionamento
JOIN 
    sensor s ON e.idEstacionamento = s.fkEstacionamento
JOIN 
    fluxo f ON s.idSensor = f.fkSensor
ORDER BY 
    u.nomeUsuario;

-- João 

SELECT
	e.nome AS 'Nome do Estacionamento',
    concat(e.logradouro, ' ', e.numeroEnd, ' - ',e.bairro) AS 'Endereço',
    e.capacidadeVagas AS 'Capacidade de Vagas',
    s.idSensor AS 'Sensor Alocado',
    CASE
		WHEN f.statusVaga = 0 THEN 'Não'
		WHEN f.statusVaga = 1 THEN 'Sim'
        END AS 'A vaga está ocupada?'
    FROM estacionamento AS e
    JOIN sensor AS s
    ON e.idEstacionamento = s.fkEstacionamento
    JOIN fluxo AS f
    ON s.idSensor = f.fkSensor;