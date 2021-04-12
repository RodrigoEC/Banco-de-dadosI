-- Questão 01 e 02: Definição das tabelas
CREATE TABLE automovel (
    renavan CHAR(17), -- PK da tabela
    placa CHAR(7),
    modelo VARCHAR(20),
    ano_fabricacao INTEGER
);

CREATE TABLE segurado (
    nome TEXT,
    cpf CHAR(11), -- PK da tabela
    renavan_automovel CHAR(17) -- Futura FK
);

CREATE TABLE oficina (
    nome VARCHAR(20),
    cnpj CHAR(14), -- PK da tabela
    cep CHAR(8) -- Futura PK
    
);

CREATE TABLE perito (
    nome TEXT,
    cpf CHAR(11) -- PK da tabela
);

CREATE TABLE seguro (
    protocolo INTEGER, -- PK da tabela
    cpf_segurado CHAR(11), -- Futura FK (segurado)
    cpf_perito CHAR(11), -- Futura FK (perito)
    renavan_automovel CHAR(7), -- Futura FK (automovel)
    mensalidade NUMERIC,
    data_ativacao DATE
);

CREATE TABLE sinistro (
    id_ocorrencia INTEGER, -- PK tabela
    data_ocorrencia TIMESTAMP,
    seguro_protocolo INTEGER, -- Futura FK (seguro)
    ocorrencia TEXT
);

CREATE TABLE pericia (
    id_pericia INTEGER, -- PK da tabela
    id_sinistro INTEGER, -- Futura FK (sinistro)
    perda_total BOOLEAN,
    analise_perito TEXT
);


CREATE TABLE reparo (
    id_reparo INTEGER, -- Futura PK
    cnpj_oficina CHAR(14), -- Futura FK (oficina)
    cep_oficina CHAR(8), -- Futura FK (oficina)
    id_pericia INTEGER, -- FUtura FK (pericia)
    Valor_reparo NUMERIC

);

-- Questão 03: Adiciona Primary Keys
ALTER TABLE automovel ADD CONSTRAINT automovel_pkey PRIMARY KEY (renavan);
ALTER TABLE segurado ADD CONSTRAINT segurado_pkey PRIMARY KEY (cpf)
ALTER TABLE oficina ADD CONSTRAINT oficina_pkey PRIMARY KEY (cnpj, cep);
ALTER TABLE perito ADD CONSTRAINT perito_pkey PRIMARY KEY (cpf);
ALTER TABLE seguro ADD CONSTRAINT seguro_pkey PRIMARY KEY (protocolo);
ALTER TABLE sinistro ADD CONSTRAINT sinistro_pkey PRIMARY KEY (id_ocorrencia);
ALTER TABLE pericia ADD CONSTRAINT pericia_pkey PRIMARY KEY (id_pericia);
ALTER TABLE reparo ADD CONSTRAINT reparo_pkey PRIMARY KEY (id_reparo);

-- Questão 04: Constraints e Foraign Keys

-- Fkeys do segurado
ALTER TABLE segurado ADD CONSTRAINT segurado_fkey FOREIGN KEY (renavan_automovel) REFERENCES automovel(renavan);

-- Fkeys do seguro
ALTER TABLE seguro ADD CONSTRAINT seguro_cpf_segurado_fkey FOREIGN KEY (cpf_segurado) REFERENCES segurado(cpf);
ALTER TABLE seguro ADD CONSTRAINT seguro_cpf_perito_fkey FOREIGN KEY (cpf_perito) REFERENCES perito(cpf);
ALTER TABLE seguro ADD CONSTRAINT seguro_automovel_fkey FOREIGN KEY (renavan_automovel) REFERENCES automovel(renavan);

-- Fkey do sinistro
ALTER TABLE sinistro ADD CONSTRAINT sinistro_seguro_protocolo_fkey FOREIGN KEY (seguro_protocolo) REFERENCES seguro(protocolo);

-- Fkey da perícia
ALTER TABLE pericia ADD CONSTRAINT pericia_id_sinistro_fkey FOREIGN KEY (id_sinistro) REFERENCES sinistro(id_ocorrencia);

