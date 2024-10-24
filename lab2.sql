/*
    ---------------------------------------------------------------
    Banco de Dados - Aula prática 2
    Data: 03/10/2024
    
    Comandos ensinados:
    - INSERT INTO <nome_tabela> (<atributo1>, <atributo2>, ...)
      VALUES (<valor1>, <valor2>, ...);

    - UPDATE <nome_tabela> SET <atributo1> = <valor1>, <atributo2> = <valor2>, ...
      WHERE <condicao>;

    - DELETE FROM <nome_tabela> WHERE <condicao>;

    Exercícios:

        1)  O paciente Paulo mudou-se para Ilhota

        2)  A consulta do médico 1 com o paciente 4 passou para às
            12:00 horas do dia 4 de Novembro de 2020
        
        3) A consulta do médico 3 com o paciente 4 passou para às 14h30
        
        4) O funcionário 4 deixou a clínica
        
        5) As consultas após as 19 horas devem ser excluídas
        
        6) Os médicos que residem em Biguacu e Palhoca devem ser excluídos

    ---------------------------------------------------------------
*/

-- 1) Inserindo dados na tabela Ambulatorios
INSERT INTO Ambulatorios (nroa, andar, capacidade) VALUES
(1, 1, 30),
(2, 1, 50),
(3, 2, 40),
(4, 2, 25),
(5, 2, 55);

-- 2) Inserindo dados na tabela Medicos
INSERT INTO Medicos (codm, nome, idade, especialidade, CPF, cidade, nroa) VALUES
(1, 'Joao', 40, 'ortopedia', '10000100000', 'Florianopolis', 1),
(2, 'Maria', 42, 'traumatologia', '10000110000', 'Blumenau', 2),
(3, 'Pedro', 51, 'pediatria', '11000100000', 'São José', 2),
(4, 'Carlos', 28, 'ortopedia', '11000110000', 'Joinville', NULL),
(5, 'Marcia', 33, 'neurologia', '11000111000', 'Biguacu', 3);

-- 3) Inserindo dados na tabela Pacientes
INSERT INTO Pacientes (codp, nome, idade, cidade, CPF, doenca) VALUES
(1, 'Ana', 20, 'Florianopolis', '20000200000', 'gripe'),
(2, 'Paulo', 24, 'Palhoca', '20000220000', 'fratura'),
(3, 'Lucia', 30, 'Biguacu', '22000200000', 'tendinite'),
(4, 'Carlos', 28, 'Joinville', '11000110000', 'sarampo');

-- 4) Inserindo dados na tabela Funcionarios
INSERT INTO Funcionarios (codf, nome, idade, cidade, salario, CPF) VALUES
(1, 'Rita', 32, 'Sao Jose', 1200, '20000100000'),
(2, 'Vera', 55, 'Palhoca', 1220, '30000110000'),
(3, 'Caio', 45, 'Florianopolis', 1100, '41000100000'),
(4, 'Marcelo', 44, 'Florianopolis', 1200, '51000110000'),
(5, 'Paula', 33, 'Florianopolis', 2500, '61000111000');

-- 5) Inserindo dados na tabela Consultas
INSERT INTO Consultas (codm, codp, data, hora) VALUES
(1, 1, '2020/10/12', '14:00'),
(1, 4, '2020/10/13', '10:00'),
(2, 1, '2020/10/13', '09:00'),
(2, 2, '2020/10/13', '11:00'),
(2, 3, '2020/10/14', '14:00'),
(2, 4, '2020/10/14', '17:00'),
(3, 1, '2020/10/19', '18:00'),
(3, 3, '2020/10/12', '10:00'),
(3, 4, '2020/10/19', '13:00'),
(4, 4, '2020/10/20', '13:00'),
(4, 4, '2020/10/22', '19:30');

-- 1) O paciente Paulo mudou-se para Ilhota
UPDATE Pacientes SET cidade = 'Ilhota' WHERE codp = 2;

-- 2) A consulta do médico 1 com o paciente 4 passou para às 12:00 horas do dia 4 de Novembro de 2020
UPDATE Consultas SET data = '2020/11/4', hora = '12:00' WHERE codm = 1 AND codp = 4;

-- 3) A consulta do médico 3 com o paciente 4 passou para às 14h30
UPDATE Consultas SET hora = '14:30' WHERE codm = 3 AND codp = 4;

-- 4) O funcionário 4 deixou a clínica
DELETE FROM Funcionarios WHERE codf = 4;

-- 5) As consultas após as 19 horas devem ser excluídas
DELETE FROM Consultas WHERE hora > '19:00';

-- 6) Os médicos que residem em Biguacu e Palhoca devem ser excluídos
DELETE FROM Medicos WHERE cidade = 'Biguacu' OR cidade = 'Palhoca';