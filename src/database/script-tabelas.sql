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
	dataAtual datetime default current_timestamp(),
	statusVaga tinyint,
	constraint chkStatus check (statusVaga in(0,1))
);

create table vaga(
	fkSensor int,
	fkFluxo int,
	primary key (fkSensor, fkFluxo)
);


    
-- quantidade de vagas ocupadas no momento
SELECT count(fkSensor) 
FROM fluxo 
where statusVaga = 1;
    
INSERT INTO fluxo (statusVaga, fkSensor, dataHora) VALUES 
(1, 1, '2024-11-16 08:30:00'),
(0, 2, '2024-11-16 08:45:00'),
(1, 3, '2024-11-16 09:00:00');
   
   
   CREATE VIEW  VagasOcupadaseDesocupadas as select 
   COUNT(CASE WHEN statusVaga = 1 THEN 1 END) as 'Vagas Ocupadas', COUNT(CASE WHEN statusVaga = 0 THEN 0 END) as 'Vagas desocupadas' FROM fluxo;
   
   
-- total de ocupações

SELECT COUNT(statusVaga) FROM fluxo WHERE statusVaga = 1;

 -- desocupações

SELECT COUNT(statusVaga) FROM fluxo WHERE statusVaga = 0;

-- pico de vagas na semana atual
SELECT COUNT(CASE WHEN statusVaga = 1 THEN 1 END) as pico_vagas_ocupadas
FROM fluxo
WHERE WEEK(dataHora) = WEEK(CURRENT_DATE())
GROUP BY DATE(dataHora)
ORDER BY pico_vagas_ocupadas DESC
LIMIT 1;
