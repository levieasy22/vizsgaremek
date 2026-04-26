-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1
-- Létrehozás ideje: 2026. Ápr 25. 17:55
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
-- Adatbázis: `allatmenhely`
--

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `adoption_requests`
--

CREATE TABLE `adoption_requests` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `animal_id` bigint(20) UNSIGNED NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `address` varchar(255) NOT NULL,
  `motivation` text NOT NULL,
  `has_garden` tinyint(1) NOT NULL DEFAULT 0,
  `has_other_pets` tinyint(1) NOT NULL DEFAULT 0,
  `status` enum('fuggoben','elfogadva','elutasitva') NOT NULL DEFAULT 'fuggoben',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- A tábla adatainak kiíratása `adoption_requests`
--

INSERT INTO `adoption_requests` (`id`, `user_id`, `animal_id`, `first_name`, `last_name`, `email`, `phone`, `address`, `motivation`, `has_garden`, `has_other_pets`, `status`, `created_at`, `updated_at`) VALUES
(1, 2, 1, 'Anna', 'Kovács', 'anna@menhely.hu', '+36 70 234 5678', '1051 Budapest, Vörösmarty tér 5.', 'Mindig is szerettem volna labradorom. Van egy 6 éves kislányom, aki imádja az állatokat. Kertünk is van.', 1, 0, 'elfogadva', '2026-04-15 18:30:37', '2026-04-18 18:53:52'),
(2, 3, 2, 'Péter', 'Nagy', 'peter@menhely.hu', '+36 20 345 6789', '4025 Debrecen, Piac utca 12.', 'Egyedül élek, home office-ban dolgozom. Egész nap otthon vagyok, rengeteg időt tudnék az állatra szánni.', 0, 0, 'elfogadva', '2026-04-11 18:30:37', '2026-04-13 18:30:37'),
(3, NULL, 3, 'Balázs', 'Tóth', 'balazs.toth@gmail.com', '+36 70 567 8901', '9021 Győr, Baross út 3.', 'Nagyon tetszik ez az állat, szeretném örökbefogadni.', 0, 1, 'elutasitva', '2026-04-08 18:30:37', '2026-04-10 18:30:37'),
(4, 9, 20, 'Walker', 'Gislason', 'crooks.joel@example.org', '+36 66 155 9001', '3810 Lynchfort, 362 Ona Corner Suite 717', 'Egész életemben álmom volt egy ilyen fajta állat. Stabil anyagi háttérrel rendelkezem, az állatorvosi költségek nem jelentenének gondot.', 1, 0, 'elfogadva', '2026-04-18 18:30:37', '2026-04-18 18:30:37'),
(5, 9, 4, 'Maribel', 'Hilpert', 'edwardo.stehr@example.com', '+36 48 270 8345', '0598 Sipesmouth, 15165 Carmen Club Apt. 413', 'Egyedül élek és szeretnék társat magam mellé. Home office-ban dolgozom, így egész nap otthon vagyok és rengeteg időt tudnék szánni az állatra.', 0, 0, 'elfogadva', '2026-04-18 18:30:37', '2026-04-22 06:16:28'),
(6, 2, 4, 'Annette', 'Medhurst', 'waters.amelie@example.org', '+36 32 599 1832', '5078 Benborough, 175 Hill Greens Suite 556', 'Nemrég vesztettem el a régi kutyámat és nagyon hiányzik az állat a házból. Tapasztalt kutyatartó vagyok, tudom mi a felelőssége.', 0, 0, 'elfogadva', '2026-04-18 18:30:37', '2026-04-18 18:30:37'),
(7, 7, 4, 'Reilly', 'Gottlieb', 'karmstrong@example.com', '+36 57 072 6698', '4946 Lake Amyatown, 32305 Zane Trace', 'A gyerekeink nagyon szeretnének állatot. Felelős gazdik lennénk, a gyerekek is részt vennének a gondozásban. Van kertünk és nagy udvarunk.', 0, 0, 'elutasitva', '2026-04-18 18:30:37', '2026-04-22 06:16:28'),
(8, NULL, 5, 'Laila', 'Homenick', 'udonnelly@example.com', '+36 61 540 4106', '3741 North Madalineland, 4448 O\'Connell Neck Apt. 262', 'A macskák iránti szeretetem régóta megvan. Tágas lakásban élek, kaparófával és rengeteg játékkal tudnám biztosítani a megfelelő körülményeket.', 1, 0, 'elutasitva', '2026-04-18 18:30:37', '2026-04-21 11:19:07'),
(9, 9, 14, 'Nelle', 'Lockman', 'eddie89@example.net', '+36 02 326 3841', '9356 O\'Reillyport, 1199 Natalia Springs', 'Mindig is szerettem volna kutyát tartani. Nagy kertünk van, ahol az állat szabadon mozoghatna. Gyermekeimnek is nagyon hiányzik egy háziállat.', 1, 0, 'elfogadva', '2026-04-18 18:30:37', '2026-04-18 18:30:37'),
(10, NULL, 10, 'Sally', 'Yundt', 'eric64@example.com', '+36 13 080 3798', '4863 North Maudieview, 704 Brayan Burg', 'Egyedül élek és szeretnék társat magam mellé. Home office-ban dolgozom, így egész nap otthon vagyok és rengeteg időt tudnék szánni az állatra.', 1, 0, 'elutasitva', '2026-04-18 18:30:37', '2026-04-18 18:30:37'),
(11, 10, 11, 'Conor', 'Price', 'kamren.olson@example.com', '+36 09 794 2247', '8742 Hartmannmouth, 364 Effertz Shores Suite 556', 'Mindig is szerettem volna kutyát tartani. Nagy kertünk van, ahol az állat szabadon mozoghatna. Gyermekeimnek is nagyon hiányzik egy háziállat.', 1, 1, 'fuggoben', '2026-04-18 18:30:37', '2026-04-18 18:30:37'),
(12, 12, 12, 'Virgie', 'Schulist', 'dayana98@example.org', '+36 61 047 4221', '4386 East Anyaville, 7893 Gusikowski Knoll Apt. 312', 'A macskák iránti szeretetem régóta megvan. Tágas lakásban élek, kaparófával és rengeteg játékkal tudnám biztosítani a megfelelő körülményeket.', 0, 0, 'fuggoben', '2026-04-18 18:30:37', '2026-04-18 18:30:37'),
(13, NULL, 4, 'Randal', 'Donnelly', 'hagenes.nick@example.org', '+36 50 866 0560', '5571 Edgarfort, 1557 Dach Station Suite 775', 'Egyedül élek és szeretnék társat magam mellé. Home office-ban dolgozom, így egész nap otthon vagyok és rengeteg időt tudnék szánni az állatra.', 0, 0, 'elutasitva', '2026-04-18 18:30:37', '2026-04-22 06:16:28'),
(14, 1, 1, 'Anna', 'Kovács', 'anna@gmail.com', '+36 70 123 4567', '1051 Budapest, Teszt utca 1.', 'Nagyon szeretném ezt az állatot örökbefogadni, mindig is szerettem volna kutyát tartani.', 1, 0, 'elutasitva', '2026-04-18 18:52:58', '2026-04-18 18:53:52'),
(15, 15, 23, 'Levente', 'Igli', 'iglilevente12@gmail.com', '+36204091502', 'BMSZC Bláthy Ottó', 'Mert imádom ezt a fajta kutyát, a neve is szuper és nagyon szeretnék már egy kutyát.', 0, 0, 'elfogadva', '2026-04-22 13:18:17', '2026-04-22 13:19:42');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `animals`
--

