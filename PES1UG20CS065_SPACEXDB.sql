/*DDL*/
CREATE TABLE Administrators (admin_id VARCHAR(12) NOT NULL PRIMARY KEY, 
name VARCHAR(25),password VARCHAR(20) CHECK ( LENGTH(password) > 8 ), access_level VARCHAR(10));

CREATE TABLE Rockets (rocket_id VARCHAR(24) NOT NULL PRIMARY KEY,name VARCHAR(20),type VARCHAR(10),active VARCHAR(10),country VARCHAR(40), 
company VARCHAR(20), cost_per_launch INTEGER);

CREATE TABLE LaunchPads (launchpad_id VARCHAR(24) NOT NULL PRIMARY KEY,name VARCHAR(50),full_name VARCHAR(80),status VARCHAR(30),locality VARCHAR(50),region VARCHAR(30),TimeZone VARCHAR(40),Latitude FLOAT, Longitude FLOAT);

CREATE TABLE Payloads(payload_id VARCHAR(24) NOT NULL PRIMARY KEY,name VARCHAR(35), type VARCHAR(20), reuse VARCHAR(10), manufacture VARCHAR(40), mass_kg FLOAT, mass_lb FLOAT, orbit VARCHAR(10), reference_system VARCHAR(30),regime VARCHAR(30));

CREATE TABLE DroneShip(ship_id VARCHAR(24) NOT NULL PRIMARY KEY,home_port VARCHAR(30),name VARCHAR(35),type VARCHAR(20),roles VARCHAR(45),activity VARCHAR(10),mass_kg FLOAT,mass_lb FLOAT); 


CREATE TABLE First_stage_Recovery (ship_id VARCHAR(24), rocket_id VARCHAR(24),role VARCHAR(50), FOREIGN KEY (ship_id) REFERENCES DroneShip(ship_id), FOREIGN KEY (rocket_id) REFERENCES Rockets(rocket_id));

CREATE TABLE Launches (launchpad_id VARCHAR(24),rocket_id VARCHAR(24), name VARCHAR(50), status VARCHAR(30), FOREIGN KEY (launchpad_id) REFERENCES LaunchPads(launchpad_id), FOREIGN KEY (rocket_id) REFERENCES Rockets(rocket_id));

CREATE TABLE Missions (date DATETIME, name VARCHAR(50), rocket_id VARCHAR(24),launchpad_id VARCHAR(24), launch_id VARCHAR(24) NOT NULL PRIMARY KEY, payload_id VARCHAR(24) ,FOREIGN KEY (rocket_id) REFERENCES Rockets(rocket_id), FOREIGN KEY (launchpad_id) REFERENCES LaunchPads(launchpad_id), FOREIGN KEY (payload_id) REFERENCES Payloads(payload_id), launch_status VARCHAR(10));

CREATE TABLE Assigns (date DATETIME,name VARCHAR(50) ,rocket_id VARCHAR(24), launch_id VARCHAR(24), FOREIGN KEY (launch_id) REFERENCES Missions(launch_id), FOREIGN KEY (rocket_id) REFERENCES Rockets(rocket_id));

CREATE TABLE Delivers (payload_id VARCHAR(24), rocket_id VARCHAR(24),name VARCHAR(50), FOREIGN KEY (payload_id) REFERENCES Payloads(payload_id), FOREIGN KEY (rocket_id) REFERENCES Rockets(rocket_id));

CREATE TABLE Updates_data (admin_id VARCHAR(12), launch_id VARCHAR(24),name VARCHAR(50), launch_status VARCHAR(10), FOREIGN KEY (admin_id) REFERENCES Administrators(admin_id), FOREIGN KEY (launch_id) REFERENCES Missions(launch_id));


/*CONSTRAINTS*/
ALTER TABLE `first_stage_recovery` DROP FOREIGN KEY `first_stage_recovery_ibfk_1`; 
ALTER TABLE `first_stage_recovery` ADD CONSTRAINT `first_stage_recovery_ibfk_1` FOREIGN KEY (`ship_id`) REFERENCES `droneship`(`ship_id`) ON DELETE CASCADE ON UPDATE CASCADE; ALTER TABLE `first_stage_recovery` DROP FOREIGN KEY `first_stage_recovery_ibfk_2`; ALTER TABLE `first_stage_recovery` ADD CONSTRAINT `first_stage_recovery_ibfk_2` FOREIGN KEY (`rocket_id`) REFERENCES `rockets`(`rocket_id`) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE `launches` DROP FOREIGN KEY `launches_ibfk_1`; 
ALTER TABLE `launches` ADD CONSTRAINT `launches_ibfk_1` FOREIGN KEY (`launchpad_id`) REFERENCES `launchpads`(`launchpad_id`) ON DELETE CASCADE ON UPDATE CASCADE; ALTER TABLE `launches` DROP FOREIGN KEY `launches_ibfk_2`; ALTER TABLE `launches` ADD CONSTRAINT `launches_ibfk_2` FOREIGN KEY (`rocket_id`) REFERENCES `rockets`(`rocket_id`) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE `assigns` DROP FOREIGN KEY `assigns_ibfk_1`;
ALTER TABLE `assigns` ADD CONSTRAINT `assigns_ibfk_1` FOREIGN KEY (`launch_id`) REFERENCES `missions`(`launch_id`) ON DELETE CASCADE ON UPDATE CASCADE; ALTER TABLE `assigns` DROP FOREIGN KEY `assigns_ibfk_2`; ALTER TABLE `assigns` ADD CONSTRAINT `assigns_ibfk_2` FOREIGN KEY (`rocket_id`) REFERENCES `rockets`(`rocket_id`) ON DELETE CASCADE ON UPDATE CASCADE

/*INSERT VALUES*/
INSERT INTO Administrators VALUES ( '121810303009' ,'Rohan', '121810303009', 'root' );
INSERT INTO Administrators VALUES ( '121810303033' ,'Hari Priya', '121810303033', 'standard' );
INSERT INTO Administrators VALUES ( '121810303023' ,'Dheeraj', '121810303023', 'standard' );
INSERT INTO Administrators VALUES ( '121810303032' ,'Nikhil', '121810303032', 'standard' );
INSERT INTO Administrators VALUES ( '121810303062' ,'Kamala Sree', '121810303062', 'standard' );
INSERT INTO Administrators VALUES ( '121810303046' ,'Sri Charan', '121810303033', 'standard' );

INSERT INTO Rockets VALUES  ('5e9d0d95eda69955f709d1eb','Falcon 1','rocket','False','Republic of the Marshall Islands','SpaceX',6700000),
('5e9d0d95eda69973a809d1ec','Falcon 9','rocket','True','United States','SpaceX', 50000000),
('5e9d0d95eda69974db09d1ed','Falcon Heavy','rocket','True','United States','SpaceX', 90000000),
('5e9d0d96eda699382d09d1ee','Starship','rocket','False','United States','SpaceX', 7000000);

