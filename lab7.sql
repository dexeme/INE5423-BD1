/*
    ---------------------------------------------------------------
    Banco de Dados - Aula prática 7
    Data: 29/10/2024
    
    Comandos utilizados:

    - Atualizações com consultas:
      DELETE, UPDATE e INSERT com uso de subconsultas para realizar operações
      complexas de atualização em tabelas relacionadas.

    Exercícios:
    - 1) Excluir ambulatórios que não possuem médicos atendendo neles.
    - 2) Atualizar dados do médico Pedro: mudar sua cidade para a mesma do paciente Paulo
         e sua idade passa a ser o dobro da idade do paciente Ana.
    - 3) Inserir o funcionário Caio (codf = 3) como médico, utilizando especialidade e 
         ambulatório da médica Maria.

    Ordenação de resultados:
    - Utilizar ORDER BY para ordenar os resultados e LIMIT para limitar o número de linhas.
    
    Exercícios de ordenação:
    - 4) Buscar os dados de todos os funcionários ordenados pelo salário (decrescente) 
         e pela idade (crescente), retornando apenas os três primeiros.
    - 5) Buscar o nome dos médicos e o número e andar do ambulatório onde eles atendem,
         ordenado pelo número do ambulatório.

    Agrupamento de resultados:
    - Utilizar GROUP BY e HAVING para realizar agrupamentos e aplicar condições.

    Exercícios de agrupamento:
    - 6) Buscar os andares dos ambulatórios e a capacidade total por andar.
    - 7) Buscar o nome dos médicos que possuem mais de uma consulta marcada.
    
    ---------------------------------------------------------------
*/

-- 1) Excluir os ambulatórios que não possuem médicos atendendo neles
DELETE FROM Ambulatorios
WHERE nroa NOT IN (SELECT nroa FROM Medicos);

-- 2) Atualizar dados do médico Pedro: mudar cidade para a mesma do paciente Paulo e idade para o dobro da idade de Ana
UPDATE Medicos
SET cidade = (SELECT cidade FROM Pacientes WHERE nome = 'Paulo'),
    idade = (SELECT idade * 2 FROM Pacientes WHERE nome = 'Ana')
WHERE nome = 'Pedro';

-- 3) Inserir Caio (codf = 3) como médico, com especialidade e ambulatório da médica Maria
INSERT INTO Medicos (codm, nome, especialidade, nroa)
SELECT 3, 'Caio', m.especialidade, m.nroa
FROM Medicos m
WHERE m.codm = 2;

-- 4) Buscar os dados de todos os funcionários ordenados pelo salário (decrescente) e pela idade (crescente), retornando apenas os três primeiros
SELECT nome, salario, idade
FROM Funcionarios
ORDER BY salario DESC, idade ASC
LIMIT 3;

-- 5) Buscar o nome dos médicos e o número e andar do ambulatório onde eles atendem, ordenado pelo número do ambulatório
SELECT m.nome, a.nroa, a.andar
FROM Medicos m
JOIN Ambulatorios a ON m.nroa = a.nroa
ORDER BY a.nroa;

-- 6) Buscar os andares dos ambulatórios e a capacidade total por andar
SELECT andar, SUM(capacidade) AS capacidade_total
FROM Ambulatorios
GROUP BY andar;

-- 7) Buscar o nome dos médicos que possuem mais de uma consulta marcada
SELECT m.nome
FROM Medicos m
JOIN Consultas c ON m.codm = c.codm
GROUP BY m.nome
HAVING COUNT(c.codm) > 1;
