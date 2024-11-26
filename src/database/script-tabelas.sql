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

-- Nicoly
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
 
 -- Gabriella
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

-- Bruno 
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
    
    
-- quantidade de vagas ocupadas no momento
SELECT count(fkSensor) 
FROM fluxo 
where statusVaga = 1;
    
INSERT INTO fluxo (statusVaga, fkSensor, dataHora) VALUES 
(1, 1, '2024-11-16 08:30:00'),
(0, 2, '2024-11-16 08:45:00'),
(1, 3, '2024-11-16 09:00:00');
   
-- total de ocupações

SELECT COUNT(statusVaga) FROM fluxo WHERE statusVaga = 1;

 -- desocupações

SELECT COUNT(statusVaga) FROM fluxo WHERE statusVaga = 0;

-- pico de vagas na semana atual
SELECT 
    COUNT(
    CASE 
    WHEN statusVaga = 1 THEN 1
    END) 
    as pico_vagas_ocupadas
FROM fluxo
WHERE WEEK(dataHora) = WEEK(CURRENT_DATE())
GROUP BY DATE(dataHora)
ORDER BY pico_vagas_ocupadas DESC
LIMIT 1;