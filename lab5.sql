/*
    ---------------------------------------------------------------
    Banco de Dados - Aula prática 5
    Data: 22/10/2024
    
    Comandos ensinados:
    
    - SELECT <colunas> 
      FROM <tabela>
      WHERE <coluna> IN (subconsulta);
    
    - SELECT <colunas> 
      FROM <tabela>
      WHERE <coluna> NOT IN (subconsulta);

    - SELECT <colunas> 
      FROM <tabela>
      WHERE <coluna> SOME (subconsulta);

    - SELECT <colunas> 
      FROM <tabela>
      WHERE <coluna> ALL (subconsulta);
      
    Exercícios:

    1) Responda utilizando subconsultas [NOT] IN:
        - a) Nome dos pacientes com consultas marcadas após às 14 horas
        - b) Nome e idade dos médicos que possuem consulta com a paciente Ana
        - c) Número e andar dos ambulatórios onde nenhum médico dá atendimento

    2) Responda utilizando subconsultas SOME e/ou ALL:
        - a) CPF dos médicos que atendem em ambulatórios do primeiro andar
        - b) Nome e CPF de todos os funcionários, exceto o de maior salário
        - c) Nome dos pacientes com consultas marcadas para horários anteriores a todos os horários de consultas marcadas para o dia 14/10/2020
        - d) Número e andar dos ambulatórios com capacidade superior à capacidade de qualquer ambulatório que esteja no primeiro andar

    ---------------------------------------------------------------
*/

-- 1) Responda utilizando subconsultas [NOT] IN:

-- 1a) Nome dos pacientes com consultas marcadas após às 14 horas
SELECT nome 
FROM Pacientes 
WHERE codp IN (
    SELECT codp 
    FROM Consultas 
    WHERE hora > '14:00:00'
);

-- 1b) Nome e idade dos médicos que possuem consulta com a paciente Ana
SELECT nome, idade 
FROM Medicos 
WHERE codm IN (
    SELECT codm 
    FROM Consultas 
    WHERE codp IN (
        SELECT codp 
        FROM Pacientes 
        WHERE nome = 'Ana'
    )
);

-- 1c) Número e andar dos ambulatórios onde nenhum médico dá atendimento
SELECT nroa, andar 
FROM Ambulatorios 
WHERE nroa NOT IN (
    SELECT DISTINCT nroa 
    FROM Medicos
);

-- 2) Responda utilizando subconsultas SOME e/ou ALL:

-- 2a) CPF dos médicos que atendem em ambulatórios do primeiro andar
SELECT CPF
FROM Medicos
WHERE nroa IN (
    SELECT nroa
    FROM Ambulatorios
    WHERE andar = 1
);

-- 2b) Nome e CPF de todos os funcionários, exceto o de maior salário
SELECT nome, CPF
FROM Funcionarios
WHERE salario != (
    SELECT MAX(salario)
    FROM Funcionarios
);

-- 2c) Nome dos pacientes com consultas marcadas para horários anteriores a todos os horários de consultas marcadas para o dia 14/10/2020
SELECT nome
FROM Pacientes
WHERE codp IN (
    SELECT codp
    FROM Consultas
    WHERE hora < (
        SELECT MIN(hora)
        FROM Consultas
        WHERE data = '2020-10-14'
    )
);

-- 2d) Número e andar dos ambulatórios com capacidade superior à capacidade de qualquer ambulatório que esteja no primeiro andar
SELECT nroa, andar
FROM Ambulatorios
WHERE capacidade > (
    SELECT MAX(capacidade)
    FROM Ambulatorios
    WHERE andar = 1
);
