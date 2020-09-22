-- Questão 01

CREATE TABLE tarefas (
    -- Como é possível fazer a inserção de todos os valores nulos eu acredito que exista uma primary key
    -- que é um número INTEIRO autoincremetável
    -- id_tarefa SERIAL PRIMARY KEY,
    id_tarefa CHAR(10),
    descricao TEXT,
    cpf_funcionario CHAR(11),
    prioridade INTEGER,
    tipo CHAR(1),

);

-- questão 02 Deu tudo certo
-- Questão 03
ALTER TABLE tarefas ADD CONSTRAINT tarefa_chk_prioridade CHECK (prioridade < 32768);
INSERT INTO tarefas VALUES (2147483649, 'limpar portas da entrada principal', '32322525199', 32768, 'A'); -- Constraint violada
INSERT INTO tarefas VALUES (2147483649, 'limpar portas da entrada principal', '32322525199', 32769, 'A'); -- Constraint violada

INSERT INTO tarefas VALUES (2147483651, 'limpar portas da entrada principal', '32323232911', 32767, 'A');
INSERT INTO tarefas VALUES (2147483652, 'limpar portas da entrada principal', '32323232911', 32766, 'A');


--Questão 04
ALTER TABLE tarefas RENAME COLUMN id_tarefa TO id;
ALTER TABLE tarefas RENAME COLUMN cpf_funcionario TO func_resp_cpf;
ALTER TABLE tarefas RENAME COLUMN tipo TO status;

-- Comandos para retirar apenas tuplas com valores iguais a NULL:
DELETE FROM tarefas WHERE id IS NULL;
DELETE FROM tarefas WHERE descricao IS NULL;
DELETE FROM tarefas WHERE func_resp_cpf IS NULL;
DELETE FROM tarefas WHERE prioridade IS NULL;
DELETE FROM tarefas WHERE status IS NULL;

-- Comandos para restringir os valores dos atributos:
ALTER TABLE tarefas ALTER COLUMN id SET NOT NULL;
ALTER TABLE tarefas ALTER COLUMN descricao SET NOT NULL;
ALTER TABLE tarefas ALTER COLUMN func_resp_cpf SET NOT NULL;
ALTER TABLE tarefas ALTER COLUMN prioridade SET NOT NULL;
ALTER TABLE tarefas ALTER COLUMN status SET NOT NULL;

-- Questão 05
    -- Decidi adicionar uma primary key ao invês de diminuir o escopo do atributo prioridade,  
    -- uma vez que no mundo real não faz muito sentido limitar o escopo desse atributo para um valor
    -- tão baixo. A chave primária faz mais sentido ao meu ver
ALTER TABLE tarefas ADD CONSTRAINT tarefas_pkey PRIMARY KEY (id);

INSERT INTO tarefas VALUES(2147483653, 'limpar portas do 1o andar', '32323232911', 2, 'A');
INSERT INTO tarefas VALUES(2147483653, 'limpar portas do 1o andar', '32323232911', 3, 'A'); -- Não foi adicionada

-- Questão 06 
--(a)
    -- Ao iniciar o roteiro já tinha pensando nesse atributo como CPF, dessa forma já adicionei
    -- essa constraint ao criar a tabela;

INSERT INTO tarefas VALUES(2147483658, 'limpar portas do teto', '370561420', 2, 'A'); -- Insert não permitido
INSERT INTO tarefas VALUES(2147483658, 'limpar portas do teto', '3701578561420', 2, 'A'); -- Insert não permitido

-- (b)
UPDATE tarefas SET status = 'P' WHERE status = 'A';
UPDATE tarefas SET status = 'E' WHERE status = 'R';
UPDATE tarefas SET status = 'C' WHERE status = 'F';

ALTER TABLE tarefas ADD CONSTRAINT status_constr CHECK (status = 'P' OR status = 'E' OR status = 'C'); 

-- Questão 07

UPDATE tarefas SET prioridade = 5 WHERE (prioridade > 5);
ALTER TABLE tarefas ADD CONSTRAINT tarefa_chk_prioridade CHECK (prioridade < 5);

-- Questão 08 

CREATE TABLE funcionario (
    cpf CHAR(11) PRIMARY KEY,
    superior_cpf CHAR(11),
    data_nasc DATE NOT NULL,
    nome VARCHAR(25) NOT NULL,
    funcao VARCHAR(11) NOT NULL,
    nivel CHAR(1) NOT NULL,

    CONSTRAINT funcionario_skey FOREIGN KEY (superior_cpf) REFERENCES funcionario(cpf),
    CONSTRAINT funcionario_chk_nivel CHECK (nivel='J' OR nivel='P' OR nivel='S'),
    CONSTRAINT funcionario_chk_funcao CHECK (funcao='LIMPEZA' or funcao='SUP_LIMPEZA'),
    CONSTRAINT funcionario_chk_funcao_escopo CHECK ((funcao='LIMPEZA' and superior_cpf IS NOT NULL) OR
                                                    (funcao='SUP_LIMPEZA' and superior_cpf IS NULL) OR
                                                    (funcao='SUP_LIMPEZA' and superior_cpf IS NOT NULL))
);


INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES 
('12345678911', '1980-05-07', 'Pedro da Silva', 'SUP_LIMPEZA', 'S', NULL); -- Comando aceito

INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES 
('12345678912', '1980-03-08', 'José da Silva', 'LIMPEZA', 'J', '12345678911'); -- Comando

INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES 
('12345678913', '1980-04-09', 'João da Silva', 'LIMPEZA', 'J', NULL); -- Comando não aceito

-- Questão 09

-- Letra A)
-- 01
INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES 
('12345678914', '1999-1-17', 'Rodraigs', 'SUP_LIMPEZA', 'S', '12345678911');

