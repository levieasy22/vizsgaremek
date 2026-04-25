# Mancs Menhely – Telepítési és Indítási Útmutató

### Fejlesztők: Igli Levente, Müller Enikő, Lakner Máté
### Github felhasználóneveink: @levieasy22 @encimuller @laknermatee
**Technológia:** Laravel 11 (backend) + Vue 3 (frontend)

---

## Tartalomjegyzék

1. [Szükséges szoftverek](#szükséges-szoftverek)
2. [Backend telepítése (Laravel)](#backend-telepítése)
3. [Frontend telepítése (Vue.js)](#frontend-telepítése)
4. [Szerverek indítása](#szerverek-indítása)
5. [Belépési adatok](#belépési-adatok)
6. [Hibaelhárítás](#hibaelhárítás)

---

## Szükséges szoftverek

A következő szoftverek telepítve kell legyenek a gépen:

| Szoftver | Verzió | Letöltés |
|---------|--------|----------|
| PHP | 8.2 vagy újabb | https://www.php.net |
| Composer | 2.x | https://getcomposer.org |
| Node.js | 18.x vagy újabb | https://nodejs.org |
| npm | 9.x vagy újabb | (Node.js-sel együtt települ) |
| MySQL | 8.0 vagy újabb | https://www.mysql.com |
| XAMPP | 8.2.x | https://www.apachefriends.org |

**Megjegyzés:** XAMPP tartalmazza a PHP-t és MySQL-t egyszerre, ezért ajánlott.  
Verziók ellenőrzése terminálban:
php --version
composer --version
node --version
npm --version

---

## Backend telepítése

1. Működéshez szükséges a composer telepítése.

### 1. lépés – Mappa megnyitása

Navigáljon a backend mappába:
cd backend\allatmenhely-backend

### 2. lépés – Függőségek telepítése
composer install

Ez telepíti az összes Laravel csomagot a vendor/ mappába.  
Körülbelül 1-2 percet vesz igénybe.

### 3. lépés – .env fájl létrehozása

Másolja le az example fájlt:
cp .env.example .env

Windows esetén:
copy .env.example .env

### 4. lépés – .env fájl szerkesztése

Nyissa meg a .env fájlt és állítsa be az adatbázis adatokat:

- env
- APP_NAME=AllatmenhelyAPI
- APP_ENV=local
- APP_KEY=base64:nqehxNrX6Y5uXXGnu9R+e+vhLf+gRiYqJgjanoHlUAA=
- APP_DEBUG=true
- APP_URL=http://localhost:8000

- DB_CONNECTION=mysql
- DB_HOST=127.0.0.1
- DB_PORT=3306
- DB_DATABASE=allatmenhely
- DB_USERNAME=root
- DB_PASSWORD=

- SANCTUM_STATEFUL_DOMAINS=localhost:5173
- SESSION_DOMAIN=localhost


### 5. lépés – Application key generálása
php artisan key:generate

### 6. lépés – Adatbázis létrehozása

1. Indítsa el a **XAMPP**-ot
2. Kattintson az **Apache** és **MySQL** melletti **Start** gombra
3. Nyissa meg a böngészőben: http://localhost/phpmyadmin
4. Kattintson az **„Új"** gombra bal oldalt
5. Adatbázis neve: allatmenhely
6. Collation: utf8mb4_unicode_ci
7. Kattintson a **„Létrehozás"** gombra

### 7. lépés – Migrációk futtatása + adatbázis feltöltése
php artisan migrate:fresh --seed

Ez létrehozza az összes táblát és feltölti őket tesztadatokkal.  
A folyamat végén megjelenik a belépési adatok táblázata.

### 8. lépés – Storage link létrehozása
php artisan storage:link

Ez szükséges ahhoz, hogy a feltöltött képek elérhetők legyenek.

### 9. lépés – Sanctum telepítése (ha szükséges)
php artisan vendor:publish --provider="Laravel\Sanctum\SanctumServiceProvider"

---

## Frontend telepítése

1. Működéshez szükséges a node telepítése.

### 1. lépés – Mappa megnyitása

Nyisson egy **új terminált** és navigáljon a frontend mappába:
cd frontend\allatmenhely-frontend

### 2. lépés – Függőségek telepítése
npm install

Ez telepíti az összes Vue csomagot a `node_modules/` mappába.  
Körülbelül 1-3 percet vesz igénybe.

A következő fő csomagok települnek automatikusan:

| Csomag | Verzió | Leírás |
|--------|--------|--------|
| vue | ^3.5.x | Vue.js framework |
| vue-router | ^4.x | Oldalak közti navigáció |
| pinia | ^2.x | Állapotkezelés |
| axios | ^1.x | HTTP kérések |
| bootstrap | ^5.3.x | CSS framework |
| bootstrap-icons | ^1.x | Ikonok |

Ha valamely csomag hiányzik, telepítse külön:
npm install vue-router pinia axios bootstrap bootstrap-icons

### 3. lépés – .env fájl létrehozása

Hozzon létre egy .env fájlt a frontend mappában:

# Windows
copy NUL .env

# Mac/Linux
touch .env

Nyissa meg és adja hozzá:
env
VITE_API_URL=http://localhost:8000/api
VITE_STORAGE_URL=http://localhost:8000/storage

---

## Szerverek indítása

**Fontos:** Mindkét szervert egyszerre kell futtatni, két külön terminálban!  
A XAMPP MySQL-nek is futnia kell!

### 1. terminál – Backend (Laravel)
cd backend\allatmenhely-backend
php artisan serve

Sikeres indítás után:
INFO  Server running on [http://127.0.0.1:8000].
Press Ctrl+C to stop the server


### 2. terminál – Frontend (Vue.js)
cd frontend\allatmenhely-frontend
npm run dev

Sikeres indítás után:
VITE v5.x.x  ready in xxx ms
Local:   http://localhost:5173/
Network: use --host to expose

### Megnyitás böngészőben

Az alkalmazás elérhető: **http://localhost:5173**

---

## Belépési adatok

### Admin fiók
| Mező | Érték |
|------|-------|
| Email | admin@menhely.hu |
| Jelszó | admin123 |

### Teszt felhasználó
| Mező | Érték |
|------|-------|
| Email | anna@menhely.hu |
| Jelszó | user123 |

Az admin belépés után az /admin oldalra irányít automatikusan.

---

## Az alkalmazás főbb funkciói

### Publikus oldalak (bejelentkezés nélkül)
- **Kezdőlap** – kiemelt állatok és statisztikák
- **Örökbefogadás** – kutyák és macskák böngészése, szűrés
- **Állat részletes oldala** – képek, adatok
- **Rólunk** – a menhely bemutatása
- **Kapcsolat** – üzenet küldése

### Bejelentkezett felhasználónak
- Örökbefogadási kérelem benyújtása
- Időpontfoglalás (megtekintés / konzultáció)

### Admin panelen (`/admin`)
- **Áttekintés** – statisztikák, legutóbbi kérelmek
- **Állatok** – hozzáadás, szerkesztés, törlés, képfeltöltés
- **Örökbefogadások** – kérelmek elfogadása / elutasítása
- **Időpontfoglalások** – megerősítés / lemondás
- **Fiók** – saját adatok, felhasználók listája, üzenetek

---

## Hibaelhárítás

### Backend - installációkor: composer install parancs futtatásakor
- The zip extension and unzip/7z commands are both missing, skipping. The php.ini used by your command-line PHP is C:\xampp\php\php.ini
- C:\xampp\php\php.ini fájlt kell módosítani: kitörölni a ";" az alábbi helyeken, ha van: extension=zip extension_dir = "ext" extension=curl extension=fileinfo extension=gd extension=mbstring extension=openssl extension=pdo_mysql

### „SQLSTATE: Connection refused" hiba
- A XAMPP MySQL nem fut. Indítsa el a XAMPP vezérlőpultból.

### „php artisan" parancs nem ismert
- A PHP nincs a PATH-ban. XAMPP esetén add hozzá:  
- C:\xampp\php a rendszer PATH változóhoz.

### „npm: command not found"
- A Node.js nincs telepítve vagy nincs a PATH-ban.  
- Telepítés után nyisson új terminált.

### „composer: command not found"
- A Composer nincs telepítve. Töltse le: https://getcomposer.org

### A képek nem jelennek meg
- Futtassa le: php artisan storage:link

### „CORS error" a böngészőkonzolban
- Ellenőrizze hogy a backend fut-e (http://localhost:8000)  
- Ellenőrizze a config/cors.php fájlban az allowed_origins értékét

### „Unauthenticated" hiba admin oldalakon
- Jelentkezzen be újra, a token lejárhatott

### Adatbázis újratöltése (reset)
- php artisan migrate:fresh --seed

- Ez törli és újra létrehozza az összes adatot!

---

## Technológiai stack

### Backend
- **Laravel 11** – PHP framework
- **Laravel Sanctum** – Token alapú autentikáció
- **MySQL 8.0** – Adatbázis
- **Eloquent ORM** – Adatbázis kezelés

### Frontend
- **Vue 3** – JavaScript framework (Composition + Options API)
- **Vue Router 4** – SPA navigáció
- **Pinia** – Állapotkezelés
- **Axios** – HTTP kommunikáció
- **Bootstrap 5.3** – CSS framework
- **Bootstrap Icons** – Ikonkészlet
- **Vite** – Build eszköz

### Architektúra
- **REST API** – A backend JSON API-ként működik
- **SPA** – Single Page Application (az oldal nem tölt újra navigáláskor)
- **RBAC** – Role Based Access Control (user / admin szerepkörök)

---

## Reméljük a vizsgaremek munkánk elnyeri tetszésüket!
### Szívélyes üdvözlettel, Igli Levente, Lakner Máté és Müller Enikő
