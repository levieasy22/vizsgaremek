-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1
-- Létrehozás ideje: 2026. Már 10. 14:19
-- Kiszolgáló verziója: 10.4.32-MariaDB
-- PHP verzió: 8.2.12

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
  `faj_id` bigint(20) UNSIGNED NOT NULL,
  `nev` varchar(255) NOT NULL,
  `eletkor` int(11) NOT NULL,
  `nem` enum('him','nosteny') NOT NULL,
  `orokbefogadasi_statusz` varchar(255) NOT NULL DEFAULT 'szabad',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `ivar` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- A tábla adatainak kiíratása `allatok`
--

INSERT INTO `allatok` (`id`, `faj_id`, `nev`, `eletkor`, `nem`, `orokbefogadasi_statusz`, `created_at`, `updated_at`, `ivar`) VALUES
(1, 1, 'Bodri', 4, 'him', 'szabad', '2026-03-03 12:45:24', '2026-03-03 12:45:24', 'ivartalanitott'),
(2, 1, 'Max', 6, 'him', 'orokbefogadva', '2026-03-03 12:45:24', '2026-03-03 12:45:24', 'ivartalanitott'),
(3, 1, 'Rocky', 8, 'him', 'szabad', '2026-03-03 12:45:24', '2026-03-03 12:45:24', 'ivaros'),
(4, 1, 'Rex', 7, 'him', 'szabad', '2026-03-03 12:45:24', '2026-03-03 12:45:24', 'ivartalanitott'),
(5, 1, 'Brúnó', 9, 'him', 'szabad', '2026-03-03 12:45:24', '2026-03-03 12:45:24', 'ivartalanitott'),
(6, 1, 'Charlie', 3, 'him', 'ideiglenes gazdi', '2026-03-03 12:45:24', '2026-03-03 12:45:24', 'ivartalanitott'),
(7, 1, 'Zeusz', 6, 'him', 'szabad', '2026-03-03 12:45:24', '2026-03-03 12:45:24', 'ivartalanitott'),
(8, 1, 'Tyson', 5, 'him', 'szabad', '2026-03-03 12:45:24', '2026-03-03 12:45:24', 'ivaros'),
(9, 1, 'Fickó', 4, 'him', 'orokbefogadva', '2026-03-03 12:45:24', '2026-03-03 12:45:24', 'ivartalanitott'),
(10, 1, 'Mackó', 7, 'him', 'orokbefogadva', '2026-03-03 12:45:24', '2026-03-03 12:45:24', 'ivartalanitott'),
(11, 1, 'Buksi', 6, 'him', 'szabad', '2026-03-03 12:45:24', '2026-03-03 12:45:24', 'ivartalanitott'),
(12, 1, 'Tappancs', 5, 'him', 'szabad', '2026-03-03 12:45:24', '2026-03-03 12:45:24', 'ivartalanitott'),
(13, 1, 'Árnyék', 6, 'him', 'ideiglenes gazdi', '2026-03-03 12:45:24', '2026-03-03 12:45:24', 'ivartalanitott'),
(14, 1, 'Sam', 5, 'him', 'ideiglenes gazdi', '2026-03-03 12:45:24', '2026-03-03 12:45:24', 'ivaros'),
(15, 1, 'Foltos', 4, 'him', 'szabad', '2026-03-03 12:45:24', '2026-03-03 12:45:24', 'ivartalanitott'),
(16, 2, 'Cirmi', 3, 'nosteny', 'szabad', '2026-03-03 12:45:24', '2026-03-03 12:45:24', 'ivartalanitott'),
(17, 2, 'Luna', 2, 'nosteny', 'ideiglenes gazdi', '0000-00-00 00:00:00', '2026-03-03 12:45:24', 'ivartalanitott'),
(18, 2, 'Mici', 5, 'nosteny', 'orokbefogadva', '2026-03-03 12:45:24', '2026-03-03 12:45:24', 'ivaros'),
(19, 2, 'Nala', 4, 'nosteny', 'szabad', '2026-03-03 12:45:24', '2026-03-03 12:45:24', 'ivaros'),
(20, 2, 'Lili', 2, 'nosteny', 'szabad', '2026-03-03 12:45:24', '2026-03-03 12:45:24', 'ivartalanitott'),
(21, 2, 'Bella', 1, 'nosteny', 'szabad', '2026-03-03 12:45:24', '2026-03-03 12:45:24', 'ivartalanitott'),
(22, 2, 'Mazsi', 4, 'nosteny', 'szabad', '2026-03-03 12:45:24', '2026-03-03 12:45:24', 'ivartalanitott'),
(23, 2, 'Cili', 2, 'nosteny', 'ideiglenes gazdi', '2026-03-03 12:45:24', '2026-03-03 12:45:24', 'ivartalanitott'),
(24, 2, 'Panna', 3, 'nosteny', 'szabad', '2026-03-03 12:45:24', '2026-03-03 12:45:24', 'ivartalanitott'),
(25, 2, 'Maja', 3, 'nosteny', 'szabad', '2026-03-03 12:45:24', '2026-03-03 12:45:24', 'ivaros'),
(26, 2, 'Folti', 2, 'nosteny', 'ideiglenes gazdi', '2026-03-03 12:45:24', '2026-03-03 12:45:24', 'ivartalanitott'),
(27, 2, 'Cuki', 4, 'nosteny', 'szabad', '2026-03-03 12:45:24', '2026-03-03 12:45:24', 'ivaros'),
(28, 2, 'Gréti', 5, 'nosteny', 'szabad', '2026-03-03 12:45:24', '2026-03-03 12:45:24', 'ivaros'),
(29, 2, 'Szofi', 1, 'nosteny', 'szabad', '2026-03-03 12:45:24', '2026-03-03 12:45:24', 'ivartalanitott'),
(30, 2, 'Picúr', 2, 'nosteny', 'szabad', '2026-03-03 12:45:24', '2026-03-03 12:45:24', 'ivartalanitott');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `fajok`
--