CREATE TABLE `animals` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(100) NOT NULL,
  `type` enum('kutya','macska') NOT NULL,
  `breed` varchar(100) DEFAULT NULL,
  `gender` enum('him','nosteny') NOT NULL,
  `age` int(11) NOT NULL,
  `description` text DEFAULT NULL,
  `status` enum('elerheto','foglalas_alatt','orokbefogadva') NOT NULL DEFAULT 'elerheto',
  `is_vaccinated` tinyint(1) NOT NULL DEFAULT 0,
  `is_neutered` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- A tábla adatainak kiíratása `animals`
--

INSERT INTO `animals` (`id`, `name`, `type`, `breed`, `gender`, `age`, `description`, `status`, `is_vaccinated`, `is_neutered`, `created_at`, `updated_at`) VALUES
(1, 'Bodri', 'kutya', 'Labrador Retriever', 'him', 3, 'Bodri egy barátságos és energikus labrador, aki imád emberek közelében lenni. Nagyon jól kijön gyerekekkel és más állatokkal egyaránt. Alapkiképzést elvégezte, ismeri az ül, le és maradj parancsokat.', 'orokbefogadva', 1, 1, '2026-04-18 18:30:37', '2026-04-18 18:53:52'),
(2, 'Hópehely', 'macska', 'Perzsa', 'nosteny', 4, 'Hópehely egy gyönyörű fehér perzsa macska, aki nagyon szereti a kényelmet. Csendes természetű, ideális lakásmacska. Rendszeres ápolást igényel hosszú szőre miatt.', 'elerheto', 1, 1, '2026-04-18 18:30:37', '2026-04-18 18:30:37'),
(3, 'Rex', 'kutya', 'Dobermann', 'him', 1, 'Rex még fiatal, mindössze egyéves dobermann kölyök. Tele van energiával és szeret tanulni. Megfelelő szocializációval és edzéssel kiváló társ lesz.', 'elerheto', 1, 0, '2026-04-18 18:30:37', '2026-04-18 18:30:37'),
(4, 'Tigris', 'macska', 'Bengáli', 'him', 2, 'Tigris egy aktív és játékos bengáli macska, lenyűgöző mintás bundával. Okos és tanulékony, még apróbb trükköket is megtaníthatók neki.', 'orokbefogadva', 1, 0, '2026-04-18 18:30:37', '2026-04-22 06:16:28'),
(5, 'Lola', 'kutya', 'Golden Retriever', 'nosteny', 6, 'Lola egy szeretetteljes golden retriever. Imádja a vízet és a labdát. Gyerekekkel nagyon türelmes, kiváló családi kutya.', 'elerheto', 1, 1, '2026-04-18 18:30:37', '2026-04-21 11:19:07'),
(6, 'Cirmos', 'macska', 'Európai rövidszőrű', 'him', 3, 'Cirmos egy vidám és kíváncsi macska, aki minden zugot felderít a lakásban. Szereti az emberek társaságát, de önállóan is jól elvan.', 'elerheto', 1, 1, '2026-04-18 18:30:37', '2026-04-18 18:30:37'),
(7, 'Bundás', 'kutya', 'Bernáthegyi', 'him', 5, 'Bundás egy hatalmas szívű bernáthegyi. Nagyon barátságos és türelmes, imádja a gyerekeket. Kerttel rendelkező otthonba ajánljuk mérete miatt.', 'orokbefogadva', 1, 0, '2026-04-18 18:30:37', '2026-04-18 18:30:37'),
(8, 'Zsemlye', 'macska', 'Ragdoll', 'nosteny', 3, 'Zsemlye egy tipikus ragdoll: lágy, ölbe simuló, türelmes macska. Soha nem karmolja meg az embert, nagyon gyerekbarát.', 'elerheto', 1, 1, '2026-04-18 18:30:37', '2026-04-18 18:30:37'),
(9, 'Góliát', 'kutya', 'Dobermann', 'nosteny', 3, 'Laboriosam cupiditate odit ut eum excepturi molestiae. Eos quasi in consectetur dolore sit sunt. Impedit quia ipsum sapiente iusto rerum deleniti nesciunt facere. Ut natus facere eos quidem rerum quae exercitationem laboriosam.', 'orokbefogadva', 1, 0, '2026-04-18 18:30:37', '2026-04-18 18:30:37'),
(10, 'Rex', 'kutya', 'Uszkár', 'him', 4, 'Voluptas nisi dolorem ullam. Eos ullam voluptatem nihil animi voluptatibus. Consequatur autem sed quos quidem quasi.', 'elerheto', 1, 1, '2026-04-18 18:30:37', '2026-04-18 18:30:37'),
(11, 'Csoki', 'kutya', 'Dobermann', 'nosteny', 12, 'Asperiores eaque esse voluptatibus unde occaecati repudiandae vitae. Quis minima vitae nostrum voluptatem. Nam commodi nesciunt aut tempora modi provident consequuntur accusantium. Sed delectus quia delectus hic et inventore qui.', 'orokbefogadva', 1, 1, '2026-04-18 18:30:37', '2026-04-18 18:30:37'),
(12, 'Hópehely', 'kutya', 'Boxer', 'him', 1, 'Tempora dolores quaerat et corporis. Fuga expedita perferendis quo. Maxime voluptates et reiciendis architecto.', 'foglalas_alatt', 1, 1, '2026-04-18 18:30:37', '2026-04-18 18:30:37'),
(13, 'Maxim', 'kutya', 'Dobermann', 'nosteny', 3, 'Optio officiis quia alias reprehenderit. Qui sunt corrupti sint dolores dolore aut delectus aspernatur. Eaque dolores dignissimos saepe. Fugit exercitationem dolorem id placeat facilis deserunt saepe distinctio.', 'orokbefogadva', 0, 0, '2026-04-18 18:30:37', '2026-04-18 18:30:37'),
(14, 'Inci', 'kutya', 'Bernáthegyi', 'him', 7, 'Eum beatae quibusdam rerum sed. Doloribus non animi illum velit consectetur quia minus. Recusandae et aut et nostrum maiores velit reprehenderit.', 'elerheto', 1, 0, '2026-04-18 18:30:37', '2026-04-18 18:30:37'),
(15, 'Mici', 'macska', 'Bengáli', 'him', 7, 'Qui quo earum deleniti sunt vitae. Distinctio sequi adipisci voluptates ipsum. Explicabo qui veniam dolores ipsam.', 'elerheto', 1, 1, '2026-04-18 18:30:37', '2026-04-18 18:30:37'),
(16, 'Narancs', 'macska', 'Maine Coon', 'nosteny', 12, 'Eaque ex et numquam rem nesciunt. Non doloremque saepe ex veritatis sapiente. Velit sit quidem excepturi dignissimos a voluptatem. Et eius voluptas id qui consectetur officia nihil. Consectetur aperiam doloribus sed unde.', 'elerheto', 1, 1, '2026-04-18 18:30:37', '2026-04-18 18:30:37'),
(17, 'Hamvas', 'macska', 'Brit rövidszőrű', 'nosteny', 1, 'Quas asperiores ab temporibus dolores ut maxime dolore. Et qui laudantium dolorem qui quisquam aut praesentium. Placeat quod cumque velit voluptates ut molestias ea.', 'foglalas_alatt', 1, 0, '2026-04-18 18:30:37', '2026-04-18 18:30:37'),
(18, 'Gömböc', 'macska', 'Keverék', 'him', 6, 'Aspernatur minima amet voluptate consequatur veritatis dolorem dolor. Magnam sit quasi quia ut. Vel autem corporis deleniti aspernatur. Dolores cupiditate at consequuntur. Et velit adipisci aspernatur eos error veritatis perferendis.', 'elerheto', 1, 0, '2026-04-18 18:30:37', '2026-04-18 18:30:37'),
(19, 'Keksz', 'macska', 'Ragdoll', 'him', 6, 'Voluptatem est mollitia sed dolores qui enim. Voluptatem sit sit qui quidem id. Tempora sit quo sed qui nobis voluptate fugiat.', 'elerheto', 1, 1, '2026-04-18 18:30:37', '2026-04-18 18:30:37'),
(20, 'Tigris', 'macska', 'Keverék', 'nosteny', 10, 'Corrupti officia omnis quisquam nobis id ea fuga. Consectetur vero perferendis optio qui maiores dolorum. Rerum blanditiis sint iste dolor temporibus eius. Vel libero et nobis laboriosam id in.', 'elerheto', 1, 0, '2026-04-18 18:30:37', '2026-04-18 18:30:37'),
(21, 'Zeusz', 'kutya', 'Labrador', 'him', 3, 'Egy labrador akit Zeusznak hívnak és nagyon barátságos.', 'elerheto', 1, 0, '2026-04-18 18:50:13', '2026-04-21 15:17:43'),
(22, 'Boxy', 'kutya', 'Labrador', 'him', 3, 'Egy nagyon aranyos labrador keverék.', 'elerheto', 1, 0, '2026-04-18 18:50:32', '2026-04-21 15:12:36'),
(23, 'Hádész', 'kutya', 'Amerikai Bulldog', 'him', 2, 'Hádész egy izmos, masszív védelemező kutya. Játékos, és sok futást igényel.', 'orokbefogadva', 1, 1, '2026-04-22 12:00:25', '2026-04-22 13:19:42');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `animal_images`
--