INSERT INTO LaunchPads VALUES('5e9e4501f5090910d4566f83','VAFB SLC 3W','Vandenberg Air Force Base Space Launch Complex 3W','retired','Vandenberg Air Force Base','California','America/Los_Angeles',34.6440904,-120.5931438);
INSERT INTO LaunchPads VALUES('5e9e4501f509094ba4566f84','CCAFS SLC 40','Cape Canaveral Air Force Station Space Launch Complex 40','active','Cape Canaveral','Florida','America/New_York',28.5618571,-80.577366);
INSERT INTO LaunchPads VALUES('5e9e4502f5090927f8566f85','STLS','SpaceX South Texas Launch Site','under construction','Boca Chica Village','Texas','America/Chicago',25.9972641,-97.1560845);
INSERT INTO LaunchPads VALUES('5e9e4502f5090995de566f86','Kwajalein Atoll','Kwajalein Atoll Omelek Island','retired','Omelek Island','Marshall Islands','Pacific/Kwajalein',9.0477206,167.7431292);
INSERT INTO LaunchPads VALUES('5e9e4502f509092b78566f87','VAFB SLC 4E','Vandenberg Air Force Base Space Launch Complex 4E','active','Vandenberg Air Force Base','California','America/Los_Angeles',34.632093,-120.610829);
INSERT INTO LaunchPads VALUES('5e9e4502f509094188566f88','KSC LC 39A','Kennedy Space Center Historic Launch Complex 39A','active','Cape Canaveral','Florida','America/New_York',28.6080585,-80.6039558);


INSERT INTO DroneShip VALUES ('5ea6ed2d080df4000697c901','Port of Los Angeles','American Champion','Tug','Support Ship','False',266712.0,588000.0);
INSERT INTO DroneShip VALUES ('5ea6ed2e080df4000697c905','Port of Los Angeles','Betty R Gambarella','Tug','ASDS Tug','False',202302.0,446000.0);
INSERT INTO DroneShip VALUES ('5ea6ed2e080df4000697c906','Port Canaveral','Elsbeth III','Tug','ASDS Tug','False',273063.0,602000.0);
INSERT INTO DroneShip VALUES ('5ea6ed2d080df4000697c907','Port Canaveral','GO Ms Chief','High Speed Craft','Fairing Recovery','True',449964.0,992000.0);
INSERT INTO DroneShip VALUES ('5ea6ed2e080df4000697c908','Port Canaveral','GO Ms Tree','High Speed Craft','Fairing Recovery','True',449964.0,992000.0);
INSERT INTO DroneShip VALUES ('5ea6ed2d080df4000697c909','Port Canaveral','GO Navigator','Cargo','Support Ship','True',	451778.0,996000.0);
INSERT INTO DroneShip VALUES ('5ea6ed2e080df4000697c90a','Port Canaveral','GO Pursuit','Cargo','Support Ship','False',502999.0,1108925.0);
INSERT INTO DroneShip VALUES ('5ea6ed2f080df4000697c90c','Port Canaveral','GO Searcher','Cargo','Support Ship','True',450870.0,994000.0);
INSERT INTO DroneShip VALUES ('5ea6ed2f080df4000697c90d','Port Canaveral','HAWK','Tug','ASDS Tug','False',508023.0,1120000.0);
INSERT INTO DroneShip VALUES ('5ea6ed2f080df4000697c90e','Fort Lauderdale','Hollywood','Tug','ASDS Tug','True',320236.0,706000.0);
INSERT INTO DroneShip VALUES ('5ea6ed30080df4000697c912','Port of Los Angeles','NRC Quest','Cargo','Support Ship','True',440892.0,972000.0);
INSERT INTO DroneShip VALUES ('5ea6ed30080df4000697c914','Port of Los Angeles','Pacific Freeedom','Tug','ASDS Tug','True',89811.0,198000.0);
INSERT INTO DroneShip VALUES ('5ea6ed30080df4000697c915','Port of Los Angeles','Pacific Warrior','Tug','ASDS Tug','False',351080.0,774000.0);
INSERT INTO DroneShip VALUES ('5ea6ed30080df4000697c916','Port Canaveral','RACHEL','Tug','ASDS Tug','False',312072.0,688000.0);
INSERT INTO DroneShip VALUES ('5ee68c683c228f36bd5809b5','Port Canaveral','Finn Falgout','Tug','Support Ship','True',843682.0,1860000.0);



