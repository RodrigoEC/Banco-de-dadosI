# Cálculo Relacional
*Seções 8.6 - 8.7 - Fundamentals of DataBase Systems 7th edition.*

## ìndice
- [Introdução](#introdução)
- [Cálculo Relacional de Tuplas](#cálculo-relacional-de-tuplas)
    - [Expressões e fórmulas](#Expressões-e-fórmulas)
    - [Quantificadores Universais e existenciais](#quantificadores-universais-e-existenciais)
- [Cálculo Relacional de domínio](#Cálculo-relacional-de-domínio)
---
## Introdução

**O cálculo relacional e a álgebra relacional:**

- O cálculo relacional é `não-procedural`, oo contrário da álgebra relacional, que é `procedural`. As expressões do cálculo relacional são apenas `declarativas`, ou seja, não possuem uma ordem em que as operações devem ser realizadas para que o resultado da requisição seja o esperado, ao contrário da álgebra relacional.

- ambos possuem o **mesmo** `Poder de expressão`: O poder de expressão é o universo que abrange todos os tipos de requisições que podem ser realizados.

O cálculo relacional é a `base da Lógica Matemática` das linguagens de consulta como SQL, dessa maneira, linguagens que realiza quaisquer requisições que o cálculo relacional consegue fazer é chamada de **Linguagem Relacionalmente Completa**. 

> **OBS:** Como foi dito anteriormente, o Cálculo Relacional é a *base*, não o topo. Dessa maneira, existem linguagens que possurem um `pode de expressão` ainda maior do que o cálculo relacional.

---
## Cálculo Relacional de tuplas

O cálculo relacional de tuplas se baseia em especificar *variáveis*, sendo essas tuplas, onde a variável pode assumir qualquer valor da `amplitude relacional`, ou seja, ela pode assumir a forma de qualquer tupla da relação em que ela se encontra. 

A resposta da requisição é um conjunto de  tuplas que `satisfazem` a condição imposta, ou seja, tuplas que sob a condição previamente determinada resultam no valor booleano TRUE.

---
### **Expressões e fórmulas**

Toda expressão do cálculo relacional de tuplas é estruturada da seguinte forma:

```
{T1.A1, T2.A2...Tn.An | Cond(T)}
```

Onde:
- `T1, T2 e Tn` são a variável(tupla);
- `A1, A2 e An` são os atributos de T1 e T2, respectivamente, que serão retornados como resposta
- `Cond(T)` é a condição envolvendo T que será julgada como verdadeira ou falsa.

A condição (Cond(T)) pode ser de três tipos:

- **R(T):** tuplas T que pertencerem a `amplitude relacional` de R serão avaliadas com *TRUE*, caso contrário como *FALSE*.

    **Ex:** Requisição que tem como resposta apenas as pessoas `e` que são estudantes.
    ```
    {e.name, e.matricula | ESTUDANTE(e)} 
    ```
- **t1.A oc t2.B:** Sendo "oc" um `operador de comparação`{=, <, ≤, >, ≥, ≠}. Essa condição retorna *TRUE* caso os dois atributos (A e B) satisfaçam a expressão, caso contrário, o valor *FALSE* é retornado.

    **Ex:** ID dos empregados que recebem mais do que 50000 reais.
    ```
    {e.id | EMPREGADO(e) AND e.salario > 50000}
    ```
- **t1.A oc const. *OR* const. oc t2.B:** Sendo "oc" um `operador de comparação`{=, <, ≤, >, ≥, ≠}. Essa condição retorna *TRUE* caso algum dos dois atributos (A ou B) satisfaçam a expressão, caso contrário, o valor *FALSE* é retornado.

    **Ex:** ID dos empregados que recebem mais de 30000 reais ou menos de 1000 reais.
    ```
    {e.id | EMPREGADO(e) AND (e.salario > 30000 OR e.salario < 1000)}
    ```

---
### **Quantificadores Universais e existenciais**
Existem dois tipos de quantificadores: 

- **Quantificador universal (∀t):** Em uma fórmula F, (∀t)(F) significa que a fórmula precisa ser verdade para **TODAS** as tuplas para que ela seja avaliada como *TRUE*, caso exista pelo menos uma tupla que não se encaixe ela é avaliada como *FALSE*.

- **Quantificador existencial(∃t):** Em uma fórmula F, (∃t)(F) é avaliado como *TRUE* caso existe pelo menos uma tupla que satisfaça a fórmula, caso contrário, ela é avaliada como *FALSE*.

Por causa dos quantificadores nós podemos classificar as variáveis em dois subgrupos:

- **Variáveis livres:** São variáveis que não estão atreladas a nenhum quantificador;
- **Variáveis ligadas:** São as variáveis que são atreladas a um quantificador

    **Ex:** Nome de todos os professores que lecionam pelo menos uam disciplina
    ```
        {t.name | PROFESSOR(t) AND (∃w)(DISCIPLINA(w) AND t.disciplina = w.professor)}
    ```
    Onde: t é uma variável `livre` e w é uma variável `ligada`.

---
## Cálculo relacional de domínio
A diferença principal desse cálculo relacional para o de tuplas é o tipo de variável. No cálculo relacional de domínio as variáveis, agora chamadas de `variáveis de domínio`, são os `atributos`.

As fórmulas do Cálculo relacional de domínio se estruturam da seguinte forma:
```
    {x1, x2, ... , xn | Cond(x1, x2, ..., xn, xn+1, xn+2, xn+m )}
```
Onde:
- **x1...xn+m:** São os variáveis de domínio;
- **Cond:** Condição que envolvem os atributos e que serão avaliadas como *TRUE* ou *FALSE*.

Assim como no cálculo relacional de tuplas, a *Cond* pode ser de 3 tipos:

- **R(x1, x2, ..., xj):** Sendo R o nome da relação de grau j e (x1, x2, ... , xj) `todos` os atributos de R. Essa condição implica que cada uma dessas variáveis de domínio representa algum dos atributos da relação R.

    **Ex:** Retornar o nome e id de todas as pessoas que pertencem a relação EMPLOYEE.
    ```
        {v, u | EMPLOYEE(vumnop)}
    ```

- **x1 oc x2:** Sendo oc um `operador de comparação`, essa condição compara duas variáveis de domínio(atributos).

    **Ex:** Retornar nome e id de todos os empregados que ganham mais de 50000 reais.
    ```
        {v, u | EMPLOYEE(vumnop) AND p > 50000}
    ```

- **x1 oc k *OR* k oc x2:** Sendo oc um `operador de comparação` e k uma `constante` qualquer, essa condição compara duas variáveis de domínio com uma constante.

    **Ex:** Retornar o nome e id de todos os funcionários que ganham mais de 4000 reais ou menos de 1000 reais.
    ```
        {v, u | EMPLOYEE(vumnop) AND (p > 4000 OR p < 1000)}
    ```