-- 02
INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES 
('12345678915', '2000-01-13', 'Liendri', 'SUP_LIMPEZA', 'S', NULL);

-- 03
INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES 
('12345678916', '2001-01-11', 'Gustevi', 'LIMPEZA', 'J', '12345678915');

-- 04
INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES 
('12345678917', '1999-08-31', 'Cleide', 'LIMPEZA', 'P', '12345678914');

-- 05
INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES 
('12345678918', '1999-04-27', 'DanyBenny', 'SUP_LIMPEZA', 'S', '12345678911');

-- 06
INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES 
('12345678919', '1995-04-24', 'Jesga', 'SUP_LIMPEZA', 'P', NULL);

-- 07
INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES 
('12345678920', '1998-04-02', 'Henrisgue', 'LIMPEZA', 'J', '12345678915');

-- 08
INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES 
('12345678921', '1996-02-24', 'Mathelus', 'SUP_LIMPEZA', 'S', NULL);

-- 09
INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES 
('12345678922', '1999-03-16', 'Robsu', 'SUP_LIMPEZA', 'S', NULL);

-- 10
INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES 
('12345678923', '2020-09-21', 'Heloísa', 'SUP_LIMPEZA', 'S', NULL);


-- Letra b)
-- 01: Data maior que o permitido
INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES 
('12345678924', '1999-111-17', 'Rodraigs', 'SUP_LIMPEZA', 'S', '12345678911');

-- 02: CPF maior do que o permitido
INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES 
('12345678549789', '2000-01-13', 'Liendri', 'SUP_LIMPEZA', 'S', NULL);

-- 03: CPF em formato invalido
INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES 
('12345678925', '2001-01-11', 'Gustevi', 'LIMPA', 'J', '12345678915');

-- 04: sup_CPF maior do que o permitido
INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES 
('12345678926', '1999-08-31', 'Cleide', 'LIMPEZA', 'P', '123456787410852');

-- 05: Função Limpeza e superior é NULL
INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES 
('12345678927', '1999-04-27', 'DanyBenny', 'LIMPEZA', 'S', NULL);

-- 06: Função Limpeza e superior é NULL e a data está em formato errado
INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES 
('12345678928', '19955-04-24', 'Jesga', 'LIMPEZA', 'P', NULL);

-- 07: CPF do superior inexistente e menor do que o permitido
INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES 
('12345678929', '1998-04-02', 'Henrisgue', 'LIMPEZA', 'J', '1234565');

-- 08: CPF maior que o permitido
INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES 
('12345678930111', '1996-02-24', 'Mathelus', 'SUP_LIMPEZA', 'S', NULL);

-- 09: Nível inválido
INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES 
('12345678931', '1999-03-16', 'Robsu', 'SUP_LIMPEZA', 'X', NULL);

-- 10: Nível igual a NULL
INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES 
('12345678932', '2020-09-21', 'Heloísa', 'SUP_LIMPEZA', NULL, NULL);

-- Questão 10
INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf)
VALUES('32323232911', '1967-06-22', 'Mirieny', 'SUP_LIMPEZA', 'S', NULL);

INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf)
VALUES('98765432111', '1988-07-30', 'Niela', 'LIMPEZA', 'P', '32323232911');

INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf)
VALUES('98765432122', '1998-08-27', 'Jé', 'LIMPEZA', 'P', '32323232911');

-- Opção 01
ALTER TABLE tarefas ADD CONSTRAINT tarefa_fkey_func_resp_cpf FOREIGN KEY (func_resp_cpf) REFERENCES funcionario(cpf) ON DELETE CASCADE;
DELETE FROM funcionario WHERE (cpf = '98765432111'); -- Deletou a tarefa associada a essa funcionaria

-- Opção 02
ALTER TABLE tarefas DROP CONSTRAINT tarefa_fkey_func_resp_cpf;
ALTER TABLE tarefas ADD CONSTRAINT tarefa_fkey_func_resp_cpf FOREIGN KEY (func_resp_cpf) REFERENCES funcionario(cpf) ON DELETE RESTRICT;

INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf)
VALUES('98765432111', '1988-07-30', 'Niela', 'LIMPEZA', 'P', '32323232911');
INSERT INTO tarefas VALUES(2147482355, 'limpar portas do 1o andar', '98765432111', 2, 'P');

DELETE FROM funcionario WHERE (cpf = '98765432111'); -- Não permite que o delete seja feito

-- Questão 11
-- Parte 01
ALTER TABLE tarefas ADD CONSTRAINT tarefas_chk_func_resp_cpf CHECK ((status='P' and func_resp_cpf IS NULL) OR
                                                                    (status='P' and func_resp_cpf IS NOT NULL) OR
                                                                    (status='C' and func_resp_cpf IS NOT NULL) OR
                                                                    (status='E' and func_resp_cpf IS NOT NULL));

-- Parte 02
ALTER TABLE tarefas DROP CONSTRAINT tarefa_fkey_func_resp_cpf;
ALTER TABLE tarefas ADD CONSTRAINT tarefa_fkey_func_resp_cpf FOREIGN KEY (func_resp_cpf) REFERENCES funcionario(cpf) ON DELETE SET NULL;

INSERT INTO tarefas VALUES(2147482357, 'Comprar cadernos', '98765432111', 2, 'C');
INSERT INTO tarefas VALUES(2147482345, 'Comprar uma cadeira, pq a minha ta me matando', '98765432111', 2, 'E');

DELETE FROM funcionario WHERE (cpf = '98765432111'); -- Erro retornado: null value in column "func_resp_cpf" violates not-null constraint