INSERT INTO payloads VALUES('5eb0e4b5b6c3bb0006eeb1e1','FalconSAT-2','Satellite','False','SSTL',20.0,43.0,'LEO','geocentric','low-earth');
INSERT INTO payloads VALUES('5eb0e4b7b6c3bb0006eeb1e5','RatSat','Satellite','False','SpaceX',165.0,363.0,'LEO','geocentric','low-earth');
INSERT INTO payloads VALUES('5eb0e4b7b6c3bb0006eeb1e6','RazakSAT','Satellite','False','Satrec',200.0,440.0,'LEO','geocentric','low-earth');
INSERT INTO payloads VALUES('5eb0e4bab6c3bb0006eeb1eb','CRS-1','Dragon 1.0','False','SpaceX',400.0,881.0,'ISS','geocentric','low-earth');
INSERT INTO payloads VALUES('5eb0e4bab6c3bb0006eeb1ec','Orbcomm-OG2','Dragon 1.0','False','Not Disclosed',400.0,881.0,'LEO','geocentric','low-earth');
INSERT INTO payloads VALUES('5eb0e4bbb6c3bb0006eeb1ed','CRS-2','Dragon 1.0','False','SpaceX',677.0,1492.0,'ISS','geocentric','low-earth');
INSERT INTO payloads VALUES('5eb0e4bbb6c3bb0006eeb1ef','SES-8','Satellite','False','Orbital ATK',3170.0,6990.0,'GTO','geocentric','geostationary');
INSERT INTO payloads VALUES('5eb0e4bbb6c3bb0006eeb1f1','CRS-3','Dragon 1.1','False','SpaceX',2296.0,5062.0,'ISS','geocentric','low-earth');
INSERT INTO payloads VALUES('5eb0e4bcb6c3bb0006eeb1f2','Orbcomm-OG2-M1','Satellite','False','Boeing',1316.0,2901.0,'LEO','geocentric','low-earth');
INSERT INTO payloads VALUES('5eb0e4bcb6c3bb0006eeb1f3','AsiaSat 8','Satellite','False','SSL',4535.0,9998.0,'GTO','geocentric','geostationary');
INSERT INTO payloads VALUES('5eb0e4bcb6c3bb0006eeb1f4','AsiaSat 6','Satellite','False','SSL',4428.0,9762.0,'GTO','geocentric','geostationary');
INSERT INTO payloads VALUES('5eb0e4bcb6c3bb0006eeb1f5','CRS-4','Dragon 1.1','False','SpaceX',2216.0,4885.0,'ISS','geocentric','low-earth');
INSERT INTO payloads VALUES('5eb0e4bbb6c3bb0006eeb1ee','CASSIOPE','Satellite','False','MDA',500.0,1100.0,'PO','geocentric','low-earth');
INSERT INTO payloads VALUES('5eb0e4bbb6c3bb0006eeb1f0','Thaicom 6','Satellite','False','Orbital ATK',3325.0,7330.0,'GTO','geocentric','geostationary');
INSERT INTO payloads VALUES('5eb0e4beb6c3bb0006eeb1fb','TürkmenÄlem 52°E / MonacoSAT','Satellite','False','Thales Alenia Space',4707.0,10377.0,'GTO','geocentric','geostationary');
INSERT INTO payloads VALUES('5eb0e4bab6c3bb0006eeb1ea','COTS Demo Flight 2','Dragon 1.0','False','SpaceX',525.0,1157.0,'LEO','geocentric','low-earth');
INSERT INTO payloads VALUES('5eb0e4bdb6c3bb0006eeb1f6','CRS-5','Dragon 1.1','False','SpaceX',2395.0,5280.0,'ISS','geocentric','low-earth');
INSERT INTO payloads VALUES('5eb0e4bdb6c3bb0006eeb1f7','DSCOVR','Satellite','False','Sierra Nevada',570.0,1260.0,'ES-L1','heliocentric','L1-point');
INSERT INTO payloads VALUES('5eb0e4bdb6c3bb0006eeb1f8','ABS-3A','Satellite','False','Boeing',1954.0,4307.0,'GTO','geocentric','geostationary');
INSERT INTO payloads VALUES('5eb0e4bdb6c3bb0006eeb1f9','Eutelsat 115 West B','Satellite','False','Boeing',2205.0,4861.0,'GTO','geocentric','geostationary');
INSERT INTO payloads VALUES('5eb0e4bdb6c3bb0006eeb1fa','CRS-6','Dragon 1.1','False','SpaceX',1898.0,4184.0,'ISS','geocentric','low-earth');
INSERT INTO payloads VALUES('5eb0e4beb6c3bb0006eeb1fc','CRS-7','Dragon 1.1','False','SpaceX',2477.0,5460.9,'ISS','geocentric','low-earth');
INSERT INTO payloads VALUES('5eb0e4beb6c3bb0006eeb1fd','Orbcomm-OG2-M2','Satellite','False','Boeing',2034.0,4484.0,'LEO','geocentric','low-earth');
INSERT INTO payloads VALUES('5eb0e4beb6c3bb0006eeb1fe','Jason-3','Satellite','False','Thales Alenia Space',553.0,1219.0,'PO','geocentric','low-earth');
INSERT INTO payloads VALUES('5eb0e4beb6c3bb0006eeb1ff','SES-9','Satellite','False','Boeing',5271.0,11621.0,'GTO','geocentric','geostationary');
INSERT INTO payloads VALUES('5eb0e4bfb6c3bb0006eeb200','CRS-8','Dragon 1.1','False','SpaceX',3136.0,6914.0,'ISS','geocentric','low-earth');
INSERT INTO payloads VALUES('5eb0e4bfb6c3bb0006eeb201','JCSAT-2B','Satellite','False','SSL',4696.0,10353.0,'GTO','geocentric','geostationary');
INSERT INTO payloads VALUES('5eb0e4bfb6c3bb0006eeb203','ABS-2A','Satellite','False','Boeing',1800.0,3950.0,'GTO','geocentric','geostationary');
INSERT INTO payloads VALUES('5eb0e4bfb6c3bb0006eeb204','Eutelsat 117 West B','Satellite','False','Boeing',1800.0,3950.0,'GTO','geocentric','geostationary');
INSERT INTO payloads VALUES('5eb0e4c0b6c3bb0006eeb205','CRS-9','Dragon 1.1','False','SpaceX',2257.0,4976.0,'ISS','geocentric','low-earth');
INSERT INTO payloads VALUES('5eb0e4c1b6c3bb0006eeb206','JCSAT-16','Satellite','False','SSL',4600.0,10100.0,'GTO','geocentric','geostationary');
INSERT INTO payloads VALUES('5eb0e4c1b6c3bb0006eeb207','Amos-6','Satellite','False','Israel Aerospace Industries',5500.0,12100.0,'GTO','geocentric','geostationary');
INSERT INTO payloads VALUES('5eb0e4c2b6c3bb0006eeb208','Iridium NEXT 1','Satellite','False','Thales Alenia Space',9600.0,21200.0,'PO','geocentric','low-earth');
INSERT INTO payloads VALUES('5eb0e4c3b6c3bb0006eeb209','CRS-10','Dragon 1.1','False','SpaceX',2490.0,5490.0,'ISS','geocentric','low-earth');
INSERT INTO payloads VALUES('5eb0e4c3b6c3bb0006eeb20b','SES-10','Satellite','False','Airbus Defence and Space',5300.0,11700.0,'GTO','geocentric','geostationary');
INSERT INTO payloads VALUES('5eb0e4c3b6c3bb0006eeb20d','Inmarsat-5 F4','Satellite','False','Boeing',6070.0,13380.0,'GTO','geocentric','geostationary');
INSERT INTO payloads VALUES('5eb0e4c4b6c3bb0006eeb20e','CRS-11','Dragon 1.1','True','SpaceX',2708.0,5970.0,'ISS','geocentric','low-earth');
INSERT INTO payloads VALUES('5eb0e4c3b6c3bb0006eeb20a','EchoStar 23','Satellite','False','Airbus Defence and Space',5600.0,12399.0,'GTO','geocentric','geostationary');
INSERT INTO payloads VALUES('5eb0e4c4b6c3bb0006eeb210','Iridium NEXT 2','Satellite','False','Thales Alenia Space',9600.0,21164.0,'PO','geocentric','low-earth');
INSERT INTO payloads VALUES('5eb0e4c4b6c3bb0006eeb211','Intelsat 35e','Satellite','False','Boeing',6761.0,14905.45,'GTO','geocentric','geosynchronous');
INSERT INTO payloads VALUES('5eb0e4c4b6c3bb0006eeb212','CRS-12','Dragon 1.1','False','SpaceX',2910.0,6415.5,'ISS','geocentric','low-earth');
INSERT INTO payloads VALUES('5eb0e4c4b6c3bb0006eeb213','FormoSat-5','Satellite','False','NSPO',475.0,1047.0,'SSO','geocentric','sun-synchronous');
INSERT INTO payloads VALUES('5eb0e4c5b6c3bb0006eeb214','X-37B OTV-5','Satellite','False','Boeing Defense',4990.0,11001.0,'LEO','geocentric','low-earth');
INSERT INTO payloads VALUES('5eb0e4c5b6c3bb0006eeb215','Iridium NEXT 3','Satellite','False','Thales Alenia Space',9600.0,21164.4,'PO','geocentric','low-earth');
INSERT INTO payloads VALUES('5eb0e4c5b6c3bb0006eeb216','SES-11 / Echostar 105','Satellite','False','Airbus Defence and Space',5200.0,11464.0,'GTO','geocentric','geostationary');
INSERT INTO payloads VALUES('5eb0e4c5b6c3bb0006eeb217','KoreaSat 5A','Satellite','False','Thales Alenia Space',3700.0,8157.104,'GTO','geocentric','geostationary');
INSERT INTO payloads VALUES('5eb0e4c5b6c3bb0006eeb218','CRS-13','Dragon 1.1','True','SpaceX',2205.0,4861.2,'ISS','geocentric','low-earth');
INSERT INTO payloads VALUES('5eb0e4c6b6c3bb0006eeb219','Iridium NEXT 4','Satellite','False','Thales Alenia Space',9600.0,21164.38,'PO','geocentric','low-earth');
INSERT INTO payloads VALUES('5eb0e4c6b6c3bb0006eeb21b','GovSat-1','Satellite','False','Orbital ATK',4230.0,9325.6,'GTO','geocentric','geostationary');
INSERT INTO payloads VALUES('5eb0e4c6b6c3bb0006eeb21d','Paz','Satellite','False','Airbus Defence and Space',1350.0,2976.2,'SSO','geocentric','sun-synchronous');
INSERT INTO payloads VALUES('5eb0e4c6b6c3bb0006eeb21e','Tintin A & B','Satellite','False','SpaceX',800.0,1763.7,'SSO','geocentric','low-earth');
INSERT INTO payloads VALUES('5eb0e4c7b6c3bb0006eeb21f','Hispasat 30W-6','Satellite','False','SSL',6092.0,13430.6,'GTO','geocentric','geostationary');
INSERT INTO payloads VALUES('5eb0e4c7b6c3bb0006eeb220','Iridium NEXT 5','Satellite','False','Thales Alenia Space',9600.0,21164.38,'PO','geocentric','low-earth');
INSERT INTO payloads VALUES('5eb0e4c7b6c3bb0006eeb221','CRS-14','Dragon 1.1','True','SpaceX',2760.0,6084.7,'ISS','geocentric','low-earth');
INSERT INTO payloads VALUES('5eb0e4c7b6c3bb0006eeb222','TESS','Satellite','False','Orbital ATK',350.0,772.0,'HEO','highly-elliptical','high-earth');
INSERT INTO payloads VALUES('5eb0e4c7b6c3bb0006eeb224','Iridium NEXT 6','Satellite','False','Thales Alenia Space',4300.0,9479.9,'PO','geocentric','low-earth');
INSERT INTO payloads VALUES('5eb0e4c8b6c3bb0006eeb225','GRACE-FO 1-2','Satellite','False','Not Disclosed',1160.0,2557.4,'PO','geocentric','sun-synchronous');
INSERT INTO payloads VALUES('5eb0e4c8b6c3bb0006eeb226','SES-12','Satellite','False','Airbus Defence and Space',5383.85,11869.4,'GTO','geocentric','geostationary');
INSERT INTO payloads VALUES('5eb0e4c8b6c3bb0006eeb227','CRS-15','Dragon 1.1','True','SpaceX',2410.0,5313.0,'ISS','geocentric','low-earth');
INSERT INTO payloads VALUES('5eb0e4c8b6c3bb0006eeb228','Telstar 19V','Satellite','False','SSL',7076.0,15600.0,'GTO','geocentric','geostationary');
INSERT INTO payloads VALUES('5eb0e4c9b6c3bb0006eeb229','Iridium NEXT 7','Satellite','False','Thales Alenia Space',9600.0,21164.38,'PO','geocentric','low-earth');
INSERT INTO payloads VALUES('5eb0e4c9b6c3bb0006eeb22a','Telkom-4','Satellite','False','SSL',5800.0,12786.81,'GTO','geocentric','geostationary');
INSERT INTO payloads VALUES('5eb0e4c9b6c3bb0006eeb22b','Telstar 18V','Satellite','False','SSL',7060.0,15564.64,'GTO','geocentric','geostationary');
INSERT INTO payloads VALUES('5eb0e4c9b6c3bb0006eeb22c','SAOCOM 1A','Satellite','False','INVAP',2800.0,6172.94,'SSO','geocentric','sun-synchronous');
INSERT INTO payloads VALUES('5eb0e4c9b6c3bb0006eeb22d','Es’hail 2','Satellite','False','Mitsubishi Electric',3000.0,6613.868,'GTO','geocentric','geostationary');
INSERT INTO payloads VALUES('5eb0e4c9b6c3bb0006eeb22e', 'SSO-A','Satellite','False','Spaceflight Industries, Inc',4000.0,8818.49,'SSO','geocentric','sun-synchronous');
INSERT INTO payloads VALUES('5eb0e4cab6c3bb0006eeb22f','CRS-16','Dragon 1.1','True','SpaceX',2573.0,5672.4940000000015,'ISS','geocentric','low-earth');
INSERT INTO payloads VALUES('5eb0e4c4b6c3bb0006eeb20f','BulgariaSat-1','Satellite','False','SSL',3669.0,8089.0,'GTO','geocentric','geostationary');
INSERT INTO payloads VALUES('5eb0e4c7b6c3bb0006eeb223','Bangabandhu-1','Satellite','False','Thales Alenia Space',3750.0,8270.0,'GTO','geocentric','geostationary');
INSERT INTO payloads VALUES('5eb0e4cab6c3bb0006eeb230','GPS III SV01','Satellite','False','Lockheed Martin',4400.0,9700.34,'MEO','geocentric','semi-synchronous');
INSERT INTO payloads VALUES('5eb0e4cab6c3bb0006eeb231','Iridium NEXT 8','Satellite','False','Thales Alenia Space',9600.0,21164.38,'PO','geocentric','low-earth');
INSERT INTO payloads VALUES('5eb0e4cab6c3bb0006eeb232','Nusantara Satu (PSN-6)','Satellite','False','SSL',5000.0,11023.11,'GTO','geocentric','geostationary');
INSERT INTO payloads VALUES('5eb0e4cab6c3bb0006eeb233','S5','Satellite','False','Applied Defense Systems',60.0,132.28,'GTO','geocentric','geostationary');
INSERT INTO payloads VALUES('5eb0e4cab6c3bb0006eeb234','Beresheet','Lander','False','SSL',585.0,1289.7,'GTO','geocentric','highly-elliptical');
INSERT INTO payloads VALUES('5eb0e4cbb6c3bb0006eeb235','CCtCap Demo Mission 1','Crew Dragon','False','SpaceX',12259.0,27026.47,'ISS','geocentric','low-earth');
INSERT INTO payloads VALUES('5eb0e4cbb6c3bb0006eeb236','ArabSat 6A','Satellite','False','Lockheed Martin',6000.0,13227.74,'GTO','geocentric','geostationary');
INSERT INTO payloads VALUES('5eb0e4cbb6c3bb0006eeb237','CRS-17','Dragon 1.1','True','SpaceX',2482.0,5472.0,'ISS','geocentric','low-earth');
INSERT INTO payloads VALUES('5eb0e4cbb6c3bb0006eeb238','Starlink v0.9','Satellite','False','SpaceX',13620.0,30027.0,'VLEO','geocentric','very-low-earth');
INSERT INTO payloads VALUES('5eb0e4ccb6c3bb0006eeb239','RADARSAT Constellation','Satellite','False','Maxar Technologies',1425.0,3141.59,'SSO','geocentric','sun-synchronous');
INSERT INTO payloads VALUES('5eb0e4ccb6c3bb0006eeb23b','COSMIC-2','Satellite','False','National Space Organization',1668.0,3677.3,'LEO','geocentric','low-earth');
INSERT INTO payloads VALUES('5eb0e4ccb6c3bb0006eeb23c','GPIM','Satellite','False','Ball Aerospace & Technologies Corp',180.0,396.0,'LEO','geocentric','low-earth');



