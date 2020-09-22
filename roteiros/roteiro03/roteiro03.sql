CREATE TYPE estados AS ENUM ('PB', 'PE', 'RN', 'MA', 'BA', 'SE', 'CE', 'AL', 'PI');

CREATE TABLE farmacia (
    id INTEGER PRIMARY KEY,
    tipo VARCHAR(6) NOT NULL,
    estado estados,
    bairro TEXT NOT NULL,

    CONSTRAINT farmcia_chk_unicidade_bairro UNIQUE (bairro),
    CONSTRAINT farmacia_chk_tipo_escopo CHECK ((tipo='sede') OR (tipo='filial')),
    CONSTRAINT farmacia_chk_unicidade_tipo EXCLUDE USING gist (tipo WITH =) WHERE (tipo='sede')
);

CREATE TABLE funcionario (
    cpf CHAR(11) PRIMARY KEY,
    nome TEXT NOT NULL,
    id_farmacia INTEGER,
    funcao VARCHAR(25) NOT NULL,
    gerente TEXT,

    CONSTRAINT funcionario_skey_id_farmacia FOREIGN KEY (id_farmacia) REFERENCES farmacia(id),
    CONSTRAINT funcionario_escopo_funcao CHECK ((funcao='farmaceutico') OR
                                                (funcao='vendedor') OR
                                                (funcao='entregador') OR
                                                (funcao='caixa') OR
                                                (funcao='administrador')),
    CONSTRAINT funcionario_chk_gerente_escopo CHECK ((gerente='gerente') OR (gerente=NULL)),
    CONSTRAINT funcionario_funcao_unica EXCLUDE USING gist (gerente WITH =, id_farmacia WITH =) WHERE (gerente='gerente'),
    CONSTRAINT funcionario_chk_gerente_funcao CHECK ((gerente='gerente' AND funcao='farmaceutico') OR
                                                     (gerente='gerente' AND funcao='administrador') OR
                                                     (gerente=NULL AND funcao='vendedor') OR
                                                     (gerente=NULL AND funcao='entregador') OR
                                                     (gerente=NULL AND funcao='caixa'))
);

CREATE TABLE cliente (
    cpf CHAR(11) PRIMARY KEY,
    nome TEXT,
    idade NUMERIC,

    CONSTRAINT cliente_chk_idade_escopo CHECK (idade > 17)
);

CREATE TABLE endereco (
    rua TEXT,
    numero INTEGER,
    bairro TEXT,
    tipo VARCHAR(10) NOT NULL,
    cpf_cliente CHAR(11),

    CONSTRAINT endereco_fkey_cpf_cliente FOREIGN KEY (cpf_cliente) REFERENCES cliente(cpf),
    CONSTRAINT endereco_pkey PRIMARY KEY (rua, numero, bairro),
    CONSTRAINT endereco_chk_tipo CHECK ((tipo='residência') OR
                                        (tipo='trabalho') OR
                                        (tipo='outro'))
);

CREATE TABLE medicamento (
    id INTEGER PRIMARY KEY,
    venda_exclusiva BOOLEAN NOT NULL
);

CREATE TABLE venda (
    id INTEGER PRIMARY KEY,
    cpf_funcionario CHAR(11) NOT NULL,
    cpf_cliente CHAR(11) NOT NULL,

    CONSTRAINT venda_fkey_cpf_funcionario FOREIGN KEY (cpf_funcionario) REFERENCES funcionario(cpf),
    CONSTRAINT venda_fkey_cpf_cliente FOREIGN KEY (cpf_cliente) REFERENCES cliente(cpf)
);



CREATE TABLE entrega (
    id_venda INTEGER NOT NULL,
    rua_endereco TEXT,
    numero_endereco INTEGER,
    bairro_endereco TEXT,
    medicamento_id INTEGER,

    CONSTRAINT entre_pkey PRIMARY KEY (id_venda, rua_endereco, numero_endereco, bairro_endereco, medicamento_id),
    CONSTRAINT entrega_fkey_rua_numero_bairro FOREIGN KEY (rua_endereco, numero_endereco, bairro_endereco) REFERENCES endereco(rua, numero, bairro),
    CONSTRAINT entrega_fkey_medicamento_id FOREIGN KEY (medicamento_id) REFERENCES medicamento(id)
)


