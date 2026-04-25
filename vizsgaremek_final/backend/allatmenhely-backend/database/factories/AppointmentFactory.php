<?php

namespace Database\Factories;

use App\Models\Animal;
use App\Models\User;
use Illuminate\Database\Eloquent\Factories\Factory;

class AppointmentFactory extends Factory
{
    private array $notes = [
        'A gyerekeimet is hoznám, szeretnék megismerkedni az állattal.',
        'Általánosan érdeklődnék az örökbefogadás folyamatáról.',
        'Előző állatomat nemrég vesztettem el, most keresek új társat.',
        null,  // néha nincs megjegyzés
        null,
        null,
    ];

    public function definition(): array
    {
        $type = fake()->randomElement(['megtekintes', 'konzultacio', 'esemeny']);

        return [
            'user_id'          => fake()->boolean(60)
                ? User::where('role', 'user')->inRandomOrder()->first()?->id
                : null,
            // Megtekintésnél van állat, konzultációnál és eseménynél lehet null
            'animal_id'        => $type === 'megtekintes'
                ? Animal::where('status', 'elerheto')->inRandomOrder()->first()?->id
                : null,
            'type'             => $type,
            'first_name'       => fake()->firstName(),
            'last_name'        => fake()->lastName(),
            'email'            => fake()->safeEmail(),
            'phone'            => '+36 ' . fake()->numerify('## ### ####'),
            // Jövőbeni dátumok: ma + 1 naptól + 30 napig
            'appointment_date' => fake()->dateTimeBetween('+1 days', '+30 days')->format('Y-m-d'),
            'appointment_time' => fake()->randomElement([
                '09:00', '09:30', '10:00', '10:30', '11:00', '11:30',
                '13:00', '13:30', '14:00', '14:30', '15:00', '15:30', '16:00',
            ]),
            'notes'            => fake()->randomElement($this->notes),
            'status'           => fake()->randomElement([
                'fuggoben', 'fuggoben',
                'megerositett', 'megerositett',
                'lemondott',
            ]),
        ];
    }
}
