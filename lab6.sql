/*
    ---------------------------------------------------------------
    Banco de Dados - Aula prática 6
    Data: 24/10/2024
    
    Comandos ensinados:

    - Subconsultas com EXISTS:
      SELECT <colunas>
      FROM <tabela>
      WHERE EXISTS (subconsulta);

    - Subconsultas na Cláusula FROM:
      SELECT <colunas>
      FROM (subconsulta) AS <alias>
      JOIN <tabela> ON <condição>;

    Exercícios:

    Responda utilizando subconsultas com EXISTS:
        - 1) Buscar o nome e o CPF dos médicos que também são pacientes do hospital
        - 2) Buscar o nome e o CPF dos médicos ortopedistas, e a data das suas consultas, para os ortopedistas que têm consulta marcada com a paciente Ana
        - 3) Buscar o nome e o CPF dos médicos que têm consultas marcadas com todos os pacientes
        - 4) Buscar o nome e o CPF dos médicos ortopedistas que têm consultas marcadas com todos os pacientes de Florianópolis

    Responda utilizando subconsultas na cláusula FROM:
        - 1) Buscar a data e a hora das consultas marcadas para a médica Maria
        - 2) Buscar o nome e a cidade dos pacientes que têm consultas marcadas com ortopedistas
        - 3) Buscar o nome e o CPF dos médicos que atendem no mesmo ambulatório do médico Pedro

    ---------------------------------------------------------------
*/

-- Responda utilizando subconsultas com EXISTS:

-- 1) Buscar o nome e o CPF dos médicos que também são pacientes do hospital
SELECT m.nome, m.CPF
FROM Medicos m
WHERE EXISTS (
    SELECT *
    FROM Pacientes p
    WHERE p.CPF = m.CPF
);

-- 2) Buscar o nome e o CPF dos médicos ortopedistas, e a data das suas consultas, para os ortopedistas que têm consulta marcada com a paciente Ana
SELECT m.nome, m.CPF, c.data
FROM Medicos m
JOIN Consultas c ON m.codm = c.codm
WHERE m.especialidade = 'Ortopedista'
AND EXISTS (
    SELECT *
    FROM Pacientes p
    WHERE p.nome = 'Ana'
    AND p.codp = c.codp
);

-- 3) Buscar o nome e o CPF dos médicos que têm consultas marcadas com todos os pacientes
SELECT m.nome, m.CPF
FROM Medicos m
WHERE NOT EXISTS (
    SELECT p.codp
    FROM Pacientes p
    WHERE NOT EXISTS (
        SELECT *
        FROM Consultas c
        WHERE c.codm = m.codm
        AND c.codp = p.codp
    )
);

-- 4) Buscar o nome e o CPF dos médicos ortopedistas que têm consultas marcadas com todos os pacientes de Florianópolis
SELECT m.nome, m.CPF
FROM Medicos m
WHERE m.especialidade = 'Ortopedista'
AND NOT EXISTS (
    SELECT p.codp
    FROM Pacientes p
    WHERE p.cidade = 'Florianópolis'
    AND NOT EXISTS (
        SELECT *
        FROM Consultas c
        WHERE c.codm = m.codm
        AND c.codp = p.codp
    )
);

-----------------------------------------------------------------------------

-- Responda utilizando subconsultas na cláusula FROM:

-- 1) Buscar a data e a hora das consultas marcadas para a médica Maria
SELECT C.data, C.hora
FROM (SELECT codm FROM Medicos WHERE nome = 'Maria') AS M
JOIN Consultas C ON M.codm = C.codm;

-- 2) Buscar o nome e a cidade dos pacientes que têm consultas marcadas com ortopedistas
SELECT P.nome, P.cidade
FROM Pacientes P
JOIN (SELECT c.codp 
      FROM Consultas c
      JOIN Medicos m ON c.codm = m.codm
      WHERE m.especialidade = 'Ortopedista') AS C
ON P.codp = C.codp;

-- 3) Buscar o nome e o CPF dos médicos que atendem no mesmo ambulatório do médico Pedro
SELECT M.nome, M.CPF
FROM Medicos M
JOIN (SELECT a.nroa
      FROM Medicos M1
      JOIN Ambulatorios a ON M1.nroa = a.nroa
      WHERE M1.nome = 'Pedro') AS AmbulatorioPedro
ON M.nroa = AmbulatorioPedro.nroa;