-- Permite
INSERT INTO farmacia(id, tipo, estado, bairro) VALUES (1547, 'sede', 'PB', 'Alto branco');
-- Permite
INSERT INTO farmacia(id, tipo, estado, bairro) VALUES (1550, 'filial', 'PE', 'Bairro de recife');
-- Não permite pelo fato de já existir uma farmacia nesse bairro
INSERT INTO farmacia(id, tipo, estado, bairro) VALUES (1548, 'filial', 'PB', 'Alto branco');
-- Não permite pelo fato de ja existir uma sede
INSERT INTO farmacia(id, tipo, estado, bairro) VALUES (1549, 'sede', 'PB', 'Catolé');
-- Permite
INSERT INTO funcionario(cpf, nome, id_farmacia, funcao, gerente) VALUES ('07475168420', 'Rodrigo', 1547, 'farmaceutico', 'gerente');
-- Permite
INSERT INTO funcionario(cpf, nome, id_farmacia, funcao, gerente) VALUES ('07475168425', 'Paulo', 1547, 'caixa', NULL);
-- Não permite, uma vez que caixas não podem ser gerentes
INSERT INTO funcionario(cpf, nome, id_farmacia, funcao, gerente) VALUES ('07475168427', 'Cabrimu', 1547, 'caixa', 'gerente');
-- Permite
INSERT INTO cliente(cpf, nome, idade) VALUES ('07475168426', 'Rodrigo', 20);
-- Permite
INSERT INTO cliente(cpf, nome, idade) VALUES ('07475168429', 'Jose', 39);
-- Não permite por ser menor de idade
INSERT INTO cliente(cpf, nome, idade) VALUES ('07475168426', 'Rodrigo', 17);
-- Permite
INSERT INTO endereco(rua, numero, bairro, tipo, cpf_cliente) VALUES ('Alto Branco', 417, 'Lauritzen', 'residência', '07475168426');
-- Permite, uma vez que um cliente pode ter mais de um endereço
INSERT INTO endereco(rua, numero, bairro, tipo, cpf_cliente) VALUES ('Rua jumbs dumbs', 418, 'Catolé', 'residência', '07475168426'); 
-- Não permite uma por sair do escopo do tipo do endereço
INSERT INTO endereco(rua, numero, bairro, tipo, cpf_cliente) VALUES ('Rua prex max', 415, 'Catolé', 'hotel', '07475168426'); 
-- Permite
INSERT INTO medicamento(id, venda_exclusiva) VALUES (951236874, TRUE);
-- Permite
INSERT INTO medicamento(id, venda_exclusiva) VALUES (951236875, FALSE);
-- Não permite por sair do escopo de venda_exclusiva
INSERT INTO medicamento(id, venda_exclusiva) VALUES (951236875, NULL);
-- Permite
INSERT INTO venda(id, cpf_funcionario, cpf_cliente) VALUES (741852963, '07475168420', '07475168429');
-- Não permite, uma vez que o funcionario não pode ser NULL
INSERT INTO venda(id, cpf_funcionario, cpf_cliente) VALUES (741852967, NULL, '07475168429');
-- Não permite, uma vez que não faz sentido fazer a venda para um cliente nulo
INSERT INTO venda(id, cpf_funcionario, cpf_cliente) VALUES (741852969, '07475168420', NULL);
-- Permite
INSERT INTO entrega(id_venda, rua_endereco, numero_endereco, bairro_endereco, medicamento_id) VALUES (741852753, 'Rua jumbs dumbs', 418, 'Catolé', 951236874);
-- Não permite por endereço não estar cadastrado
INSERT INTO entrega(id_venda, rua_endereco, numero_endereco, bairro_endereco, medicamento_id) VALUES (741852757, 'Rua jumbs dumbs', 814, 'Catolé', 951236874);
-- Não permite por medicamente não estar cadastrado
INSERT INTO entrega(id_venda, rua_endereco, numero_endereco, bairro_endereco, medicamento_id) VALUES (741852757, 'Rua jumbs dumbs', 418, 'Catolé', 9536874);