CREATE TABLE `animal_images` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `animal_id` bigint(20) UNSIGNED NOT NULL,
  `image_path` varchar(255) NOT NULL,
  `is_primary` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- A tábla adatainak kiíratása `animal_images`
--

INSERT INTO `animal_images` (`id`, `animal_id`, `image_path`, `is_primary`, `created_at`, `updated_at`) VALUES
(1, 1, 'animals/placeholder.jpg', 1, '2026-04-18 18:30:37', '2026-04-18 18:30:37'),
(4, 4, 'animals/placeholder.jpg', 1, '2026-04-18 18:30:37', '2026-04-18 18:30:37'),
(5, 5, 'animals/placeholder.jpg', 1, '2026-04-18 18:30:37', '2026-04-18 18:30:37'),
(6, 6, 'animals/placeholder.jpg', 1, '2026-04-18 18:30:37', '2026-04-18 18:30:37'),
(7, 7, 'animals/placeholder.jpg', 1, '2026-04-18 18:30:37', '2026-04-18 18:30:37'),
(8, 8, 'animals/placeholder.jpg', 1, '2026-04-18 18:30:37', '2026-04-18 18:30:37'),
(9, 9, 'animals/placeholder.jpg', 1, '2026-04-18 18:30:37', '2026-04-18 18:30:37'),
(10, 10, 'animals/placeholder.jpg', 1, '2026-04-18 18:30:37', '2026-04-18 18:30:37'),
(11, 11, 'animals/placeholder.jpg', 1, '2026-04-18 18:30:37', '2026-04-18 18:30:37'),
(12, 12, 'animals/placeholder.jpg', 1, '2026-04-18 18:30:37', '2026-04-18 18:30:37'),
(13, 13, 'animals/placeholder.jpg', 1, '2026-04-18 18:30:37', '2026-04-18 18:30:37'),
(15, 15, 'animals/placeholder.jpg', 1, '2026-04-18 18:30:37', '2026-04-18 18:30:37'),
(16, 16, 'animals/placeholder.jpg', 1, '2026-04-18 18:30:37', '2026-04-18 18:30:37'),
(17, 17, 'animals/placeholder.jpg', 1, '2026-04-18 18:30:37', '2026-04-18 18:30:37'),
(18, 18, 'animals/placeholder.jpg', 1, '2026-04-18 18:30:37', '2026-04-18 18:30:37'),
(19, 19, 'animals/placeholder.jpg', 1, '2026-04-18 18:30:37', '2026-04-18 18:30:37'),
(20, 20, 'animals/placeholder.jpg', 1, '2026-04-18 18:30:37', '2026-04-18 18:30:37'),
(21, 22, 'animals/iDzDVhgROJ4tcFpJMqbXRE1qt3V9Z5tvO7OVTfJQ.jpg', 1, '2026-04-21 14:28:10', '2026-04-21 14:28:10'),
(22, 22, 'animals/nISmlZ0iSe4XaHCFJDgj2k4sk8b9lmr3i3reUW64.jpg', 0, '2026-04-21 15:10:45', '2026-04-21 15:10:45'),
(23, 22, 'animals/jgETmQ8wm8y1b8CqGq9KW0lSbY2hTaisa7ohKVph.jpg', 0, '2026-04-21 15:10:55', '2026-04-21 15:10:55'),
(24, 21, 'animals/L2UC1IFL0VaJtZsuYbAzf1jwNuewywwdGJTx0ZKd.jpg', 1, '2026-04-21 15:17:43', '2026-04-21 15:17:43'),
(25, 21, 'animals/a01D4nJbxStLdbPZfStty3Ha0RXPRjXia7cg1ONY.webp', 0, '2026-04-21 15:18:01', '2026-04-21 15:18:01'),
(26, 21, 'animals/f29kUtR9OZ6SMUEadAptpldRPedvZ2R2ApLjvaQI.jpg', 0, '2026-04-21 15:18:20', '2026-04-21 15:18:20'),
(27, 2, 'animals/UsmSEiZPWyzjzaPueBJOhCxYNIzv6sUTmWfaIhIM.jpg', 1, '2026-04-21 15:36:31', '2026-04-22 17:22:48'),
(29, 23, 'animals/Gd2fs6e8ZalfGucKZnAA5nKRtxwTbNQWdIIVbs0K.webp', 1, '2026-04-22 12:01:49', '2026-04-22 12:01:49'),
(31, 14, 'animals/opYGZLAKgeFwmcfGNQ0lt9R0YhOeYHIiST8sNUgE.jpg', 1, '2026-04-22 18:13:34', '2026-04-22 18:14:47'),
(32, 7, 'animals/JXF98NDAMbLrLmN7U6DGmLvWLh4Q9k5jN7xcmpeO.jpg', 0, '2026-04-22 18:13:50', '2026-04-22 18:13:50'),
(33, 3, 'animals/c5CTy0oFP5oRfrFCOzUkUeolmKC2DqWHefx6xFKQ.webp', 1, '2026-04-22 18:27:42', '2026-04-22 18:27:42');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `appointments`
--

