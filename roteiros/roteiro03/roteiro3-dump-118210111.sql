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

ALTER TABLE ONLY public.venda DROP CONSTRAINT venda_fkey_cpf_funcionario;
ALTER TABLE ONLY public.venda DROP CONSTRAINT venda_fkey_cpf_cliente;
ALTER TABLE ONLY public.funcionario DROP CONSTRAINT funcionario_skey_id_farmacia;
ALTER TABLE ONLY public.entrega DROP CONSTRAINT entrega_fkey_rua_numero_bairro;
ALTER TABLE ONLY public.entrega DROP CONSTRAINT entrega_fkey_medicamento_id;
ALTER TABLE ONLY public.endereco DROP CONSTRAINT endereco_fkey_cpf_cliente;
ALTER TABLE ONLY public.venda DROP CONSTRAINT venda_pkey;
ALTER TABLE ONLY public.medicamento DROP CONSTRAINT medicamento_pkey;
ALTER TABLE ONLY public.funcionario DROP CONSTRAINT funcionario_pkey;
ALTER TABLE ONLY public.funcionario DROP CONSTRAINT funcionario_funcao_unica;
ALTER TABLE ONLY public.farmacia DROP CONSTRAINT farmcia_chk_unicidade_bairro;
ALTER TABLE ONLY public.farmacia DROP CONSTRAINT farmacia_pkey;
ALTER TABLE ONLY public.farmacia DROP CONSTRAINT farmacia_chk_unicidade_tipo;
ALTER TABLE ONLY public.entrega DROP CONSTRAINT entre_pkey;
ALTER TABLE ONLY public.endereco DROP CONSTRAINT endereco_pkey;
ALTER TABLE ONLY public.cliente DROP CONSTRAINT cliente_pkey;
DROP TABLE public.venda;
DROP TABLE public.medicamento;
DROP TABLE public.funcionario;
DROP TABLE public.farmacia;
DROP TABLE public.entrega;
DROP TABLE public.endereco;
DROP TABLE public.cliente;
DROP TYPE public.estados;
DROP EXTENSION btree_gist;
DROP EXTENSION plpgsql;
DROP SCHEMA public;
--
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO postgres;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: btree_gist; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS btree_gist WITH SCHEMA public;


--
-- Name: EXTENSION btree_gist; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION btree_gist IS 'support for indexing common datatypes in GiST';


--
-- Name: estados; Type: TYPE; Schema: public; Owner: rodrigoec
--

CREATE TYPE public.estados AS ENUM (
    'PB',
    'PE',
    'RN',
    'MA',
    'BA',
    'SE',
    'CE',
    'AL',
    'PI'
);


ALTER TYPE public.estados OWNER TO rodrigoec;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: cliente; Type: TABLE; Schema: public; Owner: rodrigoec
--

CREATE TABLE public.cliente (
    cpf character(11) NOT NULL,
    nome text,
    idade numeric,
    CONSTRAINT cliente_chk_idade_escopo CHECK ((idade > (17)::numeric))
);


ALTER TABLE public.cliente OWNER TO rodrigoec;

--
-- Name: endereco; Type: TABLE; Schema: public; Owner: rodrigoec
--

CREATE TABLE public.endereco (
    rua text NOT NULL,
    numero integer NOT NULL,
    bairro text NOT NULL,
    tipo character varying(10) NOT NULL,
    cpf_cliente character(11),
    CONSTRAINT endereco_chk_tipo CHECK ((((tipo)::text = 'residência'::text) OR ((tipo)::text = 'trabalho'::text) OR ((tipo)::text = 'outro'::text)))
);


ALTER TABLE public.endereco OWNER TO rodrigoec;

--
-- Name: entrega; Type: TABLE; Schema: public; Owner: rodrigoec
--

CREATE TABLE public.entrega (
    id_venda integer NOT NULL,
    rua_endereco text NOT NULL,
    numero_endereco integer NOT NULL,
    bairro_endereco text NOT NULL,
    medicamento_id integer NOT NULL
);


ALTER TABLE public.entrega OWNER TO rodrigoec;

--
-- Name: farmacia; Type: TABLE; Schema: public; Owner: rodrigoec
--

CREATE TABLE public.farmacia (
    id integer NOT NULL,
    tipo character varying(6) NOT NULL,
    estado public.estados,
    bairro text NOT NULL,
    CONSTRAINT farmacia_chk_tipo_escopo CHECK ((((tipo)::text = 'sede'::text) OR ((tipo)::text = 'filial'::text)))
);


ALTER TABLE public.farmacia OWNER TO rodrigoec;

