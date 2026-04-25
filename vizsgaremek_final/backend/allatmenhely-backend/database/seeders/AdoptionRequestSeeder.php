<?php

namespace Database\Seeders;

use App\Models\AdoptionRequest;
use App\Models\Animal;
use App\Models\User;
use Illuminate\Database\Seeder;

class AdoptionRequestSeeder extends Seeder
{
    public function run(): void
    {
        $users   = User::where('role', 'user')->get();
        $animals = Animal::all();

        // Biztonsági ellenőrzés: ha nincs elég adat, ne fusson le
        if ($users->isEmpty() || $animals->isEmpty()) {
            $this->command->warn('⚠️  Nincs elég user vagy állat az örökbefogadási kérelmekhez!');
            return;
        }

        // ── FIX KÉRELMEK (vegyes státuszokkal a bemutatkozáshoz) ──────

        // Függőben lévő kérelem
        AdoptionRequest::create([
            'user_id'        => $users->first()->id,
            'animal_id'      => $animals->where('status', 'elerheto')->first()->id,
            'first_name'     => 'Anna',
            'last_name'      => 'Kovács',
            'email'          => 'anna@menhely.hu',
            'phone'          => '+36 70 234 5678',
            'address'        => '1051 Budapest, Vörösmarty tér 5.',
            'motivation'     => 'Mindig is szerettem volna labradorom. Van egy 6 éves kislányom, aki imádja az állatokat. Kertünk is van.',
            'has_garden'     => true,
            'has_other_pets' => false,
            'status'         => 'fuggoben',
            'created_at'     => now()->subDays(3),
            'updated_at'     => now()->subDays(3),
        ]);

        // Elfogadott kérelem
        AdoptionRequest::create([
            'user_id'        => $users->skip(1)->first()->id ?? $users->first()->id,
            'animal_id'      => $animals->where('type', 'macska')->first()->id,
            'first_name'     => 'Péter',
            'last_name'      => 'Nagy',
            'email'          => 'peter@menhely.hu',
            'phone'          => '+36 20 345 6789',
            'address'        => '4025 Debrecen, Piac utca 12.',
            'motivation'     => 'Egyedül élek, home office-ban dolgozom. Egész nap otthon vagyok, rengeteg időt tudnék az állatra szánni.',
            'has_garden'     => false,
            'has_other_pets' => false,
            'status'         => 'elfogadva',
            'created_at'     => now()->subDays(7),
            'updated_at'     => now()->subDays(5),
        ]);

        // Elutasított kérelem
        AdoptionRequest::create([
            'user_id'        => null,  // vendég kérelem
            'animal_id'      => $animals->where('type', 'kutya')->skip(1)->first()->id ?? $animals->first()->id,
            'first_name'     => 'Balázs',
            'last_name'      => 'Tóth',
            'email'          => 'balazs.toth@gmail.com',
            'phone'          => '+36 70 567 8901',
            'address'        => '9021 Győr, Baross út 3.',
            'motivation'     => 'Nagyon tetszik ez az állat, szeretném örökbefogadni.',
            'has_garden'     => false,
            'has_other_pets' => true,
            'status'         => 'elutasitva',
            'created_at'     => now()->subDays(10),
            'updated_at'     => now()->subDays(8),
        ]);

        // ── VÉLETLENSZERŰ KÉRELMEK (Factory segítségével) ─────────────
        // Létrehoz még 10 db véletlenszerű kérelmet
        AdoptionRequest::factory(10)->create();

        $this->command->info('✅ Örökbefogadási kérelmek sikeresen létrehozva.');
    }
}