INSERT INTO First_stage_Recovery VALUES ('5ea6ed2d080df4000697c901','5e9d0d95eda69955f709d1eb','Fairing Recovery');
INSERT INTO First_stage_Recovery VALUES ('5ea6ed2e080df4000697c908','5e9d0d95eda69973a809d1ec','ASDS Tug');
INSERT INTO First_stage_Recovery VALUES ('5ea6ed2e080df4000697c90a','5e9d0d95eda69955f709d1eb','Fairing Recovery');
INSERT INTO First_stage_Recovery VALUES ('5ea6ed2f080df4000697c90d','5e9d0d95eda69973a809d1ec','Support Ship');
INSERT INTO First_stage_Recovery VALUES ('5ea6ed2d080df4000697c907','5e9d0d95eda69974db09d1ed','Support Ship');
INSERT INTO First_stage_Recovery VALUES ('5ea6ed2d080df4000697c907','5e9d0d95eda69955f709d1eb','ASDS Tug');
INSERT INTO First_stage_Recovery VALUES ('5ea6ed30080df4000697c916','5e9d0d95eda69973a809d1ec','ASDS Tug');
INSERT INTO First_stage_Recovery VALUES ('5ea6ed2e080df4000697c908','5e9d0d95eda69973a809d1ec','Fairing Recovery');
INSERT INTO First_stage_Recovery VALUES ('5ea6ed2e080df4000697c90a','5e9d0d95eda69973a809d1ec','ASDS Tug');
INSERT INTO First_stage_Recovery VALUES ('5ea6ed2f080df4000697c90d','5e9d0d95eda69955f709d1eb','Fairing Recovery');

