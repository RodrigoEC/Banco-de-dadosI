# Cálculo Relacional
*Seções 8.6 - 8.7 - Fundamentals of DataBase Systems 7th edition.*

## ìndice
- [Introdução](#introdução)
- [Cálculo Relacional de Tuplas](#cálculo-relacional-de-tuplas)
    - [Expressões e fórmulas](#Expressões-e-fórmulas)
    - [Quantificadores Universais e existenciais](#quantificadores-universais-e-existenciais)

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
- ∀