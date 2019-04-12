--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.14
-- Dumped by pg_dump version 9.5.14

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

ALTER TABLE ONLY public.venda DROP CONSTRAINT venda_id_medicamento_fkey;
ALTER TABLE ONLY public.venda DROP CONSTRAINT venda_cpf_vendedor_fkey;
ALTER TABLE ONLY public.venda DROP CONSTRAINT venda_cpf_cliente_fkey;
ALTER TABLE ONLY public.funcionario_farmacia DROP CONSTRAINT funcionario_farmacia_id_farmacia_fkey;
ALTER TABLE ONLY public.funcionario_farmacia DROP CONSTRAINT funcionario_farmacia_cpf_funcionario_fkey;
ALTER TABLE ONLY public.entrega DROP CONSTRAINT entrega_id_endereco_entrega_fkey;
ALTER TABLE ONLY public.endereco_cliente DROP CONSTRAINT endereco_cliente_cpf_cliente_fkey;
ALTER TABLE ONLY public.venda DROP CONSTRAINT venda_pkey;
ALTER TABLE ONLY public.farmacia DROP CONSTRAINT unica_farmacia_por_bairro;
ALTER TABLE ONLY public.farmacia DROP CONSTRAINT sede_unica;
ALTER TABLE ONLY public.medicamento DROP CONSTRAINT medicamento_pkey;
ALTER TABLE ONLY public.funcionario DROP CONSTRAINT funcionario_pkey;
ALTER TABLE ONLY public.funcionario_farmacia DROP CONSTRAINT funcionario_farmacia_pkey;
ALTER TABLE ONLY public.funcionario_farmacia DROP CONSTRAINT funcionario_farmacia_cpf_funcionario_key;
ALTER TABLE ONLY public.farmacia DROP CONSTRAINT farmacia_pkey;
ALTER TABLE ONLY public.entrega DROP CONSTRAINT entrega_pkey;
ALTER TABLE ONLY public.endereco_cliente DROP CONSTRAINT endereco_cliente_pkey;
ALTER TABLE ONLY public.cliente DROP CONSTRAINT cliente_pkey;
ALTER TABLE public.venda ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.medicamento ALTER COLUMN id_medicamento DROP DEFAULT;
ALTER TABLE public.farmacia ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.entrega ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.endereco_cliente ALTER COLUMN id DROP DEFAULT;
DROP SEQUENCE public.venda_id_seq;
DROP TABLE public.venda;
DROP SEQUENCE public.medicamento_id_medicamento_seq;
DROP TABLE public.medicamento;
DROP TABLE public.funcionario_farmacia;
DROP TABLE public.funcionario;
DROP SEQUENCE public.farmacia_id_seq;
DROP TABLE public.farmacia;
DROP SEQUENCE public.entrega_id_seq;
DROP TABLE public.entrega;
DROP SEQUENCE public.endereco_cliente_id_seq;
DROP TABLE public.endereco_cliente;
DROP TABLE public.cliente;
DROP TYPE public.tipo_func_valido;
DROP TYPE public.estados_validos;
DROP TYPE public.endereco_valido;
DROP DOMAIN public.cpf_valido;
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
-- Name: cpf_valido; Type: DOMAIN; Schema: public; Owner: paulo
--

CREATE DOMAIN public.cpf_valido AS character(11) NOT NULL
	CONSTRAINT cpf_valido_check CHECK ((char_length(VALUE) = 11));


ALTER DOMAIN public.cpf_valido OWNER TO paulo;

--
-- Name: endereco_valido; Type: TYPE; Schema: public; Owner: paulo
--

CREATE TYPE public.endereco_valido AS ENUM (
    'R',
    'T',
    'O'
);


ALTER TYPE public.endereco_valido OWNER TO paulo;

--
-- Name: estados_validos; Type: TYPE; Schema: public; Owner: paulo
--

CREATE TYPE public.estados_validos AS ENUM (
    'AL',
    'BA',
    'CE',
    'MA',
    'PB',
    'PE',
    'PI',
    'RN',
    'SE'
);


