# SQL (Search Query Language)
*Capítulo 06 - Fundamental of DataBase Systems (7th edition)*

## Índice
- [Introdução](#introdução)
- [Definições e tipos de dados em SQL](#Definições-e-tipos-de-dados)
    - [Esquemas e catálogos](#Esquemas-e-Catálogos)
    - [comando CREATE TABLE](#comando-CREATE-TABLE)
    - [Tipos de dados dos atributos](#Tipos-de-dados-dos-atributos)
- [Constraints](#constraints)
    - [Restrições do atributo](#Restrições-do-atributo)
        - [Valores Padrão](#Valores-Padrão)
        - [CHECK](#CHECK)
    - [Restrições da chave](#Restrições-da-chave)
       - [PRIMARY KEY](#PRIMARY-KEY)
       - [UNIQUE](#UNIQUE)
       - [FOREIGN KEY](#FOREIGN-KEY)
- [Seleção](#seleção)
    - [Nomes ambíguos](#nomes-ambíguos)
---
## Introdução
Originalmente criada e implementada pela IBM, SQL (Search Query Language) se tornou a linguagem padrão para base de dados e teve sua origem no [`cálculo relacional`](https://github.com/RodrigoEC/BancoDeDadosI/blob/master/_resumos/calculo_relacional.md) e na [`álgebra relacional`](https://github.com/RodrigoEC/BancoDeDadosI/blob/master/_resumos/algebra_relacional.md), sendo considerada o um dos principais motivos do sucesso comercial de *bases de dados relacionais*, uma vez que os usuários de sistemas de bases de dados estavam menos preocupados em migrar suas aplicações de um sistema para outro, justamente pelo fato do SQL ser a linguagem padrão utilizada nas SGBDs.

Em SQL, alguns termos da álgebra e cálculo relacional são substituídos:
- `Relação` = Tabela;
- `Tupla` = Linha;
- `Atributo` = Coluna.

---
## **Esquemas e Catálogos**

**Esquema:** Também chamado de `base de dados` em alguns sistemas, um esquema é um conjunto de relações, tipos, restrições, domínios e  [`visões`]() que pertencem à mesma aplicação. A identificação de um esquema acontece por meio do `nome do esquema` e um `identificador de autorização` referente aos usuários/contas responsáveis pelo esquema que podem acessá-lo.

Em SQL, a criação de um esquema acontece da seguinte forma:

**Ex:** Criar um esquema "Company" cuja responsável será "Joana"
```SQL
    CREATE SCHEMA COMPANY AUTHORIZATION "Joana"
```

**Catálogo:** Um catálogo é uma coleção de esquemas. Essas são as principais caracterísitcas de um catálogo:
- Os esquemas de um catálogo **não** precisam necessariamente pertencer à mesma aplicação.

- Os catálogos possuem um esquema *padrão* no qual o usuário ao se logar na base de dados já pode acessar sem precisar especificar previamente. 

- Todo catálogo possui um `esquema informacional` que provê informações referentes a todos os esquemas do catálogo.

---
## **CREATE TABLE**
O comando `CREATE TABLE` serve para a criação de uma nova tabela(relação), especificando o nome da tabela, dos atributos e também algumas restrições iniciais. Para criar os atributos é preciso especificar *nome*, *tipo do dado* (que é o domínio dos valores desse atributo) e *restrições* do atributo, como NOT NULL por exemplo.

> O esquema a qual a relação pertence é geralmente implícita de acordo com o ambiente em que o comando CREATE TABLE é executado, porém é possível especificar o esquema colocando `CREATE TABLE nome_do_esquema.nome_da_tabela`.

Ex: Criar tabela EMPREGADO, pertencendo ao esquema `empresa` com os atributos *name* e *id*, onde o id não pode ser NULL.

### Exemplo:

```SQL
    CREATE TABLE EMPRESA.EMPREGADO (
        name VARCAHR(15),
        id INT NOT NULL
    );
```
---
## **Tipos de dados dos atributos**
Existem vários tipos de dados que os atributos podem ter no domínio, sendo eles:

- **Numeric:** Esse tipo pode ser dividido em 3 tipos:
    - **Inteiro:** São os número inteiros (declarados como INT, INTEGER ou SMALLINT em SQL);
    - **Ponto flutuante:** São os números decimais (declarados como FLOAT, REAL ou DOUBLE PRECISION em SQL);
    - **Decimal:** Assim como no ponto flutuante, esse tipo está relacionado a números decimais, porém são declarados como DECIMAL(i, j), DEC(i, j) ou NUMERIC(i, j), onde `i` é o número de digitos da parte inteira e `j` é a quantidade de casas depois do ponto.

- **Caracter string:** Sâo tipos de dados *case sensitive* que representam o tipo string.
    - **CHAR(n) ou CHARACTER(n):** Essas são as declarações em SQL para representar que esse domínio só aceita string de tamanho fixo *N*.
    - **VARCHAR(n), CHAR VARYING(n) ou CHARACTER VARYING(n):** Esse tipo de dados aceita strings de tamanhos variáveis, mas que o tamanho **máximo** é *N*;

- **Bit-string:** Tipo de dado declarado como BIT(n) ou BIT VARYING(n) que representa uma string de tamanho variável de bits, como "10101" por exemplo, mas com tamanho máximo *N*. O valor padrão desse tipo de dados é *1*.

- **Boolean:** Nessa caso esse tipo de dado pode assumir 3 valores, TRUE ou FALSE ou UNKNOWN(por causa da existência do NULL).

- **DATE:** No formato "YYYY-MM-DD" esse tipo de dado representa uma data, composto por ANO, MÊs e depois dia. Para representar o tempo em horas esse tipo de dado possui o formato "HH:MM:SS", composto por 8 posições representando HORA:MINUTO:SEGUNDO;

- **Timestamp:** Esse tipo de dado, representado por TIMESTAMP em SQL, é parecido com o *DATE*, todavia, nesse caso existe uma adição para frações decimais do tempo, como "2014-09-27 09:12:47.82046", por exemplo.

> **OBS:** Os tipos *DATE* e *Timestamp* podem ser considerados tipos especiais de strings, uma vez que eles podem ser usados para comparar strings se forem convertidos para esse tipo.


### **Domínio em SQL**
Em SQL é possível criar um domínio que especifique o tipo de dado que podem ser atribuído a uma variável, dessa maneira, é possível atribuir um mesmo domínio para vários atributos, e ainda facilitando a alteração de domínio de vários atributos ao mesmo tempo.

Ex: Criação de um domínio CEP com 8 dígitos no formato STRING.
```SQL
    CREATE DOMAIN CEP as CHAR(8)
```

---
## Constraints

As restrições são partes essenciais na criação de uma tabela, Em SQL as contraints (restrições) são criadas a partir da cláusual `CHECK`, sendo possível também dar nomes às constraints que serão feitas, com a seguinte estrutura:

**Ex:** Criar uma restrição de idade maior que 18 anos.
```SQL
    CONSTRAINT maior_idade CHECK(idade > 18)
```

As constraints (restrições) no SQL podem ser resumidos em dois tipos: `Restrições do atributo`, `Restrições das chaves`.

---
### **Restrições do atributo**

#### **Valores Padrão**
Em SQL é possível definir valores padrão para qualquer atributo que não seja uma chave, dessa forma se nenhum valor for colocado o o valor padrão será atribuído ao atributo.

**Ex:** Em uma tabela EMPREGADO o departamento padrão para um funcionário é 1 

```SQL
    CREATE TABLE EMPREGADO (
        Dno INT NOT NULL DEFAULT 1,
    );
```

#### **CHECK**
Essa claúsula serve para restringir os valores de um atributo ou de um domínio. O CHECK pode ser usado tanto para restringir valores em tabelas como para restringir valores na criação de domínios.

**Ex1:** Em uma relação POKEMON os pokemons com o nome "Ivysair" não tem level menor que 32.

```SQL
    CREATE TABLE POKEMON (
        id INT PRIMARY KEY
        name VARCHAR(30) NOT NULL
        level INT NOT NULL DEFAULT 0

        CONSTRAINT ivysair
            CHECK(name == "ivysair" and level >= 32)
    );
```

**Ex2:** O domínio IDADE possui apenas valores maiores que 18

```SQL
    CREATE DOMAIN IDADE AS INTEGER
    CHECK(IDADE > 18);
```
---
### **Restrições da chave**

Todas as restrições a seguir pode ser escritas de duas maneiras dependendo das circunstâncias. 

1. Caso a cláusula englobe mais de um atributo, ela deve ser escrita depois da criação dos atributos, da seguinte forma:

    **EX:** Na relação VILAO um vilão é identificado pelo seu nome de vilão e pela quantidade de mortes que ele possui;
    ```SQL
       CREATE TABLE VILAO (
           Nome TEXT,
           Mortes INT DEFAULT 0,
           PODER TEXT,

           CONSTRAINT vilao_unico PRIMARY_KEY(Nome, Mortes) /* Constraint escrita em uma linha   
                                                            diferente da de criação da primary key */
       );
    ```

2. Caso a cláusula envolva apenas um atributo, ela pode ser escrita na mesma linha de criação do atributo

    **Ex:** Não existem 2 vilões com o mesmo poder, isso seria confuso.
    ```SQL
       CREATE TABLE VILAO (
           Nome TEXT,
           Mortes INT DEFAULT 0,
           PODER TEXT UNIQUE,  /* constraint escrita na mesma linha de criação do atributo */

           CONSTRAINT vilao_unico PRIMARY_KEY(Nome, Mortes)
       );
    ```

---
#### **PRIMARY KEY**
Essa cláusula especifica um ou mais atributos que juntos desempenham o papel da chave primária da relação.

**EX:** O Nome e CEP identificam unicamente um indivíduo em um processo de entrega.

```SQL
    CREATE TABLE CLIENTE (
        Nome TEXT,
        CEP CHAR(10),

        CONSTRAINT identificador PRIMARY KEY(Nome, CEP)
    );
```

---
#### **UNIQUE** 
Cláusula que especifica que os valores do atributo podem aparecer apenas **uma** vez na tabela.

**Ex:** Não existem pessoas com a mesma idade e nome na nossa tabela PESSOAS.

```SQL
    CREATE TABLE PESSOAS (
        Nome TEXT,
        CPF CHAR(13) PRIMARY KEY,
        idade INT,

        CONSTRAINT Pessoa_unica UNIQUE(Nome, idade)
    )
```

---
#### **FOREIGN KEY** 
A cláusula do FOREIGN KEY representa a `Chave estrangeira` da tabela.

**Ex:** Cada pessoa tem com relação uma mãe e um pai biológicos.
```SQL
    CREATE TABLE PESSOAS (
        Nome TEXT,
        CPF CAHR(13) PRIMARY KEY,
        Idade INT,
        PaiCPF CHAR(13) FOREIGN KEY REFERENCES PAIS(CPF),
        MaeCPF CHAR(13),

        CONSTRAINT CPF_da_mae REFERENCES MAES(CPF)
    );
```

A cláusula FOREIGN KEY está intrinsecamente relacionada a [`restrição de integridade referencial`](https://github.com/RodrigoEC/BancoDeDadosI/blob/master/_resumos/modelos_relacionais.md), uma vez que ela será violada, ja que ao inserir ou retirar tuplas é possível criar `chaves estrangeiras` que se relacionam com tuplas **inexistentes**. 

Para evitar a violação das restrições de integridade referencial o SQL tem as seguintes opções:

- **Opção Padrão:** o SQL tem como ação padrão `rejeitar` ações que violem a restrição de integridade referencial;

- **SET NULL ou SET DEFAULT:** Para essas duas cláusulas as chaves estrangeiras das tuplas que referenciam diretamente a tupla atual recebem o valor NULL, para o SET NULL, ou o valor padrão, para o SET DEFAULT;

    **Ex:** Caso a tupla que a chave estrangeira estiver referenciando for apagada a chave estrangeira assumirá o valor padrão, 1 no caso.
    ```SQL
        CREATE TABLE EMPREGADO (
            id CHAR(9) PRIMARY KEY,
            departamento number DEFAULT 1,

            FOREIGN KEY num_departmente REFERENCES DEPARTAMENTO(Dnumber) 
                        ON DELETE SET DEFAULT ON UPDATE CASCADE
        );
    ```

- **CASCADE:** Todas as tuplas que referenciam a tupla atual ou são apagadas, no caso de ON DELETE, ou atualizadas, no caso de ON UPGRADE.

    **Ex:** Caso a tupla que a chave estrangeira estiver referenciando for apagada a chave estrangeira a tupla também será aṕagada.

    ```SQL
        CREATE TABLE EMPREGADO (
            id CHAR(9) PRIMARY KEY,
            departamento number,

            FOREIGN KEY num_departmente REFERENCES DEPARTAMENTO(Dnumber) 
                        ON DELETE CASCADE  ON UPDATE CASCADE
        );
    ```

---
## Seleção

Em SQL existe o comando mais básico para a recuperação de informações em uma tabela, o SELECT (Não é o mesmo SELECT visto na álgebra relacional) o qual será explorado nos próximos pontos abordados nesse resumo.

---
### **SELECT-FROM-WHERE**

Também chamada de `Mapeamento` essa é a forma mais básica do SELECT mencionado acima, sendo formado por três cláusulas do SQL, o *SELECT* (Sim são muitos selects), o *FROM* e o *WHERE*.

Aqui o iterador do SQL passa por todas as tuplas das relações participantes e avalia se a tupla será selecionada a partir de da condição de seleção imposta e depois filtra seleciona apenas as colunas da tabela que são desejadas.

O mapeamento se estrutura da seguinte forma:

```SQL
    SELECT <lista de atributos>
    FROM <lista de tabelas>
    WHERE <condição>
```

Onde:
- **SELECT <lista de atributos\> :** Esse select na verdade é o *PROJECT* da álgebra relaciona, ou seja, ele seleciona as colunas que vão ser utilizadas a partir da lista de atributos especificados;

- **FROM <lista de tabelas\> :** Nomes das tabelas (relações) que são necessárias para a requisição;

- **WHERE <condição> :** O  WHERE desempenha o papel do SELECT na álgebra relacional, uma vez que ele seleciona as tuplas das relações a partir de uma `condição de seleção`. 

    Essas condições de seleção podem assumir várias formas:

    - **Condição de seleção:** São condições feitas para selecionar uma tupla em particular;
    - **Condição de junção:** São condições feitas para selecionar duas tuplas de relações diferente onde determinado atributo passado é igual. 


#### Exemplos:

Para os seguintes exemplos

--- 
### **SELECT-FROM**

---
### **ORDER BY**

---
### **Nomes ambíguos**

---
### **AS**

---
### **LIKE**

--- 
### **BETWEEN**