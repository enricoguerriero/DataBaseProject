CREATE DATABASE IF NOT EXISTS airportmodels;

USE airportmodels;

DROP TABLE IF EXISTS Vendita;
DROP TABLE IF EXISTS Imbarco;
DROP TABLE IF EXISTS Negozianti;
DROP TABLE IF EXISTS Equipaggio;
DROP TABLE IF EXISTS Dipendenti;
DROP TABLE IF EXISTS ListaAcquisti;
DROP TABLE IF EXISTS Prodotti;
DROP TABLE IF EXISTS Biglietti;
DROP TABLE IF EXISTS Passeggeri;
DROP TABLE IF EXISTS Persone;
DROP TABLE IF EXISTS Voli;
DROP TABLE IF EXISTS Negozi;
DROP TABLE IF EXISTS Compagnie;
DROP TABLE IF EXISTS Aerei;
DROP TABLE IF EXISTS Aeroporti;

CREATE TABLE Aeroporti (
	CodiceIata int PRIMARY KEY,
    NomeAeroporto varchar(45),
    Posizione varchar(45),
    NumeroGate int,
    Capacità int
);

CREATE TABLE Aerei (
	NumeroCoda int PRIMARY KEY,
    AnnoProduzione int,
    Capienza int, 
    Carico int,
    ConsumoCarburante int
);

CREATE TABLE Compagnie (
	CodiceCompagnia varchar(45) PRIMARY KEY,
    Nome varchar(45),
    AnnoFondazione int,
    PartecipazioneMercato int
);

CREATE TABLE Negozi (
	Ditta int PRIMARY KEY,
    Affitto varchar(255),
    Posizione varchar(45),
    TipoAttivita varchar(45),
    Aeroporto int,
    FOREIGN KEY (Aeroporto)
    REFERENCES Aeroporti(CodiceIata)
);

CREATE TABLE Voli (
	CodiceVolo varchar(45) PRIMARY KEY,
    DataPartenza date,
    DataArrivo date,
    OraPartenza time,
    OraArrivo time,
    CompagniaAerea varchar(45),
    Partenza int,
    Arrivo int,
    Aereo int,
    FOREIGN KEY (CompagniaAerea)
    REFERENCES Compagnie(CodiceCompagnia),
    FOREIGN KEY (Partenza)
    REFERENCES Aeroporti(CodiceIata),
    FOREIGN KEY (Arrivo)
    REFERENCES Aeroporti(CodiceIata),
	FOREIGN KEY (Aereo) 
    REFERENCES Aerei(NumeroCoda)
);

CREATE TABLE Persone (
	NumeroDocumento varchar(45) PRIMARY KEY,
    Nome varchar(45),
    Cognome varchar(45),
    DataNascita date,
    Via varchar(45),
    Civico int,
    Cap int
);

CREATE TABLE Passeggeri (
	NumeroDocumento varchar(45) PRIMARY KEY,
    FOREIGN KEY (NumeroDocumento) 
    REFERENCES Persone(NumeroDocumento)
);

CREATE TABLE Biglietti (
	NumeroBiglietto int PRIMARY KEY,
    Prezzo int,
    NumeroScali int,
    DataAcquisto date,
    DimensioneBagaglio int,
    Acquirente varchar(45),
    FOREIGN KEY (Acquirente)
    REFERENCES Passeggeri(NumeroDocumento)
);

CREATE TABLE Prodotti (
	CodiceProdotto int PRIMARY KEY,
    Nome varchar(45),
    Prezzo int,
    Descrizione varchar(255)
);

CREATE TABLE ListaAcquisti (
	NumeroProgressivo int,
    Prodotto int,
    Quantita int,
    DataAcquisto date,
    Passeggero varchar(45),
    FOREIGN KEY (Passeggero)
    REFERENCES Passeggeri(NumeroDocumento),
    PRIMARY KEY(NumeroProgressivo, Prodotto)
);

CREATE TABLE Dipendenti (
	NumeroDocumento varchar(45) PRIMARY KEY,
    Impiego varchar(45),
    TitoloStudio int,
    Stipendio int,
    Ufficio varchar(45),
    Aeroporto int,
    FOREIGN KEY (NumeroDocumento) 
    REFERENCES Persone(NumeroDocumento),
    FOREIGN KEY (Aeroporto)
    REFERENCES Aeroporti(CodiceIata)
);

CREATE TABLE Equipaggio (
	NumeroDocumento varchar(45) PRIMARY KEY,
    Impiego varchar(45),
    TitoloStudio int,
    Stipendio int,
    CompagniaAerea varchar(45),
    FOREIGN KEY (NumeroDocumento) 
    REFERENCES Persone(NumeroDocumento),
    FOREIGN KEY (CompagniaAerea)
    REFERENCES Compagnie(CodiceCompagnia)
);