CREATE TABLE `fajok` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `megnevezes` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- A tábla adatainak kiíratása `fajok`
--

INSERT INTO `fajok` (`id`, `megnevezes`, `created_at`, `updated_at`) VALUES
(1, 'Kutya', '2026-03-03 12:44:41', '2026-03-03 12:44:41'),
(2, 'Macska', '2026-03-03 12:44:41', '2026-03-03 12:44:41');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `felhasznalok`
--

CREATE TABLE `felhasznalok` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nev` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `validalt` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `jogosultsag` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- A tábla adatainak kiíratása `felhasznalok`
--

INSERT INTO `felhasznalok` (`id`, `nev`, `email`, `validalt`, `created_at`, `updated_at`, `jogosultsag`) VALUES
(1, 'Kiss Anna', 'anna@email.hu', 1, '2026-03-03 12:44:58', '2026-03-03 12:44:58', 'user'),
(2, 'Nagy Péter', 'peter@email.hu', 1, '2026-03-03 12:44:58', '2026-03-03 12:44:58', 'admin'),
(3, 'Tóth Eszter', 'eszter@email.hu', 1, '2026-03-03 12:44:58', '2026-03-03 12:44:58', 'gondozo'),
(4, 'Kovács Márk', 'mark@email.hu', 0, '2026-03-03 12:44:58', '2026-03-03 12:44:58', 'admin'),
(5, 'Fekete Anna', 'fekete@email.hu', 1, '2026-03-03 12:44:58', '2026-03-03 12:44:58', 'user'),
(6, 'Horváth Gábor', 'gabor@email.hu', 1, '2026-03-03 12:44:58', '2026-03-03 12:44:58', 'user'),
(7, 'Szűcs Dóra', 'dora@email.hu', 0, '2026-03-03 12:44:58', '2026-03-03 12:44:58', 'user'),
(8, 'Balogh Zoltán', 'zoli@email.hu', 1, '2026-03-03 12:44:58', '2026-03-03 12:44:58', 'gondozo'),
(9, 'Molnár Réka', 'reka@email.hu', 1, '2026-03-03 12:44:58', '2026-03-03 12:44:58', 'gondozo'),
(10, 'Lakatos István', 'istvan@email.hu', 0, '2026-03-03 12:44:58', '2026-03-03 12:44:58', 'user'),
(11, 'Varga Júlia', 'julia@email.hu', 1, '2026-03-03 12:44:58', '2026-03-03 12:44:58', 'user'),
(12, 'Szalai Petra', 'petra@email.hu', 1, '2026-03-03 12:44:58', '2026-03-03 12:44:58', 'gondozo');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `latogatasi_idopontok`
--

CREATE TABLE `latogatasi_idopontok` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `felhasznalo_id` bigint(20) UNSIGNED NOT NULL,
  `allat_id` bigint(20) UNSIGNED NOT NULL,
  `idopont` datetime NOT NULL,
  `statusz` enum('foglalt','lemondva','teljesitve') NOT NULL DEFAULT 'foglalt',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- A tábla adatainak kiíratása `latogatasi_idopontok`
--

INSERT INTO `latogatasi_idopontok` (`id`, `felhasznalo_id`, `allat_id`, `idopont`, `statusz`, `created_at`, `updated_at`) VALUES
(1, 1, 1, '2026-03-05 10:00:00', 'foglalt', '2026-03-03 12:45:48', '2026-03-03 12:45:48'),
(2, 2, 16, '2026-03-06 11:00:00', 'teljesitve', '2026-03-03 12:45:48', '2026-03-03 12:45:48'),
(3, 3, 2, '2026-03-07 14:00:00', 'foglalt', '2026-03-03 12:45:48', '2026-03-03 12:45:48'),
(4, 4, 18, '2026-03-08 09:00:00', 'lemondva', '2026-03-03 12:45:48', '2026-03-03 12:45:48'),
(5, 5, 5, '2026-03-09 15:00:00', 'foglalt', '2026-03-03 12:45:48', '2026-03-03 12:45:48'),
(6, 6, 20, '2026-03-10 13:00:00', 'foglalt', '2026-03-03 12:45:48', '2026-03-03 12:45:48'),
(7, 7, 3, '2026-03-11 16:00:00', 'teljesitve', '2026-03-03 12:45:48', '2026-03-03 12:45:48');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- A tábla adatainak kiíratása `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2026_03_02_211616_create_felhasznalok_table', 1),
(2, '2026_03_02_212456_create_fajok_table', 1),
(3, '2026_03_02_212457_create_allatok_table', 1),
(4, '2026_03_02_212457_create_egeszsegugyi_esemenyek_table', 1),
(5, '2026_03_02_212457_create_gondozok_table', 1),
(6, '2026_03_02_212457_create_latogatasi_idopontok_table', 1),
(7, '2026_03_02_212501_create_orokbefogadasi_kerelmek_table', 1);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `orokbefogadasi_kerelmek`
--