INSERT INTO Launches VALUES ('5e9e4501f509094ba4566f84' ,'5e9d0d95eda69973a809d1ec', 'CCAFS SLC 40','active');
INSERT INTO Launches VALUES ('5e9e4502f5090995de566f86' ,'5e9d0d95eda69955f709d1eb', 'Kwajalein Atoll','retired');
INSERT INTO Launches VALUES ('5e9e4502f5090927f8566f85' ,'5e9d0d95eda69973a809d1ec', 'STLS','under construction');
INSERT INTO Launches VALUES ('5e9e4502f509092b78566f87' ,'5e9d0d95eda69973a809d1ec', 'VAFB SLC 4E','active');
INSERT INTO Launches VALUES ('5e9e4502f509092b78566f87' ,'5e9d0d95eda69973a809d1ec', 'VAFB SLC 4E','active');
INSERT INTO Launches VALUES ('5e9e4502f5090927f8566f85' ,'5e9d0d95eda69973a809d1ec', 'STLS','under construction');
INSERT INTO Launches VALUES ('5e9e4501f509094ba4566f84' ,'5e9d0d95eda69973a809d1ec', 'CCAFS SLC 40','active');
INSERT INTO Launches VALUES ('5e9e4501f509094ba4566f84' ,'5e9d0d95eda69973a809d1ec', 'CCAFS SLC 40','active');
INSERT INTO Launches VALUES ('5e9e4501f509094ba4566f84' ,'5e9d0d95eda69973a809d1ec', 'CCAFS SLC 40','active');
INSERT INTO Launches VALUES ('5e9e4502f5090995de566f86' ,'5e9d0d95eda69973a809d1ec', 'Kwajalein Atoll','retired');
INSERT INTO Launches VALUES ('5e9e4502f5090995de566f86' ,'5e9d0d95eda69973a809d1ec', 'Kwajalein Atoll','retired');
INSERT INTO Launches VALUES ('5e9e4502f509094188566f88' ,'5e9d0d95eda69973a809d1ec', 'KSC LC 39A','active');
INSERT INTO Launches VALUES ('5e9e4502f5090995de566f86' ,'5e9d0d95eda69973a809d1ec', 'Kwajalein Atoll','retired');
INSERT INTO Launches VALUES ('5e9e4502f509094188566f88' ,'5e9d0d95eda69974db09d1ed', 'KSC LC 39A','active');
INSERT INTO Launches VALUES ('5e9e4502f5090995de566f86' ,'5e9d0d95eda69973a809d1ec', 'Kwajalein Atoll','retired');
INSERT INTO Launches VALUES ('5e9e4502f509094188566f88' ,'5e9d0d95eda69973a809d1ec', 'KSC LC 39A','active');
INSERT INTO Launches VALUES ('5e9e4502f5090927f8566f85' ,'5e9d0d95eda69973a809d1ec', 'STLS','under construction');
INSERT INTO Launches VALUES ('5e9e4502f5090927f8566f85' ,'5e9d0d95eda69973a809d1ec', 'STLS','under construction');
INSERT INTO Launches VALUES ('5e9e4501f509094ba4566f84' ,'5e9d0d95eda69973a809d1ec', 'CCAFS SLC 40','active');
INSERT INTO Launches VALUES ('5e9e4502f5090927f8566f85' ,'5e9d0d95eda69973a809d1ec', 'STLS','under construction');
INSERT INTO Launches VALUES ('5e9e4502f509094188566f88' ,'5e9d0d95eda69973a809d1ec', 'KSC LC 39A','active');
INSERT INTO Launches VALUES ('5e9e4502f5090995de566f86' ,'5e9d0d95eda69973a809d1ec', 'Kwajalein Atoll','retired');
INSERT INTO Launches VALUES ('5e9e4502f5090927f8566f85' ,'5e9d0d95eda69973a809d1ec', 'STLS','under construction');
INSERT INTO Launches VALUES ('5e9e4502f5090995de566f86' ,'5e9d0d95eda69973a809d1ec', 'Kwajalein Atoll','retired');
INSERT INTO Launches VALUES ('5e9e4501f509094ba4566f84' ,'5e9d0d95eda69973a809d1ec', 'CCAFS SLC 40','active');

