CREATE DATABASE parkwise;

USE parkwise;

CREATE TABLE usuario(
	idUsuario int primary key not null auto_increment,
    nomeCompleto varchar(100),
    email varchar(256),
    telefone char(12),
    cnpj char(14),
    endereco varchar(100),
    senha varchar(100)
) auto_increment = 100;

CREATE TABLE login(
	idLogin int primary key not null auto_increment,
    email varchar(256),
    senha varchar(100),
    cnpj char(14),
    fkUsuario int, constraint fkUsuarioLogin foreign key (fkUsuario) references usuario (idUsuario)
) auto_increment = 100;


INSERT INTO usuario (nomeCompleto, email, telefone, cnpj, endereco, senha) VALUES
	('Gabriella Lodi de Azevedo Antunes','gabriella.antunes@sptech.school','11996360040','12345678000190','Rua André Fernandes','chewbacca1234OwO'),
	('Nicoly Carvalho Teixeira','nicoly.teixeira@sptech.school','11980940613','14345078050120','Rua Dorval Jose Svizzero','luna1234pitchuca'),
	('Joao Gabriel Carvalho Ribeiro','joao.ribeiro@sptech.school','11977573100','10145888500176','Avenida Lino','pudim1234');
    
INSERT INTO login (email, senha, cnpj, fkUsuario) VALUES
	('gabriella.antunes@sptech.school','chewbacca1234OwO','12345678000190', 100),
	('nicoly.teixeira@sptech.school','luna1234pitchuca','14345078050120', 101),
	('joao.ribeiro@sptech.school','pudim1234','10145888500176', 102);
    
SELECT * FROM login;
SELECT * FROM usuario;

SELECT * FROM login JOIN usuario ON idUsuario = fkUsuario;

SELECT  login.email, 
		login.senha, 
		login.cnpj, 
        nomeCompleto, 
        telefone, 
        endereco 
FROM login JOIN usuario ON idUsuario = fkUsuario;

SELECT  login.email as EmailUsuario, 
		login.senha as SenhaUsuario, 
		login.cnpj as CNPJUsuario, 
		nomeCompleto as 'Nome do Usuário', 
		telefone as TelefoneUsuario, 
		endereco as 'Endereço Usuário'
FROM login JOIN usuario ON idUsuario = fkUsuario;

SELECT  login.email as EmailUsuario, 
		login.senha as SenhaUsuario, 
		login.cnpj as CNPJUsuario, 
		nomeCompleto as 'Nome do Usuário', 
		telefone as TelefoneUsuario, 
		endereco as 'Endereço Usuário'
FROM login JOIN usuario ON idUsuario = fkUsuario
WHERE login.senha LIKE '%chewbacca%';

SELECT  l.email as EmailUsuario, 
		l.senha as SenhaUsuario, 
		l.cnpj as CNPJUsuario, 
		nomeCompleto as 'Nome do Usuário', 
		telefone as TelefoneUsuario, 
		endereco as 'Endereço Usuário'
FROM login as l JOIN usuario ON idUsuario = fkUsuario
WHERE l.senha LIKE '%a%';

ALTER TABLE login MODIFY COLUMN fkUsuario int UNIQUE;