--
-- Name: funcionario; Type: TABLE; Schema: public; Owner: rodrigoec
--

CREATE TABLE public.funcionario (
    cpf character(11) NOT NULL,
    nome text NOT NULL,
    id_farmacia integer,
    funcao character varying(25) NOT NULL,
    gerente text,
    CONSTRAINT funcionario_chk_gerente_escopo CHECK (((gerente = 'gerente'::text) OR (gerente = NULL::text))),
    CONSTRAINT funcionario_chk_gerente_funcao CHECK ((((gerente = 'gerente'::text) AND ((funcao)::text = 'farmaceutico'::text)) OR ((gerente = 'gerente'::text) AND ((funcao)::text = 'administrador'::text)) OR ((gerente = NULL::text) AND ((funcao)::text = 'vendedor'::text)) OR ((gerente = NULL::text) AND ((funcao)::text = 'entregador'::text)) OR ((gerente = NULL::text) AND ((funcao)::text = 'caixa'::text)))),
    CONSTRAINT funcionario_escopo_funcao CHECK ((((funcao)::text = 'farmaceutico'::text) OR ((funcao)::text = 'vendedor'::text) OR ((funcao)::text = 'entregador'::text) OR ((funcao)::text = 'caixa'::text) OR ((funcao)::text = 'administrador'::text)))
);


ALTER TABLE public.funcionario OWNER TO rodrigoec;

--
-- Name: medicamento; Type: TABLE; Schema: public; Owner: rodrigoec
--

CREATE TABLE public.medicamento (
    id integer NOT NULL,
    venda_exclusiva boolean NOT NULL
);


ALTER TABLE public.medicamento OWNER TO rodrigoec;

--
-- Name: venda; Type: TABLE; Schema: public; Owner: rodrigoec
--

CREATE TABLE public.venda (
    id integer NOT NULL,
    cpf_funcionario character(11) NOT NULL,
    cpf_cliente character(11) NOT NULL
);


ALTER TABLE public.venda OWNER TO rodrigoec;

--
-- Data for Name: cliente; Type: TABLE DATA; Schema: public; Owner: rodrigoec
--

INSERT INTO public.cliente (cpf, nome, idade) VALUES ('07475168426', 'Rodrigo', 20);
INSERT INTO public.cliente (cpf, nome, idade) VALUES ('07475168429', 'Jose', 39);


--
-- Data for Name: endereco; Type: TABLE DATA; Schema: public; Owner: rodrigoec
--

INSERT INTO public.endereco (rua, numero, bairro, tipo, cpf_cliente) VALUES ('Alto Branco', 410, 'Lauritzen', 'residência', '07475168426');
INSERT INTO public.endereco (rua, numero, bairro, tipo, cpf_cliente) VALUES ('Rua jumbs dumbs', 410, 'Catolé', 'residência', '07475168426');
INSERT INTO public.endereco (rua, numero, bairro, tipo, cpf_cliente) VALUES ('Rua jumbs dumbs', 418, 'Catolé', 'residência', '07475168426');


--
-- Data for Name: entrega; Type: TABLE DATA; Schema: public; Owner: rodrigoec
--

INSERT INTO public.entrega (id_venda, rua_endereco, numero_endereco, bairro_endereco, medicamento_id) VALUES (741852753, 'Rua jumbs dumbs', 418, 'Catolé', 951236874);


--
-- Data for Name: farmacia; Type: TABLE DATA; Schema: public; Owner: rodrigoec
--

INSERT INTO public.farmacia (id, tipo, estado, bairro) VALUES (1547, 'sede', 'PB', 'Alto branco');
INSERT INTO public.farmacia (id, tipo, estado, bairro) VALUES (1550, 'filial', 'PE', 'Bairro de recife');


--
-- Data for Name: funcionario; Type: TABLE DATA; Schema: public; Owner: rodrigoec
--

INSERT INTO public.funcionario (cpf, nome, id_farmacia, funcao, gerente) VALUES ('07475168420', 'Rodrigo', 1547, 'farmaceutico', 'gerente');
INSERT INTO public.funcionario (cpf, nome, id_farmacia, funcao, gerente) VALUES ('07475168425', 'Paulo', 1547, 'caixa', NULL);


--
-- Data for Name: medicamento; Type: TABLE DATA; Schema: public; Owner: rodrigoec
--

INSERT INTO public.medicamento (id, venda_exclusiva) VALUES (951236874, true);
INSERT INTO public.medicamento (id, venda_exclusiva) VALUES (951236875, false);


