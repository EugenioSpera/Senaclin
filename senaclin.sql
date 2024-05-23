CREATE DATABASE senaclin
USE senaclin

CREATE TABLE pacientes(
idpaciente INT AUTO_INCREMENT NOT NULL, 
nome VARCHAR(50) NOT NULL,
cpf CHAR(11) NOT NULL,
tipoLogradouro VARCHAR(15),
nomeLogradouro VARCHAR(50) NOT NULL,
numero VARCHAR(6) NOT NULL,
complemento VARCHAR(10) DEFAULT 'não existe',
telefone CHAR(11) NOT NULL,
CONSTRAINT UNIQUE (cpf),
CONSTRAINT PRIMARY KEY(idPaciente),
CONSTRAINT ck_tipoLogradouro CHECK (tipoLogradouro='Praça' OR tipoLogradouro='Rua' OR tipoLogradouro='Avenida' OR tipoLogradouro='Estrada')
);

SELECT * FROM pacientes

CREATE TABLE dentistas(
idDentista INT AUTO_INCREMENT NOT NULL,
nome VARCHAR(50) NOT NULL,
cro CHAR(8) NOT NULL, 
especialidade VARCHAR(20) DEFAULT 'Geral',
telefone CHAR(11) NOT NULL,
celular CHAR(11) NOT NULL,
CONSTRAINT UNIQUE (cro),
CONSTRAINT ck_especialidade CHECK (especialidade='Ortodontia' OR especialidade='Geral' OR especialidade='Periodontia' OR especialidade='Implantodontia'),
CONSTRAINT PRIMARY KEY(idDentista)
);

SELECT * FROM dentistas


CREATE TABLE consultas(
idConsulta INT AUTO_INCREMENT NOT NULL,
idPaciente INT NOT NULL,
idDentista INT NOT NULL,
dataConsulta DATETIME NOT NULL,
horaConsulta DATETIME NOT NULL,
tipoConsulta VARCHAR(50) NOT NULL,
observacao VARCHAR(200),
CONSTRAINT ck_tipoConsulta CHECK (tipoConsulta='Avaliação' OR tipoConsulta='Tratamento'),
CONSTRAINT PRIMARY KEY(idConsulta),
CONSTRAINT fk_consultas_pacientes FOREIGN KEY (idPaciente)
REFERENCES pacientes(idpaciente),
CONSTRAINT fk_consultas_dentistas FOREIGN KEY (idDentista)
REFERENCES dentistas(idDentista)
);

SELECT * FROM consultas

ALTER TABLE pacientes
ADD cidade VARCHAR(30) NOT NULL;

INSERT INTO pacientes 
VALUES 
(1,'Jose','99988877766','Avenida','Margaridas','55','casa','01332525815','Santos'),
(2,'João','99988877755','Praça','Republica','130','95','01132525815','São Vicente'),
(3,'Pedro','99988877744','Rua','Amelia','58','casa','02132525815','Santos'),
(4,'Paulo','99988877733','Avenida','Ana Costa','250','132','01332525822','Guaruja'),
(5,'Jonas','99988877722','Estrada','Bandeirantes','km 20','','02132525818','Santos'),
(6,'Miguel','99988877711','Avenida','Paulista','1235','122','01132525843','São Vicente');

SELECT * FROM pacientes