INSERT INTO Missions VALUES ('2006-03-24T22:30:00.000', 'FalconSat','5e9d0d95eda69955f709d1eb','5e9e4502f5090995de566f86','5eb87cd9ffd86e000604b32a','5eb0e4b5b6c3bb0006eeb1e1','False');
INSERT INTO Missions VALUES ('2007-03-21T01:10:00.000', 'DemoSat','5e9d0d95eda69955f709d1eb','5e9e4502f5090995de566f86','5eb87cdaffd86e000604b32b','5eb0e4b7b6c3bb0006eeb1e5','False');
INSERT INTO Missions VALUES ('2008-08-03T03:34:00.000', 'Trailblazer','5e9d0d95eda69955f709d1eb','5e9e4502f5090995de566f86','5eb87cdbffd86e000604b32c','5eb0e4b7b6c3bb0006eeb1e6','False');
INSERT INTO Missions VALUES ('2008-09-28T23:15:00.000', 'RatSat','5e9d0d95eda69955f709d1eb','5e9e4502f5090995de566f86','5eb87cdbffd86e000604b32d','5eb0e4bab6c3bb0006eeb1ea','True');
INSERT INTO Missions VALUES ('2009-07-13T03:35:00.000', 'RazakSat','5e9d0d95eda69955f709d1eb','5e9e4502f5090995de566f86','5eb87cdcffd86e000604b32e','5eb0e4bab6c3bb0006eeb1eb','True');
INSERT INTO Missions VALUES ('2010-06-04T18:45:00.000', 'Falcon 9 Test Flight','5e9d0d95eda69973a809d1ec','5e9e4501f509094ba4566f84','5eb87cddffd86e000604b32f','5eb0e4bab6c3bb0006eeb1ec','True');
INSERT INTO Missions VALUES ('2010-12-08T15:43:00.000', 'COTS 1','5e9d0d95eda69973a809d1ec','5e9e4501f509094ba4566f84','5eb87cdeffd86e000604b330','5eb0e4bbb6c3bb0006eeb1ed','True');
INSERT INTO Missions VALUES ('2012-05-22T07:44:00.000', 'COTS 2','5e9d0d95eda69973a809d1ec','5e9e4501f509094ba4566f84','5eb87cdfffd86e000604b331','5eb0e4bbb6c3bb0006eeb1ee','True');
INSERT INTO Missions VALUES ('2012-10-08T00:35:00.000', 'CRS-1','5e9d0d95eda69973a809d1ec','5e9e4501f509094ba4566f84','5eb87ce0ffd86e000604b332','5eb0e4bbb6c3bb0006eeb1ef','True');
INSERT INTO Missions VALUES ('2013-03-01T19:10:00.000', 'CRS-2','5e9d0d95eda69973a809d1ec','5e9e4501f509094ba4566f84','5eb87ce1ffd86e000604b333','5eb0e4bbb6c3bb0006eeb1f0','True');
INSERT INTO Missions VALUES ('2013-09-29T16:00:00.000', 'CASSIOPE','5e9d0d95eda69973a809d1ec','5e9e4502f509092b78566f87','5eb87ce1ffd86e000604b334','5eb0e4bbb6c3bb0006eeb1f1','True');
INSERT INTO Missions VALUES ('2013-12-03T22:41:00.000', 'SES-8','5e9d0d95eda69973a809d1ec','5e9e4501f509094ba4566f84','5eb87ce2ffd86e000604b335','5eb0e4bcb6c3bb0006eeb1f2','True');
INSERT INTO Missions VALUES ('2014-01-06T18:06:00.000', 'Thaicom 6','5e9d0d95eda69973a809d1ec','5e9e4501f509094ba4566f84','5eb87ce3ffd86e000604b336','5eb0e4bcb6c3bb0006eeb1f3','True');
INSERT INTO Missions VALUES ('2014-04-18T19:25:00.000', 'CRS-3','5e9d0d95eda69973a809d1ec','5e9e4501f509094ba4566f84','5eb87ce4ffd86e000604b337','5eb0e4bcb6c3bb0006eeb1f4','True');
INSERT INTO Missions VALUES ('2014-07-14T15:15:00.000', 'OG-2 Mission 1','5e9d0d95eda69973a809d1ec','5e9e4501f509094ba4566f84','5eb87ce4ffd86e000604b338','5eb0e4bcb6c3bb0006eeb1f5','True');
INSERT INTO Missions VALUES ('2014-08-05T08:00:00.000', 'AsiaSat 8','5e9d0d95eda69973a809d1ec','5e9e4501f509094ba4566f84','5eb87ce5ffd86e000604b339','5eb0e4bdb6c3bb0006eeb1f6','True');
INSERT INTO Missions VALUES ('2014-09-07T05:00:00.000', 'AsiaSat 6','5e9d0d95eda69973a809d1ec','5e9e4501f509094ba4566f84','5eb87ce6ffd86e000604b33a','5eb0e4bdb6c3bb0006eeb1f7','True');
INSERT INTO Missions VALUES ('2014-09-21T05:52:00.000', 'CRS-4','5e9d0d95eda69973a809d1ec','5e9e4501f509094ba4566f84','5eb87ce7ffd86e000604b33b','5eb0e4bdb6c3bb0006eeb1f8','True');
INSERT INTO Missions VALUES ('2015-01-10T09:47:00.000', 'CRS-5','5e9d0d95eda69973a809d1ec','5e9e4501f509094ba4566f84','5eb87ce8ffd86e000604b33c','5eb0e4bdb6c3bb0006eeb1f9','True');
INSERT INTO Missions VALUES ('2015-02-11T23:03:00.000', 'DSCOVR','5e9d0d95eda69973a809d1ec','5e9e4501f509094ba4566f84','5eb87ceaffd86e000604b33d','5eb0e4bdb6c3bb0006eeb1fa','True');
INSERT INTO Missions VALUES ('2015-03-02T03:50:00.000', 'ABS-3A / Eutelsat 115W B','5e9d0d95eda69973a809d1ec','5e9e4501f509094ba4566f84','5eb87ceaffd86e000604b33e','5eb0e4beb6c3bb0006eeb1fb','True');
INSERT INTO Missions VALUES ('2015-04-14T20:10:00.000', 'CRS-6','5e9d0d95eda69973a809d1ec','5e9e4501f509094ba4566f84','5eb87cecffd86e000604b33f','5eb0e4beb6c3bb0006eeb1fc','True');
INSERT INTO Missions VALUES ('2015-04-27T23:03:00.000', 'TürkmenÄlem 52°E / MonacoSAT','5e9d0d95eda69973a809d1ec','5e9e4501f509094ba4566f84','5eb87cedffd86e000604b340','5eb0e4beb6c3bb0006eeb1fd','True');
INSERT INTO Missions VALUES ('2015-06-28T14:21:00.000', 'CRS-7','5e9d0d95eda69973a809d1ec','5e9e4501f509094ba4566f84','5eb87ceeffd86e000604b341','5eb0e4beb6c3bb0006eeb1fe','False');
INSERT INTO Missions VALUES ('2015-12-22T01:29:00.000', 'OG-2 Mission 2','5e9d0d95eda69973a809d1ec','5e9e4501f509094ba4566f84','5eb87cefffd86e000604b342','5eb0e4beb6c3bb0006eeb1ff','True');
INSERT INTO Missions VALUES ('2016-01-17T15:42:00.000', 'Jason 3','5e9d0d95eda69973a809d1ec','5e9e4502f509092b78566f87','5eb87cf0ffd86e000604b343','5eb0e4bfb6c3bb0006eeb200','True');
INSERT INTO Missions VALUES ('2016-03-04T23:35:00.000', 'SES-9','5e9d0d95eda69973a809d1ec','5e9e4501f509094ba4566f84','5eb87cf2ffd86e000604b344','5eb0e4bfb6c3bb0006eeb201','True');
INSERT INTO Missions VALUES ('2016-05-06T05:21:00.000', 'JCSAT-2B','5e9d0d95eda69973a809d1ec','5e9e4501f509094ba4566f84','5eb87cf5ffd86e000604b346','5eb0e4bfb6c3bb0006eeb203','True');
INSERT INTO Missions VALUES ('2016-05-27T21:39:00.000', 'Thaicom 8','5e9d0d95eda69973a809d1ec','5e9e4501f509094ba4566f84','5eb87cf6ffd86e000604b347','5eb0e4bfb6c3bb0006eeb204','True');
INSERT INTO Missions VALUES ('2016-06-15T14:29:00.000', 'ABS-2A / Eutelsat 117W B','5e9d0d95eda69973a809d1ec','5e9e4501f509094ba4566f84','5eb87cf8ffd86e000604b348','5eb0e4c0b6c3bb0006eeb205','True');
INSERT INTO Missions VALUES ('2016-07-18T04:45:00.000', 'CRS-9','5e9d0d95eda69973a809d1ec','5e9e4501f509094ba4566f84','5eb87cf9ffd86e000604b349','5eb0e4c1b6c3bb0006eeb206','True');
INSERT INTO Missions VALUES ('2016-08-14T05:26:00.000', 'JCSAT-16','5e9d0d95eda69973a809d1ec','5e9e4501f509094ba4566f84','5eb87cfaffd86e000604b34a','5eb0e4c1b6c3bb0006eeb207','True');
INSERT INTO Missions VALUES ('2016-09-01T13:07:00.000', 'Amos-6','5e9d0d95eda69973a809d1ec','5e9e4501f509094ba4566f84','5eb87cfbffd86e000604b34b','5eb0e4c2b6c3bb0006eeb208','False');
INSERT INTO Missions VALUES ('2017-01-14T17:54:00.000', 'Iridium NEXT Mission 1','5e9d0d95eda69973a809d1ec','5e9e4502f509092b78566f87','5eb87cfdffd86e000604b34c','5eb0e4c3b6c3bb0006eeb209','True');
INSERT INTO Missions VALUES ('2017-02-19T14:39:00.000', 'CRS-10','5e9d0d95eda69973a809d1ec','5e9e4502f509094188566f88','5eb87cfeffd86e000604b34d','5eb0e4c3b6c3bb0006eeb20a','True');
INSERT INTO Missions VALUES ('2017-03-16T06:00:00.000', 'EchoStar 23','5e9d0d95eda69973a809d1ec','5e9e4502f509094188566f88','5eb87cfeffd86e000604b34e','5eb0e4c3b6c3bb0006eeb20b','True');
INSERT INTO Missions VALUES ('2017-03-30T22:27:00.000', 'SES-10','5e9d0d95eda69973a809d1ec','5e9e4502f509094188566f88','5eb87d00ffd86e000604b34f','5eb0e4c3b6c3bb0006eeb20d','True');
INSERT INTO Missions VALUES ('2017-05-01T11:15:00.000', 'NROL-76','5e9d0d95eda69973a809d1ec','5e9e4502f509094188566f88','5eb87d01ffd86e000604b350','5eb0e4c4b6c3bb0006eeb20e','True');
INSERT INTO Missions VALUES ('2017-05-15T23:21:00.000', 'Inmarsat-5 F4','5e9d0d95eda69973a809d1ec','5e9e4502f509094188566f88','5eb87d01ffd86e000604b351','5eb0e4c4b6c3bb0006eeb20f','True');
INSERT INTO Missions VALUES ('2017-06-03T21:07:00.000', 'CRS-11','5e9d0d95eda69973a809d1ec','5e9e4502f509094188566f88','5eb87d03ffd86e000604b352','5eb0e4c4b6c3bb0006eeb210','True');
INSERT INTO Missions VALUES ('2017-06-23T19:10:00.000', 'BulgariaSat-1','5e9d0d95eda69973a809d1ec','5e9e4502f509094188566f88','5eb87d04ffd86e000604b353','5eb0e4c4b6c3bb0006eeb211','True');
INSERT INTO Missions VALUES ('2017-06-25T20:25:00.000', 'Iridium NEXT Mission 2','5e9d0d95eda69973a809d1ec','5e9e4502f509092b78566f87','5eb87d05ffd86e000604b354','5eb0e4c4b6c3bb0006eeb212','True');
INSERT INTO Missions VALUES ('2017-07-05T23:35:00.000', 'Intelsat 35e','5e9d0d95eda69973a809d1ec','5e9e4502f509094188566f88','5eb87d06ffd86e000604b355','5eb0e4c4b6c3bb0006eeb213','True');
INSERT INTO Missions VALUES ('2017-08-14T16:31:00.000', 'CRS-12','5e9d0d95eda69973a809d1ec','5e9e4502f509094188566f88','5eb87d07ffd86e000604b356','5eb0e4c5b6c3bb0006eeb214','True');
INSERT INTO Missions VALUES ('2017-08-24T18:50:00.000', 'FormoSat-5','5e9d0d95eda69973a809d1ec','5e9e4502f509092b78566f87','5eb87d08ffd86e000604b357','5eb0e4c5b6c3bb0006eeb215','True');
INSERT INTO Missions VALUES ('2017-09-07T13:50:00.000', 'Boeing X-37B OTV-5','5e9d0d95eda69973a809d1ec','5e9e4502f509094188566f88','5eb87d09ffd86e000604b358','5eb0e4c5b6c3bb0006eeb216','True');
INSERT INTO Missions VALUES ('2017-10-09T12:37:00.000', 'Iridium NEXT Mission 3','5e9d0d95eda69973a809d1ec','5e9e4502f509092b78566f87','5eb87d0affd86e000604b359','5eb0e4c5b6c3bb0006eeb217','True');
INSERT INTO Missions VALUES ('2017-10-11T22:53:00.000', 'SES-11 / Echostar 105','5e9d0d95eda69973a809d1ec','5e9e4502f509094188566f88','5eb87d0cffd86e000604b35a','5eb0e4c5b6c3bb0006eeb218','True');
INSERT INTO Missions VALUES ('2017-10-30T19:34:00.000', 'KoreaSat 5A','5e9d0d95eda69973a809d1ec','5e9e4502f509094188566f88','5eb87d0dffd86e000604b35b','5eb0e4c6b6c3bb0006eeb219','True');
INSERT INTO Missions VALUES ('2017-12-15T15:36:00.000', 'CRS-13','5e9d0d95eda69973a809d1ec','5e9e4501f509094ba4566f84','5eb87d0effd86e000604b35c','5eb0e4c6b6c3bb0006eeb21b','True');
INSERT INTO Missions VALUES ('2017-12-23T01:27:23.000', 'Iridium NEXT Mission 4','5e9d0d95eda69973a809d1ec','5e9e4502f509092b78566f87','5eb87d0fffd86e000604b35d','5eb0e4c6b6c3bb0006eeb21d','True');
INSERT INTO Missions VALUES ('2018-01-08T01:00:00.000', 'ZUMA','5e9d0d95eda69973a809d1ec','5e9e4501f509094ba4566f84','5eb87d10ffd86e000604b35e','5eb0e4c6b6c3bb0006eeb21e','True');
INSERT INTO Missions VALUES ('2018-01-31T21:25:00.000', 'SES-16 / GovSat-1','5e9d0d95eda69973a809d1ec','5e9e4501f509094ba4566f84','5eb87d11ffd86e000604b35f','5eb0e4c7b6c3bb0006eeb21f','True');
INSERT INTO Missions VALUES ('2018-02-06T20:45:00.000', 'Falcon Heavy Test Flight','5e9d0d95eda69974db09d1ed','5e9e4502f509094188566f88','5eb87d13ffd86e000604b360','5eb0e4c7b6c3bb0006eeb220','True');
INSERT INTO Missions VALUES ('2018-02-22T14:17:00.000', 'Paz / Starlink Demo','5e9d0d95eda69973a809d1ec','5e9e4502f509092b78566f87','5eb87d14ffd86e000604b361','5eb0e4c7b6c3bb0006eeb221','True');
INSERT INTO Missions VALUES ('2018-03-06T05:33:00.000', 'Hispasat 30W-6','5e9d0d95eda69973a809d1ec','5e9e4501f509094ba4566f84','5eb87d15ffd86e000604b362','5eb0e4c7b6c3bb0006eeb222','True');
INSERT INTO Missions VALUES ('2018-03-30T14:13:51.000', 'Iridium NEXT Mission 5','5e9d0d95eda69973a809d1ec','5e9e4502f509092b78566f87','5eb87d16ffd86e000604b363','5eb0e4c7b6c3bb0006eeb223','True');
INSERT INTO Missions VALUES ('2018-04-02T20:30:41.000', 'CRS-14','5e9d0d95eda69973a809d1ec','5e9e4501f509094ba4566f84','5eb87d16ffd86e000604b364','5eb0e4c7b6c3bb0006eeb224','True');
INSERT INTO Missions VALUES ('2018-04-18T22:51:00.000', 'TESS','5e9d0d95eda69973a809d1ec','5e9e4501f509094ba4566f84','5eb87d18ffd86e000604b365','5eb0e4c8b6c3bb0006eeb225','True');
INSERT INTO Missions VALUES ('2018-05-11T20:14:00.000', 'Bangabandhu-1','5e9d0d95eda69973a809d1ec','5e9e4502f509094188566f88','5eb87d19ffd86e000604b366','5eb0e4c8b6c3bb0006eeb226','True');
INSERT INTO Missions VALUES ('2018-05-22T19:47:58.000', 'Iridium NEXT Mission 6','5e9d0d95eda69973a809d1ec','5e9e4502f509092b78566f87','5eb87d1affd86e000604b367','5eb0e4c8b6c3bb0006eeb227','True');
INSERT INTO Missions VALUES ('2018-06-04T04:45:00.000', 'SES-12','5e9d0d95eda69973a809d1ec','5e9e4501f509094ba4566f84','5eb87d1bffd86e000604b368','5eb0e4c8b6c3bb0006eeb228','True');
INSERT INTO Missions VALUES ('2018-06-29T09:42:00.000', 'CRS-15','5e9d0d95eda69973a809d1ec','5e9e4501f509094ba4566f84','5eb87d1cffd86e000604b369','5eb0e4c9b6c3bb0006eeb229','True');
INSERT INTO Missions VALUES ('2018-07-22T05:50:00.000', 'Telstar 19V','5e9d0d95eda69973a809d1ec','5e9e4501f509094ba4566f84','5eb87d1effd86e000604b36a','5eb0e4c9b6c3bb0006eeb22a','True');
INSERT INTO Missions VALUES ('2018-07-25T11:39:26.000', 'Iridium NEXT Mission 7','5e9d0d95eda69973a809d1ec','5e9e4502f509092b78566f87','5eb87d1fffd86e000604b36b','5eb0e4c9b6c3bb0006eeb22b','True');
INSERT INTO Missions VALUES ('2018-08-07T05:18:00.000', 'Merah Putih','5e9d0d95eda69973a809d1ec','5e9e4501f509094ba4566f84','5eb87d20ffd86e000604b36c','5eb0e4c9b6c3bb0006eeb22c','True');
INSERT INTO Missions VALUES ('2018-09-10T04:45:00.000', 'Telstar 18V','5e9d0d95eda69973a809d1ec','5e9e4501f509094ba4566f84','5eb87d22ffd86e000604b36d','5eb0e4c9b6c3bb0006eeb22d','True');
INSERT INTO Missions VALUES ('2018-10-08T02:22:00.000', 'SAOCOM 1A','5e9d0d95eda69973a809d1ec','5e9e4502f509092b78566f87','5eb87d23ffd86e000604b36e','5eb0e4c9b6c3bb0006eeb22e','True');
INSERT INTO Missions VALUES ('2018-11-15T20:46:00.000', 'Es’hail 2','5e9d0d95eda69973a809d1ec','5e9e4502f509094188566f88','5eb87d24ffd86e000604b36f','5eb0e4cab6c3bb0006eeb22f','True');
INSERT INTO Missions VALUES ('2018-12-03T18:34:00.000', 'SSO-A','5e9d0d95eda69973a809d1ec','5e9e4502f509092b78566f87','5eb87d25ffd86e000604b370','5eb0e4cab6c3bb0006eeb230','True');
INSERT INTO Missions VALUES ('2018-12-05T18:16:00.000', 'CRS-16','5e9d0d95eda69973a809d1ec','5e9e4501f509094ba4566f84','5eb87d26ffd86e000604b371','5eb0e4cab6c3bb0006eeb231','True');


