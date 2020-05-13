# SQL (Search Query Language)
*Capítulo 06 - Fundamental of DataBase systems (7th edition)*

## Índice
- [Introdução](#introdução)

## Introdução
Originalmente criada e implementada pela IBM, SQL é a linguagem padrão para base de dados que teve sua origem no [`cálculo relacional`](#introdução) e na [`álgebra relacional`]() , sendo considerada o um dos principais motivos do sucesso comercial de *bases de dados relacionais*, uma vez que os usuários de sistemas de bases de dados estavam menos preocupados em migrar suas aplicações de um sistema para outro, justamente pelo fato do SQL ser a linguagem padrão utilizada nas SGBDs.

Esse resumo da linguagem SQL será focado em:

## Definições e tipos de dados
Em SQL, alguns termos da álgebra e cálculo relacional são substituídos:
- `Relação` = Tabela;
- `Tupla` = Linha;
- `Atributo` = Coluna.

### Esquema e Catálogo

**Esquema:** Também chamado de `banco de dados`, um esquema é um conjunto de relações. Um esquema é indentificado por um `nome` e um `identificador de autorização` referentes aos usuários responsáveis pelo esquema.

Em SQL, a criação de um esquema acontece da seguinte forma:

Ex: Criar um esquema "Company" cujo responsável sera "Joana"
```
    CREATE SCHEMA COMPANY AUTHORIZATION "Joana"
```
**Catálogo:** Coleção de esquemas.