-- Comentários
-- Questão 01
    -- Como é possível fazer a inserção de todos os valores nulos eu acredito que exista uma primary key
    -- que é um número INTEIRO autoincremetável
    -- id_tarefa SERIAL PRIMARY KEY,

-- Questão 04
    -- Comandos para retirar apenas tuplas com valores iguais a NULL:
    -- Comandos para restringir os valores dos atributos:

-- Questão 05
    -- Decidi adicionar uma primary key ao invês de diminuir o escopo do atributo prioridade,  
    -- uma vez que no mundo real não faz muito sentido limitar o escopo desse atributo para um valor
    -- tão baixo. A chave primária faz mais sentido ao meu ver

-- Questão 06 
--(a)
    -- Ao iniciar o roteiro já tinha pensando nesse atributo como CPF, dessa forma já adicionei
    -- essa constraint ao criar a tabela;

-- Questão 11
--Parte02
    -- Erro retornado: null value in column "func_resp_cpf" violates not-null constraint
--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.23
-- Dumped by pg_dump version 9.5.23

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

ALTER TABLE ONLY public.tarefas DROP CONSTRAINT tarefa_fkey_func_resp_cpf;
ALTER TABLE ONLY public.funcionario DROP CONSTRAINT funcionario_skey;
ALTER TABLE ONLY public.tarefas DROP CONSTRAINT tarefas_pkey;
ALTER TABLE ONLY public.funcionario DROP CONSTRAINT funcionario_pkey;
DROP TABLE public.tarefas;
DROP TABLE public.funcionario;
SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: funcionario; Type: TABLE; Schema: public; Owner: rodrigoec
--

CREATE TABLE public.funcionario (
    cpf character(11) NOT NULL,
    superior_cpf character(11),
    data_nasc date NOT NULL,
    nome character varying(25) NOT NULL,
    funcao character varying(11) NOT NULL,
    nivel character(1) NOT NULL,
    CONSTRAINT funcionario_chk_funcao CHECK ((((funcao)::text = 'LIMPEZA'::text) OR ((funcao)::text = 'SUP_LIMPEZA'::text))),
    CONSTRAINT funcionario_chk_funcao_escopo CHECK (((((funcao)::text = 'LIMPEZA'::text) AND (superior_cpf IS NOT NULL)) OR (((funcao)::text = 'SUP_LIMPEZA'::text) AND (superior_cpf IS NULL)) OR (((funcao)::text = 'SUP_LIMPEZA'::text) AND (superior_cpf IS NOT NULL)))),
    CONSTRAINT funcionario_chk_nivel CHECK (((nivel = 'J'::bpchar) OR (nivel = 'P'::bpchar) OR (nivel = 'S'::bpchar)))
);


ALTER TABLE public.funcionario OWNER TO rodrigoec;

--
-- Name: tarefas; Type: TABLE; Schema: public; Owner: rodrigoec
--

CREATE TABLE public.tarefas (
    id character(10) NOT NULL,
    descricao text NOT NULL,
    func_resp_cpf character(11) NOT NULL,
    prioridade integer NOT NULL,
    status character(1) NOT NULL,
    CONSTRAINT status_constr CHECK (((status = 'P'::bpchar) OR (status = 'E'::bpchar) OR (status = 'C'::bpchar))),
    CONSTRAINT tarefa_chk_prioridade CHECK ((prioridade < 32768)),
    CONSTRAINT tarefas_chk_func_resp_cpf CHECK ((((status = 'P'::bpchar) AND (func_resp_cpf IS NULL)) OR ((status = 'P'::bpchar) AND (func_resp_cpf IS NOT NULL)) OR ((status = 'C'::bpchar) AND (func_resp_cpf IS NOT NULL)) OR ((status = 'E'::bpchar) AND (func_resp_cpf IS NOT NULL))))
);


ALTER TABLE public.tarefas OWNER TO rodrigoec;

--
-- Data for Name: funcionario; Type: TABLE DATA; Schema: public; Owner: rodrigoec
--