CREATE TABLE Negozianti (
	NumeroDocumento varchar(45) PRIMARY KEY,
    Impiego varchar(45),
    TitoloStudio int,
    Stipendio int,
    Aeroporto int,
    Ditta int,
    FOREIGN KEY (NumeroDocumento) 
    REFERENCES Persone(NumeroDocumento),
    FOREIGN KEY (Aeroporto)
    REFERENCES Aeroporti(CodiceIata),
    FOREIGN KEY (Ditta)
    REFERENCES Negozi(Ditta)
);

CREATE TABLE Imbarco (
	ImbarcoID int PRIMARY KEY AUTO_INCREMENT,
    Volo varchar(45),
    Biglietto int,
    FOREIGN KEY (Volo)
    REFERENCES Voli(CodiceVolo),
    FOREIGN KEY (Biglietto)
    REFERENCES Biglietti(NumeroBiglietto)
);

CREATE TABLE Vendita(
	VenditaID int PRIMARY KEY AUTO_INCREMENT,
    Negozio int,
    Prodotto int,
    FOREIGN KEY (Negozio)
    REFERENCES Negozi(Ditta),
    FOREIGN KEY (Prodotto)
    REFERENCES Prodotti(CodiceProdotto)
);



/* Aggiungo dei dati random */

-- Insert data into Aeroporti table
INSERT INTO Aeroporti (CodiceIata, NomeAeroporto, Posizione, NumeroGate, Capacità)
VALUES
(1, 'JFK', 'New York', 20, 5000),
(2, 'LAX', 'Los Angeles', 15, 4000),
(3, 'LHR', 'London', 25, 6000);

-- Insert data into Aerei table
INSERT INTO Aerei (NumeroCoda, AnnoProduzione, Capienza, Carico, ConsumoCarburante)
VALUES
(1, 2010, 200, 50000, 1000),
(2, 2015, 150, 40000, 800),
(3, 2008, 180, 45000, 900);

-- Insert data into Compagnie table
INSERT INTO Compagnie (CodiceCompagnia, Nome, AnnoFondazione, PartecipazioneMercato)
VALUES
(1, 'Airline 1', 1990, 30),
(2, 'Airline 2', 1985, 20),
(3, 'Airline 3', 2000, 50);

-- Insert data into Negozi table
INSERT INTO Negozi (Ditta, Affitto, Posizione, TipoAttivita, Aeroporto)
VALUES
(1, '1000 USD', 'Terminal 1', 'Retail', 1),
(2, '1500 USD', 'Terminal 2', 'Food and Beverage', 2),
(3, '800 USD', 'Terminal 3', 'Duty-Free', 3);

-- Insert data into Voli table
INSERT INTO Voli (CodiceVolo, DataPartenza, DataArrivo, OraPartenza, OraArrivo, CompagniaAerea, Partenza, Arrivo, Aereo)
VALUES
('FL001', '2023-07-05', '2023-07-05', '08:00:00', '12:00:00', 1, 1, 2, 1),
('FL002', '2023-07-06', '2023-07-07', '14:30:00', '18:30:00', 2, 2, 3, 2),
('FL003', '2023-07-07', '2023-07-07', '10:45:00', '15:00:00', 3, 3, 1, 3);

INSERT INTO Voli (CodiceVolo)
VALUES
('FR9666'),
('FR5225'),
('FR6279');

-- Insert data into Persone table
INSERT INTO Persone (NumeroDocumento, Nome, Cognome, DataNascita, Via, Civico, Cap)
VALUES
('ABC123', 'John', 'Doe', '1990-01-01', 'Main Street', 10, 12345),
('DEF456', 'Jane', 'Smith', '1985-02-02', 'Park Avenue', 20, 67890),
('GHI789', 'Michael', 'Johnson', '1995-03-03', 'Broadway', 30, 54321);

-- Insert data into Passeggeri table
INSERT INTO Passeggeri (NumeroDocumento)
VALUES ('ABC123'), ('DEF456'), ('GHI789');

-- Insert data into Biglietti table
INSERT INTO Biglietti (NumeroBiglietto, Prezzo, NumeroScali, DataAcquisto, DimensioneBagaglio, Acquirente)
VALUES
(1, 500, 1, '2023-07-04', 1, 'ABC123'),
(2, 700, 2, '2023-07-03', 2, 'DEF456'),
(3, 400, 0, '2023-07-02', 1, 'GHI789');
INSERT INTO Biglietti (NumeroBiglietto)
VALUES
(4),
(5);

-- Insert data into Prodotti table
INSERT INTO Prodotti (CodiceProdotto, Nome, Prezzo, Descrizione)
VALUES
(1, 'Item 1', 10, 'Description 1'),
(2, 'Item 2', 20, 'Description 2'),
(3, 'Item 3', 30, 'Description 3');

