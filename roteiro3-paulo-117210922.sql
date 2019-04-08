-- Paulo Mendes da Silva Júnior - 117210922 - Roteiro 3

CREATE TABLE FARMACIA (
	nome VARCHAR(25) NOT NULL,
	tipo VARCHAR(10) NOT NULL,
	gerente_cpf VARCHAR(14) NOT NULL,
	cnpj_farmacia CHAR(18) NOT NULL,	

	CONSTRAINT tipo_valido_chk CHECK (tipo IN ('sede', 'filial'))	
);

-- F = farmacêutico, V = vendedor, E = entregador, C = caixa, A = administrador
CREATE TABLE FUNCIONARIO (
	tipo_func CHAR(1) NOT NULL,
	cpf VARCHAR(14) NOT NULL,
	
	CONSTRAINT tipo_func_valido_chk CHECK (tipo_func IN ('F', 'V', 'E', 'C', 'A'))
); 

CREATE TABLE MEDICAMENTO (

);

CREATE TABLE VENDA (

);

CREATE TABLE ENTREGA (

);

CREATE TABLE CLIENTE (
	cpf_cliente VARCHAR(14) NOT NULL,
);

-- R = residência, T = trabalho, O = outro
CREATE TABLE ENDERECO_CLIENTE (
	cpf_cliente VARCHAR(14) NOT NULL,
	endereco CHAR(1) NOT NULL,

	CONSTRAINT endereco_valido_chk CHECK (endereco IN ('R', 'T', 'O')) 
);