CREATE TABLE `appointments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `animal_id` bigint(20) UNSIGNED DEFAULT NULL,
  `type` enum('megtekintes','konzultacio','esemeny') NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `appointment_date` date NOT NULL,
  `appointment_time` time NOT NULL,
  `notes` text DEFAULT NULL,
  `status` enum('fuggoben','megerositett','lemondott') NOT NULL DEFAULT 'fuggoben',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- A tábla adatainak kiíratása `appointments`
--

INSERT INTO `appointments` (`id`, `user_id`, `animal_id`, `type`, `first_name`, `last_name`, `email`, `phone`, `appointment_date`, `appointment_time`, `notes`, `status`, `created_at`, `updated_at`) VALUES
(1, 2, 1, 'megtekintes', 'Anna', 'Kovács', 'anna@menhely.hu', '+36 70 234 5678', '2026-04-20', '10:00:00', 'Szeretném személyesen is megismerni az állatot örökbefogadás előtt.', 'megerositett', '2026-04-16 18:30:37', '2026-04-18 18:30:37'),
(2, 3, NULL, 'konzultacio', 'Péter', 'Nagy', 'peter@menhely.hu', '+36 20 345 6789', '2026-04-22', '14:00:00', 'Általánosan érdeklődnék macska örökbefogadásról.', 'fuggoben', '2026-04-17 18:30:37', '2026-04-17 18:30:37'),
(3, NULL, NULL, 'esemeny', 'Zsuzsa', 'Molnár', 'molnar.zsuzsi@gmail.com', '+36 70 789 0123', '2026-04-25', '09:00:00', 'Az önkéntes napra szeretnék bejelentkezni.', 'megerositett', '2026-04-15 18:30:37', '2026-04-18 18:30:37'),
(4, 2, 2, 'megtekintes', 'Balázs', 'Tóth', 'balazs@gmail.com', '+36 70 567 8901', '2026-04-19', '15:30:00', NULL, 'lemondott', '2026-04-13 18:30:37', '2026-04-16 18:30:37'),
(5, 11, NULL, 'esemeny', 'Newell', 'Stokes', 'lueilwitz.clark@example.org', '+36 90 458 2565', '2026-05-12', '10:00:00', 'Előző állatomat nemrég vesztettem el, most keresek új társat.', 'megerositett', '2026-04-18 18:30:37', '2026-04-18 18:30:37'),
(6, 13, NULL, 'konzultacio', 'Armand', 'McCullough', 'pollich.kyleigh@example.org', '+36 82 455 7336', '2026-04-22', '10:00:00', NULL, 'lemondott', '2026-04-18 18:30:37', '2026-04-18 18:30:37'),
(7, NULL, 19, 'megtekintes', 'Chaya', 'Barton', 'zgottlieb@example.net', '+36 72 664 6506', '2026-05-13', '14:30:00', NULL, 'fuggoben', '2026-04-18 18:30:37', '2026-04-18 18:30:37'),
(8, 6, 14, 'megtekintes', 'Allan', 'Bashirian', 'ritchie.angus@example.com', '+36 39 194 0461', '2026-04-28', '13:30:00', NULL, 'fuggoben', '2026-04-18 18:30:37', '2026-04-18 18:30:37'),
(9, 6, 3, 'megtekintes', 'Cordell', 'Steuber', 'cordell92@example.net', '+36 83 280 4541', '2026-05-03', '13:00:00', NULL, 'fuggoben', '2026-04-18 18:30:37', '2026-04-18 18:30:37'),
(10, 13, 10, 'megtekintes', 'Lane', 'Durgan', 'arunolfsson@example.com', '+36 95 002 9329', '2026-05-02', '09:00:00', NULL, 'fuggoben', '2026-04-18 18:30:37', '2026-04-18 18:30:37'),
(11, NULL, 15, 'megtekintes', 'Henri', 'Weber', 'gino.parisian@example.com', '+36 24 458 3677', '2026-05-07', '15:30:00', 'A gyerekeimet is hoznám, szeretnék megismerkedni az állattal.', 'lemondott', '2026-04-18 18:30:37', '2026-04-18 18:30:37'),
(12, NULL, NULL, 'konzultacio', 'Macie', 'Flatley', 'jpouros@example.net', '+36 25 935 8170', '2026-05-02', '10:00:00', NULL, 'lemondott', '2026-04-18 18:30:37', '2026-04-18 18:30:37'),
(13, 3, NULL, 'esemeny', 'Trevion', 'Kshlerin', 'issac13@example.net', '+36 64 708 3529', '2026-05-14', '11:30:00', NULL, 'fuggoben', '2026-04-18 18:30:37', '2026-04-18 18:30:37'),
(14, 12, NULL, 'konzultacio', 'Alize', 'Stehr', 'okon.valentin@example.net', '+36 76 964 1947', '2026-04-29', '09:00:00', NULL, 'lemondott', '2026-04-18 18:30:37', '2026-04-18 18:30:37'),
(15, 14, 5, 'megtekintes', 'lakner', 'máté', 'levieasy22@gmail.com', '+36 20 409 1502', '2026-04-23', '13:00:00', 'nincs', 'fuggoben', '2026-04-22 06:20:00', '2026-04-22 06:20:00'),
(16, 15, 23, 'konzultacio', 'Levente', 'Igli', 'iglilevente12@gmail.com', '+36204091502', '2026-04-24', '14:00:00', NULL, 'fuggoben', '2026-04-22 13:17:33', '2026-04-22 13:17:33');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `contact_messages`
--

CREATE TABLE `contact_messages` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(255) NOT NULL,
  `subject` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `is_read` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- A tábla adatainak kiíratása `contact_messages`
--

INSERT INTO `contact_messages` (`id`, `name`, `email`, `subject`, `message`, `is_read`, `created_at`, `updated_at`) VALUES
(1, 'Horváth Judit', 'horvath.judit@gmail.com', 'Önkéntes lehetőségek', 'Üdvözlöm! Érdeklődnék, hogy van-e lehetőség önkéntesnek jelentkezni a menhelyre. Hétvégeken szívesen segítenék az állatok gondozásában és sétáltatásában. Várom megtisztelő válaszukat!', 0, '2026-04-16 18:30:37', '2026-04-16 18:30:37'),
(2, 'Kiss Gábor', 'kiss.gabor@freemail.hu', 'Talált kutya bejelentése', 'Jó napot! Tegnap este egy kóbor kutyát találtam a lakótelep mellett. Körülbelül 2 éves, barna-fehér foltos, nyakörv nélkül. Jelenleg nálam van. Kérem jelezzék, mit tegyek.', 1, '2026-04-14 18:30:37', '2026-04-15 18:30:37'),
(3, 'Varga Réka', 'varga.reka@citromail.hu', 'Adomány leadása', 'Tisztelt Menhely! Szeretnék adományozni száraztápot és néhány játékot az állatoknak. Mikor és hogyan tudom leadni? Nagyjából 10 kg száraztápot hoztam össze.', 0, '2026-04-17 18:30:37', '2026-04-17 18:30:37'),
(4, 'Balogh Tamás', 'balogh.tamas@gmail.com', 'Örökbefogadott állat visszahozatala', 'Sajnálattal értesítem Önöket, hogy körülményeim megváltozása miatt nem tudom tovább tartani a 2 hónapja örökbefogadott állatot. Kérem tájékoztassanak a visszahozatal menetéről.', 1, '2026-04-12 18:30:37', '2026-04-13 18:30:37'),
(5, 'Fekete Kata', 'fekete.kata@outlook.com', 'Szponzoráció', 'Kis vállalkozásunk szeretné szponzorálni a menhely egyik állatát. Havonta egy összegben tudnánk hozzájárulni az ellátási költségekhez. Kérlek vegyétek fel velünk a kapcsolatot!', 0, '2026-04-18 18:30:37', '2026-04-18 18:30:37'),
(6, 'Mr. Bell Schinner', 'bashirian.karen@example.net', 'Általános érdeklődés', 'Kis vállalkozásunk szeretné szponzorálni a menhely egyik állatát. Havonta tudnánk hozzájárulni az ellátási költségekhez.', 1, '2026-04-18 18:30:37', '2026-04-18 18:30:37'),
(7, 'Lafayette Rath PhD', 'aschmidt@example.net', 'Rendezvény szervezés', 'Kis vállalkozásunk szeretné szponzorálni a menhely egyik állatát. Havonta tudnánk hozzájárulni az ellátási költségekhez.', 0, '2026-04-18 18:30:37', '2026-04-18 18:30:37'),
(8, 'Alexandrine Zieme', 'yschmitt@example.org', 'Örökbefogadott állat visszahozatala', 'Tisztelt Menhely! Száraztápot és játékokat szeretnék adományozni. Mikor és hogyan tudom leadni az adományokat?', 1, '2026-04-18 18:30:37', '2026-04-18 18:30:37'),
(9, 'Zaria Wisozk', 'rogers04@example.com', 'Önkéntes lehetőségek', 'Sajnálattal értesítem Önöket, hogy körülményeim megváltozása miatt nem tudom tovább tartani az örökbefogadott állatom.', 0, '2026-04-18 18:30:37', '2026-04-18 18:30:37'),
(10, 'Jennifer Leuschke', 'britney27@example.org', 'Örökbefogadott állat visszahozatala', 'Tisztelt Menhely! Száraztápot és játékokat szeretnék adományozni. Mikor és hogyan tudom leadni az adományokat?', 1, '2026-04-18 18:30:37', '2026-04-18 18:30:37'),
(11, 'Judd Luettgen', 'hconn@example.com', 'Sajtómegkeresés', 'Szeretném megkérdezni, hogy mikor van nyitva a menhely látogatók számára. Szeretnék személyesen megnézni néhány állatot.', 1, '2026-04-18 18:30:37', '2026-04-18 18:30:37'),
(12, 'Sarina Harber', 'emie79@example.com', 'Adomány leadása', 'Kis vállalkozásunk szeretné szponzorálni a menhely egyik állatát. Havonta tudnánk hozzájárulni az ellátási költségekhez.', 0, '2026-04-18 18:30:37', '2026-04-18 18:30:37'),
(13, 'Mayra Reynolds', 'skiehn@example.com', 'Általános érdeklődés', 'Sajnálattal értesítem Önöket, hogy körülményeim megváltozása miatt nem tudom tovább tartani az örökbefogadott állatom.', 0, '2026-04-18 18:30:37', '2026-04-18 18:30:37'),
(14, 'Winfield Bergstrom', 'daryl35@example.net', 'Általános érdeklődés', 'Érdeklődnék, hogy milyen feltételei vannak az örökbefogadásnak. Először tennék szert háziállatra, ezért sok kérdésem van.', 0, '2026-04-18 18:30:37', '2026-04-18 18:30:37'),
(15, 'Della Rodriguez', 'darron.hermann@example.org', 'Talált állat bejelentése', 'Tisztelt Menhely! Száraztápot és játékokat szeretnék adományozni. Mikor és hogyan tudom leadni az adományokat?', 0, '2026-04-18 18:30:37', '2026-04-18 18:30:37'),
(16, 'Dr. Xzavier Corwin', 'gibson.forest@example.com', 'Adomány leadása', 'Sajnálattal értesítem Önöket, hogy körülményeim megváltozása miatt nem tudom tovább tartani az örökbefogadott állatom.', 0, '2026-04-18 18:30:37', '2026-04-18 18:30:37'),
(17, 'Efren Hoppe', 'elfrieda68@example.net', 'Általános érdeklődés', 'Jó napot! Tegnap este egy kóbor kutyát találtam a lakótelep mellett. Körülbelül 2 éves, barna-fehér foltos. Jelenleg nálam van.', 0, '2026-04-18 18:30:37', '2026-04-18 18:30:37'),
(18, 'Teszt Felhasználó', 'teszt@gmail.com', 'Érdeklődés', 'Érdeklődnék az önkéntes lehetőségekről a menhelyen.', 0, '2026-04-18 18:53:22', '2026-04-18 18:53:22'),
(19, 'Levente Igli', 'iglilevente12@gmail.com', 'gyors kérdés', 'asdsadasdasdads', 1, '2026-04-21 11:03:28', '2026-04-21 11:15:06'),
(20, 'asdasadsads', 'levieasy22@gmail.com', 'asdadsadsdasadsdasdasdas', 'asddsadsaadsadsads', 1, '2026-04-22 06:15:19', '2026-04-22 06:15:55'),
(21, 'Müller Enikő', 'muller.eniko@blathy.info', 'teszt üzenet', 'teszt üzenet mancs menhely', 1, '2026-04-22 12:02:51', '2026-04-22 13:19:57');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2026_04_18_145055_create_personal_access_tokens_table', 1),
(5, '2026_04_18_150536_add_role_and_phone_to_users_table', 1),
(6, '2026_04_18_150550_create_animals_table', 1),
(7, '2026_04_18_150610_create_animal_images_table', 1),
(8, '2026_04_18_150616_create_adoption_requests_table', 1),
(9, '2026_04_18_150621_create_appointments_table', 1),
(10, '2026_04_18_150626_create_contact_messages_table', 1);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` text NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- A tábla adatainak kiíratása `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(13, 'App\\Models\\User', 1, 'auth_token', 'eb3a3338dad9309c859a8436f3d35b10e993f9c05e20ee568a4384d67dc5fb8c', '[\"*\"]', '2026-04-25 12:37:41', NULL, '2026-04-22 18:27:19', '2026-04-25 12:37:41');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- A tábla adatainak kiíratása `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('Ic6Jc1xFxELDOX9RdFjsVWKn5lhustCpApMdKcWm', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiMzB2SmN6UDhUUUEzZUdYM3hjUENNTGY3OVlVT3NMcnFmRDc0aEFUSCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6Mzk6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvYW5pbWFscy9zdGF0cyI7czo1OiJyb3V0ZSI7Tjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1776773072),
('IGyLREOp70ATTBHOMARnb0oj8XgYPjos8FLWXtv7', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiNFpXWThWWjNKTTBiOEVoaWd0Nkh6UWxqN2JkcDdsYVlFbFlKUjNGdiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6NTc6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvYW5pbWFscz9saW1pdD02JnN0YXR1cz1lbGVyaGV0byI7czo1OiJyb3V0ZSI7Tjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1776767565);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('user','admin') NOT NULL DEFAULT 'user',
  `phone` varchar(20) DEFAULT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- A tábla adatainak kiíratása `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `role`, `phone`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Adminisztrátor', 'admin@menhely.hu', NULL, '$2y$12$at2Fv5VKdm1TiBJv8HxBRORIWdivXhKSEl1X5Zx8b8JwBiDHgzlQq', 'admin', '+36 30 123 4567', NULL, '2026-04-18 18:30:35', '2026-04-18 18:30:35'),
(2, 'Kovács Anna', 'anna@menhely.hu', NULL, '$2y$12$jfnyVmwUJNocw4kG8qXQ4ORaN16VDY9HAQ92X17hRXbbLNuisLn6q', 'user', '+36 70 234 5678', NULL, '2026-04-18 18:30:35', '2026-04-18 18:30:35'),
(3, 'Nagy Péter', 'peter@menhely.hu', NULL, '$2y$12$EcAXdwYYitEZYakaRobTWuIcMPpBru54FfWYfqfJ1EMUXH1SokA3.', 'user', '+36 20 345 6789', NULL, '2026-04-18 18:30:35', '2026-04-18 18:30:35'),
(4, 'Prof. Lambert Barton', 'bauch.cecil@example.org', '2026-04-18 18:30:35', '$2y$12$cFHKlR86.edMEyEKVrG6ZeBSscDzdPSegr2urff2KYnOXNnZvoa4y', 'user', '+36 84 825 5141', 'qVCYzuyMiN', '2026-04-18 18:30:37', '2026-04-18 18:30:37'),
(5, 'Prof. Juliana Strosin PhD', 'balistreri.katrine@example.org', '2026-04-18 18:30:35', '$2y$12$U20oiuZ7fMorKW33NkmUXOTZWX86tJvwhyrBsbA2VZuUxH/NtRACW', 'user', '+36 14 751 2041', 'zWyshwcLZK', '2026-04-18 18:30:37', '2026-04-18 18:30:37'),
(6, 'Maegan Gleason PhD', 'xturner@example.org', '2026-04-18 18:30:35', '$2y$12$sCm94xeX8zQ8yxIffRpPue44VwH4dWZZB6VKGG8yff2hujDIzGCi.', 'user', '+36 20 517 8590', 'gB8pN9KaHd', '2026-04-18 18:30:37', '2026-04-18 18:30:37'),
(7, 'Lyric Miller', 'malvina51@example.com', '2026-04-18 18:30:36', '$2y$12$X4aupZgCKTjs4u043PaAXeSAFz0byfCJzQZWj6NchhmzB.ctLIm5C', 'user', '+36 17 819 7260', 'hXTGpNG7Sp', '2026-04-18 18:30:37', '2026-04-18 18:30:37'),
(8, 'Dr. Meagan Blick', 'claud25@example.org', '2026-04-18 18:30:36', '$2y$12$l.d7CpznBC4IRpgFU9/4YuOvsq2MzztnEyl7EeSdwLqJn8AIe5Bf2', 'user', '+36 14 054 6525', 'dv3KBwRiUz', '2026-04-18 18:30:37', '2026-04-18 18:30:37'),
(9, 'Mrs. Robyn White', 'daisha.oconner@example.org', '2026-04-18 18:30:36', '$2y$12$jcANE/F3GYXdUQwUOBKEeOvoQC9w9CtjQ..yheC7rEVfiTIbDS3rK', 'user', '+36 18 338 9032', 'RcwS9pavZ1', '2026-04-18 18:30:37', '2026-04-18 18:30:37'),
(10, 'Dr. Tyrell Green IV', 'corkery.whitney@example.org', '2026-04-18 18:30:36', '$2y$12$ngEJy9lL3cg/iNzM46peOuQbGlEXah4six5wqU86/kNiCuK1tKOJK', 'user', '+36 38 893 1095', 'pgfcsVMOat', '2026-04-18 18:30:37', '2026-04-18 18:30:37'),
(11, 'Mr. Jamal Baumbach IV', 'cristian.gutmann@example.org', '2026-04-18 18:30:36', '$2y$12$uLwYRQsA8gX2S.R9nblNTe/bQJ3zpsrY24ILYgN9ybGJOvHKFIHtG', 'user', '+36 14 038 8042', 'RCozbAOyJx', '2026-04-18 18:30:37', '2026-04-18 18:30:37'),
(12, 'Miss Sienna Bauch V', 'samson.tillman@example.net', '2026-04-18 18:30:37', '$2y$12$BJUls4ZZI43MJOR/Dp78E.DHB0noKL98XHLYNb8pjH4T./zY8QByy', 'user', '+36 41 272 9100', 'yPSOSqYcz6', '2026-04-18 18:30:37', '2026-04-18 18:30:37'),
(13, 'Prof. Malachi Price DDS', 'yost.forest@example.net', '2026-04-18 18:30:37', '$2y$12$8.WeukRVmPnwukab8HHDo.hNEi8xGShhaynhpCNaclPZuXPgt/gJ2', 'user', '+36 57 198 0776', 'R780xamWsF', '2026-04-18 18:30:37', '2026-04-18 18:30:37'),
(14, 'lakner máté', 'levieasy22@gmail.com', NULL, '$2y$12$ZBlH37Mfo/PpSFWqjRkAI.S50Iw6w4Qf/od1tew3JteU1ryrgjii6', 'user', NULL, NULL, '2026-04-22 06:18:14', '2026-04-22 06:18:14'),
(15, 'Levente Igli', 'iglilevente12@gmail.com', NULL, '$2y$12$qazy7wlsm.qSfbiQ/9T87OMSF0exwh4Y1AmAjs0f3gf/RVe/O/Pam', 'user', '+36204091502', NULL, '2026-04-22 13:16:11', '2026-04-22 13:16:11');

--
-- Indexek a kiírt táblákhoz
--

--
-- A tábla indexei `adoption_requests`
--
ALTER TABLE `adoption_requests`
  ADD PRIMARY KEY (`id`),
  ADD KEY `adoption_requests_user_id_foreign` (`user_id`),
  ADD KEY `adoption_requests_animal_id_foreign` (`animal_id`);

--
-- A tábla indexei `animals`
--
ALTER TABLE `animals`
  ADD PRIMARY KEY (`id`);

--
-- A tábla indexei `animal_images`
--
ALTER TABLE `animal_images`
  ADD PRIMARY KEY (`id`),
  ADD KEY `animal_images_animal_id_foreign` (`animal_id`);

--
-- A tábla indexei `appointments`
--
ALTER TABLE `appointments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `appointments_user_id_foreign` (`user_id`),
  ADD KEY `appointments_animal_id_foreign` (`animal_id`);