ALTER TYPE public.estados_validos OWNER TO paulo;

--
-- Name: tipo_func_valido; Type: TYPE; Schema: public; Owner: paulo
--

CREATE TYPE public.tipo_func_valido AS ENUM (
    'F',
    'V',
    'E',
    'C',
    'A'
);


ALTER TYPE public.tipo_func_valido OWNER TO paulo;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: cliente; Type: TABLE; Schema: public; Owner: paulo
--

CREATE TABLE public.cliente (
    cpf_cliente public.cpf_valido NOT NULL,
    nome character varying(20) NOT NULL,
    sobrenome character varying(20) NOT NULL,
    idade integer,
    CONSTRAINT cliente_idade_check CHECK ((idade >= 18))
);


ALTER TABLE public.cliente OWNER TO paulo;

--
-- Name: endereco_cliente; Type: TABLE; Schema: public; Owner: paulo
--

CREATE TABLE public.endereco_cliente (
    id integer NOT NULL,
    cpf_cliente public.cpf_valido,
    tipo_endereco public.endereco_valido,
    cidade character varying(20),
    estado public.estados_validos,
    rua character varying(20),
    bairro character varying(20),
    numero smallint
);


ALTER TABLE public.endereco_cliente OWNER TO paulo;

--
-- Name: endereco_cliente_id_seq; Type: SEQUENCE; Schema: public; Owner: paulo
--

CREATE SEQUENCE public.endereco_cliente_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.endereco_cliente_id_seq OWNER TO paulo;

--
-- Name: endereco_cliente_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: paulo
--

ALTER SEQUENCE public.endereco_cliente_id_seq OWNED BY public.endereco_cliente.id;


--
-- Name: entrega; Type: TABLE; Schema: public; Owner: paulo
--

CREATE TABLE public.entrega (
    id integer NOT NULL,
    id_endereco_entrega integer NOT NULL,
    id_entrega integer
);


ALTER TABLE public.entrega OWNER TO paulo;

--
-- Name: entrega_id_seq; Type: SEQUENCE; Schema: public; Owner: paulo
--

CREATE SEQUENCE public.entrega_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.entrega_id_seq OWNER TO paulo;

--
-- Name: entrega_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: paulo
--

ALTER SEQUENCE public.entrega_id_seq OWNED BY public.entrega.id;


--
-- Name: farmacia; Type: TABLE; Schema: public; Owner: paulo
--

CREATE TABLE public.farmacia (
    id integer NOT NULL,
    tipo character(1) NOT NULL,
    gerente_cpf public.cpf_valido NOT NULL,
    gerente_func character(1) NOT NULL,
    cidade character varying(20) NOT NULL,
    bairro character varying(20) NOT NULL,
    estado public.estados_validos NOT NULL,
    CONSTRAINT farmacia_gerente_func_check CHECK ((gerente_func = ANY (ARRAY['A'::bpchar, 'F'::bpchar]))),
    CONSTRAINT farmacia_tipo_check CHECK ((tipo = ANY (ARRAY['S'::bpchar, 'F'::bpchar])))
);


ALTER TABLE public.farmacia OWNER TO paulo;

--
-- Name: farmacia_id_seq; Type: SEQUENCE; Schema: public; Owner: paulo
--

CREATE SEQUENCE public.farmacia_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.farmacia_id_seq OWNER TO paulo;

--
-- Name: farmacia_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: paulo
--

ALTER SEQUENCE public.farmacia_id_seq OWNED BY public.farmacia.id;


--
-- Name: funcionario; Type: TABLE; Schema: public; Owner: paulo
--

CREATE TABLE public.funcionario (
    cpf_func public.cpf_valido NOT NULL,
    nome character varying(20) NOT NULL,
    id_farmacia integer,
    tipo_func public.tipo_func_valido
);


ALTER TABLE public.funcionario OWNER TO paulo;

--
-- Name: funcionario_farmacia; Type: TABLE; Schema: public; Owner: paulo
--

