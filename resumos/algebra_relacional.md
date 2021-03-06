# Álgebra Relacional
*Seção 8.5 - Fundamentals of DataBase Systems 7th edition.*


## Índice
- [Introdução](#introdução)
- [Expressões in-line e relações intermediárias](#Expressões-in-line-e-relações-intermediárias)
- [Operações Unárias](#operações-relacionais-unárias)
    - [SELECT](#select)
    - [PROJECT](#PROJECT)
    - [RENAME](#RENAME)
- [Teoria dos conjuntos](#Teoria-dos-conjuntos)
    - [UNION](#UNION)
    - [INTERSECTION](#INTERSECTION)
    - [SET DIFFERENCE](#SET-DIFFERENCE-ou-MINUS)
    - [CARTESIAN PRODUCT](#CARTESIAN-(ou-CROSS)-PRODUCT)
- [Operações Binárias](#Operações-Relacionais-Binárias)
    - [JOIN](#JOIN)
    - [EQUIJOIN](#EQUIJOIN)
    - [NATURAL JOIN](#NATURAL-JOIN)
    - [DIVISION](#DIVISION)
- [Árvores de Consulta](#árvores-de-consulta)   
- [Operações relacionais adicionais](#operações-relacionais-adicionais)
    - [Projeção Generalizada](#Projeção-Generalizada)
    - [Fechamento Recursivo](#fechamento-recursivo)
    - [OUTER JOIN](#outer-join)
    - [OUTER UNION](#outer-union)

---
## Introdução
---
A álgebra relacional é um conjunto de operações que vão envolver as relações de um modelo relacional com o objetivo de manipular as informações de um banco de dados.

Dentro da linguagem [**`SQL`**](https://pt.wikipedia.org/wiki/SQL), existem as sublinguagens como `DQL`(Data Query Language) que são focadas em abranger essa parte da álgebra relacional.
    
As operações da álgebra relacional podem ser divididas em dois principais grupos:
    
1. **Teoria dos conjuntos:** 
    - [UNION](#UNION);
    - [INTERSECTION](#INTERSECTION);
    - [SET DIFFERENCE](#SET-DIFFERENCE-ou-MINUS);
    - [CARTESIAN PRODUCT](#CARTESIAN-(ou-CROSS)-PRODUCT).

2. **Específicas para Bases de dados:** 
    - [SELECT](#select);
    - [PROJECT](#PROJECT);
    - [JOIN](#RENAME).


---
## Expressões in-line e relações intermediárias
---

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

---
## Operações Relacionais Unárias
---
Operações unárias são as operações que envolvem apenas *uma* relação.

---
### **SELECT**

Operação que seleciona um subconjunto de tuplas (linhas) de uma relação (tabela) a partir de uma ou mais **condição de seleção**.

A operação *SELECT* se organiza da seguinte maneira:

```
σ <condição de seleção> ( R )
```

Onde:
    
- **σ** :Sigma, letra que representa a operação SELECT;
- **<condição de seleção>:** Condição que serve para filtrar as tuplas, podendo apresentar mais de uma condição, adicionando os operadores lógicos `AND`, `OR` e `NOT`;
- **(R)**: Relação na qual será feita a filtragem.

**Comutatividade:** A ordem das condições de seleção não aletra o resultado da operação.

---
### **PROJECT**

Operação que filtra os **atributos**(coluna) de um relação. Essa operação é denominada `divisora vertical` uma vez que divide a relação em duas novas relações, uma que contém as colunas descartadas e a outra com as colunas necessárias

A operação de seleção é organizada da seguinte maneira:

```
π <atributos > ( R )
```

Onde:
- **π:** PI, letra que representa a operação PROJECT;
- <**atributos**>: Lista de atributos que estarão presentes na nova relação criada;
- **(R):** Relação na qual será feita a operação.


**Comutatividade:** A operação project **não** é comutativa.

> :warning: **OBS:** A π pode produzir tuplas iguais, caso as chaves sejam descartadas. A álgebra relacional exclui tuplas repetidas, todavia o SQL não.

---
### **RENAME**
Operação que renomeia os atributos de uma relação. 

> :warning: **OBS:** Essa operação é extremamente útil quando existirem operações mais complexas que exigem que dois atributos de duas relações diferentes tenham o mesmo nome. 

Essa operação é representada da seguinte maneira:

```
ρ relação(lista de atributos) (R)
```

Onde:
- **ρ:** Rho, letra que representa a operação de RENAME;
- **relação:** Título novo da relação. Optativo, caso não se queira mudar o nome da relação;
- **(B1, B2, ... , Bn):** Conjunto de nomes novos para os atributos. Optativa, caso não se queira mudar os nome de algum atributos;
- **(R):** Relação sobre a qual a operação vai ser realizada.

---
## Teoria dos conjuntos
---

As tabelas a seguir servirão como base para os exemplos dados:

ESTUDANTE
| Nome | id |
| --- | --- |
| José | 154 | 
| Hui | 147 |
| Virna | 187 |

INSTRUTOR
| Nome | id |
| --- | --- |
| José | 154 |
| Paulo | 197 |
| VIctor | 164 |

---
### **UNION**
A operação de união junta as tuplas de uma relação R com as tuplas de uma relação S e cria uma nova relação `R ⋃ S`, onde não há tuplas duplicadas. Essa operação só ocorre caso as relações apresentarem os mesmo tipo e [domínio](https://github.com/RodrigoEC/BancoDeDadosI/blob/master/_resumos/modelos_relacionais.md#dom%C3%ADnio).

- **Comutatividade = TRUE:** R ⋃ S == S ⋃ R
- **Associatividade = TRUE:** (R ⋃ S) ⋃ T ==  R ⋃ (S ⋃ T)

**Ex:**

ESTUDANTE ⋃ INSTRUTOR
| Nome | id |
| --- | --- |
| Jośe | 154 |
| Hui | 147 |
| Virna | 187 |
| Paulo | 197 |
| Victor | 164 |

---
### **INTERSECTION**
A operação que cria uma nova relação que contém apenas as tuplas que pertencem tanto a uma relação R como a uma outra relação S, sendo denotada como `R ⋂ S`.

- **Comutatividade = TRUE:** R ⋂ S == S ⋂ R
- **Associatividade = TRUE:** (R ⋂ S) ⋂ T ==  R ⋂ (S ⋂ T)

**Ex:**

ESTUDANTE ⋂ INSTRUTOR
| Nome | id |
| --- | --- |
| José | 154 |

---
### **SET DIFFERENCE ou MINUS**
Operação `R - S` que produz como resultado todas as tuplas que estão em R mas não estão em S. 

- **Comutatividade = FALSE:** R - S != S - R

**Ex:**

ESTUDANTE - INSTRUTOR
| Nome | id |
| --- | --- |
| Hui | 147 |
| Virna | 187 |

---
### **CARTESIAN (ou CROSS) PRODUCT**
Essa operação `R X S` produz uma nova relação Z formada pela combinação de todas as tuplas de R com as tuplas de S, resultando na relação Z que possui a quantidade de colunas de R somada a quantidade de colunas de S.

Essa operação é representada da seguinte forma:

```
Z <- R X S
```

Onde:
- **X:** Símbolo que representa a operação de produto cartesiano;
- **Z:** Relação produzida a partir do produto cartesiano;
- **R e S:** RElações participantes da operação.

**n° tuplas:** n° tuplas de R * n° tuplas de S;

**Ordem:** n° atributos de R + n° atributos de S.

> :warning: **OBS:** O produto cartesiano por si só *não* traz conhecimento **real** por si só, sendo necessária à utilização do SELECT, por exemplo, para filtrar os dados que podem ter algum significado.

**Ex:**

ESTUDANTE X INSTRUTOR
| Nome | id | Nome | id |
| --- | --- | --- | --- |
| José | 154 | José | 154 |
| José | 154 | Paulo | 197 |
| José | 154 | VIctor | 164 |
| Hui | 147 | José | 154 |
| Hui | 147 | Paulo | 197 |
| Hui | 147 | VIctor | 164 |
| Virna | 187 | José | 154 |
| Virna | 187 | Paulo | 197 |
| Virna | 187 | VIctor | 164 |

---
## Operações Relacionais Binárias
---
São operações que envolvem a manipulação de *duas* relações.

---
### **JOIN**
Essa operação engloba as operações de [produto cartesiano](#CARTESINA-(ou-CROSS)-PRODUCT(X)) seguida pela operação de [select](#SELECT-(σ)), devido ao fato de dessa sequência de operações ser muito utilizada.

Essa operação é representada da seguinte maneira:

```
DEPARTMENT ⋈ Mgr_ssn = Ssn EMPLOYEE
```

Onde:
- **⋈:** Símbolo que representa a operação de JOIN;
- **Mgr_ssn = Ssn:** Condição de seleção;
- **Department e employee:** Relações sobre as quais a operação será feita.

- **n° tuplas:** desde n° tuplas de R * n° tuplas tuplas S até 0, caso a *condição* imposta nunca seja satisfeita.

- **Ordem:** n° atributos de R + n° atributos atributos de S.

---
### **EQUIJOIN**
Variação do [JOIN](#JOIN-(⋈)), onde o operador de condição utilizado é o `=`. Como o operador utilizado é o =, a relação resultante apresentará 2 colunas de atributos com os mesmos valores.

---
### **NATURAL JOIN**
Operação criada para excluir a segunda coluna repetida do [EQUIJOIN](#equijoin).

Essa operação se organiza da seguinte maneira:

```
NOVA_REL <- R * <condição1 AND condição2> S
```

Onde:
- **NOVA_REL:** Relação resultante;
- **R e S:** Relações sobre as quais a operação será realzada;
- *: Símblo da operação natural join;
- <**condição1 AND condição2**>: Condições que ditarão como será feita a seleção das tuplas     , chamado de `THETA_JOIN`.

> :warning: **OBS:** Para que essa operação funcione é necessário que o nome dos atributos que vão ser comparados sejam iguais.

---
### DIVISION
A operação R ÷ S funciona da seguinte maneira. sendo o conjunto de atributos de S um subconjunto dos atributos de R, R ÷ S pega todos os valores das tuplas de R que se conseguem abranger  TODAS as tuplas de S e cria uma nova relação a partir disso.

**Exemplo:**

FUNCIONÁRIO
| Nome | Proj_n | SSN |
| --- | --- | --- |
| regis | 1 | 1234 |
| regis | 2 | 1234 |
| Bia | 1 | 7410 |
| Bia | 3 | 7410 |

PROJETOS
| Proj_n |
| --- |
| 1 |
| 2 |

FUNCIONÁRIO ÷ PROJETOS
| Nome | SSN |
| --- | --- |
| Regis | 1234 |

---
## Árvores de Consulta
---
Árvores de consulta(Query trees) são estruturas de dados na forma de árvores que representam uma expressão algébrica relacional. A estrutura da árvore é organizada da seguinte forma:

- **Folhas:** Relações que serão utilizadas pelas operações;
- **Nós internos:** São as operações que serão realizadas.

O Processo acontece da seguinte maneira:

1. As operações acontecem a partir das folhas de menor nível, as quais serão utilizadas na operação que do seu `nó pai`.

2. O nó interno que fez a operação a partir das relações dos seus nós filhos se transforma na relação resultante da sua operação, e essa será utilizada pelo seu `nó pai`.

3. O processo se repete e só acaba quando chega no `nó raiz`, que faz a operação que lhe pertence e retorna a relação resultado.


Exemplo de uma árvore de consulta(Query Tree):
![Query Tree](https://github.com/RodrigoEC/BancoDeDadosI/blob/master/_imagens/arvore_de_consulta.png)

---
## Operações relacionais adicionais
---
São operações que realizam tarefas que as operações *originais* não conseguem resolver para a SGBDR (Sistema de gerenciamento de banco de dados Relacional)

---
### **Operações de projeção generalizada**
A projeção generalizada  é uma operação que estende a operação [PROJECT](#PROJECT), permitindo que funções sejam inclusas na lista de atributos que serão "filtrados".

Essa operação é estruturada da seguinte forma:

```
π <f1, f2, ..., fn> (R)
```

Onde:
- **π:** Símbolo da operação PROJECT;
- **f1, f2, ..., fn:** Funções sobre os atributos da relação, podendo ser operações aritméticas ou valores constantes;
- **(R:)** Relação sobre a qual a operação será realizada.

> :warning: **Atenção:** O nome dos atributos criados a partir das funções pode ficar sem sentido, por isso normalmente se utiliza a operação de [Rename](#rename) para complementar essa operação.

**Ex:**

REPORT <- ρ( Ssn, Net_salary, Bonus, Tax ) (π Ssn, Salary – Deduction , 2000 * Years_service , 0.25 * Salary ( EMPLOYEE ))

---
### **Operação de funções de agregação e Agrupamento**
A operação de funções de agregação é uma operação que permite a utilização de [`Funções de agregação`](https://www.devmedia.com.br/sql-funcoes-de-agregacao/38463), funções essas que servem para sumarizar informações a partir de um conjunto de tuplas da base de dados, assim como permite o `agrupamento` de tuplas a partir dos valores de atributos especificados é outra necessidade.

Essa operação se estrutura da seguinte maneira:

```
<`grouping attributes`> I <function list> (R)
```

Onde:
- <**grouping attributes**>: Atributos que servirão para fazer o agrupamento;
- **I:** Símbolo da operação de Funçoẽs de agregação;
- <**function list**>: Lista de tuplas (<`função`><`atributo`>), onde `função` é uma das funções permitidas (como SUM, AVERAGE, MAXIMUM, MINIMUM, COUNT) e `Atributo` é o atributo sobre o qual a função vai ser operada;
- **(R):** Relação sobre a qual ocorrerá a operação.

> :warning: **OBS:** Caso a operação SELECT não seja utilizada em seguida, os nomes dos atributos criados na nova relação será uma concatenação `função_atributo`.

---
### **Fechamento Recursivo**

O fechamento recursivo é uma operação em que existe um **relacionamento recursivo** entre as tuplas de um mesmo tipo. 

> :warning: **OBS:** Essa operação não é possível de ser implementada com operações básicas da álgebra realacional, todavia, é implementada na linguagem [`SQL`(colocar o link para o resumo de SQL)]().

**Ex:**  

Caso seja requisitado os ids de todos os funcionários que estejam sendo supervisionados pelo funcionário X, ou por aqueles que ele supervisiona. Será necessário acessar os supervisionados do X, depois os supervisionados dos supervisionados de X e assim em diante.

---
### **OUTER JOiN**

A operação `outer join` possui o mesmo princípio de um [`join`](#join) comum, todavia, ao fazer o "matching" das duas relações ela não descarta as tuplas que não possuem par, ao invés disso, associa essas tuplas a valores *NULL*.

Representação:

```
DEPARTMENT ⋈ Mgr_ssn = Ssn EMPLOYEE
```

> obs: O símbolo acima possui perninhas dependendo do tipo, mas não achei do tamanho correto

O outer join pode ser dividido em 3 variasções:

- **LEFT OUTER JOIN:** As tuplas da relação à esquerda que não possuem par são associados a valores *NULL*, enquanto as tuplas que não possuem par na relação a direito são descartadas;

- **RIGHT OUTER JOIN:** Mesma ideia do `left outer join`, porém, nesse caso as tuplas da relação à direita que não possuem par são associados a valores *NULL*, enquanto as tuplas que não possuem par na relação a esquerda são descartadas; 

- **FULL OUTER JOIN** Tanto as tuplas da relação a direita, quanto as tuplas da relação a esquerda que não possuirem um par quando for realizada a operação de `join` são associados a valores *NULL*.

**Ex:**

EMPREGADO
| nome | id_dept |
| --- | --- |
| Josenildo | 1 |
| Joselanda | 2 |
| Joana | 1 |
| Jefferson | 4 |

DEPARTAMENTO
| id | nome_dep |
| --- | --- |
| 1 | Administração |
| 2 | Financeiro |
| 3 | Marketing |

**LEFT OUTER JOIN:** REL <- π nome, id_dept, nome_dep (EMPREGADO ⋈ id_dept = id DEPARTAMENTO)

REL
| nome | id_dept | nome_dep |
| --- | --- | --- |
| Josenildo | 1 | Administração |
| Joselanda | 2 | Financeiro |
| Joana | 1 | Administração |
| Jefferson | 4 | NULL |

**RIGHT OUTER JOIN:** REL <- π nome, id, nome_dep (EMPREGADO ⋈ id_dept = id DEPARTAMENTO)

REL
| nome | id | nome_dep |
| --- | --- | --- |
| Josenildo | 1 | Administração |
| Joselanda | 2 | Financeiro |
| Joana | 1 | Administração | 
| NULL | 3 | marketing |

**FULL OUTER JOIN:** REL <- π nome, id, nome_dep (EMPREGADO ⋈ id_dept = id DEPARTAMENTO)

REL
| nome | id | nome_dep |
| --- | --- | --- |
| Josenildo | 1 | Administração |
| Joselanda | 2 | Financeiro |
| Joana | 1 | Administração | 
| NULL | 3 | marketing |
| Jefferson | 4 | NULL |

---
### **OUTER UNION**

Essa operação é a mesma do `FULL OUTER JOIN`. Sendo:

- R(nome, id, dep)
- S(id_dept, nome_dept)

REL <- R ⋃* <dep = id_dept> S gera a seguinte relação:

> REL(nome, id, dep, nome_dept)

Onde, assim como no [`FULL OUTER JOIN`](#outer-join), as tuplas que não tinham par são associadas a valores *NULL*.
