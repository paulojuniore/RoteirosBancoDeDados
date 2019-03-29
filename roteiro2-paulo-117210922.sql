
--- Questão 1
CREATE TABLE TAREFA(
	codigo_tarefa INTEGER,
	descricao_tarefa TEXT,
	cpf_empregado CHAR(11),
	prioridade INTEGER,
	status_atividade CHAR(1)
);

ALTER TABLE TAREFA RENAME TO TAREFAS;


INSERT INTO tarefas VALUES(2147483647, 'limpar janelas da sala 203', '98765432122', 1, 'F');

INSERT INTO tarefas VALUES(2147483647, 'limpar janelas da sala 203', '98765432122', 1, 'F');

INSERT INTO tarefas VALUES(null, null, null, null, null);


INSERT INTO tarefas VALUES(2147483644, 'limpar chão do corretor superior', '987654323211', 0, 'F');

INSERT INTO tarefas VALUES(2147483643, 'limpar chão do corredor superior', '98765432321', 0, 'FF');

INSERT INTO tarefas VALUES(2147483648, 'limpar portas do térreo', '32323232955', 4, 'A');


--- Questão 2
ALTER TABLE TAREFAS ALTER COLUMN codigo_tarefa TYPE bigint;

--- Questão 3
ALTER TABLE tarefas ALTER COLUMN prioridade TYPE smallint;

--- Questão 4
DELETE FROM tarefas WHERE codigo_tarefa IS NULL;
ALTER TABLE tarefas ALTER COLUMN codigo_tarefa SET NOT NULL;
ALTER TABLE tarefas ALTER COLUMN descricao_tarefa SET NOT NULL;
ALTER TABLE tarefas ALTER COLUMN cpf_empregado SET NOT NULL;
ALTER TABLE tarefas ALTER COLUMN prioridade SET NOT NULL;
ALTER TABLE tarefas ALTER COLUMN status_atividade SET NOT NULL;

ALTER TABLE tarefas RENAME COLUMN codigo_tarefa TO id;
ALTER TABLE tarefas RENAME COLUMN descricao_tarefa TO descricao;
ALTER TABLE tarefas RENAME COLUMN cpf_empregado TO func_resp_cpf;
ALTER TABLE tarefas RENAME COLUMN status_atividade TO status;

--- Questão 5
ALTER TABLE tarefas ADD CONSTRAINT pks_tarefas PRIMARY KEY (id, func_resp_cpf);
ALTER TABLE tarefas DROP CONSTRAINT pks_tarefas;
ALTER TABLE tarefas ADD CONSTRAINT pk_tarefas PRIMARY KEY (func_resp_cpf);
ALTER TABLE tarefas ADD CONSTRAINT unique_id UNIQUE (id);

--- Questão 6
--- A
ALTER TABLE tarefas ADD CONSTRAINT tarefa_check_cpf CHECK (length(func_resp_cpf) = 11);

--- B
UPDATE tarefas SET status = 'P' WHERE status = 'A';
UPDATE tarefas SET status = 'E' WHERE status = 'R';
UPDATE tarefas SET status = 'C' WHERE status = 'F';
ALTER TABLE tarefas ADD CONSTRAINT tarefa_status CHECK (status IN ('P', 'E', 'C'));

--- Questão 7
UPDATE tarefas SET prioridade = '5' WHERE prioridade IN ('32766', '32767');
ALTER TABLE tarefas ADD CONSTRAINT tarefa_check_prioridade CHECK (prioridade IN (0, 1, 2, 3, 4, 5));

--- Questão 8
CREATE TABLE FUNCIONARIO(
	cpf CHAR(11) PRIMARY KEY NOT NULL,
	data_nasc DATE NOT NULL,
	nome VARCHAR(50) NOT NULL,
	funcao VARCHAR(30) NOT NULL,
	nivel CHAR(1) NOT NULL,
	superior_cpf CHAR(11) REFERENCES tarefas(func_resp_cpf),

	CONSTRAINT funcao_chk CHECK (funcao IN ('LIMPEZA', 'SUP_LIMPEZA')),
	CONSTRAINT nivel_chk CHECK (nivel IN ('J', 'P', 'S'))
);

INSERT INTO funcionario VALUES ('12345678911', '1980-05-07', 'Pedro da Silva', 'SUP_LIMPEZA', 'S', null);
INSERT INTO funcionario VALUES ('12345678912', '1980-03-08', 'Jose da Silva', 'LIMPEZA', 'J', '12345678911');

INSERT INTO funcionario VALUES ('12345678913', '1980-04-09', 'Joao da Silva', 'LIMPEZA', 'J', null);
--- ALTER TABLE funcionario ADD CONSTRAINT funcionario_check_funcao_cpfsuperior CHECK (funcao = 'LIMPEZA') ALTER COLUMN superior_cpf SET NOT NULL;

INSERT INTO funcionario VALUES ('33344455591', '1980-05-13', 'Pedro Julio', 'SUP_LIMPEZA', 'S', null);
INSERT INTO funcionario VALUES ('33344466612', '1978-07-19', 'Zé Felipe', 'SUP_LIMPEZA', 'S', null);
INSERT INTO funcionario VALUES ('33344477731', '1975-01-08', 'Cristiano Vieira', 'LIMPEZA', 'S', '32323232955');
INSERT INTO funcionario VALUES ('33344488846', '1979-09-22', 'Felipe Almeida', 'SUP_LIMPEZA', 'S', null);
INSERT INTO funcionario VALUES ('33344499976', '1983-04-13', 'Anderson Alves', 'SUP_LIMPEZA', 'P', null);
INSERT INTO funcionario VALUES ('33399944412', '1982-05-19', 'Tiago Leite', 'SUP_LIMPEZA', 'S', null);
INSERT INTO funcionario VALUES ('22233344498', '1977-05-23', 'Leandro Mendes', 'LIMPEZA', 'S', '98765432122');
INSERT INTO funcionario VALUES ('11122233345', '1983-05-19', 'Gabriel Pereira', 'LIMPEZA', 'S', '98765432122');
INSERT INTO funcionario VALUES ('33344462717', '1985-04-13', 'Thiago Martins', 'SUP_LIMPEZA', 'S', null);
INSERT INTO funcionario VALUES ('33354637721', '1978-03-15', 'Thulio Rocha', 'SUP_LIMPEZA', 'S', null);











