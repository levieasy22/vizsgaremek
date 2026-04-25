<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Str;

class UserFactory extends Factory
{
    public function definition(): array
    {
        return [
            'name'              => fake()->name(),
            'email'             => fake()->unique()->safeEmail(),
            'email_verified_at' => now(),
            'password'          => Hash::make('password'),  // minden generált user jelszava: "password"
            'role'              => 'user',
            'phone'             => '+36 ' . fake()->numerify('## ### ####'),
            'remember_token'    => Str::random(10),
        ];
    }

    /**
     * Admin user létrehozásához használható állapot.
     * Használat: User::factory()->admin()->create()
     */
    public function admin(): static
    {
        return $this->state(fn (array $attributes) => [
            'role' => 'admin',
        ]);
    }
}
