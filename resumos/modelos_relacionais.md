# Modelo de Dados Relacional

## Índice
- [Conceitos Iniciais](#conceitos-iniciais)
    - [Tupla](#tupla)
    - [Relação](#relação)
    - [Atributo](#atributo)
    - [Esquema da relação](#esquema-da-relação)
    - [Chaves](#chaves)
- [Conceitos Auxiliares](#conceitos-auxiliares)
    - [Domínio](#domínio)
    - [Valores Atômicos](#valores-atômicos)
    - [Mini-Mundo](#mini-mundo)
    - [Grau de uma relação](#grau)
- [Constraints](#constraints)
    - [Restrições Implícitas](#restrições-implícitas)
    - [Restrições Explícitas](#restrições-explícitas)
    - [Restrições Semânticas](#restrições-semânticas)
- [Restrições de Integridade relacional](#restrições-de-integridade-relacional)
    - [Restrições de Domínio](#restrições-de-domínio)
    - [Restrições de integridade de uma entidade](#restrições-de-integridade-de-uma-entidade)
    - [Restrição de integridade referencial](#restrição-de-integridade-da-referência)
- [Banco de dados relacional](#Banco-de-dados-relacional)
    - [Esquema de uma base de dados relacional](#Esquema-de-uma-base-de-dados-relacional)



## Conceitos Iniciais

Para os próximos conceitos vamos utilizar a próxima tabela(relação) como exemplo.

**Aluno**
|Nome|Matrícula|idade|curso|
| --- | --- | --- | --- |
| Joana | 118241501 | 21 | Engenharia Elétrica |
| Rodrigo | 118210111 | 20 | Ciência da Computação |
| Leonardo | 115210114 | 28 | Arquitetura e Urbanismo |
| Leandra | 118547124 | 20 | Ciência da Computação |

**Esquema:** Aluno(Nome, Matrícula, Idade, Curso)

### Relação 
Conjunto, não ordenado, de tuplas {t1, t2, ... , tn}, ou seja, a tabela `Aluno` é uma relação. Cada relação possui um **[Grau](#grau)**.

### Esquema da relação 
O esquema é uma representação curta da relação, obedecendo o seguinte formato:

**Ex:** Esquema da relação Aluno:

    Aluno (Nome, Matrícula, idade, curso)

Onde:
- *Aluno*: Nome da relação(tabela);
- *(Nome, matrícula, idade, curso)*: Lista de atributos pertencentes ao aluno;

### Atributo
Uma coluna da tabela que representa uma característica das entidades existentes na relação. Cada atributo possui um **[domínio](#domínio)** e apresenta apenas **[Valores Atômicos](#valores-atômicos)**.

**Ex:** A coluna *"Nome"* é um atributo da relação Aluno, uma vez que representa uma característica das entidades existentes na tabela.

### Tupla 
As tuplas de uma relação são as linhas da tabela e são uma lista *ordenada* de valores pertencentes a um domínio. Cada tupla representa uma entidade do **[mini-mundo](#mini-mundo)** que a relação que ela está inserida aborda.

**Ex:** A linha que possui os valores `Rodrigo, 118210111, 20, Ciência da Computação` é uma tupla da relação e representa uma entidade do seu mini-mundo, onde a entidade é o aluno Rodrigo que possui as características apresentadas em cada atributo.


### Chaves 
Chaves são atributos que tem a capacidade de identificar unicamente uma tupla. Chaves podem ser divididas em:

**Ex:** Na relação pessoa o atributo `matrícula` é uma chave, uma vez que cada aluno possui uma matrícula diferente dos demais.


- **Super Chaves:** Conjunto de atributos que **juntos** funcionam como identificador único
> :warning: Obs: O conceito de super chave permite que existam atributos que "não fazem a diferença" na identificação única do elemento.

**Ex:** Na relação `Aluno` o conjunto de atributos formado pela `matrícula` + `nome` é uma superchave, uma vez que esse conjunto de atributos juntos identificam unicamente cada tupla. Mesmo que o atributo nome não faça muita diferença nessa identificação única esse conjunto de atributos ainda é considerado uma super chave;


- **Super chave mínima ou chave:** Eh um conjunto irredutível de atributos, onde caso uma atributo seja removido a chave perde o poder de identificar unicamente as tuplas.

- **Chave primária(PK):** Atributo da tabela que serve como chave. Chaves primárias não podem assumir valores **NULL**.

- **Chave estrangeira(FK):** São atributos de uma relação que referenciam chaves primárias de outras relações, ou seja, a FK de uma relação é a PK de outra.


## Conceitos Auxiliares

### Domínio
Valores que cada *atributo* da relação pode receber, como *tipo* ou uma *seleção específica de valores*, a partir das restrições que são determinadas.

**Ex:** O atributo `matrícula` da relação Aluno possui um domínio que abrange apenas os números inteiros, sendo assim, não existem matrículas compostas por letras ou caracteres especiais.

### Valores atômicos
Em uma relação os valores tem que ser únicos, atômicos.

**Ex:** Cliente(nome, cpf, telefone). O cliente não pode ter o atributo *telefone* com mais de 1 telefone cadastrado, para que isso seja possível é preciso criar outra relação **Telefone** com uma chave estrangeira que referencia o Cliente.

### Mini-Mundo
Parte do mundo real que a relação aborda

### Grau
Número de atributos de uma relação.

**Ex:** A relação *Aluno* é de grau 4, uma vez que possui 4 atributos.

## Constraints

As constraints, ou restrições, são o conjunto de regras que os valores dentro das relações podem assumir, de acordo com o mini-mundo sobre o qual aquelas relações foram criadas. 

As constraints podem ser divididas em três principais categorias:
### Restrições Implícitas 
Restrições que são inerentes ao modelo relacional de dados.

**Ex:** Tuplas repetidas. Relações são conjuntos de tuplas, então não é permitida a repetição de elementos.

### Restrições Explícitas
Restrições que já podem ser diretamente especificadas no esquema da relação.

**Ex:** Restrições de tipo, valor Null de uma chave primária, quantidade de letras em um atributo.

Restrições explícitas podem ser divididas em 3 subtipos:

#### Restrições de Domínio 
Essas são as restrições que especificam **[valores atômicos](#valores-atômicos)** assim como os **tipos** dos valores de cada atributo.

#### Restrições de integridade de uma entidade
Chaves primárias **não** podem assumir valores *Nulo*, uma vez que o objetivo de uma chave primária é justamente identificar unicamente a tupla.

#### Restrição de integridade referencial
Interações entre relações acontecem por meio de **chaves estrangeiras**, dessa maneira, essa restrição define que uma tupla que referencia outra tupla precisa referenciar uma tupla **existente**. 


### Restrições Semânticas
São restrições que não podem ser diretamente especificadas pelo esquema das relações.

**Ex:** Geralmente são regras de negócio, como por exemplo: Um Aluno não pode cursar dus cadeiras com o mesmo professor.

### Esquema de uma base de dados relacional 

O esquema de uma base de dados relacional é um conjunto de esquemas de relações S = {R1, R2...R3} e um outro conjunto de **[restrições de integridade](#restrições-de-integridade-relacional)**(RI), ou seja, um conjunto de normas que devem ser seguidas.


## Banco de dados relacional

Um conjunto de relações, r de R, na qual cada RI está associada a uma RI.

> :warning: **OBS:** Uma relação que não obedece as RI são chamadas  de relações *não válidas*, enquanto a relação que as obedece são chamadas de *válidas*.

<p align="center">
     <br><i>Espero que você tenha entendido tudo, até o próximo resumo!</i>
    <img src="../imagens/pocahontas_bye.gif">
</p>