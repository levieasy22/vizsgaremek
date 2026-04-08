-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1
-- Létrehozás ideje: 2026. Ápr 08. 13:16
-- Kiszolgáló verziója: 10.4.32-MariaDB
-- PHP verzió: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Adatbázis: `menhely_db`
--

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `allatok`
--

CREATE TABLE `allatok` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `faj` varchar(255) NOT NULL,
  `nev` varchar(255) NOT NULL,
  `eletkor` int(11) NOT NULL,
  `nem` enum('him','nosteny') NOT NULL,
  `orokbefogadasi_statusz` varchar(255) NOT NULL DEFAULT 'szabad'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `allatok`
--

INSERT INTO `allatok` (`id`, `faj`, `nev`, `eletkor`, `nem`, `orokbefogadasi_statusz`) VALUES
(1, 'kutya', 'Bodri', 4, 'him', 'szabad'),
(2, 'kutya', 'Max', 6, 'him', 'orokbefogadva'),
(3, 'kutya', 'Rocky', 8, 'him', 'szabad'),
(4, 'kutya', 'Rex', 7, 'him', 'szabad'),
(5, 'kutya', 'Brúnó', 9, 'him', 'szabad'),
(6, 'kutya', 'Charlie', 3, 'him', 'ideiglenes gazdi'),
(7, 'kutya', 'Zeusz', 6, 'him', 'szabad'),
(8, 'kutya', 'Tyson', 5, 'him', 'szabad'),
(9, 'kutya', 'Fickó', 4, 'him', 'orokbefogadva'),
(10, 'kutya', 'Mackó', 7, 'him', 'orokbefogadva'),
(11, 'kutya', 'Buksi', 6, 'him', 'szabad'),
(12, 'kutya', 'Tappancs', 5, 'him', 'szabad'),
(13, 'kutya', 'Árnyék', 6, 'him', 'ideiglenes gazdi'),
(14, 'kutya', 'Sam', 5, 'him', 'ideiglenes gazdi'),
(15, 'kutya', 'Foltos', 4, 'him', 'szabad'),
(16, 'macska', 'Cirmi', 3, 'nosteny', 'szabad'),
(17, 'macska', 'Luna', 2, 'nosteny', 'ideiglenes gazdi'),
(18, 'macska', 'Mici', 5, 'nosteny', 'orokbefogadva'),
(19, 'macska', 'Nala', 4, 'nosteny', 'szabad'),
(20, 'macska', 'Lili', 2, 'nosteny', 'szabad'),
(21, 'macska', 'Bella', 1, 'nosteny', 'szabad'),
(22, 'macska', 'Mazsi', 4, 'nosteny', 'szabad'),
(23, 'macska', 'Cili', 2, 'nosteny', 'ideiglenes gazdi'),
(24, 'macska', 'Panna', 3, 'nosteny', 'szabad'),
(25, 'macska', 'Maja', 3, 'nosteny', 'szabad'),
(26, 'macska', 'Folti', 2, 'nosteny', 'ideiglenes gazdi'),
(27, 'macska', 'Cuki', 4, 'nosteny', 'szabad'),
(28, 'macska', 'Gréti', 5, 'nosteny', 'szabad'),
(29, 'macska', 'Szofi', 1, 'nosteny', 'szabad'),
(30, 'macska', 'Picúr', 2, 'nosteny', 'szabad');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `egeszsegugy`
--

