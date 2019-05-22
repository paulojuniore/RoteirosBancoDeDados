-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2019-05-22 14:42:46.837

-- tables
-- Table: JOGADOR
CREATE TABLE JOGADOR (
    nome varchar(20)  NOT NULL,
    cpf varchar(11)  NOT NULL,
    posição varchar(3)  NOT NULL,
    TIME_id int  NOT NULL,
    TIME_nome varchar(20)  NOT NULL,
    CONSTRAINT JOGADOR_pk PRIMARY KEY (cpf)
);

-- Table: JOGADOR_PARTIDA
CREATE TABLE JOGADOR_PARTIDA (
    id_partida int  NOT NULL,
    golsJogador int  NOT NULL,
    cartaoAmarelo boolean  NOT NULL,
    cartaoVermelho boolean  NOT NULL,
    JOGADOR_cpf varchar(11)  NOT NULL,
    CONSTRAINT JOGADOR_PARTIDA_pk PRIMARY KEY (id_partida)
);

-- Table: PARTIDA
CREATE TABLE PARTIDA (
    id_partida int  NOT NULL,
    Data date  NOT NULL,
    Juiz varchar(20)  NOT NULL,
    Bandeirinha varchar(20)  NOT NULL,
    CONSTRAINT PARTIDA_pk PRIMARY KEY (id_partida)
);

-- Table: TIME
CREATE TABLE TIME (
    id int  NOT NULL,
    nome varchar(20)  NOT NULL,
    tecnico varchar(20)  NOT NULL,
    nacionalidade char(2)  NOT NULL,
    CONSTRAINT TIME_pk PRIMARY KEY (id,nome)
);

-- Table: TIME_PARTIDA
CREATE TABLE TIME_PARTIDA (
    golsTimeA int  NOT NULL,
    golsTimeB int  NOT NULL,
    cartoesTimeA int  NOT NULL,
    cartoesTimeB int  NOT NULL,
    TIME_id int  NOT NULL,
    TIME_nome varchar(20)  NOT NULL,
    PARTIDA_id_partida int  NOT NULL
);

-- foreign keys
-- Reference: JOGADOR_PARTIDA_JOGADOR (table: JOGADOR_PARTIDA)
ALTER TABLE JOGADOR_PARTIDA ADD CONSTRAINT JOGADOR_PARTIDA_JOGADOR
    FOREIGN KEY (JOGADOR_cpf)
    REFERENCES JOGADOR (cpf)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: JOGADOR_PARTIDA_PARTIDA (table: JOGADOR_PARTIDA)
ALTER TABLE JOGADOR_PARTIDA ADD CONSTRAINT JOGADOR_PARTIDA_PARTIDA
    FOREIGN KEY ()
    REFERENCES PARTIDA ()  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: JOGADOR_TIME (table: JOGADOR)
ALTER TABLE JOGADOR ADD CONSTRAINT JOGADOR_TIME
    FOREIGN KEY (TIME_id, TIME_nome)
    REFERENCES TIME (id, nome)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: TIME_PARTIDA_PARTIDA (table: TIME_PARTIDA)
ALTER TABLE TIME_PARTIDA ADD CONSTRAINT TIME_PARTIDA_PARTIDA
    FOREIGN KEY (PARTIDA_id_partida)
    REFERENCES PARTIDA (id_partida)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: TIME_PARTIDA_TIME (table: TIME_PARTIDA)
ALTER TABLE TIME_PARTIDA ADD CONSTRAINT TIME_PARTIDA_TIME
    FOREIGN KEY (TIME_id, TIME_nome)
    REFERENCES TIME (id, nome)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- End of file.

