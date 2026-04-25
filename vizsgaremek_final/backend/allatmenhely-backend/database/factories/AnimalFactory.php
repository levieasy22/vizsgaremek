<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;

class AnimalFactory extends Factory
{
    // Kutya nevek listája
    private array $dogNames = [
        'Bodri', 'Rex', 'Morzsa', 'Bundás', 'Csoki', 'Herceg', 'Lola',
        'Buksi', 'Cirmos', 'Dundi', 'Fifi', 'Góliát', 'Hópehely', 'Inci',
        'Jacky', 'Kendy', 'Lajos', 'Maxim', 'Nero', 'Ördög',
    ];

    // Macska nevek listája
    private array $catNames = [
        'Cica', 'Mici', 'Tigris', 'Hógolyó', 'Narancs', 'Zsemlye', 'Lili',
        'Füles', 'Gömböc', 'Hamvas', 'Inka', 'Jázmin', 'Keksz', 'Luna',
        'Mirci', 'Napsugár', 'Okos', 'Pötyi', 'Rozi', 'Suti',
    ];

    // Kutyafajták
    private array $dogBreeds = [
        'Labrador Retriever', 'Golden Retriever', 'Német Juhász',
        'Beagle', 'Uszkár', 'Dobermann', 'Husky', 'Boxer',
        'Bernáthegyi', 'Keverék',
    ];

    // Macskafajták
    private array $catBreeds = [
        'Európai rövidszőrű', 'Perzsa', 'Sziámi', 'Bengáli',
        'Ragdoll', 'Maine Coon', 'Brit rövidszőrű', 'Keverék',
    ];

    public function definition(): array
    {
        $type = fake()->randomElement(['kutya', 'macska']);

        if ($type === 'kutya') {
            $name  = fake()->randomElement($this->dogNames);
            $breed = fake()->randomElement($this->dogBreeds);
        } else {
            $name  = fake()->randomElement($this->catNames);
            $breed = fake()->randomElement($this->catBreeds);
        }

        return [
            'name'          => $name,
            'type'          => $type,
            'breed'         => $breed,
            'gender'        => fake()->randomElement(['him', 'nosteny']),
            'age'           => fake()->numberBetween(1, 12),
            'description'   => fake()->paragraph(3),
            'status'        => fake()->randomElement([
                'elerheto', 'elerheto', 'elerheto',   // 3x szerepel = nagyobb eséllyel elérhető lesz
                'foglalas_alatt',
                'orokbefogadva',
            ]),
            'is_vaccinated' => fake()->boolean(80),  // 80% eséllyel igaz
            'is_neutered'   => fake()->boolean(60),  // 60% eséllyel igaz
        ];
    }

    /**
     * Csak elérhető állat létrehozásához.
     * Használat: Animal::factory()->available()->create()
     */
    public function available(): static
    {
        return $this->state(fn (array $attributes) => [
            'status' => 'elerheto',
        ]);
    }

    /**
     * Csak kutya létrehozásához.
     * Használat: Animal::factory()->dog()->create()
     */
    public function dog(): static
    {
        return $this->state(fn (array $attributes) => [
            'type'  => 'kutya',
            'name'  => fake()->randomElement($this->dogNames),
            'breed' => fake()->randomElement($this->dogBreeds),
        ]);
    }

    /**
     * Csak macska létrehozásához.
     * Használat: Animal::factory()->cat()->create()
     */
    public function cat(): static
    {
        return $this->state(fn (array $attributes) => [
            'type'  => 'macska',
            'name'  => fake()->randomElement($this->catNames),
            'breed' => fake()->randomElement($this->catBreeds),
        ]);
    }
}