/*JOINS*/
SELECT rockets.name as Rocket_name, launches.name as Launch_name, rockets.cost_per_launch as Cost_per_launch
FROM Launches 
LEFT JOIN rockets ON launches.rocket_id = rockets.rocket_id;

SELECT missions.name as Mission_name, missions.date as Mission_date, missions.launch_status as Launch_status, payloads.orbit as Orbit
FROM Missions 
LEFT JOIN payloads ON missions.payload_id = payloads.payload_id; 

/*SET OPERATIONS*/

SELECT country, SUM(cost_per_launch)  FROM rockets GROUP BY country;

SELECT orbit, regime , reference_system , AVG(mass_kg) FROM payloads GROUP BY orbit,regime,reference_system;

SELECT name, COUNT(launch_id) FROM `Missions` GROUP BY rocket_id

/* SET OPERATIONS */
SELECT * FROM rockets WHERE rocket_id not in
( SELECT rocket_id FROM launches 
UNION
SELECT rocket_id FROM delivers);

SELECT rocket_id FROM Rockets 
UNION ALL 
SELECT rocket_id FROM Launches 
EXCEPT 
SELECT rocket_id FROM Delivers;


/*FUNCTIONS*/

DELIMITER $$
CREATE FUNCTION check_max_mass(orbit_g VARCHAR(20))
DETERMINISTIC
RETURNS INT
BEGIN
    DECLARE max_m int;
    SELECT max_mass into max_m from (SELECT orbit,max(mass_kg) as max_mass from     payloads group by orbit) as m WHERE orbit=orbit_g;
    RETURN max_m;
