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
	placa_veiculo VARCHAR(8),
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






