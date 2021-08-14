
CREATE DATABASE Visas;
CREATE USER userVisas@'%' IDENTIFIED BY 'v_2005';
GRANT ALL PRIViLEGES ON visas.* TO uservisas@'%';

--- 
USE Visas;

DROP TABLE IF EXISTS Soc;
CREATE TABLE Soc (
  SocID integer NOT NULL,
  SocCode VARCHAR(100) NOT NULL,
  Name VARCHAR(100) NOT NULL,
  CONSTRAINT pk_Soc PRIMARY KEY(SocID)
  );
  
DROP TABLE IF EXISTS Job;
CREATE TABLE Job (
  JobID INTEGER NOT NULL,
  Name VARCHAR(100) NOT NULL,
  Full_time_position VARCHAR(10),
  PREVAILING_WAGE float,
  id_soc integer,
  CONSTRAINT pk_Job PRIMARY KEY(JobID),
  CONSTRAINT fk_job_soc FOREIGN KEY(id_soc) REFERENCES Soc(SocID)
);

 
DROP TABLE IF EXISTS State;
CREATE TABLE State (
  StateID INTEGER NOT NULL,
  Name varchar(50),
  CONSTRAINT pk_State PRIMARY KEY(StateID)
  );
  
DROP TABLE IF EXISTS City;
CREATE TABLE City (
  CityID INTEGER NOT NULL,
  Name varchar (100),
  State INTEGER NOT NULL,
  CONSTRAINT pk_City PRIMARY KEY(CityID),
  CONSTRAINT fk_city_state FOREIGN KEY(State) REFERENCES State(StateID)
);
  
DROP TABLE IF EXISTS Employer;
CREATE TABLE Employer (
  EmployerID INTEGER NOT NULL,
  Name VARCHAR(100) NOT NULL,
  City INTEGER NOT NULL,
  CONSTRAINT pk_Employer PRIMARY KEY(EmployerID),
  CONSTRAINT fk_city_empl FOREIGN KEY(City) REFERENCES City(CityID)
);

DROP TABLE IF EXISTS Years;
CREATE TABLE Years (
  YearID INTEGER NOT NULL,
  Year INTEGER NOT NULL,
  CONSTRAINT pk_year PRIMARY KEY(YearID)
  );

DROP TABLE IF EXISTS Petitions;
CREATE TABLE Petitions (
  CaseID VARCHAR(50) NOT NULL,
  Status VARCHAR(50) NOT NULL,
  ID_Empl integer not null,
  ID_soc integer not null,
  ID_job integer not null,
  ID_year integer not null,
  PRIMARY KEY(CaseID,Status,ID_Empl,ID_soc,ID_job,ID_year),
  CONSTRAINT fk_Pet_Empl FOREIGN KEY(ID_Empl) REFERENCES Employer(EmployerID),
  CONSTRAINT fk_Pet_Soc FOREIGN KEY(ID_soc) REFERENCES Soc(SocID),
  CONSTRAINT fk_Pet_Job FOREIGN KEY(ID_job) REFERENCES Job(JobID),
  CONSTRAINT fk_Pet_Year FOREIGN KEY(ID_year) REFERENCES Years(YearID)
);

