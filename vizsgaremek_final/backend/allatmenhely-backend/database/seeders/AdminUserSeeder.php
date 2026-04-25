<?php

namespace Database\Seeders;

use App\Models\User;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;

class AdminUserSeeder extends Seeder
{
    public function run(): void
    {
        // ── ADMIN FELHASZNÁLÓ ─────────────────────────────────────────
        User::create([
            'name'     => 'Adminisztrátor',
            'email'    => 'admin@menhely.hu',
            'password' => Hash::make('admin123'),
            'role'     => 'admin',
            'phone'    => '+36 30 123 4567',
        ]);

        // ── TESZT FELHASZNÁLÓK (fix adatokkal, könnyű bejelentkezni) ──
        User::create([
            'name'     => 'Kovács Anna',
            'email'    => 'anna@menhely.hu',
            'password' => Hash::make('user123'),
            'role'     => 'user',
            'phone'    => '+36 70 234 5678',
        ]);

        User::create([
            'name'     => 'Nagy Péter',
            'email'    => 'peter@menhely.hu',
            'password' => Hash::make('user123'),
            'role'     => 'user',
            'phone'    => '+36 20 345 6789',
        ]);

        // ── EXTRA VÉLETLENSZERŰ USEREK (Factory segítségével) ─────────
        // Létrehoz még 10 db véletlenszerű felhasználót
        User::factory(10)->create();

        $this->command->info('✅ Felhasználók sikeresen létrehozva.');
        $this->command->info('   Admin: admin@menhely.hu / admin123');
        $this->command->info('   User:  anna@menhely.hu  / user123');
    }
}
