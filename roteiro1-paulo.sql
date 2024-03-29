-- Questão 1 e 2

CREATE TABLE AUTOMOVEL(
	noFab VARCHAR(17),
	modelo VARCHAR(20),
	marca VARCHAR(10),
	ano CHAR(4),
	placa CHAR(8),
	cpf_proprietario VARCHAR(13)
);

CREATE TABLE SEGURADO(
	nome VARCHAR(20),
	cpf VARCHAR(13),
	numero_seguro SERIAL,
	valor_seguro NUMERIC
);

CREATE TABLE PERITO(
	nome VARCHAR(20),
	cpf VARCHAR(13)
);

CREATE TABLE OFICINA(
	nome VARCHAR(20),
	cnpj VARCHAR(20)
);

CREATE TABLE SEGURO(
	numero_seguro SERIAL,
	valor_seguro NUMERIC,
	noFab VARCHAR(17)
);

CREATE TABLE SINISTRO(
	tipo_sinistro VARCHAR(10),
	noFab VARCHAR(8),
	local VARCHAR(30),
	hora TIMESTAMP
);

CREATE TABLE PERICIA(
	id_pericia SERIAL,
	cpf_perito VARCHAR(13),
	sinistro VARCHAR(10)
);

CREATE TABLE REPARO(
	id_reparo SERIAL,
	noFab VARCHAR(17),
	custo_reparo VARCHAR(20),
	cnpj_oficina VARCHAR(20)
);

-- Questão 3

ALTER TABLE automovel ADD PRIMARY KEY (noFab);

ALTER TABLE segurado ADD PRIMARY KEY (cpf);

ALTER TABLE perito ADD PRIMARY KEY (cpf);

ALTER TABLE oficina ADD PRIMARY KEY (cnpj);

ALTER TABLE seguro ADD PRIMARY KEY (numero_seguro);

ALTER TABLE sinistro ADD PRIMARY KEY (placa_veiculo, hora);

ALTER TABLE pericia ADD PRIMARY KEY (id_pericia);

ALTER TABLE reparo ADD PRIMARY KEY (id_reparo);


-- Questão 4

ALTER TABLE automovel ADD CONSTRAINT automovel_cpfProprietario FOREIGN KEY (cpf_proprietario) REFERENCES segurado(cpf);

ALTER TABLE segurado ADD CONSTRAINT segurado_noSeguro FOREIGN KEY(numero_seguro) REFERENCES seguro(numero_seguro);

ALTER TABLE seguro ADD CONSTRAINT seguro_placa_veiculo FOREIGN KEY(noFab) REFERENCES automovel(noFab);

ALTER TABLE sinistro ADD CONSTRAINT sinistro_placa_veiculo FOREIGN KEY(placa_veiculo) REFERENCES automovel(placa);

ALTER TABLE pericia ADD CONSTRAINT pericia_cpf_perito FOREIGN KEY(cpf_perito) REFERENCES perito(cpf);

ALTER TABLE reparo ADD CONSTRAINT reparo_placa_veiculo FOREIGN KEY(nofab) REFERENCES automovel(noFab);

ALTER TABLE reparo ADD CONSTRAINT reparo_cnpj_oficina FOREIGN KEY(cnpj_oficina) REFERENCES oficina(cnpj);


-- Questão 6

DROP TABLE automovel CASCADE;

DROP TABLE segurado CASCADE;

DROP TABLE perito CASCADE;

DROP TABLE oficina CASCADE;

DROP TABLE seguro CASCADE;

DROP TABLE sinistro CASCADE;

DROP TABLE pericia CASCADE;

DROP TABLE reparo CASCADE;


-- Questão 7

CREATE TABLE AUTOMOVEL(
	noFab VARCHAR(17) PRIMARY KEY,
	modelo VARCHAR(20) NOT NULL,
	marca VARCHAR(10) NOT NULL,
	ano CHAR(4) NOT NULL,
	placa CHAR(8) NOT NULL,
	cpf_proprietario VARCHAR(13) NOT NULL
);


CREATE TABLE PERITO(
	nome VARCHAR(20) NOT NULL,
	cpf VARCHAR(13) PRIMARY KEY
);

CREATE TABLE PERICIA(
	id_pericia SERIAL PRIMARY KEY,
	cpf_perito VARCHAR(13) NOT NULL REFERENCES perito(cpf),
	sinistro VARCHAR(10) NOT NULL
);

CREATE TABLE OFICINA(
	nome VARCHAR(20) NOT NULL,
	cnpj VARCHAR(20) PRIMARY KEY
);

CREATE TABLE REPARO(
	id_reparo SERIAL PRIMARY KEY,
	noFab VARCHAR(17) NOT NULL REFERENCES automovel(noFab),
	custo_reparo VARCHAR(20) NOT NULL,
	cnpj_oficina VARCHAR(20) NOT NULL REFERENCES oficina(cnpj)
);


CREATE TABLE SEGURO(
	numero_seguro SERIAL PRIMARY KEY,
	valor_seguro NUMERIC NOT NULL,
	noFab VARCHAR(17) NOT NULL REFERENCES automovel(noFab)
);

CREATE TABLE SEGURADO(
	nome VARCHAR(20) NOT NULL,
	cpf VARCHAR(13) PRIMARY KEY,
	numero_seguro SERIAL NOT NULL REFERENCES seguro(numero_seguro),
	valor_seguro NUMERIC NOT NULL
);


CREATE TABLE SINISTRO(
	tipo_sinistro VARCHAR(10) NOT NULL,
	noFab VARCHAR(17) REFERENCES automovel(noFab),
	local VARCHAR(30) NOT NULL,
	hora TIMESTAMP NOT NULL,

	CONSTRAINT pk PRIMARY KEY(noFab, hora)
);

ALTER TABLE automovel ADD CONSTRAINT automovel_cpfProprietario FOREIGN KEY (cpf_proprietario) REFERENCES segurado(cpf);


-- Questão 9

DROP TABLE automovel CASCADE;

DROP TABLE segurado CASCADE;

DROP TABLE perito CASCADE;

DROP TABLE oficina CASCADE;

DROP TABLE seguro CASCADE;

DROP TABLE sinistro CASCADE;

DROP TABLE pericia CASCADE;

DROP TABLE reparo CASCADE;









