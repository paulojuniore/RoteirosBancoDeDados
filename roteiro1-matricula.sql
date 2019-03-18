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
	numero_seguro VARCHAR(10),
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
	placa_veiculo VARCHAR(8)
);

CREATE TABLE SINISTRO(
	tipo_sinistro VARCHAR(10),
	placa_veiculo VARCHAR(8),
	local VARCHAR(30),
	hora TIMESTAMP
);

CREATE TABLE PERICIA(
	nome VARCHAR(20),
	cpf VARCHAR(13)
);

CREATE TABLE REPARO(
	placa_veiculo VARCHAR(20),
	custo_reparo VARCHAR(20)
);

-- Questão 3

ALTER TABLE automovel ADD PRIMARY KEY (noFab);

ALTER TABLE segurado ADD PRIMARY KEY (cpf);

ALTER TABLE perito ADD PRIMARY KEY (cpf);

ALTER TABLE oficina ADD PRIMARY KEY (cnpj);

ALTER TABLE seguro ADD PRIMARY KEY (numero_seguro);

ALTER TABLE sinistro ADD PRIMARY KEY (placa_veiculo, hora);

ALTER TABLE pericia ADD PRIMARY KEY (cpf);

ALTER TABLE reparo ADD PRIMARY KEY (placa_veiculo);


-- Questão 4

ALTER TABLE automovel ADD CONSTRAINT automovel_cpfProprietario FOREIGN KEY (cpf_proprietario) REFERENCES segurado(cpf);

ALTER TABLE segurado ADD CONSTRAINT segurado_noSeguro FOREIGN KEY(numero_seguro) REFERENCES seguro(numero_seguro);





