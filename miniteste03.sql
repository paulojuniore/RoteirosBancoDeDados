CREATE TABLE estudante (
	matricula CHAR(9) PRIMARY KEY NOT NULL,
	nome VARCHAR(20) NOT NULL,
	data_nasc DATE NOT NULL
);	

CREATE TABLE disciplina (
	codigo CHAR(4) PRIMARY KEY NOT NULL,
	carga_horaria INTEGER NOT NULL
);

CREATE TABLE estudantedisciplina (
	matricula CHAR(9) REFERENCES estudante(matricula),
	disciplina CHAR(4) REFERENCES disciplina(codigo),
	periodo_letivo CHAR(6)
);
