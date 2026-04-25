<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    public function run(): void
    {
        $this->command->info('🐾 Állatmenhely adatbázis feltöltése...');
        $this->command->newLine();

        // A SORREND NAGYON FONTOS!
        // Először a userek, aztán az állatok,
        // végül azok, amik hivatkoznak rájuk (FK miatt).

        $this->call([
            AdminUserSeeder::class,       // 1. Felhasználók (admin + userek)
            AnimalSeeder::class,          // 2. Állatok + képek
            AdoptionRequestSeeder::class, // 3. Örökbefogadási kérelmek (user + animal kell)
            AppointmentSeeder::class,     // 4. Időpontfoglalások (user + animal kell)
            ContactMessageSeeder::class,  // 5. Kapcsolatfelvételi üzenetek (független)
        ]);

        $this->command->newLine();
        $this->command->info('✅ Adatbázis sikeresen feltöltve!');
        $this->command->newLine();
        $this->command->table(
            ['Szerepkör', 'Email', 'Jelszó'],
            [
                ['Admin', 'admin@menhely.hu', 'admin123'],
                ['User',  'anna@menhely.hu',  'user123'],
                ['User',  'peter@menhely.hu', 'user123'],
            ]
        );
    }
}
