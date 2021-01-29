-- POMOCNICZE
DROP TABLE pracownik;
DROP TABLE stanowisko;
DROP TABLE adres;

-- 1. Tworzy tabelę pracownik(imie, nazwisko, wyplata, data urodzenia, stanowisko). W tabeli mogą być dodatkowe kolumny, które uznasz za niezbędne.
CREATE TABLE pracownik (
	id bigint primary key auto_increment,
    first_name varchar(20),
    last_name varchar(20),
    salary int,
    birthdate DATE,
    position varchar(50)
);

-- 2. Wstawia do tabeli co najmniej 6 pracowników
INSERT INTO pracownik(first_name, last_name, salary, birthdate, position)
VALUES ('Jan', 'Kasperek', 3000, '1998-10-12', "Gitarzysta"), 
('Dominik', 'Mikolajczyk', 6000,'1999-07-19', 'Gitarzysta'),
('Klaudia', 'Pawłat', 5000,'1999-05-19', 'Wokal'),
('Michał', 'Ziomek', 3100,'1997-05-10', 'Perkusista'), 
('Zenek', 'Maryniarz', 2500,'1994-04-24', 'Basista'),
('Karola', 'Włodarczyk', 4800,'1996-02-28', 'Wokal'),
('Andrzej', 'Malownik', 7000,'1990-01-1', 'Basista');

-- 3. Pobiera wszystkich pracowników i wyświetla ich w kolejności alfabetycznej po nazwisku
SELECT * FROM pracownik
ORDER BY last_name;

-- 4. Pobiera pracowników na wybranym stanowisku
SELECT * FROM pracownik WHERE position = 'Gitarzysta';

-- 5. Pobiera pracowników, którzy mają co najmniej 30 lat
SELECT * FROM pracownik 
WHERE FLOOR(DATEDIFF(CURDATE(), birthdate) / 365.25) >= 30;

-- 6. Zwiększa wypłatę pracowników na wybranym stanowisku o 10%
UPDATE pracownik SET salary = (salary + (salary * 0.1))
WHERE position = 'Gitarzysta';

-- 7. Usuwa najmłodszego pracownika
DELETE FROM pracownik
WHERE birthdate = (
	select birthdate from (
		SELECT MAX(birthdate) FROM pracownik
	) as t
);

-- 8. Usuwa tabelę pracownik
DROP TABLE pracownik;

-- 9. Tworzy tabelę stanowisko (nazwa stanowiska, opis, wypłata na danym stanowisku)
CREATE TABLE stanowisko (
	id BIGINT PRIMARY KEY AUTO_INCREMENT,
    nazwa VARCHAR(20) UNIQUE NOT NULL,
    opis VARCHAR(200) UNIQUE NOT NULL,
    wyplata_na_stan VARCHAR(20) UNIQUE NOT NULL
);

-- 10. Tworzy tabelę adres (ulica+numer domu/mieszkania, kod pocztowy, miejscowość)
CREATE TABLE adres (
	id BIGINT PRIMARY KEY AUTO_INCREMENT,
	ulica VARCHAR(20) UNIQUE NOT NULL,
    numer_domu_mieszkania VARCHAR(50) UNIQUE NOT NULL,
    kod_pocztowy INT UNIQUE NOT NULL,
    miejscowosc VARCHAR(50) UNIQUE NOT NULL
);

-- 11. Tworzy tabelę pracownik (imię, nazwisko) + relacje do tabeli stanowisko i adres
CREATE TABLE pracownik (
	id BIGINT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(20) UNIQUE NOT NULL,
    last_name VARCHAR(20) UNIQUE NOT NULL
);

-- 12. Dodaje dane testowe (w taki sposób, aby powstały pomiędzy nimi sensowne powiązania)
INSERT INTO pracownik (first_name, last_name)
VALUES ('Klaudia', 'Pawłat'), 
('Dominik', 'Mikol'),
('Bartek', 'Pierkura'),
('Karolina', 'Włodarczyk');

INSERT INTO stanowisko (ulica, numer_domu_mieszkania, kod_pocztowy, miejscowosc)
VALUES ('Baszkow', '42a', 98-290, 'Wroclaw'), 
('Zdunia', '1', 84-130, 'Zdunia'), 
('Poznan', '31b', 91-130, 'Poznac'), 
('Warszawa', '8', 92-230, 'Warszawa');

INSERT INTO stanowisko (nazwa, opis, wyplata_na_stan)
VALUES ('Gitarzysta', 'Granie na gitarze', 6000), 
('Wokal', 'Śpiewanko', 5500),
('Perkusita', 'Walenie w bębny', 5000),
('Basista', 'Granie na basie', 5800);