CREATE TABLE `egeszsegugy` (
  `allat_id` bigint(20) UNSIGNED NOT NULL,
  `ivar` varchar(255) NOT NULL,
  `oltas` varchar(255) NOT NULL,
  `gyogyszer` varchar(255) NOT NULL,
  `hatranyok` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `egeszsegugy`
--

INSERT INTO `egeszsegugy` (`allat_id`, `ivar`, `oltas`, `gyogyszer`, `hatranyok`) VALUES
(1, 'ivartalanitott', 'oltva', 'nem', 'hallasserult'),
(2, 'ivaros', 'oltva', 'nem', 'nincs'),
(3, 'ivartalanitott', 'nincs oltva', 'nem', 'latasserult'),
(4, 'ivaros', 'oltva', 'szukseges', 'vitaminhiany'),
(5, 'ivartalanitott', 'oltva', 'nem', 'nincs'),
(6, 'ivaros', 'oltva', 'szukseges', 'jobb hatso labanak mozgasa korlatozott'),
(7, 'ivartalanitott', 'oltva', 'nem', 'bal szemere nem lat'),
(8, 'ivartalanitott', 'nincs oltva', 'nem', 'nincs'),
(9, 'ivaros', 'oltva', 'nem', 'nincs'),
(10, 'ivartalanitott', 'oltva', 'nem', 'mozgaskorlatozott'),
(11, 'ivaros', 'nincs oltva', 'nem', 'nincs'),
(12, 'ivartalanitott', 'oltva', 'nem', 'marha allergia'),
(13, 'ivartalanitott', 'oltva', 'nem', 'nincs'),
(14, 'ivaros', 'oltva', 'nem', 'nincs'),
(15, 'ivartalanitott', 'oltva', 'nem', 'bal hatso laba hianyzik'),
(16, 'ivartalanitott', 'nincs oltva', 'nem', 'nincs'),
(17, 'ivaros', 'oltva', 'nem', 'jobb szemere nem lat'),
(18, 'ivartalanitott', 'oltva', 'nem', 'nincs'),
(19, 'ivartalanitott', 'oltva', 'szukseges', 'verszegeny'),
(20, 'ivaros', 'oltva', 'nem', 'nincs'),
(21, 'ivartalanitott', 'nincs oltva', 'szukseges', 'tisztitoszer allergia'),
(22, 'ivartalanitott', 'oltva', 'nem', 'nincs'),
(23, 'ivaros', 'oltva', 'szukseges', 'mozgasserult'),
(24, 'ivartalanitott', 'oltva', 'nem', 'bal fulere nem hall'),
(25, 'ivartalanitott', 'nincs oltva', 'nem', 'nincs'),
(26, 'ivaros', 'oltva', 'nem', 'latasserult'),
(27, 'ivartalanitott', 'oltva', 'nem', 'nincs'),
(28, 'ivartalanitott', 'nincs oltva', 'nem', 'nincs'),
(29, 'ivaros', 'oltva', 'nem', 'nincs'),
(30, 'ivartalanitott', 'oltva', 'nem', 'hallasserult');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `felhasznalok`
--

CREATE TABLE `felhasznalok` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nev` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `validalt` tinyint(1) NOT NULL DEFAULT 0,
  `jogosultsag` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `felhasznalok`
--

INSERT INTO `felhasznalok` (`id`, `nev`, `email`, `validalt`, `jogosultsag`) VALUES
(1, 'Kiss Anna', 'anna@email.hu', 1, 'user'),
(2, 'Nagy Péter', 'peter@email.hu', 1, 'admin'),
(3, 'Tóth Eszter', 'eszter@email.hu', 1, 'gondozo'),
(4, 'Kovács Márk', 'mark@email.hu', 0, 'admin'),
(5, 'Fekete Anna', 'fekete@email.hu', 1, 'user'),
(6, 'Horváth Gábor', 'gabor@email.hu', 1, 'user'),
(7, 'Szűcs Dóra', 'dora@email.hu', 0, 'user'),
(8, 'Balogh Zoltán', 'zoli@email.hu', 1, 'gondozo'),
(9, 'Molnár Réka', 'reka@email.hu', 1, 'gondozo'),
(10, 'Lakatos István', 'istvan@email.hu', 0, 'user'),
(11, 'Varga Júlia', 'julia@email.hu', 1, 'user'),
(12, 'Szalai Petra', 'petra@email.hu', 1, 'gondozo');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `latogatasi_idopontok`
--

CREATE TABLE `latogatasi_idopontok` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `felhasznalo_id` bigint(20) UNSIGNED NOT NULL,
  `allat_id` bigint(20) UNSIGNED NOT NULL,
  `idopont` datetime NOT NULL,
  `statusz` enum('foglalt','lemondva','teljesitve') NOT NULL DEFAULT 'foglalt'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `latogatasi_idopontok`
--

INSERT INTO `latogatasi_idopontok` (`id`, `felhasznalo_id`, `allat_id`, `idopont`, `statusz`) VALUES
(1, 1, 1, '2026-03-05 10:00:00', 'foglalt'),
(2, 2, 16, '2026-03-06 11:00:00', 'teljesitve'),
(3, 3, 2, '2026-03-07 14:00:00', 'foglalt'),
(4, 4, 18, '2026-03-08 09:00:00', 'lemondva'),
(5, 5, 5, '2026-03-09 15:00:00', 'foglalt'),
(6, 6, 20, '2026-03-10 13:00:00', 'foglalt'),
(7, 7, 3, '2026-03-11 16:00:00', 'teljesitve');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `orokbefogadasi_kerelmek`
--

CREATE TABLE `orokbefogadasi_kerelmek` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `felhasznalo_id` bigint(20) UNSIGNED NOT NULL,
  `allat_id` bigint(20) UNSIGNED NOT NULL,
  `statusz` enum('elbiralas_alatt','elfogadva','elutasitva') NOT NULL DEFAULT 'elbiralas_alatt',
  `indoklas` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `orokbefogadasi_kerelmek`
--

INSERT INTO `orokbefogadasi_kerelmek` (`id`, `felhasznalo_id`, `allat_id`, `statusz`, `indoklas`) VALUES
(1, 1, 2, 'elfogadva', NULL),
(2, 2, 18, 'elfogadva', NULL),
(3, 3, 1, 'elbiralas_alatt', NULL),
(4, 4, 16, 'elutasitva', 'nem megfelelo kornyezet biztositasa'),
(5, 5, 5, 'elbiralas_alatt', NULL),
(6, 6, 20, 'elbiralas_alatt', NULL),
(7, 7, 3, 'elfogadva', NULL);

--
-- Indexek a kiírt táblákhoz
--

--
-- A tábla indexei `allatok`
--
ALTER TABLE `allatok`
  ADD PRIMARY KEY (`id`);

--
-- A tábla indexei `egeszsegugy`
--
ALTER TABLE `egeszsegugy`
  ADD PRIMARY KEY (`allat_id`);

--
-- A tábla indexei `felhasznalok`
--
ALTER TABLE `felhasznalok`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `felhasznalok_email_unique` (`email`);

--
-- A tábla indexei `latogatasi_idopontok`
--
ALTER TABLE `latogatasi_idopontok`
  ADD PRIMARY KEY (`id`),
  ADD KEY `latogatasi_idopontok_felhasznalo_id_foreign` (`felhasznalo_id`),
  ADD KEY `latogatasi_idopontok_allat_id_foreign` (`allat_id`);

--
-- A tábla indexei `orokbefogadasi_kerelmek`
--
ALTER TABLE `orokbefogadasi_kerelmek`
  ADD PRIMARY KEY (`id`),
  ADD KEY `orokbefogadasi_kerelmek_felhasznalo_id_foreign` (`felhasznalo_id`),
  ADD KEY `orokbefogadasi_kerelmek_allat_id_foreign` (`allat_id`);

--
-- A kiírt táblák AUTO_INCREMENT értéke
--

--
-- AUTO_INCREMENT a táblához `allatok`
--
ALTER TABLE `allatok`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT a táblához `felhasznalok`
--
ALTER TABLE `felhasznalok`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT a táblához `latogatasi_idopontok`
--
ALTER TABLE `latogatasi_idopontok`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT a táblához `orokbefogadasi_kerelmek`
--
ALTER TABLE `orokbefogadasi_kerelmek`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Megkötések a kiírt táblákhoz
--

--
-- Megkötések a táblához `egeszsegugy`
--
ALTER TABLE `egeszsegugy`
  ADD CONSTRAINT `fk_egeszsegugy_allat` FOREIGN KEY (`allat_id`) REFERENCES `allatok` (`id`) ON DELETE CASCADE;

--
-- Megkötések a táblához `latogatasi_idopontok`
--
ALTER TABLE `latogatasi_idopontok`
  ADD CONSTRAINT `fk_latogatas_allat` FOREIGN KEY (`allat_id`) REFERENCES `allatok` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `latogatasi_idopontok_allat_id_foreign` FOREIGN KEY (`allat_id`) REFERENCES `allatok` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `latogatasi_idopontok_felhasznalo_id_foreign` FOREIGN KEY (`felhasznalo_id`) REFERENCES `felhasznalok` (`id`) ON DELETE CASCADE;

--
-- Megkötések a táblához `orokbefogadasi_kerelmek`
--
ALTER TABLE `orokbefogadasi_kerelmek`
  ADD CONSTRAINT `fk_orokbefogadas_allat` FOREIGN KEY (`allat_id`) REFERENCES `allatok` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `orokbefogadasi_kerelmek_allat_id_foreign` FOREIGN KEY (`allat_id`) REFERENCES `allatok` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `orokbefogadasi_kerelmek_felhasznalo_id_foreign` FOREIGN KEY (`felhasznalo_id`) REFERENCES `felhasznalok` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
