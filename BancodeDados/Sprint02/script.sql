use parkwise;

create table sensor(
	idSensor int primary key auto_increment,
    estadoVaga tinyint,
    horarioEntrada char(5),
    horarioSaida char(5),
    dataLeitura date
);

create table estacionamento (
	idEstacionamento int primary key auto_increment,
    nome varchar(45),
    endereco varchar(45),
    cnpj char(18),
    capacidadeVagas int,
    fkSensor int,
    constraint fkSensorEstac foreign key (fkSensor) references sensor(idSensor)
);

create table suporteChamados(
	idChamado int primary key auto_increment,
    email varchar(255),
    descricao varchar(300),
    dataChamado date
);

create table login(
	idLogin int primary key auto_increment,
    email varchar(255),
    senha varchar(45)
);

create table cliente(
	idCliente int primary key auto_increment,
    nomeCompleto varchar(100),
    telefone char(13),
    endereco varchar(255),
    qtdEstacionamento int,
    fkLogin int unique,
    fkEstacionamento int,
    fkChamados int,
    constraint fkLoginCliente foreign key (fkLogin) references login(idLogin),
    constraint fkEstacionamentoCliente foreign key (fkEstacionamento) references estacionamento(idEstacionamento),
    constraint fkChamadosCliente foreign key (fkChamados) references suporteChamados(idChamado)
);

INSERT INTO sensor (estadoVaga, horarioEntrada, horarioSaida, dataLeitura) VALUES
	(1, '08:00', '12:00', '2024-09-01'),
	(0, '13:00', '18:00', '2024-09-02'),
	(1, '09:30', '11:45', '2024-09-03'),
	(0, '14:45', '17:30', '2024-09-04'),
	(1, '07:00', '10:30', '2024-09-05');
    
SELECT * FROM sensor;
    
INSERT INTO estacionamento (nome, endereco, cnpj, capacidadeVagas, fkSensor) VALUES
	('Estacionamento Central', 'Rua A, 123', '12.345.678/0001-90', 100, 1),
	('Estacionamento Norte', 'Rua B, 456', '98.765.432/0001-21', 80, 2),
	('Estacionamento Sul', 'Rua C, 789', '54.321.678/0001-11', 120, 3),
	('Estacionamento Leste', 'Rua D, 101', '33.444.555/0001-22', 90, 4),
	('Estacionamento Oeste', 'Rua E, 202', '22.333.111/0001-33', 75, 5);

SELECT * FROM estacionamento;    
    
INSERT INTO suporteChamados (email, descricao, dataChamado) VALUES
	('cliente1@example.com', 'Problema com o acesso ao estacionamento', '2024-09-05'),
	('cliente2@example.com', 'Dificuldade em efetuar o pagamento', '2024-09-06'),
	('cliente3@example.com', 'Vaga indisponível', '2024-09-07'),
	('cliente4@example.com', 'Falha no sensor de entrada', '2024-09-08'),
	('cliente5@example.com', 'Problema na saída', '2024-09-09');
    
SELECT * FROM suporteChamados;
    
INSERT INTO login (email, senha) VALUES 
	('cliente1@example.com', 'senha123'),
	('cliente2@example.com', 'senha456'),
	('cliente3@example.com', 'senha789'),
	('cliente4@example.com', 'senha101'),
	('cliente5@example.com', 'senha202');

SELECT * FROM login;
    
INSERT INTO cliente (nomeCompleto, telefone, endereco, qtdEstacionamento, fkLogin, fkEstacionamento, fkChamados) VALUES 
	('João Silva', '11999999999', 'Av. Principal, 100', 1, 1, 1, 1),
	('Maria Oliveira', '11988888888', 'Rua Secundária, 200', 2, 2, 2, 2),
	('Pedro Santos', '11977777777', 'Travessa 3, 300', 1, 3, 3, 3),
	('Ana Costa', '11966666666', 'Beco 4, 400', 1, 4, 4, 4),
	('Carlos Lima', '11955555555', 'Praça 5, 500', 1, 5, 5, 5);
    
SELECT * FROM cliente;