--
-- A tábla indexei `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`),
  ADD KEY `cache_expiration_index` (`expiration`);

--
-- A tábla indexei `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`),
  ADD KEY `cache_locks_expiration_index` (`expiration`);

--
-- A tábla indexei `contact_messages`
--
ALTER TABLE `contact_messages`
  ADD PRIMARY KEY (`id`);

--
-- A tábla indexei `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- A tábla indexei `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- A tábla indexei `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- A tábla indexei `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- A tábla indexei `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- A tábla indexei `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`),
  ADD KEY `personal_access_tokens_expires_at_index` (`expires_at`);

--
-- A tábla indexei `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- A tábla indexei `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- A kiírt táblák AUTO_INCREMENT értéke
--

--
-- AUTO_INCREMENT a táblához `adoption_requests`
--
ALTER TABLE `adoption_requests`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT a táblához `animals`
--
ALTER TABLE `animals`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT a táblához `animal_images`
--
ALTER TABLE `animal_images`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT a táblához `appointments`
--
ALTER TABLE `appointments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT a táblához `contact_messages`
--
ALTER TABLE `contact_messages`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT a táblához `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT a táblához `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT a táblához `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT a táblához `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT a táblához `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- Megkötések a kiírt táblákhoz
--

--
-- Megkötések a táblához `adoption_requests`
--
ALTER TABLE `adoption_requests`
  ADD CONSTRAINT `adoption_requests_animal_id_foreign` FOREIGN KEY (`animal_id`) REFERENCES `animals` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `adoption_requests_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Megkötések a táblához `animal_images`
--
ALTER TABLE `animal_images`
  ADD CONSTRAINT `animal_images_animal_id_foreign` FOREIGN KEY (`animal_id`) REFERENCES `animals` (`id`) ON DELETE CASCADE;

--
-- Megkötések a táblához `appointments`
--
ALTER TABLE `appointments`
  ADD CONSTRAINT `appointments_animal_id_foreign` FOREIGN KEY (`animal_id`) REFERENCES `animals` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `appointments_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
