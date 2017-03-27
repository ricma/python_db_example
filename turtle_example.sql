
-- Creation des tables
CREATE TABLE Lieu (
nom VARCHAR(15),
Adresse VARCHAR(250),
PRIMARY KEY (nom)
)
ENGINE=INNODB;

CREATE TABLE Zone (
identifiant CHAR(3),
pourcentageSable VARCHAR(3),
pourcentageHerbier VARCHAR(3),
pourcentageRoche VARCHAR(3),
profondeur INT(4),
lieu VARCHAR(15),
PRIMARY KEY (identifiant), 
FOREIGN KEY (`lieu`) REFERENCES `Lieu`(`nom`)
)
ENGINE=INNODB;


CREATE TABLE Veterinaire ( 
identifiant CHAR(2),
numeroEnregistrementOrdre VARCHAR (10),
nom VARCHAR (15) NOT NULL,
prenom VARCHAR (15) NOT NULL,
adresse VARCHAR (40),
telephone VARCHAR (12) NOT NULL,
PRIMARY KEY (identifiant)
)
ENGINE=INNODB;


CREATE TABLE InfoJour (
numeroJour VARCHAR(5), 
date DATE, 
heure TIME,
etatCiel VARCHAR(15) ,      -- valeur null en aquarium 
temperatureAir TINYINT(2),  -- valeur null en aquarium 
etatMer VARCHAR(15) ,       -- valeur null en aquarium
temperatureEau TINYINT(2),  -- valeur null en aquarium car controlé - stable
commentaire VARCHAR(1000),
PRIMARY KEY (numeroJour)
)
ENGINE=INNODB;


CREATE TABLE Observateur(
identifiant CHAR(2),
nom VARCHAR (15) NOT NULL,
prenom VARCHAR (15) NOT NULL,
statut VARCHAR (10) NOT NULL,
naissanceDate DATE,
adresse VARCHAR (40),
telephone VARCHAR (12) NOT NULL, # taille 12 pour permettre saisie de num étranger
cursus VARCHAR (1000),
PRIMARY KEY (identifiant)
)
ENGINE=INNODB;


CREATE TABLE Tortue (
identifiant TINYINT AUTO_INCREMENT,
nom VARCHAR(2),
numPUCE VARCHAR(10),
couleur VARCHAR (8),
sexe VARCHAR(1) DEFAULT 'F' NOT NULL,
nomEspece VARCHAR(20) DEFAULT 'Caretta caretta' NOT NULL,
parent1 TINYINT DEFAULT '00', #la majorité des tortues étudiées ici sont de la même portée
parent2 TINYINT DEFAULT '00',
dateNaissance DATE DEFAULT '2011-06-30' NOT NULL,
lieuNaissance VARCHAR(35) DEFAULT 'aquarium Marineland' NOT NULL,
decesDate DATE DEFAULT '0000-00-00' NOT NULL,
commentaire VARCHAR(1000),
PRIMARY KEY (identifiant) 
)

ENGINE=INNODB;


CREATE TABLE TDR (
numTDR VARCHAR(11),
tortue TINYINT(2),
heureInit TIME,
PRIMARY KEY (numTDR),
FOREIGN KEY (`tortue`) REFERENCES `Tortue`(`identifiant`)
)
ENGINE=INNODB;


CREATE TABLE MesureTDR (
numTDR VARCHAR(11),
dateT DATE NOT NULL, -- bloque l’importation s’il y a un décalage
heureT TIME NOT NULL,
profondeur FLOAT (7) NOT NULL,
temperature TINYINT(2) NOT NULL,
PRIMARY KEY (numTDR, dateT, heureT),
FOREIGN KEY (`numTDR`) REFERENCES `TDR`(`numTDR`)
)
ENGINE=INNODB;



CREATE TABLE Observation (
numeroObservation TINYINT AUTO_INCREMENT,
observateur CHAR(2),   -- « Char » car taille connue
numeroJourMission VARCHAR(5),
heure TIME NOT NULL,
tortue TINYINT NOT NULL,   
zone CHAR(3) NOT NULL,
zoneProx CHAR(3),
positionVerticale CHAR(1) BINARY,
action1 VARCHAR (10) BINARY DEFAULT 'Respire' NOT NULL,
occurencesAction1 TINYINT(1) DEFAULT '1' NOT NULL, -- car minimum 1 action/observation
action2 VARCHAR (15) BINARY,
occurencesAction2 TINYINT(1) DEFAULT '0' NOT NULL, -- valeur numérique pour faciliter traitement stat
action3 VARCHAR (15) BINARY,
occurencesAction3 TINYINT(1) DEFAULT '0' NOT NULL,
Commentaires VARCHAR(1500),
PRIMARY KEY (numeroObservation),
FOREIGN KEY (`tortue`) REFERENCES `Tortue`(`identifiant`),
FOREIGN KEY (`observateur`) REFERENCES `Observateur`(`identifiant`),
FOREIGN KEY (`zone`) REFERENCES `Zone`(`identifiant`),
FOREIGN KEY (`numeroJourMission`) REFERENCES `InfoJour`(`numeroJour`)
)
ENGINE=INNODB;


CREATE TABLE AnalyseVet (
date DATE,
heure TIME,
tortue CHAR(2),
poids TINYINT(3), #pas de not null permet la collecte info même si analyse partielle pour vérification d’un point
taille TINYINT(3),
hormoneStress FLOAT(5),
Veterinaire CHAR(2) NOT NULL,
PRIMARY KEY (date,heure,tortue),
FOREIGN KEY (`Veterinaire`) REFERENCES `Veterinaire`(`identifiant`),
FOREIGN KEY (`tortue`) REFERENCES `Tortue`(`identifiant`)
)
ENGINE=INNODB;