INSERT INTO public.funcionario (cpf, superior_cpf, data_nasc, nome, funcao, nivel) VALUES ('12345678911', NULL, '1980-05-07', 'Pedro da Silva', 'SUP_LIMPEZA', 'S');
INSERT INTO public.funcionario (cpf, superior_cpf, data_nasc, nome, funcao, nivel) VALUES ('12345678912', '12345678911', '1980-03-08', 'José da Silva', 'LIMPEZA', 'J');
INSERT INTO public.funcionario (cpf, superior_cpf, data_nasc, nome, funcao, nivel) VALUES ('12345678914', '12345678911', '1999-11-17', 'Rodraigs', 'SUP_LIMPEZA', 'S');
INSERT INTO public.funcionario (cpf, superior_cpf, data_nasc, nome, funcao, nivel) VALUES ('12345678915', NULL, '2000-01-13', 'Liendri', 'SUP_LIMPEZA', 'S');
INSERT INTO public.funcionario (cpf, superior_cpf, data_nasc, nome, funcao, nivel) VALUES ('12345678916', '12345678915', '2001-01-11', 'Gustevi', 'LIMPEZA', 'J');
INSERT INTO public.funcionario (cpf, superior_cpf, data_nasc, nome, funcao, nivel) VALUES ('12345678917', '12345678914', '1999-08-31', 'Cleide', 'LIMPEZA', 'P');
INSERT INTO public.funcionario (cpf, superior_cpf, data_nasc, nome, funcao, nivel) VALUES ('12345678918', '12345678911', '1999-04-27', 'DanyBenny', 'SUP_LIMPEZA', 'S');
INSERT INTO public.funcionario (cpf, superior_cpf, data_nasc, nome, funcao, nivel) VALUES ('12345678919', NULL, '1995-04-24', 'Jesga', 'SUP_LIMPEZA', 'P');
INSERT INTO public.funcionario (cpf, superior_cpf, data_nasc, nome, funcao, nivel) VALUES ('12345678920', '12345678915', '1998-04-02', 'Henrisgue', 'LIMPEZA', 'J');
INSERT INTO public.funcionario (cpf, superior_cpf, data_nasc, nome, funcao, nivel) VALUES ('12345678921', NULL, '1996-02-24', 'Mathelus', 'SUP_LIMPEZA', 'S');
INSERT INTO public.funcionario (cpf, superior_cpf, data_nasc, nome, funcao, nivel) VALUES ('12345678922', NULL, '1999-03-16', 'Robsu', 'SUP_LIMPEZA', 'S');
INSERT INTO public.funcionario (cpf, superior_cpf, data_nasc, nome, funcao, nivel) VALUES ('12345678923', NULL, '2020-09-21', 'Heloísa', 'SUP_LIMPEZA', 'S');
INSERT INTO public.funcionario (cpf, superior_cpf, data_nasc, nome, funcao, nivel) VALUES ('32323232911', NULL, '1967-06-22', 'Mirieny', 'SUP_LIMPEZA', 'S');
INSERT INTO public.funcionario (cpf, superior_cpf, data_nasc, nome, funcao, nivel) VALUES ('98765432122', '32323232911', '1998-08-27', 'Jé', 'LIMPEZA', 'P');
INSERT INTO public.funcionario (cpf, superior_cpf, data_nasc, nome, funcao, nivel) VALUES ('98765432111', '32323232911', '1988-07-30', 'Niela', 'LIMPEZA', 'P');


--
-- Data for Name: tarefas; Type: TABLE DATA; Schema: public; Owner: rodrigoec
--

INSERT INTO public.tarefas (id, descricao, func_resp_cpf, prioridade, status) VALUES ('2147483653', 'limpar portas do 1o andar', '32323232911', 2, 'P');
INSERT INTO public.tarefas (id, descricao, func_resp_cpf, prioridade, status) VALUES ('2147483651', 'limpar portas da entrada principal', '32323232911', 5, 'P');
INSERT INTO public.tarefas (id, descricao, func_resp_cpf, prioridade, status) VALUES ('2147483652', 'limpar portas da entrada principal', '32323232911', 5, 'P');
INSERT INTO public.tarefas (id, descricao, func_resp_cpf, prioridade, status) VALUES ('2147482353', 'limpar portas do 1o andar', '32323232911', 2, 'P');
INSERT INTO public.tarefas (id, descricao, func_resp_cpf, prioridade, status) VALUES ('2147482355', 'limpar portas do 1o andar', '98765432111', 2, 'P');
INSERT INTO public.tarefas (id, descricao, func_resp_cpf, prioridade, status) VALUES ('2147482357', 'Comprar cadernos', '98765432111', 2, 'C');
INSERT INTO public.tarefas (id, descricao, func_resp_cpf, prioridade, status) VALUES ('2147482345', 'Comprar uma cadeira, pq a minha ta me matando', '98765432111', 2, 'E');


--
-- Name: funcionario_pkey; Type: CONSTRAINT; Schema: public; Owner: rodrigoec
--

ALTER TABLE ONLY public.funcionario
    ADD CONSTRAINT funcionario_pkey PRIMARY KEY (cpf);


--
-- Name: tarefas_pkey; Type: CONSTRAINT; Schema: public; Owner: rodrigoec
--

ALTER TABLE ONLY public.tarefas
    ADD CONSTRAINT tarefas_pkey PRIMARY KEY (id);


--
-- Name: funcionario_skey; Type: FK CONSTRAINT; Schema: public; Owner: rodrigoec
--

ALTER TABLE ONLY public.funcionario
    ADD CONSTRAINT funcionario_skey FOREIGN KEY (superior_cpf) REFERENCES public.funcionario(cpf);


--
-- Name: tarefa_fkey_func_resp_cpf; Type: FK CONSTRAINT; Schema: public; Owner: rodrigoec
--

ALTER TABLE ONLY public.tarefas
    ADD CONSTRAINT tarefa_fkey_func_resp_cpf FOREIGN KEY (func_resp_cpf) REFERENCES public.funcionario(cpf) ON DELETE SET NULL;


--
-- PostgreSQL database dump complete
--