END;$$
DELIMITER ;

/*PROCUDURES*/

DELIMITER $$
CREATE procedure launch_in_months(IN @datee int) 
BEGIN
    SELECT launchpads.full_name as launchpad_name, rockets.name AS Rocket_name, payloads.name AS payload_name, launch_id ,missions.name ,launch_status  from ((missions inner join launchpads on missions.launchpad_id=launchpads.launchpad_id) inner join rockets on missions.rocket_id=rockets.rocket_id) inner join payloads on payloads.payload_id = missions.payload_id WHERE date LIKE CONCAT(datee,'%')
END; $$
DELIMITER ;

/*TRIGGERS*/

DELIMITER $$
CREATE TRIGGER change_mass_lb 
BEFORE INSERT
ON payloads FOR EACH ROW  
BEGIN  
    DECLARE error_msg VARCHAR(255);  
    DECLARE max_mass INT(10);
    SET error_msg = ('The new quantity cannot be greater than max weight');  
    SELECT MAX(mass_kg) into max_mass from payloads  where orbit=new.orbit group by orbit;
    IF new.mass_kg > max_mass THEN  
    SIGNAL SQLSTATE '45000'   
    SET MESSAGE_TEXT = error_msg;  
    END IF;  
END $$   
DELIMITER ;

/*CURSOR*/
DELIMITER $$
CREATE procedure cursor_drone(INOUT name_list VARCHAR(4000))
BEGIN
    DECLARE ship_name VARCHAR(30) DEFAULT "";
    DECLARE is_done INT DEFAULT 0;
    DECLARE PrintActiveDroneShips CURSOR FOR SELECT name FROM droneship WHERE activity = 'True';
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET is_done =1;
    OPEN PrintActiveDroneShips;   
    print_ships: LOOP
    FETCH PrintActiveDroneShips INTO ship_name;   
    IF is_done =1 THEN
    LEAVE print_ships;
    END IF;
    SET name_list = CONCAT(ship_name,";",name_list);
    END LOOP print_ships;
    CLOSE PrintActiveDroneShips;
END;$$
DELIMITER ;