CREATE TABLE public.funcionario_farmacia (
    cpf_funcionario public.cpf_valido NOT NULL,
    id_farmacia integer NOT NULL
);


ALTER TABLE public.funcionario_farmacia OWNER TO paulo;

--
-- Name: medicamento; Type: TABLE; Schema: public; Owner: paulo
--

CREATE TABLE public.medicamento (
    id_medicamento integer NOT NULL,
    restricao_venda boolean NOT NULL,
    nome character varying(20) NOT NULL
);


ALTER TABLE public.medicamento OWNER TO paulo;

--
-- Name: medicamento_id_medicamento_seq; Type: SEQUENCE; Schema: public; Owner: paulo
--

CREATE SEQUENCE public.medicamento_id_medicamento_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.medicamento_id_medicamento_seq OWNER TO paulo;

--
-- Name: medicamento_id_medicamento_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: paulo
--

ALTER SEQUENCE public.medicamento_id_medicamento_seq OWNED BY public.medicamento.id_medicamento;


--
-- Name: venda; Type: TABLE; Schema: public; Owner: paulo
--

CREATE TABLE public.venda (
    id integer NOT NULL,
    id_medicamento integer NOT NULL,
    cpf_vendedor public.cpf_valido,
    cpf_cliente public.cpf_valido,
    usa_receita boolean NOT NULL,
    id_entrega integer NOT NULL
);


ALTER TABLE public.venda OWNER TO paulo;

--
-- Name: venda_id_seq; Type: SEQUENCE; Schema: public; Owner: paulo
--

CREATE SEQUENCE public.venda_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.venda_id_seq OWNER TO paulo;

--
-- Name: venda_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: paulo
--

ALTER SEQUENCE public.venda_id_seq OWNED BY public.venda.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: paulo
--

