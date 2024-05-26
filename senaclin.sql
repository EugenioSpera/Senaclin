senaclinsenaclinCREATE DATABASE senaclin
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
SELECT * FROM dentistas

INSERT INTO dentistas (nome, cro, especialidade, telefone, celular)
VALUES ('Marcos', '999999mg','Ortodontia','01332525855','13999888770');
INSERT INTO dentistas (nome, cro, especialidade, telefone, celular)
VALUES ('Joel', '888888rj','Geral','01332525822','13999888779');
INSERT INTO dentistas (nome, cro, especialidade, telefone, celular)
VALUES ('Manoel', '777777sp','Periodontia','01332525833','13999888778');
INSERT INTO dentistas (nome, cro, especialidade, telefone, celular)
VALUES ('Lucas', '888888sp','Implantodontia','01332525844','13999888777');

SELECT * FROM Consultas

INSERT INTO consultas (idPaciente, idDentista, dataConsulta, horaConsulta, tipoConsulta, observacao)
VALUES (1, 1, '2024-06-10', '10:30:00','avaliacao','');
INSERT INTO consultas (idPaciente, idDentista, dataConsulta, horaConsulta, tipoConsulta, observacao)
VALUES (2, 2, '2024-07-15', '09:00:00','avaliacao','');
INSERT INTO consultas (idPaciente, idDentista, dataConsulta, horaConsulta, tipoConsulta, observacao)
VALUES (3, 2, '2024-08-05', '11:40:00','avaliacao','');

SELECT * FROM dentistas

UPDATE dentistas
SET especialidade ='geral'
WHERE idDentista=4

UPDATE dentistas
SET telefone ='01332525844'
WHERE idDentista=4

UPDATE dentistas
SET celular ='13999888777'
WHERE idDentista=4

UPDATE consultas
SET dataConsulta ='2024-07-10'
WHERE idConsulta=2

UPDATE consultas
SET horaConsulta ='2024-07-10 10:20:00'
WHERE idConsulta=2

SELECT * FROM consultas

UPDATE consultas
SET tipoConsulta ='tratamento', observacao ='“Tratamento será realizado em 10 consultas. Prioridade: Moderada. Remédio aplicado: Ponstan, caso sinta dores”'
WHERE idConsulta=1

SELECT nome, telefone, cidade FROM pacientes 
WHERE cidade = 'santos'
ORDER BY nome ASC

SELECT * FROM pacientes
SELECT * FROM dentistas
SELECT * FROM consultas

SELECT dentistas.nome, consultas.dataConsulta, pacientes.telefone, pacientes.nome
FROM ((consultas
INNER JOIN  dentistas ON consultas.idDentista = dentistas.idDentista)
INNER JOIN pacientes ON consultas.idPaciente = pacientes.idpaciente);

SELECT dentistas.nome, consultas.dataConsulta, consultas.tipoConsulta
FROM consultas
Right JOIN  dentistas ON consultas.idDentista = dentistas.idDentista;

SELECT COUNT(idDentista),especialidade AS 'Total de Dentistas' FROM dentistas
GROUP BY especialidade
ORDER BY especialidade ASC 

SELECT COUNT(idConsulta),dataConsulta AS 'Total de Consultas' FROM consultas
WHERE dataConsulta LIKE '2024-07%' 


SELECT COUNT(idConsulta), tipoConsulta FROM consultas
GROUP BY tipoConsulta

SELECT COUNT(idPaciente) AS 'Total de pacientes' FROM pacientes

/* No exercicio 5 foi alterado a especialidade do unico dentista que tinha implantodontia*/
SELECT dentistas.nome, dentistas.cro, consultas.dataConsulta, pacientes.nome
FROM ((consultas
INNER JOIN  dentistas ON consultas.idDentista = dentistas.idDentista)
INNER JOIN pacientes ON consultas.idPaciente = pacientes.idpaciente)
WHERE especialidade = 'implantodontia'
ORDER BY dataConsulta desc

SELECT * FROM dentistas
SELECT * FROM consultas


SELECT  COUNT(idConsulta), dentistas.nome
FROM consultas
Inner JOIN dentistas ON consultas.idDentista = dentistas.idDentista
WHERE idConsulta >=0
GROUP BY dentistas.nome
ORDER BY idConsulta DESC

