-- Paulo Mendes da Silva Júnior - Roteiro 3

-- Domínio para verificação de cpf válido
CREATE DOMAIN cpf_valido AS CHAR(11) NOT NULL CHECK (char_length(value) = 11);

-- Tipo para verificação de estados válidos
CREATE TYPE estados_validos AS ENUM ('AL', 'BA', 'CE', 'MA', 'PB', 'PE', 'PI', 'RN', 'SE');

-- Verificação de tipo de funcionários
-- F = farmacêutico, V = vendedor, E = entregador, C = caixa, A = administrador
CREATE TYPE tipo_func_valido AS ENUM ('F', 'V', 'E', 'C', 'A'); 

-- Verificação de tipo de endereço do cliente
-- R = residência, T = trabalho, O = outro
CREATE TYPE endereco_valido AS ENUM ('R', 'T', 'O');



-- Definições das tabelas

CREATE TABLE FARMACIA (
	id SERIAL PRIMARY KEY,
	tipo CHAR(1) NOT NULL CHECK (tipo IN ('S', 'F')),
	gerente_cpf cpf_valido NOT NULL,
    gerente_func CHAR(1) NOT NULL CHECK (gerente_func IN ('A', 'F')),
    cidade VARCHAR(20) NOT NULL,
    bairro VARCHAR(20) NOT NULL,
	estado estados_validos NOT NULL,

    CONSTRAINT unica_farmacia_por_bairro EXCLUDE USING gist (bairro WITH =, cidade WITH =),
    CONSTRAINT sede_unica EXCLUDE USING gist (tipo WITH =) WHERE (tipo = 'S')
);

CREATE TABLE FUNCIONARIO (
    cpf_func cpf_valido UNIQUE PRIMARY KEY,
    nome VARCHAR(20) NOT NULL,
	id_farmacia INTEGER,
	tipo_func tipo_func_valido
); 

CREATE TABLE CLIENTE (
	cpf_cliente cpf_valido PRIMARY KEY,
	nome VARCHAR(20) NOT NULL,
    sobrenome VARCHAR(20) NOT NULL,
    idade INTEGER CHECK (idade >= 18)
);

CREATE TABLE ENDERECO_CLIENTE (
    id SERIAL PRIMARY KEY,
	cpf_cliente cpf_valido REFERENCES cliente(cpf_cliente),
	tipo_endereco endereco_valido,
    cidade VARCHAR(20),
    estado estados_validos,
    rua VARCHAR(20),
    bairro VARCHAR(20),
    numero SMALLINT
);

CREATE TABLE MEDICAMENTO (
	id_medicamento SERIAL PRIMARY KEY,
	restricao_venda BOOLEAN NOT NULL,
    nome VARCHAR(20) NOT NULL
);

CREATE TABLE VENDA (
    id SERIAL PRIMARY KEY,
    id_medicamento INTEGER NOT NULL REFERENCES medicamento(id_medicamento),
    cpf_vendedor cpf_valido REFERENCES funcionario(cpf_func),
	cpf_cliente cpf_valido REFERENCES cliente(cpf_cliente),
    usa_receita BOOLEAN NOT NULL,
    id_entrega INTEGER NOT NULL
);

CREATE TABLE ENTREGA (
    id SERIAL PRIMARY KEY,
	id_endereco_entrega INTEGER REFERENCES endereco_cliente(id) NOT NULL,
    id_entrega INTEGER
);

CREATE TABLE FUNCIONARIO_FARMACIA (
    cpf_funcionario cpf_valido UNIQUE REFERENCES funcionario(cpf_func),
    id_farmacia INTEGER NOT NULL REFERENCES farmacia(id),
    PRIMARY KEY (cpf_funcionario, id_farmacia)
);


-- TESTES DE RESTRIÇÕES

-- Adicionando uma nova coluna a tabela medicamento, havia esquecido rsrs.
ALTER TABLE medicamento ADD COLUMN nome VARCHAR(20) NOT NULL;

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






