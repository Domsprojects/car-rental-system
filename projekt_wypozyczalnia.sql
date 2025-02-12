-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Czas generowania: 12 Lut 2025, 20:36
-- Wersja serwera: 10.4.21-MariaDB
-- Wersja PHP: 8.0.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Baza danych: `projekt_wypozyczalnia`
--

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `archiwum`
--

CREATE TABLE `archiwum` (
  `id_archiwum` int(11) NOT NULL,
  `id_uzytkownika` int(11) NOT NULL,
  `id_samochodu` int(11) NOT NULL,
  `poczatek` date NOT NULL,
  `koniec` date NOT NULL,
  `status` varchar(20) COLLATE utf8_polish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Zrzut danych tabeli `archiwum`
--

INSERT INTO `archiwum` (`id_archiwum`, `id_uzytkownika`, `id_samochodu`, `poczatek`, `koniec`, `status`) VALUES
(49, 66, 1, '2022-01-13', '2022-01-14', 'zaakceptowane'),
(51, 69, 2, '2021-12-15', '2021-12-23', 'zaakceptowane'),
(52, 69, 1, '2021-12-16', '2021-12-30', 'oczekujace'),
(60, 67, 1, '2021-12-15', '2021-12-22', 'zaakceptowane'),
(67, 66, 1, '2021-12-15', '2021-12-23', 'zaakceptowane'),
(68, 66, 1, '2021-12-22', '2021-12-30', 'zaakceptowane'),
(69, 66, 1, '2021-12-01', '2021-12-12', 'zaakceptowane'),
(70, 66, 1, '2021-12-08', '2021-12-13', 'zaakceptowane'),
(71, 66, 2, '2021-12-15', '2021-12-17', 'oczekujace'),
(72, 66, 3, '2021-12-15', '2021-12-23', 'oczekujace');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `oferta`
--

CREATE TABLE `oferta` (
  `id_samochodu` int(11) NOT NULL,
  `marka` varchar(30) COLLATE utf8_polish_ci NOT NULL,
  `model` varchar(30) COLLATE utf8_polish_ci NOT NULL,
  `skrzynia` varchar(20) COLLATE utf8_polish_ci NOT NULL,
  `silnik` varchar(20) COLLATE utf8_polish_ci NOT NULL,
  `ilosc_osob` int(1) NOT NULL,
  `klimatyzacja` varchar(3) COLLATE utf8_polish_ci NOT NULL,
  `cena` int(4) NOT NULL,
  `sciezka_zdjecia` varchar(100) COLLATE utf8_polish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Zrzut danych tabeli `oferta`
--

INSERT INTO `oferta` (`id_samochodu`, `marka`, `model`, `skrzynia`, `silnik`, `ilosc_osob`, `klimatyzacja`, `cena`, `sciezka_zdjecia`) VALUES
(1, 'Toyota', 'Yaris', 'manualna', 'benzyna', 5, 'tak', 89, 'https://wypozyczalnia-aut24.pl/wp-content/uploads/2017/11/yaris-bia%C5%82y.jpg'),
(2, 'Toyota', 'Auris Kombi', 'manulana', 'benzyna', 5, 'tak', 119, 'https://wypozyczalnia-aut24.pl/wp-content/uploads/2017/11/toyota-auris-kombi.png'),
(3, 'Skoda', 'CitiGo', 'manualna', 'benzyna', 5, 'nie', 79, 'https://wypozyczalnia-aut24.pl/wp-content/uploads/2017/12/new-skoda-citigo-sport-53077-1.jpg'),
(4, 'Skoda', 'Octavia Kombi', 'automatyczna', 'benzyna', 5, 'tak', 149, 'https://wypozyczalnia-aut24.pl/wp-content/uploads/2017/11/octavia-kombi.jpg'),
(5, 'Ford', 'Focus Kombi', 'manualna', 'diesel', 5, 'tak', 109, 'https://wypozyczalnia-aut24.pl/wp-content/uploads/2017/11/focus-kombi.jpg'),
(6, 'Ford', 'Fiesta', 'manualna', 'benzyna', 5, 'nie', 79, 'https://wypozyczalnia-aut24.pl/wp-content/uploads/2017/11/fiesta-czarna.jpg');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `rezerwacje`
--

CREATE TABLE `rezerwacje` (
  `id_rezerwacji` int(11) NOT NULL,
  `id_samochodu` int(11) NOT NULL,
  `id_uzytkownika` int(11) NOT NULL,
  `poczatek` date NOT NULL,
  `koniec` date NOT NULL,
  `status` varchar(20) COLLATE utf8_polish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Zrzut danych tabeli `rezerwacje`
--

INSERT INTO `rezerwacje` (`id_rezerwacji`, `id_samochodu`, `id_uzytkownika`, `poczatek`, `koniec`, `status`) VALUES
(17, 1, 81, '2025-02-13', '2025-02-15', 'zaakceptowane');

--
-- Wyzwalacze `rezerwacje`
--
DELIMITER $$
CREATE TRIGGER `dodaj_do_archiwum` BEFORE DELETE ON `rezerwacje` FOR EACH ROW INSERT INTO archiwum(id_uzytkownika, id_samochodu, poczatek, koniec, status) VALUES(OLD.id_uzytkownika, OLD.id_samochodu, OLD.poczatek, OLD.koniec, OLD.status)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `uzytkownicy`
--

CREATE TABLE `uzytkownicy` (
  `id_uzytkownika` int(11) NOT NULL,
  `email` varchar(50) COLLATE utf8_polish_ci NOT NULL,
  `haslo` varchar(100) COLLATE utf8_polish_ci NOT NULL,
  `funkcja` varchar(20) COLLATE utf8_polish_ci NOT NULL,
  `status` varchar(20) COLLATE utf8_polish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Zrzut danych tabeli `uzytkownicy`
--

INSERT INTO `uzytkownicy` (`id_uzytkownika`, `email`, `haslo`, `funkcja`, `status`) VALUES
(66, 'a@a.pl', '$2y$10$Y2SS91QIbXzZ8HyKe7m8p.m1moV6USmHKaxeLSFPzSu6YFGkIjOFW', 'uzytkownik', 'aktywny'),
(67, 'admin@admin.pl', '$2y$10$CJtvcHzLCgCOkHbcfjcQyOniOasunGb/eFb.lgJ6er3vOAABUX9qq', 'administrator', 'aktywny'),
(68, 'mod@mod.pl', '$2y$10$oDnYfZdsLKsfpyiM7.eiH.qBnm7H9XHgwSY8MwrxasJ8Etp5unYCy', 'moderator', 'aktywny'),
(69, 'b@b.pl', '$2y$10$1KSt7ZRCYTKCi4M3tdEljeyEODyVs8UjukW6tLWWKcEqsp3A.KbeG', 'uzytkownik', 'aktywny'),
(80, 'c@c.pl', '$2y$10$J2gIm0EYCgkMykyypToN6uztodMrfxw5fOsWLb4Q0zGpWVdrM2Edu', 'uzytkownik', 'nieaktywny'),
(81, 'aa@aa.pl', '$2y$10$9.cG.WYBfP6ZEIkdQhEV5.HQ6j72bS.nk9qFGQ0XKKZ/OeDX3VZkS', 'uzytkownik', 'aktywny');

--
-- Indeksy dla zrzutów tabel
--

--
-- Indeksy dla tabeli `archiwum`
--
ALTER TABLE `archiwum`
  ADD PRIMARY KEY (`id_archiwum`),
  ADD KEY `id_uzytkownika` (`id_uzytkownika`),
  ADD KEY `id_samochodu` (`id_samochodu`);

--
-- Indeksy dla tabeli `oferta`
--
ALTER TABLE `oferta`
  ADD PRIMARY KEY (`id_samochodu`);

--
-- Indeksy dla tabeli `rezerwacje`
--
ALTER TABLE `rezerwacje`
  ADD PRIMARY KEY (`id_rezerwacji`),
  ADD UNIQUE KEY `id_samochodu` (`id_samochodu`,`id_uzytkownika`),
  ADD KEY `id_uzytkownika` (`id_uzytkownika`);

--
-- Indeksy dla tabeli `uzytkownicy`
--
ALTER TABLE `uzytkownicy`
  ADD PRIMARY KEY (`id_uzytkownika`);

--
-- AUTO_INCREMENT dla zrzuconych tabel
--

--
-- AUTO_INCREMENT dla tabeli `archiwum`
--
ALTER TABLE `archiwum`
  MODIFY `id_archiwum` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=73;

--
-- AUTO_INCREMENT dla tabeli `oferta`
--
ALTER TABLE `oferta`
  MODIFY `id_samochodu` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT dla tabeli `rezerwacje`
--
ALTER TABLE `rezerwacje`
  MODIFY `id_rezerwacji` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT dla tabeli `uzytkownicy`
--
ALTER TABLE `uzytkownicy`
  MODIFY `id_uzytkownika` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=82;

--
-- Ograniczenia dla zrzutów tabel
--

--
-- Ograniczenia dla tabeli `archiwum`
--
ALTER TABLE `archiwum`
  ADD CONSTRAINT `archiwum_ibfk_1` FOREIGN KEY (`id_uzytkownika`) REFERENCES `uzytkownicy` (`id_uzytkownika`),
  ADD CONSTRAINT `archiwum_ibfk_2` FOREIGN KEY (`id_samochodu`) REFERENCES `oferta` (`id_samochodu`);

--
-- Ograniczenia dla tabeli `rezerwacje`
--
ALTER TABLE `rezerwacje`
  ADD CONSTRAINT `rezerwacje_ibfk_1` FOREIGN KEY (`id_uzytkownika`) REFERENCES `uzytkownicy` (`id_uzytkownika`),
  ADD CONSTRAINT `rezerwacje_ibfk_2` FOREIGN KEY (`id_samochodu`) REFERENCES `oferta` (`id_samochodu`);

DELIMITER $$
--
-- Zdarzenia
--
CREATE DEFINER=`root`@`localhost` EVENT `dodaj_czas` ON SCHEDULE EVERY 2 SECOND STARTS '2021-12-14 05:35:55' ON COMPLETION NOT PRESERVE DISABLE DO UPDATE rezerwacje 
SET poczatek = DATE_ADD(poczatek, INTERVAL 1 DAY), koniec = DATE_ADD(koniec, INTERVAL 1 DAY) WHERE 1=1$$

CREATE DEFINER=`root`@`localhost` EVENT `odejmij_czas` ON SCHEDULE EVERY 2 SECOND STARTS '2021-12-14 05:36:20' ON COMPLETION NOT PRESERVE DISABLE DO UPDATE rezerwacje 
SET poczatek = ADDDATE(poczatek, INTERVAL -1 DAY), koniec = ADDDATE(koniec, INTERVAL -1 DAY) WHERE 1=1$$

DELIMITER ;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
