<?php

namespace Database\Seeders;

use App\Models\Animal;
use App\Models\Appointment;
use App\Models\User;
use Illuminate\Database\Seeder;

class AppointmentSeeder extends Seeder
{
    public function run(): void
    {
        $users   = User::where('role', 'user')->get();
        $animals = Animal::where('status', 'elerheto')->get();

        if ($users->isEmpty()) {
            $this->command->warn('⚠️  Nincs elég user az időpontokhoz!');
            return;
        }

        // ── FIX IDŐPONTOK (vegyes típusokkal a bemutatkozáshoz) ───────

        // Megtekintési időpont – jövőbeni, megerősített
        Appointment::create([
            'user_id'          => $users->first()->id,
            'animal_id'        => $animals->first()?->id,
            'type'             => 'megtekintes',
            'first_name'       => 'Anna',
            'last_name'        => 'Kovács',
            'email'            => 'anna@menhely.hu',
            'phone'            => '+36 70 234 5678',
            'appointment_date' => now()->addDays(2)->format('Y-m-d'),
            'appointment_time' => '10:00:00',
            'notes'            => 'Szeretném személyesen is megismerni az állatot örökbefogadás előtt.',
            'status'           => 'megerositett',
            'created_at'       => now()->subDays(2),
            'updated_at'       => now(),
        ]);

        // Konzultációs időpont – jövőbeni, függőben
        Appointment::create([
            'user_id'          => $users->skip(1)->first()?->id ?? $users->first()->id,
            'animal_id'        => null,
            'type'             => 'konzultacio',
            'first_name'       => 'Péter',
            'last_name'        => 'Nagy',
            'email'            => 'peter@menhely.hu',
            'phone'            => '+36 20 345 6789',
            'appointment_date' => now()->addDays(4)->format('Y-m-d'),
            'appointment_time' => '14:00:00',
            'notes'            => 'Általánosan érdeklődnék macska örökbefogadásról.',
            'status'           => 'fuggoben',
            'created_at'       => now()->subDay(),
            'updated_at'       => now()->subDay(),
        ]);

        // Esemény időpont – jövőbeni, megerősített, vendég
        Appointment::create([
            'user_id'          => null,
            'animal_id'        => null,
            'type'             => 'esemeny',
            'first_name'       => 'Zsuzsa',
            'last_name'        => 'Molnár',
            'email'            => 'molnar.zsuzsi@gmail.com',
            'phone'            => '+36 70 789 0123',
            'appointment_date' => now()->addDays(7)->format('Y-m-d'),
            'appointment_time' => '09:00:00',
            'notes'            => 'Az önkéntes napra szeretnék bejelentkezni.',
            'status'           => 'megerositett',
            'created_at'       => now()->subDays(3),
            'updated_at'       => now(),
        ]);

        // Lemondott időpont
        Appointment::create([
            'user_id'          => $users->first()->id,
            'animal_id'        => $animals->skip(1)->first()?->id,
            'type'             => 'megtekintes',
            'first_name'       => 'Balázs',
            'last_name'        => 'Tóth',
            'email'            => 'balazs@gmail.com',
            'phone'            => '+36 70 567 8901',
            'appointment_date' => now()->addDays(1)->format('Y-m-d'),
            'appointment_time' => '15:30:00',
            'notes'            => null,
            'status'           => 'lemondott',
            'created_at'       => now()->subDays(5),
            'updated_at'       => now()->subDays(2),
        ]);

        // ── VÉLETLENSZERŰ IDŐPONTOK (Factory segítségével) ────────────
        Appointment::factory(10)->create();

        $this->command->info('✅ Időpontfoglalások sikeresen létrehozva.');
    }
}