-- Insert data into ListaAcquisti table
INSERT INTO ListaAcquisti (NumeroProgressivo, Prodotto, Quantita, DataAcquisto, Passeggero)
VALUES
(1, 1, 2, '2023-07-04', 'ABC123'),
(2, 2, 1, '2023-07-03', 'DEF456'),
(3, 3, 3, '2023-07-02', 'GHI789');

-- Insert data into Dipendenti table
INSERT INTO Dipendenti (NumeroDocumento, Impiego, TitoloStudio, Stipendio, Ufficio, Aeroporto)
VALUES
('ABC123', 'Staff', 1, 3000, 'Administration', 1),
('DEF456', 'Pilot', 2, 5000, 'Operations', 2),
('GHI789', 'Crew', 3, 2000, 'Customer Service', 3);

-- Insert data into Equipaggio table
INSERT INTO Equipaggio (NumeroDocumento, Impiego, TitoloStudio, Stipendio, CompagniaAerea)
VALUES
('ABC123', 'Crew', 1, 2500, 1),
('DEF456', 'Pilot', 2, 4000, 2),
('GHI789', 'Staff', 3, 1500, 3);

-- Insert data into Negozianti table
INSERT INTO Negozianti (NumeroDocumento, Impiego, TitoloStudio, Stipendio, Aeroporto, Ditta)
VALUES
('ABC123', 'Salesperson', 1, 2000, 1, 1),
('DEF456', 'Manager', 2, 3500, 2, 2),
('GHI789', 'Cashier', 3, 1800, 3, 3);

-- Insert data into Imbarco table
INSERT INTO Imbarco (Volo, Biglietto)
VALUES
('FL001', 1),
('FL002', 2),
('FL003', 3),
('FR9666', 4),
('FR5225',4),
('FR6279',4),
('FR5225',5),
('FR6279',5);


-- Insert data into Vendita table
INSERT INTO Vendita (Negozio, Prodotto)
VALUES
(1, 1),
(2, 2),
(3, 3);

INSERT INTO Compagnie (CodiceCompagnia, Nome)
VALUES
('FR', 'Ryanair');



/* Codice per ridondanza numero scali */

SELECT COUNT(*)-1
FROM Imbarco 
WHERE Biglietto = 4;

/* Codice per ridondanza compagnia aerea */

SELECT c.Nome AS NomeCompagnia, v.CodiceVolo
FROM Compagnie c
LEFT JOIN Voli v
ON LEFT(CodiceVolo,2) = CodiceCompagnia
WHERE CodiceVolo = 'FR5225';


/* Trigger di chatgpt */

-- Creazione del trigger
DELIMITER $$

CREATE TRIGGER check_date_voli
BEFORE INSERT ON Voli
FOR EACH ROW
BEGIN
    IF NEW.DataArrivo < NEW.DataPartenza THEN
        SIGNAL SQLSTATE '45001' SET MESSAGE_TEXT = 'La data di arrivo deve essere successiva o uguale alla data di partenza';
    ELSEIF NEW.DataArrivo = NEW.DataPartenza AND NEW.OraArrivo <= NEW.OraPartenza THEN
        SIGNAL SQLSTATE '45001' SET MESSAGE_TEXT = "L\'ora di arrivo deve essere successiva all\'ora di partenza se la data è la stessa";
    END IF;
END $$

DELIMITER ;


/* Un altro */

-- Creazione del trigger
DELIMITER $$
CREATE TRIGGER Check_Prezzo_in
BEFORE INSERT ON Biglietti
FOR EACH ROW
BEGIN
	IF NEW.Prezzo <= (SELECT MAX(B2.Prezzo) FROM Biglietti AS B1
		JOIN Imbarco AS I1 ON B1.NumeroBiglietto = I1.Biglietto
		JOIN Imbarco AS I2 ON I1.Volo = I2.Volo
		JOIN Biglietti AS B2 ON I2.Biglietto = B2.NumeroBiglietto AND B1.NumeroBiglietto != B2.NumeroBiglietto
		WHERE B1.NumeroBiglietto = NEW.NumeroBiglietto) THEN
        SIGNAL SQLSTATE '45001' SET MESSAGE_TEXT = 'Il prezzo del biglietto deve essere inferiore se consente meno voli rispetto ad altri biglietti con lo stesso numero di scali';
    END IF;
END $$
DELIMITER ;


INSERT INTO Biglietti (NumeroBiglietto, Prezzo)
VALUES
(6, 15),
(7, 20);

INSERT INTO Imbarco (Volo, Biglietto)
VALUES
('FL001', 6),
('FL002', 6),
('FL003', 7);