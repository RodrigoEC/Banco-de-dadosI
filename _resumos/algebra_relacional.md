# Álgebra Relacional

## Índice
- [Introdução](#introdução)
- [Operações Unárias](#operações-relacionais-unárias)
    - [SELECT](#select-(σ))
    - [PROJECT](#PROJECT-(π))
    - [RENAME](#RENAME-(⍴))
- [Teoria dos conjuntos](#Teoria-dos-conjuntos)



## Introdução
---
A álgebra relacional é um conjunto de operações que vão envolver as relações de um modelo relacional com o objetivo de manipular as informações de um banco de dados.

Dentro da linguagem [**`SQL`**](https://pt.wikipedia.org/wiki/SQL), existem as sublinguagens como `DQL`(Data Query Language) que são focadas em abranger essa parte da álgebra relacional.
    
As operações da álgebra relacional podem ser divididas em dois principais grupos:
    
1. **Teoria dos conjuntos:** 
    - [UNION]();
    - [INTERSECTION]();
    - [SET DIFFERENCE]();
    - [CARTESIAN PRODUCT]().

2. **Específicas para Bases de dados:** 
    - [SELECT](#select-(σ));
    - [PROJECT]();
    - [JOIN]().
---
## Operações Relacionais Unárias
---
Operações unárias são as operações que envolvem apenas *uma* relação.

### **SELECT (σ)**

Operação que seleciona um subconjunto de tuplas (linhas) de uma relação (tabela) a partir de uma ou mais **condição de seleção**.

A operação *SELECT* se organiza da seguinte maneira:

        σ <condição de seleção> ( R )

Onde:
    
- **σ** :Sigma, letra que representa a operação SELECT;
- **<condição de seleção>:** Condição que serve para filtrar as tuplas, podendo apresentar mais de uma condição, adicionando os operadores lógicos `AND`, `OR` e `NOT`;
- **(R)**: Relação na qual será feita a filtragem.

**Comutatividade:** A ordem das condições de seleção não aletra o resultado da operação.



### **PROJECT (π)**

Operação que filtra os **atributos**(coluna) de um relação. Essa operação é denominada `divisora vertical` uma vez que divide a relação em duas novas relações, uma que contém as colunas descartadas e a outra com as colunas necessárias

A operação de seleção é organizada da seguinte maneira:

        π <atributos > ( R )

Onde:
- **π:** PI, letra que representa a operação PROJECT;
- <**atributos**>: Lista de atributos que estarão presentes na nova relação criada;
- **(R):** Relação na qual será feita a operação.


**Comutatividade:** A operação `project` **não** é comutativa.

> :warning: **OBS:** A π pode produzir tuplas iguais, caso as chaves sejam descartadas. A álgebra relacional exclui tuplas repetidas, todavia o SQL não.

### **RENAME (⍴)**
Operação que renomeia os atributos de uma relação. 

> :warning: **OBS:** Essa operação é extremamente útil quando existirem operações mais complexas que exigem que dois atributos de duas relações diferentes tenham o mesmo nome. 

Essa operação é representada da seguinte maneira:

        ρ relação(lista de atributos) (R)

Onde:
- **ρ:** Rho, letra que representa a operação de RENAME;
- **relação:** Título novo da relação. Optativo, caso não se queira mudar o nome da relação;
- **(B1, B2, ... , Bn):** Conjunto de nomes novos para os atributos. Optativa, caso não se queira mudar os nome de algum atributos;
- **(R):** Relação sobre a qual a operação vai ser realizada.

---
## Teoria dos conjuntos
---

Relações de exemplo:
![dwdwd](https://github.com/RodrigoEC/BancoDeDadosI/blob/master/_imagens/UNION.png)


### **UNION (⋃)**
A operação de união junta as tuplas de uma relação R com as tuplas de uma relação S e cria uma nova relação **R ⋃ S**, onde não há tuplas duplicadas. Essa operação só ocorre caso as relações apresentarem os mesmo tipo e o [domínio](https://github.com/RodrigoEC/BancoDeDadosI/blob/master/_resumos/modelos_relacionais.md#dom%C3%ADnio).

- **Comutatividade = TRUE:** R ⋃ S == S ⋃ R
- **Associatividade = TRUE:** (R ⋃ S) ⋃ T ==  R ⋃ (S ⋃ T)
























## Expressões in-line e relações intermediárias

Todas as operações previamente citadas podem ser escritas como uma única **expressão algébrica relacional(expressões in-line)** ou podem ser escritas com o auxílio de **relações intermediárias**.


- **Expressão in-line:**
    ```
    𝛑 Name, age, sex(σ age > 18(R))
    ```

- **Utilizando relações intermediárias:**
    ```
    rel_temp <- σ age > 18(R)

    𝛑 Name, age, sex(rel_temp)
    ```