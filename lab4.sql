/*
    ---------------------------------------------------------------
    Banco de Dados - Aula prática 4
    Data: 10/10/2024
    
    Comandos ensinados:

    - JOIN: 
        SELECT <coluna1>, <coluna2>, ...
        FROM <tabela1>
        JOIN <tabela2> ON <tabela1>.<coluna> = <tabela2>.<coluna>;

    - JOIN NATURAL:
        SELECT <coluna1>, <coluna2>, ...
        FROM <tabela1>
        NATURAL JOIN <tabela2>;

    - LEFT JOIN:
        SELECT <coluna1>, <coluna2>, ...
        FROM <tabela1>
        LEFT JOIN <tabela2> ON <tabela1>.<coluna> = <tabela2>.<coluna>;


    Exercícios:

    1) Responda o que se pede utilizando junção (não natural):
            - a) Buscar o nome e CPF dos médicos que também são pacientes do hospital
            - b) Buscar nomes de funcionários e de médicos (exibir pares de nomes) que residem na mesma cidade
            - c) Buscar o nome e idade dos médicos que têm consulta marcada com a paciente cujo nome é Ana
            - d) Buscar o número dos ambulatórios que estão no mesmo andar do ambulatório 5
    
    2) Responda o que se pede utilizando junção natural:
            - a) Buscar o código e o nome dos pacientes com consulta marcada para horários após às 14 horas
            - b) Buscar o número e o andar dos ambulatórios cujos médicos possuem consultas marcadas para o dia 12/10/2020
    
    3) Responda o que se pede utilizando junção externa (e também junção, se necessário):
            - a) Buscar os dados de todos os ambulatórios e, para aqueles ambulatórios onde médicos dão atendimento, exibir também os códigos e nomes destes médicos
            - b) Buscar o CPF e o nome de todos os médicos e, para aqueles médicos que possuem consultas marcadas, exibir também o nome dos paciente e a data da consulta 


    ---------------------------------------------------------------
*/

-- 1) Responda o que se pede utilizando junção (não natural)

-- 1a) Buscar o nome e CPF dos médicos que também são pacientes do hospital
SELECT m.nome, m.CPF 
FROM Medicos AS m 
JOIN Pacientes AS p ON m.CPF = p.CPF;

-- 1b) Buscar nomes de funcionários e de médicos (exibir pares de nomes) que residem na mesma cidade
SELECT f.nome AS nome_funcionario, m.nome AS nome_medico 
FROM Funcionarios AS f 
JOIN Medicos AS m ON f.cidade = m.cidade;

-- 1c) Buscar o nome e idade dos médicos que têm consulta marcada com a paciente cujo nome é Ana
SELECT m.nome, m.idade 
FROM Medicos AS m 
JOIN Consultas AS c ON m.codm = c.codm 
JOIN Pacientes AS p ON c.codp = p.codp 
WHERE p.nome = 'Ana';

-- 1d) Buscar o número dos ambulatórios que estão no mesmo andar do ambulatório 5
SELECT a.nroa 
FROM Ambulatorios AS a 
JOIN (SELECT andar FROM Ambulatorios WHERE nroa = 5) AS a5 ON a.andar = a5.andar;

-- 2) Responda o que se pede utilizando junção natural

-- 2a) Buscar o código e o nome dos pacientes com consulta marcada para horários após às 14 horas
SELECT DISTINCT codp, nome 
FROM Pacientes 
NATURAL JOIN Consultas 
WHERE hora > '14:00';

-- 2b) Buscar o número e o andar dos ambulatórios cujos médicos possuem consultas marcadas para o dia 12/10/2020
SELECT a.nroa, a.andar 
FROM Ambulatorios AS a 
NATURAL JOIN Medicos 
NATURAL JOIN Consultas 
WHERE data = '2020-10-12';

-- 3) Responda o que se pede utilizando junção externa

-- 3a) Buscar os dados de todos os ambulatórios e, para aqueles ambulatórios onde médicos dão atendimento, exibir também os códigos e nomes destes médicos
SELECT a.*, m.codm, m.nome 
FROM Ambulatorios AS a 
LEFT JOIN Medicos AS m ON a.nroa = m.nroa;

-- 3b) Buscar o CPF e o nome de todos os médicos e, para aqueles médicos que possuem consultas marcadas, exibir também o nome dos pacientes e a data da consulta
SELECT m.CPF, m.nome, p.pnome, p.data 
FROM Medicos AS m 
LEFT JOIN (
    SELECT c.codm, p.nome AS pnome, c.data 
    FROM Consultas AS c 
    JOIN Pacientes AS p ON c.codp = p.codp
) AS p ON m.codm = p.codm;