ALTER TABLE ONLY public.endereco_cliente ALTER COLUMN id SET DEFAULT nextval('public.endereco_cliente_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: paulo
--

ALTER TABLE ONLY public.entrega ALTER COLUMN id SET DEFAULT nextval('public.entrega_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: paulo
--

ALTER TABLE ONLY public.farmacia ALTER COLUMN id SET DEFAULT nextval('public.farmacia_id_seq'::regclass);


--
-- Name: id_medicamento; Type: DEFAULT; Schema: public; Owner: paulo
--

ALTER TABLE ONLY public.medicamento ALTER COLUMN id_medicamento SET DEFAULT nextval('public.medicamento_id_medicamento_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: paulo
--

ALTER TABLE ONLY public.venda ALTER COLUMN id SET DEFAULT nextval('public.venda_id_seq'::regclass);


--
-- Data for Name: cliente; Type: TABLE DATA; Schema: public; Owner: paulo
--

INSERT INTO public.cliente (cpf_cliente, nome, sobrenome, idade) VALUES ('12345678909', 'João', 'Alves', 52);
INSERT INTO public.cliente (cpf_cliente, nome, sobrenome, idade) VALUES ('12345678908', 'Josefa', 'Pinheiro', 35);


--
-- Data for Name: endereco_cliente; Type: TABLE DATA; Schema: public; Owner: paulo
--

INSERT INTO public.endereco_cliente (id, cpf_cliente, tipo_endereco, cidade, estado, rua, bairro, numero) VALUES (1, '12345678909', 'R', 'Fagundes', 'PB', 'Rua dos Pombos', 'Centro', 0);
INSERT INTO public.endereco_cliente (id, cpf_cliente, tipo_endereco, cidade, estado, rua, bairro, numero) VALUES (2, '12345678909', 'R', 'João Pessoa', 'PB', 'Ruy Carneiro', 'Centro', 10);


--
-- Name: endereco_cliente_id_seq; Type: SEQUENCE SET; Schema: public; Owner: paulo
--

SELECT pg_catalog.setval('public.endereco_cliente_id_seq', 3, true);


--
-- Data for Name: entrega; Type: TABLE DATA; Schema: public; Owner: paulo
--



--
-- Name: entrega_id_seq; Type: SEQUENCE SET; Schema: public; Owner: paulo
--

SELECT pg_catalog.setval('public.entrega_id_seq', 1, false);


--
-- Data for Name: farmacia; Type: TABLE DATA; Schema: public; Owner: paulo
--

INSERT INTO public.farmacia (id, tipo, gerente_cpf, gerente_func, cidade, bairro, estado) VALUES (1, 'S', '12345678902', 'A', 'Campina Grande', 'Alto Branco', 'PB');


--
-- Name: farmacia_id_seq; Type: SEQUENCE SET; Schema: public; Owner: paulo
--

SELECT pg_catalog.setval('public.farmacia_id_seq', 3, true);


--
-- Data for Name: funcionario; Type: TABLE DATA; Schema: public; Owner: paulo
--

INSERT INTO public.funcionario (cpf_func, nome, id_farmacia, tipo_func) VALUES ('12345678905', 'Antenor', 1, 'V');
INSERT INTO public.funcionario (cpf_func, nome, id_farmacia, tipo_func) VALUES ('12345678901', 'Joao', NULL, NULL);
INSERT INTO public.funcionario (cpf_func, nome, id_farmacia, tipo_func) VALUES ('12345678902', 'Pedro', 0, 'A');


--
-- Data for Name: funcionario_farmacia; Type: TABLE DATA; Schema: public; Owner: paulo
--

INSERT INTO public.funcionario_farmacia (cpf_funcionario, id_farmacia) VALUES ('12345678902', 1);


--
-- Data for Name: medicamento; Type: TABLE DATA; Schema: public; Owner: paulo
--

INSERT INTO public.medicamento (id_medicamento, restricao_venda, nome) VALUES (1, false, 'dipirona');
INSERT INTO public.medicamento (id_medicamento, restricao_venda, nome) VALUES (2, false, 'tylenol');
INSERT INTO public.medicamento (id_medicamento, restricao_venda, nome) VALUES (3, true, 'omeprazol');


--
-- Name: medicamento_id_medicamento_seq; Type: SEQUENCE SET; Schema: public; Owner: paulo
--

SELECT pg_catalog.setval('public.medicamento_id_medicamento_seq', 3, true);


--
-- Data for Name: venda; Type: TABLE DATA; Schema: public; Owner: paulo
--

INSERT INTO public.venda (id, id_medicamento, cpf_vendedor, cpf_cliente, usa_receita, id_entrega) VALUES (1, 1, '12345678905', '12345678909', false, 1);
INSERT INTO public.venda (id, id_medicamento, cpf_vendedor, cpf_cliente, usa_receita, id_entrega) VALUES (2, 1, '12345678905', '12345678909', false, 2);


--
-- Name: venda_id_seq; Type: SEQUENCE SET; Schema: public; Owner: paulo
--

SELECT pg_catalog.setval('public.venda_id_seq', 2, true);


--
-- Name: cliente_pkey; Type: CONSTRAINT; Schema: public; Owner: paulo
--

ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT cliente_pkey PRIMARY KEY (cpf_cliente);


--
-- Name: endereco_cliente_pkey; Type: CONSTRAINT; Schema: public; Owner: paulo
--

ALTER TABLE ONLY public.endereco_cliente
    ADD CONSTRAINT endereco_cliente_pkey PRIMARY KEY (id);


--
-- Name: entrega_pkey; Type: CONSTRAINT; Schema: public; Owner: paulo
--

ALTER TABLE ONLY public.entrega
    ADD CONSTRAINT entrega_pkey PRIMARY KEY (id);


--
-- Name: farmacia_pkey; Type: CONSTRAINT; Schema: public; Owner: paulo
--

ALTER TABLE ONLY public.farmacia
    ADD CONSTRAINT farmacia_pkey PRIMARY KEY (id);


--
-- Name: funcionario_farmacia_cpf_funcionario_key; Type: CONSTRAINT; Schema: public; Owner: paulo
--

ALTER TABLE ONLY public.funcionario_farmacia
    ADD CONSTRAINT funcionario_farmacia_cpf_funcionario_key UNIQUE (cpf_funcionario);


--
-- Name: funcionario_farmacia_pkey; Type: CONSTRAINT; Schema: public; Owner: paulo
--

ALTER TABLE ONLY public.funcionario_farmacia
    ADD CONSTRAINT funcionario_farmacia_pkey PRIMARY KEY (cpf_funcionario, id_farmacia);


--
-- Name: funcionario_pkey; Type: CONSTRAINT; Schema: public; Owner: paulo
--

ALTER TABLE ONLY public.funcionario
    ADD CONSTRAINT funcionario_pkey PRIMARY KEY (cpf_func);


--
-- Name: medicamento_pkey; Type: CONSTRAINT; Schema: public; Owner: paulo
--

ALTER TABLE ONLY public.medicamento
    ADD CONSTRAINT medicamento_pkey PRIMARY KEY (id_medicamento);


--
-- Name: sede_unica; Type: CONSTRAINT; Schema: public; Owner: paulo
--

ALTER TABLE ONLY public.farmacia
    ADD CONSTRAINT sede_unica EXCLUDE USING gist (tipo WITH =) WHERE ((tipo = 'S'::bpchar));


--
-- Name: unica_farmacia_por_bairro; Type: CONSTRAINT; Schema: public; Owner: paulo
--

ALTER TABLE ONLY public.farmacia
    ADD CONSTRAINT unica_farmacia_por_bairro EXCLUDE USING gist (bairro WITH =, cidade WITH =);


--
-- Name: venda_pkey; Type: CONSTRAINT; Schema: public; Owner: paulo
--

ALTER TABLE ONLY public.venda
    ADD CONSTRAINT venda_pkey PRIMARY KEY (id);


--
-- Name: endereco_cliente_cpf_cliente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: paulo
--

ALTER TABLE ONLY public.endereco_cliente
    ADD CONSTRAINT endereco_cliente_cpf_cliente_fkey FOREIGN KEY (cpf_cliente) REFERENCES public.cliente(cpf_cliente);


--
-- Name: entrega_id_endereco_entrega_fkey; Type: FK CONSTRAINT; Schema: public; Owner: paulo
--

ALTER TABLE ONLY public.entrega
    ADD CONSTRAINT entrega_id_endereco_entrega_fkey FOREIGN KEY (id_endereco_entrega) REFERENCES public.endereco_cliente(id);


--
-- Name: funcionario_farmacia_cpf_funcionario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: paulo
--

ALTER TABLE ONLY public.funcionario_farmacia
    ADD CONSTRAINT funcionario_farmacia_cpf_funcionario_fkey FOREIGN KEY (cpf_funcionario) REFERENCES public.funcionario(cpf_func);


--
-- Name: funcionario_farmacia_id_farmacia_fkey; Type: FK CONSTRAINT; Schema: public; Owner: paulo
--

ALTER TABLE ONLY public.funcionario_farmacia
    ADD CONSTRAINT funcionario_farmacia_id_farmacia_fkey FOREIGN KEY (id_farmacia) REFERENCES public.farmacia(id);


--
-- Name: venda_cpf_cliente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: paulo
--

ALTER TABLE ONLY public.venda
    ADD CONSTRAINT venda_cpf_cliente_fkey FOREIGN KEY (cpf_cliente) REFERENCES public.cliente(cpf_cliente);


--
-- Name: venda_cpf_vendedor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: paulo
--

ALTER TABLE ONLY public.venda
    ADD CONSTRAINT venda_cpf_vendedor_fkey FOREIGN KEY (cpf_vendedor) REFERENCES public.funcionario(cpf_func);


--
-- Name: venda_id_medicamento_fkey; Type: FK CONSTRAINT; Schema: public; Owner: paulo
--

ALTER TABLE ONLY public.venda
    ADD CONSTRAINT venda_id_medicamento_fkey FOREIGN KEY (id_medicamento) REFERENCES public.medicamento(id_medicamento);


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



-- COMANDOS ADICIONAIS



-- INSERINDO FUNCIONÁRIOS
INSERT INTO FUNCIONARIO VALUES ('12345678905', 'Antenor', 1, 'V');

-- insere um funcionário que não está alocado em nenhuma farmácia, logo também nao tem um tipo associado
INSERT INTO FUNCIONARIO VALUES ('12345678901', 'Joao', null, null);

-- insere um funcionário alocado em uma farmácia como administrador
INSERT INTO FUNCIONARIO VALUES ('12345678902', 'Pedro', 0, 'A');

-- insere uma farmacia como sede, não deve aceitar outra inserção com esse mesmo tipo
INSERT INTO FARMACIA (tipo, gerente_cpf, gerente_func, cidade, bairro, estado) VALUES ('S', '12345678902', 'A', 'Campina Grande', 'Alto Branco', 'PB');

-- insere uma segunda farmácia como sede (não funciona)
INSERT INTO FARMACIA (tipo, gerente_cpf, gerente_func, cidade, bairro, estado) VALUES ('S', '12345678902', 'A', 'Campina Grande', 'Bodocongó', 'PB');

-- só pode haver uma farmácia por bairro (não funciona)
INSERT INTO FARMACIA (tipo, gerente_cpf, gerente_func, cidade, bairro, estado) VALUES ('F', '12345678902', 'A', 'Campina Grande', 'Alto Branco', 'PB');

-- validação de que um funcionário só pode trabalhar em uma farmácia
INSERT INTO FUNCIONARIO_FARMACIA VALUES ('12345678902', 1);

-- validação de que um funcionário só pode trabalhar em uma farmácia (não funciona)
INSERT INTO FUNCIONARIO_FARMACIA VALUES ('12345678902', 2);

-- INSERINDO CLIENTES
INSERT INTO CLIENTE VALUES ('12345678909', 'João', 'Alves', 52);
INSERT INTO CLIENTE VALUES ('12345678908', 'Josefa', 'Pinheiro', 35);

-- Inserindo endereço de clientes
INSERT INTO ENDERECO_CLIENTE (cpf_cliente, tipo_endereco, cidade, estado, rua, bairro, numero) VALUES ('12345678909', 'R', 'Fagundes', 'PB', 'Rua dos Pombos', 'Centro', 0);

-- O mesmo funcionário pode ter vários endereços
INSERT INTO ENDERECO_CLIENTE (cpf_cliente, tipo_endereco, cidade, estado, rua, bairro, numero) VALUES ('12345678909', 'R', 'João Pessoa', 'PB', 'Ruy Carneiro', 'Centro', 10);

-- Inserindo endereço de um cliente com tipo inválido (não funciona)
INSERT INTO ENDERECO_CLIENTE (cpf_cliente, tipo_endereco, cidade, estado, rua, bairro, numero) VALUES ('12345678909', 'P', 'Fagundes', 'PB', 'Rua dos Pombos', 'Centro', 0);

-- Inserindo endereço de um cliente que não está cadastrado (não funciona)
INSERT INTO ENDERECO_CLIENTE (cpf_cliente, tipo_endereco, cidade, estado, rua, bairro, numero) VALUES ('12345678910', 'R', 'Fagundes', 'PB', 'Rua dos Pombos', 'Centro', 0);

-- INSERINDO MEDICAMENTOS
INSERT INTO MEDICAMENTO (restricao_venda, nome) VALUES (false, 'dipirona');
INSERT INTO MEDICAMENTO (restricao_venda, nome) VALUES (false, 'tylenol');
INSERT INTO MEDICAMENTO (restricao_venda, nome) VALUES (true, 'omeprazol');


-- Cadastrando vendas
INSERT INTO VENDA (id_medicamento, cpf_vendedor, cpf_cliente, usa_receita, id_entrega) VALUES (1, '12345678905', '12345678909', false, 1);
INSERT INTO VENDA (id_medicamento, cpf_vendedor, cpf_cliente, usa_receita, id_entrega) VALUES (1, '12345678905', '12345678909', false, 2);



