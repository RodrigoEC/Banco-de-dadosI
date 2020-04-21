# Modelo de Dados Relacional

## Índice
- [Conceitos Iniciais](#conceitos-iniciais)
- [Conceitos Auxiliares](#conceitos-auxiliares)
- [Constraints](#constraints)




## Conceitos Iniciais
- **Tupla:** Lista *ordenada* de valores pertencentes a um domínio. Cada tupla representa uma entidade do **[mini-mundo](#conceitos-auxiliares)** que relação que ela está inserida aborda

- **Relação:** Conjunto, não ordenado, de tuplas {t1, t2, ... , tn}. Cada relação possui um **[Grau](#conceitos-auxiliares)**.

- **Atributo:** Uma coluna da tabela que representa uma característica das entidades existentes na relação. Cada atributo possui um **[domínio](#conceitos-auxiliares)** e apresenta apenas **[Valores Atômicos](#conceitos-auxiliares)**.

- **Esquema da relação:** O esquema R(a1,a2..ai) é formado pelo nome da relação (R) e pela lista de atributos.
    > *Ex:* Universitario(Nome, Matrícula, idade)

- **Chaves:** Chaves são atributos que tem a capacidade de identificar unicamente uma tupla. Chaves podem ser divididas em:
    - **Super Chaves:** Conjunto atributos que **juntos** funcionam como identificador único, mas sozinhos não (a não ser que o conjunto seja unitário, claro).

    - **Super chave mínima:** Super chave formada por apenas um atributo, ou seja, uma chave "comum".

    - **Chave primária(PK):** Atributo da tabela que serve como chave. Chaves primárias não podem assumir valores **NULL**.

    - **Chave estrangeira(FK):** São atributos de uma relação que referenciam chaves primárias de outras relações, ou seja, a FK de uma relação é a PK de outra.


## Conceitos Auxiliares

- **Domínio:** Valores que cada *atributo* da relação pode receber, como *tipo* ou uma *seleção específica de valores*, a  partir das restrições que são determinadas.

- **Valores atômicos:** Em uma relação os valores tem que ser únicos, atômicos.
    > *Ex:* Cliente(nome, cpf, telefone). O cliente não pode ter o atributo *telefone* com mais de 1 telefone cadastrado, para que isso seja possível é preciso criar outra relação **Telefone** com uma chave estrangeira que referencia o Cliente.

- **Mini-Mundo:** Parte do mundo real que a relação aborda

- **Grau:** Número de atributos de uma relação.

## Constraints

As constraints, ou restrições, são o conjunto de regras que os valores dentro das relações podem assumir, de acordo com o mini-mundo sobre o qual aquelas relações foram criadas. 

As constraints podem ser divididas em três principais categorias:
1. **Restrições Implícitas:** Restrições que são inerentes ao modelo relacional de dados.
    > *Ex:* Tuplas repetidas. Relações são conjuntos de tuplas, então não é permitida a repetição de elementos.

2. **Restrições Explícitas:** Restrições que já podem ser diretamente deduzidas a partir do esquema da relação.
    > *Ex:* A partir do esquema de relações de uma relação FILME, por exemplo, já é possível saber que o atributo “duração" apenas suporta uma entrada, ou seja, o filme só tem uma duração

3. **Restrições Semânticas:** São restrições que não podem ser diretamente especificadas pelo esquema das relações.
    > *Ex:* Em uma relação “FUNCIONÁRIO” existe o atributo “função” que não pode receber todo tipo de valor, todavia, é impossível saber quais são esses valores apenas olhando o esquema das relações, ou seja, o nome da relação e o seu conjunto com o nome das tuplas. 

### Restrições de Integridade relacional:

- **Restrições de Domínio:** Essas são as restrições que especificam **[valores atômicos](#conceitos-auxiliares)** assim como os **tipos** dos valores de cada atributo.

- **Restrições de integridade de uma entidade:** Chaves primárias **não** podem assumir valores *Nulo*, uma vez que o objetivo de uma chave primária é justamente identificar unicamente a tupla.

- **Restrição de integridade da referência:** Interações entre relações acontecem por meio de **chaves estrangeiras**, dessa maneira, essa restrição define que uma tupla que referencia outra tupla precisa referenciar uma tupla **existente**. 

## Base de dados relacional e seu esquema:
- **Esquema de uma base de dados relacional:** O esquema de uma base de dados relacional é um conjunto de esquemas de relações S = {R1, R2...R3} e um outro conjunto de *restrições de integridade(RI)*, ou seja, um conjunto de normas que devem ser seguidas.

- **Banco de dados relacional:** Um conjunto de relações, r de R, na qual cada ri está associada a uma Ri.
    > :warning: **OBS:** Uma relação que não obedece as RI são chamadas  de relações **não válidas**, enquanto a relação que as obedece são chamadas de **válidas**.