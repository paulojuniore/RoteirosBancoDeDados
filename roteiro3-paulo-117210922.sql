-- Paulo Mendes da Silva Júnior - 117210922 - Roteiro 3

CREATE TABLE FARMACIA (
	id_farmacia AUTO INCREMENT NOT NULL,
	nome VARCHAR(25) NOT NULL,
	tipo VARCHAR(10) NOT NULL,
	gerente_cpf VARCHAR(14) NOT NULL,

	CONSTRAINT tipo_valido_chk CHECK (tipo IN ('sede', 'filial'))	
);

-- F = farmacêutico, V = vendedor, E = entregador, C = caixa, A = administrador
CREATE TABLE FUNCIONARIO (
	id_farmacia INTEGER UNIQUE,
	tipo_func CHAR(1) NOT NULL,
	cpf_func VARCHAR(14) NOT NULL,
	
	CONSTRAINT tipo_func_valido_chk CHECK (tipo_func IN ('F', 'V', 'E', 'C', 'A'))
); 

CREATE TABLE MEDICAMENTO (
	id_medicamento AUTO INCREMENT PRIMARY KEY,
	receita TEXT,
	nome VARCHAR(50),
	fabricante VARCHAR(20)
);

CREATE TABLE VENDA (
	cpf_funcionario VARCHAR(14),
	nome_cliente VARCHAR(20)
	
);

CREATE TABLE ENTREGA (
	cpf_entregador VARCHAR(14),
);

CREATE TABLE CLIENTE (
	cpf_cliente VARCHAR(14) NOT NULL,
	data_nascimento DATE NOT NULL CHECK (
);

-- R = residência, T = trabalho, O = outro
CREATE TABLE ENDERECO_CLIENTE (
	cpf_cliente VARCHAR(14) NOT NULL,
	endereco CHAR(1) NOT NULL,

	CONSTRAINT endereco_valido_chk CHECK (endereco IN ('R', 'T', 'O')) 
);

CREATE TABLE ENDERECO_FARMACIA (
	bairro VARCHAR(20) PRIMARY KEY NOT NULL,
	cidade VARCHAR(20) NOT NULL,
	estado CHAR(2) NOT NULL
);
