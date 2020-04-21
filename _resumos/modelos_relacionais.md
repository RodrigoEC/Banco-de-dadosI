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
    - [Restrições Implícitas](#1.restrições-implícitas)
    - [Restrições Explícitas](#2.restrições-explícitas)
    - [Restrições Semânticas](#3.restrições-semânticas)
- [Restrições de Integridade relacional](#restrições-de-integridade-relacional)
    - [Restrições de Domínio](#restrições-de-domínio)
    - [Restrições de integridade de uma entidade](#restrições-de-integridade-de-uma-entidade)
    - [Restrição de integridade da referência](#restrição-de-integridade-da-referência)




## Conceitos Iniciais

Exemplo de Relação:

**Aluno**
|Nome|Matrícula|idade|curso|
| --- | --- | --- | --- |
| Joana | 118241501 | 21 | Engenharia Elétrica |
| Rodrigo | 118210111 | 20 | Ciência da Computação |
| Leonardo | 115210114 | 28 | Arquitetura e Urbanismo |
| Leandra | 118547124 | 20 | Ciência da Computação |

**Esquema:** Aluno(Nome, Matrícula, Idade, Curso)


### **Tupla** 
Lista *ordenada* de valores pertencentes a um domínio. Cada tupla representa uma entidade do **[mini-mundo](#conceitos-auxiliares)** que relação que ela está inserida aborda

### **Relação** 
Conjunto, não ordenado, de tuplas {t1, t2, ... , tn}. Cada relação possui um **[Grau](#conceitos-auxiliares)**.

### **Atributo** 
Uma coluna da tabela que representa uma característica das entidades existentes na relação. Cada atributo possui um **[domínio](#conceitos-auxiliares)** e apresenta apenas **[Valores Atômicos](#conceitos-auxiliares)**.

### **Esquema da relação** 
O esquema R(a1,a2..ai) é formado pelo nome da relação (R) e pela lista de atributos.
    > *Ex:* Aluno (Nome, Matrícula, idade, curso)

### **Chaves** 
Chaves são atributos que tem a capacidade de identificar unicamente uma tupla. Chaves podem ser divididas em:

- **Super Chaves:** Conjunto atributos que **juntos** funcionam como identificador único, mas sozinhos não (a não ser que o conjunto seja unitário, claro).

- **Super chave mínima:** Super chave formada por apenas um atributo, ou seja, uma chave "comum".

- **Chave primária(PK):** Atributo da tabela que serve como chave. Chaves primárias não podem assumir valores **NULL**.

- **Chave estrangeira(FK):** São atributos de uma relação que referenciam chaves primárias de outras relações, ou seja, a FK de uma relação é a PK de outra.


## Conceitos Auxiliares

### **Domínio** 
Valores que cada *atributo* da relação pode receber, como *tipo* ou uma *seleção específica de valores*, a  partir das restrições que são determinadas.

### **Valores atômicos** 
Em uma relação os valores tem que ser únicos, atômicos.

> *Ex:* Cliente(nome, cpf, telefone). O cliente não pode ter o atributo *telefone* com mais de 1 telefone cadastrado, para que isso seja possível é preciso criar outra relação **Telefone** com uma chave estrangeira que referencia o Cliente.

### **Mini-Mundo** 
Parte do mundo real que a relação aborda

### **Grau** 
Número de atributos de uma relação.

## Constraints

As constraints, ou restrições, são o conjunto de regras que os valores dentro das relações podem assumir, de acordo com o mini-mundo sobre o qual aquelas relações foram criadas. 

As constraints podem ser divididas em três principais categorias:
### 1.Restrições Implícitas 
Restrições que são inerentes ao modelo relacional de dados.

> *Ex:* Tuplas repetidas. Relações são conjuntos de tuplas, então não é permitida a repetição de elementos.

### 2.Restrições Explícitas
Restrições que já podem ser diretamente deduzidas a partir do esquema da relação.

> *Ex:* A partir do esquema de relações da relação ALUNO, por exemplo, já é possível saber que o atributo “matrícula" apenas suporta uma entrada, ou seja, um aluno possui apenas uma matrícula.

### 3.Restrições Semânticas
São restrições que não podem ser diretamente especificadas pelo esquema das relações.

> *Ex:* Em uma relação “Aluno” existe o atributo “curso” que só suporta strings que representam os cursos existentes na universidade, todavia, é impossível saber quais são esses valores apenas olhando o **[esquema das relações](#esquema-da-relação)**.

## Restrições de Integridade relacional:

### **Restrições de Domínio** 
Essas são as restrições que especificam **[valores atômicos](#conceitos-auxiliares)** assim como os **tipos** dos valores de cada atributo.

### **Restrições de integridade de uma entidade** 
Chaves primárias **não** podem assumir valores *Nulo*, uma vez que o objetivo de uma chave primária é justamente identificar unicamente a tupla.

### **Restrição de integridade da referência** 
Interações entre relações acontecem por meio de **chaves estrangeiras**, dessa maneira, essa restrição define que uma tupla que referencia outra tupla precisa referenciar uma tupla **existente**. 

