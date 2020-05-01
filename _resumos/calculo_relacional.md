# Cálculo Relacional
*Seções 8.6 - 8.7 - Fundamentals of DataBase Systems 7th edition.*


## ìndice
- [Introdução](#introdução)


## Introdução

**O cálculo relacional e a álgebra relacional:**

- O cálculo relacional é `não-procedural`, oo contrário da álgebra relacional, que é `procedural`. As expressões do cálculo relacional são apenas `declarativas`, ou seja, não possuem uma ordem em que as operações devem ser realizadas para que o resultado da requisição seja o esperado, ao contrário da álgebra relacional.

- ambos possuem o **mesmo** `Poder de expressão`: O poder de expressão é o universo que abrange todos os tipos de requisições que podem ser realizados.

O cálculo relacional é a `base da Lógica Matemática` das linguagens de consulta como SQL, dessa maneira, linguagens que realiza quaisquer requisições que o cálculo relacional consegue fazer é chamada de **Linguagem Relacionalmente Completa**. 

> **OBS:** Como foi dito anteriormente, o Cálculo Relacional é a *base*, não o topo. Dessa maneira, existem linguagens que possurem um `pode de expressão` ainda maior do que o cálculo relacional.


## Cálculo Relacional de tuplas

O cálculo relacional de tuplas se baseia em especificar *variáveis*, sendo essas tuplas, onde a variável pode assumir qualquer valor da `amplitude relacional`, amplitude essa que é formada pelas tuplas da relação selecionada. 

A resposta da requisição é um conjunto de  tuplas que `satisfazem` a condição imposta, ou seja, tuplas que sob a condição previamente determinada resultam no valor booleano TRUE.

Toda requisição do cálculo relacional de tuplas é estruturada da seguinte forma:

```
{T | Cond(T)}
```

Onde:
- `T` é a variável(tupla);
- `Cond(T)` é a condição envolvendo T que será julgada como verdadeira ou falsa.