CREATE TABLE `orokbefogadasi_kerelmek` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `felhasznalo_id` bigint(20) UNSIGNED NOT NULL,
  `allat_id` bigint(20) UNSIGNED NOT NULL,
  `statusz` enum('elbiralas_alatt','elfogadva','elutasitva') NOT NULL DEFAULT 'elbiralas_alatt',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- A tábla adatainak kiíratása `orokbefogadasi_kerelmek`
--

INSERT INTO `orokbefogadasi_kerelmek` (`id`, `felhasznalo_id`, `allat_id`, `statusz`, `created_at`, `updated_at`) VALUES
(1, 1, 2, 'elfogadva', '2026-03-03 12:45:58', '2026-03-03 12:45:58'),
(2, 2, 18, 'elfogadva', '2026-03-03 12:45:58', '2026-03-03 12:45:58'),
(3, 3, 1, 'elbiralas_alatt', '2026-03-03 12:45:58', '2026-03-03 12:45:58'),
(4, 4, 16, 'elutasitva', '2026-03-03 12:45:58', '2026-03-03 12:45:58'),
(5, 5, 5, 'elbiralas_alatt', '2026-03-03 12:45:58', '2026-03-03 12:45:58'),
(6, 6, 20, 'elbiralas_alatt', '2026-03-03 12:45:58', '2026-03-03 12:45:58'),
(7, 7, 3, 'elfogadva', '2026-03-03 12:45:58', '2026-03-03 12:45:58');

--
-- Indexek a kiírt táblákhoz
--

--
-- A tábla indexei `allatok`
--
ALTER TABLE `allatok`
  ADD PRIMARY KEY (`id`),
  ADD KEY `allatok_faj_id_foreign` (`faj_id`);

--
-- A tábla indexei `fajok`
--
ALTER TABLE `fajok`
  ADD PRIMARY KEY (`id`);

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
-- A tábla indexei `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=273;

--
-- AUTO_INCREMENT a táblához `fajok`
--
ALTER TABLE `fajok`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

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
-- AUTO_INCREMENT a táblához `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT a táblához `orokbefogadasi_kerelmek`
--
ALTER TABLE `orokbefogadasi_kerelmek`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Megkötések a kiírt táblákhoz
--

--
-- Megkötések a táblához `allatok`
--
ALTER TABLE `allatok`
  ADD CONSTRAINT `allatok_faj_id_foreign` FOREIGN KEY (`faj_id`) REFERENCES `fajok` (`id`) ON DELETE CASCADE;

--
-- Megkötések a táblához `latogatasi_idopontok`
--
ALTER TABLE `latogatasi_idopontok`
  ADD CONSTRAINT `latogatasi_idopontok_allat_id_foreign` FOREIGN KEY (`allat_id`) REFERENCES `allatok` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `latogatasi_idopontok_felhasznalo_id_foreign` FOREIGN KEY (`felhasznalo_id`) REFERENCES `felhasznalok` (`id`) ON DELETE CASCADE;

--
-- Megkötések a táblához `orokbefogadasi_kerelmek`
--
ALTER TABLE `orokbefogadasi_kerelmek`
  ADD CONSTRAINT `orokbefogadasi_kerelmek_allat_id_foreign` FOREIGN KEY (`allat_id`) REFERENCES `allatok` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `orokbefogadasi_kerelmek_felhasznalo_id_foreign` FOREIGN KEY (`felhasznalo_id`) REFERENCES `felhasznalok` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