--
-- Data for Name: venda; Type: TABLE DATA; Schema: public; Owner: rodrigoec
--

INSERT INTO public.venda (id, cpf_funcionario, cpf_cliente) VALUES (741852963, '07475168420', '07475168429');


--
-- Name: cliente_pkey; Type: CONSTRAINT; Schema: public; Owner: rodrigoec
--

ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT cliente_pkey PRIMARY KEY (cpf);


--
-- Name: endereco_pkey; Type: CONSTRAINT; Schema: public; Owner: rodrigoec
--

ALTER TABLE ONLY public.endereco
    ADD CONSTRAINT endereco_pkey PRIMARY KEY (rua, numero, bairro);


--
-- Name: entre_pkey; Type: CONSTRAINT; Schema: public; Owner: rodrigoec
--

ALTER TABLE ONLY public.entrega
    ADD CONSTRAINT entre_pkey PRIMARY KEY (id_venda, rua_endereco, numero_endereco, bairro_endereco, medicamento_id);


--
-- Name: farmacia_chk_unicidade_tipo; Type: CONSTRAINT; Schema: public; Owner: rodrigoec
--

ALTER TABLE ONLY public.farmacia
    ADD CONSTRAINT farmacia_chk_unicidade_tipo EXCLUDE USING gist (tipo WITH =) WHERE (((tipo)::text = 'sede'::text));


--
-- Name: farmacia_pkey; Type: CONSTRAINT; Schema: public; Owner: rodrigoec
--

ALTER TABLE ONLY public.farmacia
    ADD CONSTRAINT farmacia_pkey PRIMARY KEY (id);


--
-- Name: farmcia_chk_unicidade_bairro; Type: CONSTRAINT; Schema: public; Owner: rodrigoec
--

ALTER TABLE ONLY public.farmacia
    ADD CONSTRAINT farmcia_chk_unicidade_bairro UNIQUE (bairro);


--
-- Name: funcionario_funcao_unica; Type: CONSTRAINT; Schema: public; Owner: rodrigoec
--

ALTER TABLE ONLY public.funcionario
    ADD CONSTRAINT funcionario_funcao_unica EXCLUDE USING gist (gerente WITH =, id_farmacia WITH =) WHERE ((gerente = 'gerente'::text));


--
-- Name: funcionario_pkey; Type: CONSTRAINT; Schema: public; Owner: rodrigoec
--

ALTER TABLE ONLY public.funcionario
    ADD CONSTRAINT funcionario_pkey PRIMARY KEY (cpf);


--
-- Name: medicamento_pkey; Type: CONSTRAINT; Schema: public; Owner: rodrigoec
--

ALTER TABLE ONLY public.medicamento
    ADD CONSTRAINT medicamento_pkey PRIMARY KEY (id);


--
-- Name: venda_pkey; Type: CONSTRAINT; Schema: public; Owner: rodrigoec
--

ALTER TABLE ONLY public.venda
    ADD CONSTRAINT venda_pkey PRIMARY KEY (id);


--
-- Name: endereco_fkey_cpf_cliente; Type: FK CONSTRAINT; Schema: public; Owner: rodrigoec
--

ALTER TABLE ONLY public.endereco
    ADD CONSTRAINT endereco_fkey_cpf_cliente FOREIGN KEY (cpf_cliente) REFERENCES public.cliente(cpf);


--
-- Name: entrega_fkey_medicamento_id; Type: FK CONSTRAINT; Schema: public; Owner: rodrigoec
--

ALTER TABLE ONLY public.entrega
    ADD CONSTRAINT entrega_fkey_medicamento_id FOREIGN KEY (medicamento_id) REFERENCES public.medicamento(id);


--
-- Name: entrega_fkey_rua_numero_bairro; Type: FK CONSTRAINT; Schema: public; Owner: rodrigoec
--

ALTER TABLE ONLY public.entrega
    ADD CONSTRAINT entrega_fkey_rua_numero_bairro FOREIGN KEY (rua_endereco, numero_endereco, bairro_endereco) REFERENCES public.endereco(rua, numero, bairro);


--
-- Name: funcionario_skey_id_farmacia; Type: FK CONSTRAINT; Schema: public; Owner: rodrigoec
--

ALTER TABLE ONLY public.funcionario
    ADD CONSTRAINT funcionario_skey_id_farmacia FOREIGN KEY (id_farmacia) REFERENCES public.farmacia(id);


--
-- Name: venda_fkey_cpf_cliente; Type: FK CONSTRAINT; Schema: public; Owner: rodrigoec
--

