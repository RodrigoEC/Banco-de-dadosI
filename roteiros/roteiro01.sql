-- Como o renavan é um conjunto de caracteres único de cada veículo decidi
--mante-lo como a chave primária, uma vez que somente ele já satisfaz esse papel.
CREATE TABLE automovel (
    renavan CHAR(17) NOT NULL,
    placa CHAR(7) NOT NULL,
    modelo VARCHAR(20),
    ano INTEGER,
    chassi  CHAR(17) NOT NULL,
    marca VARCHAR(20),
    
    PRIMARY KEY (renavan)
);

--  Decidi deixar o cpf como a chave primária dessa tabela pelo fato de o cpf ser um 
-- único que já nos identifica unicamente na realidade. O renavan do automovel foi colocado como
-- chave estrangeira, uma vez que esse atributo faz referencia de forma única para o automovel do segurado
CREATE TABLE segurado (
    nome TEXT,
    cpf  CHAR(11) NOT NULL,
    renavan_automovel CHAR(7),

    PRIMARY KEY (cpf),
    FOREIGN KEY(renavan_automovel) REFERENCES automovel(renavan)
);


--  Ficou decidido que o cnpj seria a chave única dessa tabela pelo fato de o cnpj
-- já ser um conjunto de caracteres que identifica unicamente as empresas.
CREATE TABLE oficina (
    cnpj CHAR(14) NOT NULL,
    nome VARCHAR(20),

    PRIMARY KEY (cnpj)
);

--   Assim como no segurado, o cpf é a chave primária pelo fato de já haver esse tipo de representação 
-- na realidade.
CREATE TABLE perito (
    nome TEXT,
    cpf CHAR(11) NOT NULL,

    PRIMARY KEY(cpf)
);

--  O protocolo foi escolhido como a chave primária para representar um fato que existe na realidade.
--  Os cpf, tanto do perito como do segurado, e o renavan do automovel foram escolhidos como chave estrangeira
-- pelo fato de esses atributos referenciarem atributos que são chaves primárias nas tabelas onde eles estão.
CREATE TABLE seguro (
    protocolo INTEGER NOT NULL,
    cpf_segurado CHAR(11) NOT NULL,
    cpf_perito CHAR(11) NOT NULL,
    renavan_automovel CHAR(7) NOT NULL,
    mensalidade INTEGER,
    data_ativacao DATE,

    PRIMARY KEY (protocolo),
    FOREIGN KEY (cpf_segurado) REFERENCES segurado (cpf),
    FOREIGN KEY (cpf_perito)  REFERENCES perito(cpf),
    FOREIGN KEY (renavan_automovel) REFERENCES automovel(renavan)

);

CREATE TABLE sinistro (
    id_ocorrencia INTEGER NOT NULL,
    data_ocorrencia TIMESTAMP,
    seguro_protocolo INTEGER NOT NULL,
    ocorrencia TEXT,

    PRIMARY KEY (id_ocorrencia),
    FOREIGN KEY (seguro_protocolo) REFERENCES seguro(protocolo)
);

--  O atributo id_pericia foi escolhido como chave primária da tabela pelo fato de não existir
-- um atributo "natural" que seja capaz de servir com chave primária.
CREATE TABLE pericia (
    id_pericia INTEGER NOT NULL,
    id_sinistro INTEGER NOT NULL,
    perda_total BOOLEAN,

    PRIMARY KEY (id_pericia),
    FOREIGN KEY (id_sinistro) REFERENCES sinistro(id_ocorrencia)
);

--   Pelo fato de não existir um atributo "natural" que seja capaz de representar unicamente os
-- atributos da tabela reparo, o atributo id_reparo foi criado, a fim de servir com chave primária da tabela.
CREATE TABLE reparo (
    id_reparo INTEGER NOT NULL,
    cnpj_oficina CHAR(14) NOT NULL,
    id_pericia INTEGER NOT NULL,
    valor_reparo INTEGER,

    PRIMARY KEY (id_reparo),
    FOREIGN KEY (cnpj_oficina) REFERENCES oficina(cnpj),
    FOREIGN KEY (id_pericia) REFERENCES pericia(id_pericia)
);