-- Fkey do reparo
ALTER TABLE reparo ADD COLUMN cep_oficina CHAR(8);
ALTER TABLE reparo ADD CONSTRAINT reparo_cnpj_oficina_cep_oficina_fkey FOREIGN KEY (cnpj_oficina, cep_oficina) REFERENCES oficina(cnpj, cep);

-- Questão 05

-- NOT NULL do automovel
ALTER TABLE automovel ALTER COLUMN placa SET NOT NULL;

-- NOT NULL do seguro
-- ACredito que não faz sentido existir um seguro que não possui segurado, perito ou automovel que ele está assegurando
ALTER TABLE seguro ALTER COLUMN cpf_segurado SET NOT NULL;
ALTER TABLE seguro ALTER COLUMN cpf_perito SET NOT NULL;
ALTER TABLE seguro ALTER COLUMN renavan_automovel SET NOT NULL;

-- NOT NULL do sinistro
ALTER TABLE sinistro ALTER COLUMN data_ocorrencia SET NOT NULL;

-- NOT NULL da perícia
ALTER TABLE pericia ALTER COLUMN perda_total SET NOT NULL;

-- Questão 07

CREATE TABLE automovel (
    renavan CHAR(17) PRIMARY KEY,
    placa CHAR(7) NOT NULL,
    modelo VARCHAR(20),
    ano_fabricacao INTEGER
);

CREATE TABLE segurado (
    nome TEXT,
    cpf CHAR(11) PRIMARY KEY,
    renavan_automovel CHAR(7),
    CONSTRAINT segurado_fkey FOREIGN KEY (renavan_automovel) REFERENCES automovel(renavan)
);

CREATE TABLE oficina (
    cnpj CHAR(14),
    nome VARCHAR(20),
    cep CHAR(8),

    CONSTRAINT oficina_pkey PRIMARY KEY (cnpj, cep)
);

CREATE TABLE PERITO (
    nome TEXT, 
    cpf CHAR(11),

    CONSTRAINT perito_pkey PRIMARY KEY (cpf)
);

CREATE TABLE seguro (
    protocolo INTEGER,
    cpf_segurado CHAR(11) NOT NULL,
    cpf_perito CHAR(11) NOT NULL,
    renavan_automovel CHAR(7) NOT NULL,
    mensalidade INTEGER,
    data_ativacao DATE,

    CONSTRAINT seguro_pkey PRIMARY KEY (protocolo),
    CONSTRAINT seguro_cpf_segurado_fkey FOREIGN KEY (cpf_segurado) REFERENCES segurado(cpf),
    CONSTRAINT seguro_cpf_perito_fkey FOREIGN KEY (cpf_perito) REFERENCES perito(cpf),
    CONSTRAINT seguro_automovel_fkey FOREIGN KEY (renavan_automovel) REFERENCES automovel(renavan)
);

CREATE TABLE sinistro (
    id_ocorrencia INTEGER, 
    data_ocorrencia TIMESTAMP NOT NULL,
    seguro_protocolo INTEGER,
    ocorrencia TEXT,

    CONSTRAINT sinistro_pkey PRIMARY KEY (id_ocorrencia),
    CONSTRAINT sinistro_seguro_protocolo_fkey FOREIGN KEY (seguro_protocolo) REFERENCES seguro(protocolo)
);

CREATE TABLE pericia (
    id_pericia INTEGER, 
    id_sinistro INTEGER,
    analise_perito TEXT,
    perda_total BOOLEAN NOT NULL,

    CONSTRAINT pericia_pkey PRIMARY KEY (id_pericia),
    CONSTRAINT pericia_id_sinistro_fkey FOREIGN KEY (id_sinistro) REFERENCES sinistro(id_ocorrencia)
);

CREATE TABLE reparo (
    id_reparo INTEGER,
    cnpj_oficina CHAR(14),
    cep_oficina CHAR(8),
    id_pericia INTEGER,
    valor_reparo INTEGER,

    CONSTRAINT reparo_pkey PRIMARY KEY (id_reparo),
    CONSTRAINT reparo_cnpj_oficina_cep_oficina_fkey FOREIGN KEY (cnpj_oficina, cep_oficina) REFERENCES oficina(cnpj, cep)
);


-- Questão 10: Não mudaria nada desse roteiro pelo motivo de não conhecer nada de carro.