ALTER TABLE ONLY public.venda
    ADD CONSTRAINT venda_fkey_cpf_cliente FOREIGN KEY (cpf_cliente) REFERENCES public.cliente(cpf);


--
-- Name: venda_fkey_cpf_funcionario; Type: FK CONSTRAINT; Schema: public; Owner: rodrigoec
--

ALTER TABLE ONLY public.venda
    ADD CONSTRAINT venda_fkey_cpf_funcionario FOREIGN KEY (cpf_funcionario) REFERENCES public.funcionario(cpf);


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

-- 
-- COMANDOS ADICIONAIS
--

-- Permite
INSERT INTO farmacia(id, tipo, estado, bairro) VALUES (1547, 'sede', 'PB', 'Alto branco');
-- Permite
INSERT INTO farmacia(id, tipo, estado, bairro) VALUES (1550, 'filial', 'PE', 'Bairro de recife');
-- Não permite pelo fato de já existir uma farmacia nesse bairro
INSERT INTO farmacia(id, tipo, estado, bairro) VALUES (1548, 'filial', 'PB', 'Alto branco');
-- Não permite pelo fato de ja existir uma sede
INSERT INTO farmacia(id, tipo, estado, bairro) VALUES (1549, 'sede', 'PB', 'Catolé');
-- Permite
INSERT INTO funcionario(cpf, nome, id_farmacia, funcao, gerente) VALUES ('07475168420', 'Rodrigo', 1547, 'farmaceutico', 'gerente');
-- Permite
INSERT INTO funcionario(cpf, nome, id_farmacia, funcao, gerente) VALUES ('07475168425', 'Paulo', 1547, 'caixa', NULL);
-- Não permite, uma vez que caixas não podem ser gerentes
INSERT INTO funcionario(cpf, nome, id_farmacia, funcao, gerente) VALUES ('07475168427', 'Cabrimu', 1547, 'caixa', 'gerente');
-- Permite
INSERT INTO cliente(cpf, nome, idade) VALUES ('07475168426', 'Rodrigo', 20);
-- Permite
INSERT INTO cliente(cpf, nome, idade) VALUES ('07475168429', 'Jose', 39);
-- Não permite por ser menor de idade
INSERT INTO cliente(cpf, nome, idade) VALUES ('07475168426', 'Rodrigo', 17);
-- Permite
INSERT INTO endereco(rua, numero, bairro, tipo, cpf_cliente) VALUES ('Alto Branco', 417, 'Lauritzen', 'residência', '07475168426');
-- Permite, uma vez que um cliente pode ter mais de um endereço
INSERT INTO endereco(rua, numero, bairro, tipo, cpf_cliente) VALUES ('Rua jumbs dumbs', 418, 'Catolé', 'residência', '07475168426'); 
-- Não permite uma por sair do escopo do tipo do endereço
INSERT INTO endereco(rua, numero, bairro, tipo, cpf_cliente) VALUES ('Rua prex max', 415, 'Catolé', 'hotel', '07475168426'); 
-- Permite
INSERT INTO medicamento(id, venda_exclusiva) VALUES (951236874, TRUE);
-- Permite
INSERT INTO medicamento(id, venda_exclusiva) VALUES (951236875, FALSE);
-- Não permite por sair do escopo de venda_exclusiva
INSERT INTO medicamento(id, venda_exclusiva) VALUES (951236875, NULL);
-- Permite
INSERT INTO venda(id, cpf_funcionario, cpf_cliente) VALUES (741852963, '07475168420', '07475168429');
-- Não permite, uma vez que o funcionario não pode ser NULL
INSERT INTO venda(id, cpf_funcionario, cpf_cliente) VALUES (741852967, NULL, '07475168429');
-- Não permite, uma vez que não faz sentido fazer a venda para um cliente nulo
INSERT INTO venda(id, cpf_funcionario, cpf_cliente) VALUES (741852969, '07475168420', NULL);
-- Permite
INSERT INTO entrega(id_venda, rua_endereco, numero_endereco, bairro_endereco, medicamento_id) VALUES (741852753, 'Rua jumbs dumbs', 418, 'Catolé', 951236874);
-- Não permite por endereço não estar cadastrado
INSERT INTO entrega(id_venda, rua_endereco, numero_endereco, bairro_endereco, medicamento_id) VALUES (741852757, 'Rua jumbs dumbs', 814, 'Catolé', 951236874);
-- Não permite por medicamente não estar cadastrado
INSERT INTO entrega(id_venda, rua_endereco, numero_endereco, bairro_endereco, medicamento_id) VALUES (741852757, 'Rua jumbs dumbs', 418, 'Catolé', 9536874);

