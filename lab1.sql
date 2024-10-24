/*
    ---------------------------------------------------------------
    Banco de Dados - Aula prática 1
    Data: 01/10/2024
    
    Comandos ensinados:
    - DROP TABLE IF EXISTS <nome_tabela>;
    - CREATE TABLE <nome_tabela> (
        <atributo1> <tipo1> <restrições1>,
        <atributo2> <tipo2> <restrições2>,
        ...
        PRIMARY KEY (<atributo1>)
    );

    - ALTER TABLE <nome_tabela>
        DROP COLUMN <atributo>;

    - CREATE INDEX <nome_indice> ON <nome_tabela>(<atributo>);

    Exercícios:

    1) Criar as seguintes tabelas:
        a) Ambulatorios: 
            - Atributos: nroa (int), andar (numeric(2)) (não nulo), capacidade (smallint)
            - Chave primária: nroa

        b) Medicos: 
            - Atributos: codm (int), nome (varchar(40)) (não nulo), idade (smallint) (não nulo),
              cidade (varchar(40)), CPF (numeric(11)) (não nulo e único), especialidade (varchar(30)), 
              nroa (int)
            - Chave primária: codm
            - Chave estrangeira: nroa

        c) Pacientes: 
            - Atributos: codp (int), nome (varchar(40)) (não nulo), idade (smallint) (não nulo),
              cidade (varchar(40)), CPF (numeric(11)) (não nulo e único), doenca (varchar(40)) (não nulo)
            - Chave primária: codp

        d) Funcionarios: 
            - Atributos: codf (int), nome (varchar(40)) (não nulo), idade (smallint) (não nulo),
              cidade (varchar(40)), CPF (numeric(11)) (não nulo e único), salário (numeric(10)), 
              cargo (varchar(40))
            - Chave primária: codf

        e) Consultas:
            - Atributos: codm (int), codp (int), data (date), hora (time)
            - Chave primária: codm, codp, data, hora
            - Chave estrangeira: codm, codp

    2) Alterar a tabela Funcionarios:
        - Remover o atributo 'cargo'

    3) Criar um índice:
        - Criar um índice para o atributo 'cidade' na tabela Pacientes

    ---------------------------------------------------------------
*/

-- 1) Excluindo as tabelas existentes, caso já existam
DROP TABLE IF EXISTS Consultas;
DROP TABLE IF EXISTS Medicos;
DROP TABLE IF EXISTS Pacientes;
DROP TABLE if EXISTS Ambulatorios;
DROP TABLE IF EXISTS Funcionarios;

-- 1) a. Criando a tabela Ambulatorios
CREATE TABLE Ambulatorios (
	nroa int,
  	andar numeric(2) NOT NULL,
  	capacidade smallint,
  	PRIMARY KEY (nroa)
 );

-- 1) b. Criando a tabela Medicos
CREATE TABLE Medicos (
  	codm int, 
  	nome varchar(40) NOT NULL,
  	idade smallint NOT NULL,
  	cidade varchar(40),
  	CPF numeric(11) NOT NULL UNIQUE,
	especialidade varchar(30), 
  	nroa int,
  	PRIMARY KEY (codm),
  	FOREIGN KEY (nroa) REFERENCES Ambulatorios
);

-- 1) c. Criando a tabela Pacientes
CREATE TABLE Pacientes (
  	codp int, 
  	nome varchar(40) NOT NULL,
  	idade smallint NOT NULL,
  	cidade varchar(40),
  	CPF numeric(11) NOT NULL UNIQUE,
	doenca varchar(40),
	PRIMARY KEY (codp)
);

-- 1) d. Criando a tabela Funcionarios
CREATE TABLE Funcionarios (
  	codf int, 
  	nome varchar(40) NOT NULL,
  	idade smallint NOT NULL,
  	cidade varchar(40),
  	CPF numeric(11) NOT NULL UNIQUE,
	salario numeric(10), 
  	cargo varchar(40),
  	PRIMARY KEY (codf)
);

-- 1) e. Criando a tabela Consultas
CREATE TABLE Consultas (
  	data date,
  	hora time,
  	codm int,
  	codp int,
  	PRIMARY KEY (codm, codp, data),
	FOREIGN KEY (codm) REFERENCES Medicos,
  	FOREIGN KEY (codp) REFERENCES Pacientes
);

-- 2) Alterando a tabela Funcionarios para remover o atributo 'cargo'
ALTER TABLE Funcionarios
	DROP COLUMN cargo;

-- 3) Criando um índice para o atributo 'cidade' na tabela Pacientes
CREATE INDEX indPac_cidade ON Pacientes(cidade);